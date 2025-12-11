-- criação database
create database vendedor_aliado;

-- ATENÇÃO antes de criar as tabelas selecione o banco de dados 'vendedor_aliado' 
-- para não criar as tabelas no banco errado.

-- criação das tabelas
create table loja (
    id serial primary key,
    fantasia varchar(50) not null,
    razao_social varchar(50) not null,
    cnpj varchar(20) not null unique,
    i_estadual varchar(20) unique,
    endereco varchar(50) not null,
    numero varchar(6) not null,
    bairro varchar(50) not null,
    cidade varchar(50) not null,
    estado char(2) not null,
    cep varchar(9) not null,
    telefone varchar(15),
    email varchar(50) unique
);

create table fornecedor (
    id serial primary key,
    nome varchar(50) not null,
    cnpj varchar(20) not null unique,
    endereco varchar(50) not null,
    numero varchar(6) not null,
    bairro varchar(50) not null,
    cidade varchar(50) not null,
    estado char(2) not null,
    cep varchar(9) not null,
    telefone varchar(15),
    email varchar(50) unique
);

create table categoria (
    id serial primary key,
    nome varchar(40) not null,
    descricao varchar(100)
);

create table produto (
    id serial primary key,
    nome varchar(40) not null,
    descricao varchar(100),
    cod_referencia varchar(20) not null unique,
    categoria_id int not null,
    unidade char(2) not null check(unidade in ('un','kg','lt','cx','pc')),
    peso_gramas decimal(10,2) not null,
    altura decimal(10,2) not null,
    largura decimal(10,2) not null,
    profundidade decimal(10,2) not null,
    custo decimal(13,2) not null,          
    preco_avista decimal(13,2) not null,
    preco_aprazo decimal(13,2) not null, 
    local_estoque varchar(50),
    estoque int not null default 0,        
    foreign key (categoria_id) references categoria(id)
);

create table promocao (
    id serial primary key,
    nome varchar(40) not null,
    promocao_ativa boolean not null,
    tipo_promocao varchar(20) not null check(tipo_promocao in ('valor', 'porcentagem')),
    preco_promocao decimal(13,2) not null,
    inicio date not null,
    fim date not null
);

create table promocao_produto (
    id serial primary key,
    promocao_id int not null,
    produto_id int not null,
    foreign key (promocao_id) references promocao(id),
    foreign key (produto_id) references produto(id)
);

create table promocao_categoria (
    id serial primary key,
    promocao_id int not null,
    categoria_id int not null,
    foreign key (promocao_id) references promocao(id),
    foreign key (categoria_id) references categoria(id)
);

-- compra:  total_* ficam NULL até os triggers/funções calcularem.
create table compra (
    id serial primary key,
    pedido_numero varchar(50) not null unique,
    fornecedor_id int not null,
    data date not null,
    frete decimal(13,2) default 0,
    impostos decimal(13,2) default 0,
    desconto decimal(13,2) default 0,
    total_bruto decimal(13,2) null,
    total_liquido decimal(13,2) null,
    deu_baixa boolean not null default false,
    confirmada boolean not null default false,  -- indica compra finalizada/confirmada
    foreign key (fornecedor_id) references fornecedor(id)
);

-- compra_item: lote_id pode ser NULL inicialmente. custo também pode ser NULL (mas ideal informar).
create table compra_item (
    id serial primary key,
    compra_id int not null,
    produto_id int not null,
    lote_id int null,
    quantidade int not null,
    custo decimal(13,2) null,
    foreign key (compra_id) references compra(id),
    foreign key (produto_id) references produto(id)
    -- note: referencial para lote existe, mas lote é criado apenas quando compra confirmada
);

-- lote: será criado ao FINALIZAR a compra; referencia compra_id (compra confirmada que originou o lote).
create table lote (
    id serial primary key,
    produto_id int not null,
    compra_id int not null,           -- compra que originou o lote (preenchido na finalização)
    codigo_lote varchar(50),          -- opcional: código do lote se houver
    data_validade date,               -- pode ser NULL se não houver validade
    quantidade_inicial int not null default 0,
    quantidade_atual int not null default 0,
    entradas decimal(13,2) default 0,
    saidas decimal(13,2) default 0,
    foreign key (produto_id) references produto(id),
    foreign key (compra_id) references compra(id)
);

create table departamento (
    id serial primary key,
    nome varchar(50) not null
);

create table cargo (
    id serial primary key,
    nome varchar(50) not null
);

