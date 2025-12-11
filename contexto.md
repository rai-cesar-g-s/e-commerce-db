## 📍Contexto

Uma microempresa chamada *"Vendedor aliado"* quer montar um pequeno e-commerce para começar a vendar seus produtos, para isto ela precisa de um banco de dados que atenda a todas as suas necesidades mais simples, como controle de estoque, controle de vendas, devoluções, promoções etc. Portanto crie um banco de dados relacional que atenda a estas necessidades deste pequeno empreendimento.

### :computer: O sistema deve permitir:
- Controle de produtos.
- Registro de fornecedores.
- Gestão de clientes e funcionários.
- Gerenciamento de vendas (pedidos) e devoluções.
- Aplicação de promoções.
- Acompanhamento de faturamento e lucros.
- Uso de diferentes tipos de frete e transportadoras.
- Marcação de produtos favoritos pelos clientes.

O banco de dados deve seguir o modelo relacional e contemplar tabelas essenciais ao funcionamento de um e-commerce compacto, mas consistente, garantindo integridade, rastreabilidade e facilidade de consulta. 

### :inbox_tray: O sistema deve incluir:

**1. Stored Procedures** para processos repetitivos e rotinas críticas: calcular faturamento toal; custo total das compras; impostos totais.
**2. Views** para visualizar determinadas informações como: produtos mais devolvidos; produto com maior lucro aprazo e avista; produto com o menor lucro; todos os produtos em promoção; todas as categorias em promoção; item mais comprado; compras sem baixa;
**3. Triggers** para automatizar custos totais; validar carrinho não faturado; bloquear ações em carrinhos não faturados; validar carrinho faturado para poder colocar em pedidos.

### :clipboard: Requisitos (minímos):
- Tabela de devolução.
- Tabela de fornecedores.
- Tabela de Clientes.
- Tabela de funcionários.
- Quantidade de produtos no estoque.
- Tabela de faturamento.
- Tabela de lucros.
- Tabela tipo de frete.
- Tabela favoritos.
- Tabela transportadora.

*O objetivo final é fornecer uma estrutura enxuta, clara e escalável, que permita à empresa operar seu e-commerce sem complexidade excessiva, mas com todos os recursos fundamentais para vendas, controle e tomada de decisão.*