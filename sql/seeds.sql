-- inserts(Seeds)
insert into loja (fantasia, razao_social, cnpj, i_estadual, endereco, numero, bairro, cidade, estado, cep, telefone, email) values
('Comércio Central', 'Comércio Central LTDA', '11.222.333/0001-44', '123456789', 'Rua Alfa', '100', 'Centro', 'Ribeirão Preto', 'SP', '14010-000', '(16) 3232-1000', 'contato@comerciocentral.com');

insert into fornecedor (nome, cnpj, endereco, numero, bairro, cidade, estado, cep, telefone, email) values
('Fornecedor Brasil', '22.333.444/0001-55', 'Av. Paulista', '1500', 'Bela Vista', 'São Paulo', 'SP', '01310-200', '(11) 3030-2000', 'contato@fb.com'),
('Sul Distribuidora', '33.444.555/0001-66', 'Rua das Flores', '375', 'Centro', 'Curitiba', 'PR', '80010-130', '(41) 3333-4444', 'vendas@sul.com'),
('Norte Atacado', '44.555.666/0001-77', 'Av. Amazônia', '80', 'Distrito', 'Manaus', 'AM', '69005-020', '(92) 4002-8922', 'contato@norte.com'),
('Leste Importados', '55.666.777/0001-88', 'Rua Imperial', '290', 'Industrial', 'Recife', 'PE', '50030-040', '(81) 3900-5050', 'suporte@leste.com'),
('Oeste Suprimentos', '66.777.888/0001-99', 'Rua Rio Branco', '120', 'Centro', 'Cuiabá', 'MT', '78005-100', '(65) 3020-7070', 'atendimento@oeste.com');

insert into categoria (nome, descricao) values
('Eletrônicos', 'Produtos de tecnologia'),
('Vestuário', 'Roupas e acessórios'),
('Alimentos', 'Itens alimentícios'),
('Móveis', 'Mobiliário residencial'),
('Esportes', 'Produtos esportivos');

insert into produto (nome, descricao, cod_referencia, categoria_id, unidade, peso_gramas, altura, largura, profundidade, custo, preco_avista, preco_aprazo, local_estoque, estoque) values
('Fone Bluetooth', 'Fone sem fio', 'PRD001', 1, 'un', 150, 10, 8, 4, 50.00, 99.90, 119.90, 'A1-01', 0),
('Camiseta Dry Fit', 'Camiseta esportiva', 'PRD002', 2, 'un', 200, 2, 25, 1, 20.00, 59.90, 69.90, 'B2-07', 0),
('Arroz 5kg', 'Pacote de arroz', 'PRD003', 3, 'kg', 5000, 40, 20, 15, 15.00, 24.90, 29.90, 'C3-15', 0),
('Mesa Gamer', 'Mesa com LED', 'PRD004', 4, 'cx', 18000, 75, 120, 70, 200.00, 499.90, 549.90, 'D4-03', 0),
('Bola de Futebol', 'Bola tamanho oficial', 'PRD005', 5, 'un', 450, 22, 22, 22, 30.00, 89.90, 99.90, 'E5-11', 0);

insert into promocao (nome, promocao_ativa, tipo_promocao, preco_promocao, inicio, fim) values
('Promo Verão', true, 'valor', 79.90, '2025-01-01', '2025-01-31'),
('Semana Tech', true, 'porcentagem', 20.00, '2025-03-01', '2025-03-10'),
('Liquida Total', false, 'valor', 49.90, '2024-11-01', '2024-11-15'),
('Natal Premiado', true, 'valor', 19.90, '2025-12-01', '2025-12-25'),
('Esporte+ Promo', true, 'porcentagem', 15.00, '2025-02-10', '2025-02-20');

insert into promocao_produto (promocao_id, produto_id) values
(1, 1),
(2, 2),
(4, 5),
(5, 3),
(1, 4);

insert into promocao_categoria (promocao_id, categoria_id) values
(1, 1),
(2, 5),
(3, 2),
(4, 3),
(5, 4);

insert into compra (pedido_numero, fornecedor_id, data, frete, impostos, desconto) values
('CMP001', 1, '2025-01-10', 20.00, 5.00, 0),
('CMP002', 2, '2025-01-12', 15.00, 3.00, 2.00),
('CMP003', 3, '2025-01-15', 30.00, 8.00, 0),
('CMP004', 4, '2025-01-20', 10.00, 2.00, 1.00),
('CMP005', 5, '2025-01-22', 25.00, 4.00, 0);

insert into compra_item (compra_id, produto_id, quantidade, custo) values
(1, 1, 10, 40.00),
(1, 3, 20, 10.00),
(2, 2, 15, 15.00),
(3, 5, 12, 20.00),
(4, 4, 5, 180.00);

insert into departamento (nome) values
('Financeiro'),
('RH'),
('Tecnologia'),
('Vendas'),
('Logística');

insert into cargo (nome) values
('Analista'),
('Gerente'),
('Assistente'),
('Desenvolvedor'),
('Coordenador');

insert into funcionario (nome, cpf, nascimento, telefone, email, endereco, numero, bairro, cidade, estado, cep, departamento_id, cargo_id) values
('Carlos Silva','123.456.789-00','1990-05-10','(11)90000-0001','carlos@empresa.com','Rua A','101','Centro','São Paulo','SP','01001-000',3,4),
('Mariana Alves','987.654.321-00','1985-02-20','(21)90000-0002','mariana@empresa.com','Av B','202','Copacabana','Rio de Janeiro','RJ','22010-000',1,2),
('João Pedro','555.666.777-88','1992-09-15','(31)90000-0003','joao@empresa.com','Rua C','303','Savassi','Belo Horizonte','MG','30130-000',5,1),
('Ana Souza','111.222.333-44','1998-12-01','(41)90000-0004','ana@empresa.com','Rua D','404','Centro','Curitiba','PR','80010-000',2,3),
('Pedro Lima','444.555.666-77','1995-07-25','(71)90000-0005','pedro@empresa.com','Av E','505','Barra','Salvador','BA','40140-000',4,5);