create table funcionario (
    id serial primary key,
    nome varchar(50) not null,
    cpf varchar(14) not null unique,
    nascimento date not null,
    telefone varchar(15),
    email varchar(50) unique,
    endereco varchar(50) not null,
    numero varchar(6) not null,
    bairro varchar(50) not null,
    cidade varchar(50) not null,
    estado char(2) not null,
    cep varchar(9) not null,
    departamento_id int not null,
    cargo_id int not null,
    foreign key (departamento_id) references departamento(id),
    foreign key (cargo_id) references cargo(id)
);

create table cliente (
    id serial primary key,
    nome varchar(50) not null,
    cpf varchar(14) not null unique,
    rg varchar(14),
    nascimento date not null,
    telefone varchar(15),
    email varchar(50) unique,
    senha_hash varchar(255) not null
);

create table endereco_cliente (
    id serial primary key,
    cliente_id int not null,
    tipo varchar(20) not null check(tipo in ('casa','empresa','apartamento')),
    endereco varchar(50) not null,
    numero varchar(6) not null,
    bairro varchar(50) not null,
    cidade varchar(50) not null,
    estado char(2) not null,
    cep varchar(9) not null,
    foreign key (cliente_id) references cliente(id)
);

create table transportadora (
    id serial primary key,
    nome varchar(50) not null,
    cnpj varchar(20) not null unique,
    telefone varchar(15),
    email varchar(50) unique,
    endereco varchar(50) not null,
    numero varchar(6) not null,
    bairro varchar(50) not null,
    cidade varchar(50) not null,
    estado char(2) not null,
    cep varchar(9) not null
);

create table tipo_frete (
    id serial primary key,
    nome varchar(50) not null,
    transportadora_id int not null,
    regioes_atendidas varchar(200),
    logica_frete varchar(20) not null check(logica_frete in ('peso','tamanho','fixo')),
    formula_frete varchar(50),
    foreign key (transportadora_id) references transportadora(id)
);

create table favoritos (
    id serial primary key,
    cliente_id int not null,
    produto_id int not null,
    foreign key (cliente_id) references cliente(id),
    foreign key (produto_id) references produto(id)
);

-- carrinho: total_* ficam NULL até cálculo via triggers; faturado indica que foi fechado.
create table carrinho (
    id serial primary key,
    data date not null,
    cliente_id int not null,
    total_bruto decimal(13,2) null,
    tipo_frete_id int not null,
    frete decimal(13,2) default 0,
    impostos decimal(13,2) default 0,
    desconto decimal(13,2) default 0,
    total_liquido decimal(13,2) null,
    faturado boolean not null default false,
    foreign key (cliente_id) references cliente(id),
    foreign key (tipo_frete_id) references tipo_frete(id)
);

create table carrinho_produto (
    id serial primary key,
    carrinho_id int not null,
    produto_id int not null,
    quantidade int not null,
    preco_unitario decimal(13,2) null, -- preço aplicado no momento (pode levar promoção)
    desconto_aplicado decimal(13,2) default 0,
    foreign key (carrinho_id) references carrinho(id),
    foreign key (produto_id) references produto(id)
);

create table pedido (
    id serial primary key,
    carrinho_id int not null,
    data date not null,
    tipo_frete_id int not null,
    frete decimal(13,2),
    impostos decimal(13,2),
    desconto decimal(13,2),
    total_bruto decimal(13,2) null,
    total_liquido decimal(13,2) null,
    forma_pagamento varchar(20) not null check(forma_pagamento in ('pix','debito','credito','boleto')),
    foreign key (carrinho_id) references carrinho(id),
    foreign key (tipo_frete_id) references tipo_frete(id)
);

create table pedido_item (
    id serial primary key,
    pedido_id int not null,
    produto_id int not null,
    custo decimal(13,2) not null,        -- custo registrado no momento da venda (para contabilidade)
    quantidade int not null,
    imposto decimal(13,2) default 0,
    custo_total decimal(13,2) null,
    observacao varchar(100),
    foreign key (pedido_id) references pedido(id),
    foreign key (produto_id) references produto(id)
);

create table devolucao (
    id serial primary key,
    pedido_id int not null,
    data date not null,
    motivo varchar(200) not null,
    foreign key (pedido_id) references pedido(id)
);

create table devolucao_item (
    id serial primary key,
    devolucao_id int not null,
    produto_id int not null,
    quantidade int not null,
    foreign key (devolucao_id) references devolucao(id),
    foreign key (produto_id) references produto(id)
);
