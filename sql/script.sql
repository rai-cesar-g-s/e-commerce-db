-- funções & trigges

-- atualiza totais da compra ao inserir/atualizar/deletar itens
create or replace function atualiza_totais_compra() returns trigger as $$
declare
    cid int;
    soma_itens numeric;
    frete_val numeric;
    impostos_val numeric;
    desconto_val numeric;
    novo_total_bruto numeric;
    novo_total_liquido numeric;
begin
    -- determina compra_id vindo de NEW ou OLD
    if TG_OP = 'DELETE' then
        cid := OLD.compra_id;
    else
        cid := NEW.compra_id;
    end if;

    if cid is null then
        return null;
    end if;

    select coalesce(sum(coalesce(custo,0) * quantidade),0)
    into soma_itens
    from compra_item
    where compra_id = cid;

    select coalesce(frete,0), coalesce(impostos,0), coalesce(desconto,0)
    into frete_val, impostos_val, desconto_val
    from compra
    where id = cid;

    novo_total_bruto := soma_itens + coalesce(frete_val,0) + coalesce(impostos_val,0);
    novo_total_liquido := novo_total_bruto - coalesce(desconto_val,0);

    update compra
    set total_bruto = novo_total_bruto,
        total_liquido = novo_total_liquido
    where id = cid;

    return case when TG_OP = 'DELETE' then OLD else NEW end;
end;
$$ language plpgsql;

create trigger trg_compra_item_totais
after insert or update or delete on compra_item
for each row execute function atualiza_totais_compra();


-- trigger para impedir inserir item em carrinho já faturado
create or replace function valida_carrinho_nao_faturado() returns trigger as $$
declare
    fat boolean;
begin
    select faturado into fat from carrinho where id = NEW.carrinho_id;
    if fat is null then
        raise exception 'Carrinho % não encontrado', NEW.carrinho_id;
    end if;
    if fat = true then
        raise exception 'Não é permitido adicionar itens ao carrinho faturado: %', NEW.carrinho_id;
    end if;
    return NEW;
end;
$$ language plpgsql;

create trigger trg_carrinho_prod_insert
before insert on carrinho_produto
for each row execute function valida_carrinho_nao_faturado();


-- trigger para impedir alterações proibidas em carrinho faturado
create or replace function bloqueia_alteracao_carrinho_faturado() returns trigger as $$
begin
    -- se o carrinho já estava faturado, proíbe mudanças em campos financeiros (exceto permitir mudar faturado de false->true)
    if OLD.faturado = true then
        -- bloqueia qualquer update (você pode afinar quais campos permitir)
        raise exception 'Operação proibida: carrinho id=% já está faturado.', OLD.id;
    end if;
    return NEW;
end;
$$ language plpgsql;

create trigger trg_carrinho_before_update
before update on carrinho
for each row execute function bloqueia_alteracao_carrinho_faturado();


-- trigger para validar que pedido vem de carrinho faturado
create or replace function valida_carrinho_faturado_para_pedido()
returns trigger as $$
declare
    fat boolean;
begin
    select faturado into fat from carrinho where id = NEW.carrinho_id;
    if fat is null then
        raise exception 'Carrinho % não existe', NEW.carrinho_id;
    end if;
    if fat = false then
        raise exception 'Não é possível criar um pedido a partir de um carrinho não faturado.';
    end if;
    return NEW;
end;
$$ language plpgsql;

create trigger trg_pedido_valida_carrinho
before insert on pedido
for each row execute function valida_carrinho_faturado_para_pedido();


-- procedures

-- faturamento total (soma total_liquido dos pedidos)
create or replace function faturamento_total() returns numeric as $$
declare
    res numeric;
begin
    select coalesce(sum(total_liquido),0) into res from pedido;
    return res;
end;
$$ language plpgsql;


-- custo total de todas as compras
create or replace function custo_total_compras() returns numeric as $$
declare
    res numeric;
begin
    select coalesce(sum(total_bruto),0) into res from compra;
    return res;
end;
$$ language plpgsql;