insert into cliente (nome, cpf, rg, nascimento, telefone, email, senha_hash) values
('Rafael Costa','101.202.303-40','1234567','2000-01-10','(11)98888-1111','rafael@mail.com','hash1'),
('Julia Martins','202.303.404-50','2345678','1999-02-15','(21)97777-2222','julia@mail.com','hash2'),
('Bruno Rocha','303.404.505-60','3456789','1998-03-20','(31)96666-3333','bruno@mail.com','hash3'),
('Marina Lopes','404.505.606-70','4567890','2001-04-25','(41)95555-4444','marina@mail.com','hash4'),
('Thiago Nunes','505.606.707-80','5678901','1997-05-30','(51)94444-5555','thiago@mail.com','hash5');

insert into endereco_cliente (cliente_id, tipo, endereco, numero, bairro, cidade, estado, cep) values
(1,'casa','Rua Alfa','10','Centro','São Paulo','SP','01010-000'),
(2,'apartamento','Av Beta','200','Boa Vista','Recife','PE','50050-000'),
(3,'empresa','Rua Gama','300','Centro','Porto Alegre','RS','90010-000'),
(4,'casa','Rua Delta','400','Jardins','São Paulo','SP','01430-000'),
(5,'apartamento','Av Épsilon','500','Centro','Fortaleza','CE','60060-000');

insert into transportadora (nome, cnpj, telefone, email, endereco, numero, bairro, cidade, estado, cep) values
('TransVale','12.345.678/0001-00','(11)4000-1000','contato@transvale.com','Rua A','100','Centro','São Paulo','SP','01000-000'),
('RápidoNordeste','23.456.789/0001-11','(81)4000-2000','suporte@rn.com','Av B','200','Boa Viagem','Recife','PE','51020-000'),
('SulExpress','34.567.890/0001-22','(51)4000-3000','suporte@sx.com','Rua C','300','Centro','Porto Alegre','RS','90020-000'),
('CentroLog','45.678.901/0001-33','(61)4000-4000','contato@cl.com','Av D','400','Asa Sul','Brasília','DF','70040-000'),
('ViaOeste','56.789.012/0001-44','(31)4000-5000','atendimento@vo.com','Rua E','500','Savassi','Belo Horizonte','MG','30140-000');

insert into tipo_frete (nome, transportadora_id, regioes_atendidas, logica_frete, formula_frete) values
('Frete SP Capital', 1, 'São Paulo e região metropolitana', 'fixo', 'valor=25'),
('Frete Nordeste', 2, 'Estados do NE', 'peso', 'valor=peso*2'),
('Frete Sul', 3, 'RS, SC, PR', 'tamanho', 'valor=altura*0.5'),
('Frete Nacional Expresso', 4, 'Todo Brasil', 'fixo', 'valor=50'),
('Frete MG Interior', 5, 'Interior de MG', 'peso', 'valor=peso*1.5');

insert into favoritos (cliente_id, produto_id) values
(1, 1),
(2, 3),
(3, 5),
(4, 2),
(5, 4);

insert into carrinho (data, cliente_id, tipo_frete_id) values
('2025-01-10',1,1),
('2025-01-12',2,2),
('2025-01-14',3,3),
('2025-01-16',4,4),
('2025-01-18',5,5);

insert into carrinho_produto (carrinho_id, produto_id, quantidade, preco_unitario, desconto_aplicado) values
(1,1,1,99.90,0),
(1,3,2,24.90,0),
(2,2,1,59.90,5.00),
(3,5,1,89.90,0),
(4,4,1,499.90,0);

-- LEMBRE-SE: marque os carrinhos como faturado antes de rodar
update carrinho set faturado = true where id in (1,2,3,4,5);

insert into pedido (carrinho_id, data, tipo_frete_id, frete, impostos, desconto, total_bruto, total_liquido, forma_pagamento) values
(1,'2025-02-01',1,25,5,0,150,145,'pix'),
(2,'2025-02-02',2,30,6,2,180,172,'debito'),
(3,'2025-02-03',3,40,8,0,200,192,'credito'),
(4,'2025-02-04',4,50,10,5,300,285,'boleto'),
(5,'2025-02-05',5,35,4,0,120,116,'pix');

insert into pedido_item (pedido_id, produto_id, custo, quantidade, imposto, custo_total) values
(1,1,40.00,1,5,40.00),
(2,2,20.00,1,2,20.00),
(3,5,25.00,2,4,50.00),
(4,4,180.00,1,10,180.00),
(5,3,10.00,3,3,30.00);

insert into devolucao (pedido_id, data, motivo) values
(1,'2025-02-10','Defeito no produto'),
(2,'2025-02-12','Tamanho incorreto'),
(3,'2025-02-14','Arrependimento'),
(4,'2025-02-16','Produto avariado'),
(5,'2025-02-18','Erro na entrega');

insert into devolucao_item (devolucao_id, produto_id, quantidade) values
(1,1,1),
(2,2,1),
(3,5,1),
(4,4,1),
(5,3,2);
