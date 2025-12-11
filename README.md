## :package: Banco de Dados para E-commerce (PostgreSQL) 

Este repositório apresenta a criação de um banco de dados para a empresa fictícia Vendedor Aliado, uma loja que decidiu abrir seu próprio e-commerce. Para viabilizar essa migração, foi desenvolvido um banco de dados simples, focado em demonstrar domínio de PostgreSQL e entendimento das estruturas comuns em sistemas de comércio eletrônico.

O objetivo aqui não é montar um banco de produção completo — até porque isso exigiria análise de requisitos, regras de negócio e várias definições de arquitetura — mas sim entregar um modelo funcional, didático e tecnicamente sólido.

### ✅ O que foi feito

- **Criação das tabelas essenciais de um e-commerce**  
  Entidades implementadas:  
  `loja`, `fornecedor`, `categoria`, `produto`, `promocao`, `promocao_produto`, `promocao_categoria`,  
  `compra`, `compra_item`, `lote`, `departamento`, `cargo`, `funcionario`,  
  `cliente`, `endereco_cliente`, `transportadora`, `tipo_frete`,  
  `favoritos`, `carrinho`, `carrinho_produto`,  
  `pedido`, `pedido_item`, `devolucao`, `devolucao_item`.

- **Criação de seeds**

- **Stored Procedures**
  - `faturamento_total()` — retorna o faturamento total considerando pedidos concluídos.  
  - `custo_total_compras()` — soma os custos das compras registradas.  
  - `impostos_totais_compras()` — calcula os impostos totais das compras.  
  - `produtos_em_promocao(x)` — lista produtos filtrados por tipo de promoção.

- **Triggers**

  - **Funções auxiliares**
    - `atualiza_totais_compra()` — recalcula total bruto e líquido da compra.  
    - `valida_carrinho_nao_faturado()` — impede alterações em carrinho já faturado.  
    - `bloqueia_alteracao_carrinho_faturado()` — trava atualizações indevidas.  
    - `valida_carrinho_faturado_para_pedido()` — validação antes de gerar pedido.

  - **Triggers relacionados**
    - `trg_compra_item_totais` — dispara recálculo ao inserir/alterar compra_item.  
    - `trg_carrinho_prod_insert` — valida e atualiza carrinho ao inserir itens.  
    - `trg_carrinho_before_update` — bloqueia alterações indevidas em carrinho.  
    - `trg_pedido_valida_carrinho` — garante consistência ao criar pedido.

- **Views**
  - `produto_maior_lucro_avista`  
  - `produto_maior_lucro_aprazo`  
  - `produto_menor_lucro`  
  - `todos_produtos_promocao`  
  - `todas_categorias_promocao`  
  - `item_mais_comprado`  
  - `compras_sem_baixa`  
  - `frete_mais_usado`  
  - `produto_favorito`  
  - `produtos_mais_devolvidos`

### 📂 Estrutura do projeto:

- contexto.md -> explicação do enunciado formulado para direcionar a ciração do banco de dados.
- /modelo-fisico-simplificado -> pasta com o modelo-fisico-simplificado em pdf e png.
- /sql -> pasta com os scripts sql 
    - 'create.sql' - criação do banco e tabelas.
    - 'seeds.sql' - dados iniciais.
    - 'others.sql' - triggers, procedures, views e demais objetos.

### ▶️ Como rodar:

1. Acesse o PgAdmin ou Dbeaver 
2. Execute os scripts na ordem: 'create.sql' -> 'others.sql' -> 'seeds.sql' - há alguns comentários/instruções em alguns lugares dos arquivos.

### ⚒️ Tecnologias usadas:

- PostgreSQL 16.11.
- Dbeaver - SGBD e editor SQL.
- LucidChart - DER.
- Git - versioanamento.
- Vs-Code - organização do projeto e arquivos.
- ChatGPT - apoio pontutal(seeds, comentários e auxílio técnico).

### 💡 Possiveis melhorias:

- Aumentar a complexidade das entidades (datas, estados, novas relações, etc.).
- Criar mais triggers, procedures e views para maior controle sobre estoque, produto, movimentações financeiras etc.
- Evoluir o modelo para algo mais próximo de um ambiente real de e-commerce.