-- impostos totais pagos nas compras
create or replace function impostos_totais_compras() returns numeric as $$
declare
    res numeric;
begin
    select coalesce(sum(coalesce(impostos,0)),0) into res from compra;
    return res;
end;
$$ language plpgsql;

-- lista produtos em determinada promocao (exemplo)
create or replace function produtos_em_promocao(p_promocao_id int) returns table(produto_id int, nome varchar, preco_promocao numeric) as $$
begin
    return query
    select p.id, p.nome, pr.preco_promocao
    from promocao_produto pp
    join produto p on pp.produto_id = p.id
    join promocao pr on pp.promocao_id = pr.id
    where pp.promocao_id = p_promocao_id and pr.promocao_ativa = true;
end;
$$ language plpgsql;

-- select das stored procedure
select faturamento_total();
select custo_total_compras();
select impostos_totais_compras();
select produtos_em_promocao(1); -- só de exemplo

-- views
create view produto_maior_lucro_avista as
select id, nome, (preco_avista - custo) as lucro_avista
from produto
order by lucro_avista desc
limit 1;

create view produto_maior_lucro_aprazo as
select id, nome, (preco_aprazo - custo) as lucro_aprazo
from produto
order by lucro_aprazo desc
limit 1;

create view produto_menor_lucro as
select id, nome, 
       (preco_avista - custo) as lucro_avista,
       (preco_aprazo - custo) as lucro_aprazo
from produto
order by ( (preco_avista - custo) + (preco_aprazo - custo) ) asc
limit 1;

create view todos_produtos_promocao as
select pp.produto_id, p.nome, pp.promocao_id 
from promocao_produto pp
join produto p on pp.produto_id = p.id;

create view todas_categorias_promocao as
select pc.categoria_id, c.nome, pc.promocao_id 
from promocao_categoria pc
join categoria c on pc.categoria_id = c.id;

create view item_mais_comprado as
select pd.produto_id, p.nome, count(*) as repeticoes
from pedido_item pd
join produto p on p.id = pd.produto_id
group by pd.produto_id, p.nome
order by repeticoes desc
limit 1;

create view compras_sem_baixa as
select *
from compra
where deu_baixa = false;

create view frete_mais_usado as
select pd.tipo_frete_id, ft.nome, ft.transportadora_id, ft.regioes_atendidas, count(pd.tipo_frete_id) as repeticoes
from pedido pd
join tipo_frete ft on pd.tipo_frete_id = ft.id
group by pd.tipo_frete_id, ft.nome, ft.transportadora_id, ft.regioes_atendidas
order by repeticoes desc
limit 1;

create view produto_favorito as
select f.produto_id, p.nome, count(f.produto_id) as repeticoes
from favoritos f
join produto p on f.produto_id = p.id
group by f.produto_id, p.nome
order by repeticoes desc
limit 1;

create view produtos_mais_devolvidos as
select di.produto_id, p.nome, count(di.produto_id) as repeticoes
from devolucao_item di
join produto p on di.produto_id = p.id
group by di.produto_id, p.nome
order by repeticoes desc
limit 3;

-- selects das views
select * from produto_maior_lucro_avista;
select * from produto_maior_lucro_aprazo;
select * from produto_menor_lucro;
select * from todos_produtos_promocao;
select * from todas_categorias_promocao;
select * from item_mais_comprado;
select * from compras_sem_baixa;
select * from frete_mais_usado;
select * from produto_favorito;
select * from produtos_mais_devolvidos;

-- selects tradicionais
select * from loja;
select * from fornecedor;
select * from categoria;
select * from produto;
select * from promocao;
select * from promocao_produto;
select * from promocao_categoria;
select * from compra;
select * from lote;
select * from compra_item;
select * from departamento;
select * from cargo;
select * from funcionario;
select * from cliente;
select * from endereco_cliente;
select * from transportadora;
select * from tipo_frete;
select * from favoritos;
select * from carrinho;
select * from carrinho_produto;
select * from pedido;
select * from pedido_item;
select * from devolucao;
select * from devolucao_item;