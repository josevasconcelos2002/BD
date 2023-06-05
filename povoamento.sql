-- ------------------------------------------------------
-- ------------------------------------------------------
-- Universidade do Minho
-- Licenciatura em Engenharia Informática
-- Unidade Curricular de Bases de Dados
-- 
-- Caso de Estudo: A loja da Dona Lola
-- Criação do Esquema Físico
-- Ano letivo 22/23
-- ------------------------------------------------------
-- ------------------------------------------------------

--
-- Esquema: "Loja D.Lola"
USE `mydb` ;

--
-- Permissão para fazer operações de remoção de dados.
SET SQL_SAFE_UPDATES = 0;

--
-- Povoamento da tabela "Genero"
INSERT INTO genero
	(genero_id, genero_descricao)
	VALUES 
		(1, 'Masculino'),
        (2, 'Feminino'),
        (3, 'Unissexo')
        ;
--
-- DELETE FROM genero;
-- SELECT * FROM genero;

--
-- Povoamento da tabela "Tipo"
INSERT INTO tipo
	(tipo_id, tipo_descricao)
	VALUES 
		(1, 'Camiseta'),
        (2, 'Calça'),
        (3, 'Blazer'),
        (4, 'Vestido'),
        (5, 'Moletom'),
        (6, 'Jaqueta'),
        (7, 'Bermuda'),
        (8, 'Camisa')
        ;
--
-- DELETE FROM tipo;
-- SELECT * FROM tipo;

--
-- Povoamento da tabela "Marca"
INSERT INTO marca
	(marca_id, marca_descricao)
	VALUES 
		(1, 'Zara'),
        (2, 'H&M'),
        (3, 'Gucci'),
        (4, 'Chanel'),
        (5, 'Nike')
        ;
--
-- DELETE FROM marca;
-- SELECT * FROM marca;

--
-- Povoamento da tabela "colecao"
INSERT INTO colecao
	(colecao_id, colecao_nome, ano, colecao_descricao, estacao)
	VALUES 
		(1, 'Primavera/Verão 2023', '2023-01-01', 'Coleção inspirada nas cores vibrantes e estampas florais da temporada primavera/verão.', 'Primavera/Verão'),
		(2, 'Outono/Inverno 2023', '2023-01-01', 'Coleção com peças quentes e elegantes, ideais para os meses mais frios do outono/inverno.', 'Outono/Inverno'),
		(3, 'Verão 2022', '2022-01-01', 'Coleção com roupas leves e descontraídas para aproveitar os dias quentes de verão.', 'Verão'),
		(4, 'Inverno 2022', '2022-01-01', 'Coleção com roupas confortáveis e aconchegantes para enfrentar as baixas temperaturas do inverno.', 'Inverno'),
		(5, 'Primavera 2021', '2021-01-01', 'Coleção com peças frescas e estampas florais para celebrar a chegada da primavera.', 'Primavera')
	;
--
-- DELETE FROM colecao;
-- SELECT * FROM colecao;

--
-- Povoamento da tabela "colecaofornecedor"
INSERT INTO colecaofornecedor 
	(precocompra, datafornecimento, pecaColFor_quantidade, peca_id, for_NIF,colecao_id)
	VALUES
		(29.99, '2023-05-15', 50, 1, 10549492,1),
		(35.99, '2023-05-16', 40, 2, 51916191,1),
		(79.99, '2023-05-17', 20, 3, 51679649,2),
		(49.99, '2023-05-18', 30, 4, 15479563,2),
		(59.99, '2023-05-19', 25, 5, 79836214,2)
	;
--
-- DELETE FROM colecaofornecedor;
-- SELECT * FROM colecaofornecedor;

--
-- Povoamento da tabela "fornecedor"
INSERT INTO fornecedor 
	(NIF, for_nome, for_rua, for_email, for_Localidade, for_codigopostal)
	VALUES 
		(10549492, 'EntregaRoup.lda', 'Rua da Liberdade', 'email1@example.com', 'Lisboa', '12345-678'),
		(51916191, 'Roupa&Roupinha', 'Avenida Infante Dom Henrique', 'email2@example.com', 'Porto', '98765-432'),
		(51679649, 'PeçasDRoupa.com', 'Travessa do Comércio', 'email3@example.com', 'Braga', '54321-678'),
		(15479563, 'RoupaDelivery', 'Praça da República', 'email4@example.com', 'Coimbra', '87654-321'),
		(79836214, 'PumaFornecedores', 'Rua dos Lusíadas', 'email5@example.com', 'Faro', '23456-789')
	;

--
-- DELETE FROM fornecedor;
-- SELECT * FROM fornecedor;

--
-- Povoamento da tabela "PecaDRoupa"
INSERT INTO PecaDeRoupa 
	(peca_id, peca_nome, tamanho, stock, cor, peca_descricao, precovenda, promocao, genero_id, tipo_id, marca_id)
	VALUES 
		(1, 'Camiseta Branca', 'M', 50, 'Branco', 'Camiseta básica de algodão', 19.99, 0, 3, 1, 1),
		(2, 'Calça Jeans Skinny', '38', 30, 'Azul', 'Calça jeans justa e moderna', 49.99, 1, 2, 2, 2),
		(3, 'Blazer Preto', 'L', 20, 'Preto', 'Blazer elegante para ocasiões formais', 99.99, 0, 1, 3, 3),
		(4, 'Vestido Floral', 'S', 15, 'Estampado', 'Vestido com estampa floral romântica', 79.99, 0, 2, 4, 4),
		(5, 'Moletom Cinza', 'XL', 40, 'Cinza', 'Moletom confortável para dias frios', 59.99, 0, 3, 5, 5),
		(6, 'Jaqueta de Couro', 'M', 10, 'Preto', 'Jaqueta de couro clássica', 149.99, 0, 2, 6, 1),
		(7, 'Bermuda Jeans', '32', 25, 'Azul', 'Bermuda jeans casual', 39.99, 0, 1, 7, 2),
		(8, 'Camisa Listrada', 'L', 35, 'Azul e Branco', 'Camisa de algodão com listras', 29.99, 0, 1, 8, 3),
		(9, 'Vestido de Festa', 'M', 12, 'Preto', 'Vestido elegante para ocasiões especiais', 129.99, 0, 2, 4, 4),
		(10, 'Moletom com Capuz', 'S', 20, 'Cinza', 'Moletom confortável com capuz', 69.99, 1, 3, 5, 5),
		(11, 'Camiseta Estampada', 'XL', 30, 'Branco', 'Camiseta com estampa moderna', 24.99, 0, 3, 1, 1),
		(12, 'Calça de Moletom', '40', 18, 'Cinza', 'Calça de moletom confortável', 44.99, 0, 2, 2, 2)
	;
--
-- DELETE FROM PecaDRoupa;
-- SELECT * FROM PecaDRoupa;

--
-- Povoamento da tabela "PecaFornecedor"
INSERT INTO PecaFornecedor 
	(pecaFor_precocompra, pecaFor_datafornecimento, quantidade, peca_id, for_NIF)
	VALUES
		(29.99, '2023-05-15',  50, 1, 10549492),
		(35.99, '2023-05-16',  40, 2, 51916191),
		(79.99, '2023-05-17',  20, 3, 51679649),
		(49.99, '2023-05-18',  30, 4, 15479563),
		(59.99, '2023-05-19',  25, 5, 79836214)
	;
--
-- DELETE FROM PecaFornecedor;
-- SELECT * FROM PecaFornecedor;

--
-- Povoamento da tabela "localizacao"
INSERT INTO localizacao 
	(loc_id, loc_descricao, loc_rua, loc_localizacao, loc_codigopostal, loc_telefone)
	VALUES
		(1, 'Loja de Roupas A', 'Rua Principal, 123', 'Cidade X', '12345-678', '157984369'),
		(2, 'Loja de Roupas B', 'Avenida Central, 456', 'Cidade Y', '23456-789', '965874238'),
		(3, 'Loja de Roupas C', 'Praça das Flores, 789', 'Cidade Z', '34567-890', '968741258'),
		(4, 'Loja de Roupas D', 'Rua Secundária, 456', 'Cidade W', '45678-901', '968713584'),
		(5, 'Loja de Roupas E', 'Avenida Principal, 789', 'Cidade V', '56789-012', '968748789')
	;
--
-- DELETE FROM localizacao;
-- SELECT * FROM localizacao;

-- Povoamento da tabela "contacto"
INSERT INTO contacto 
	(id, telefone, idFornecedor)
	VALUES
		(1, '965874582', 1),
		(2, '854712369', 2),
		(3, '789534871', 3),
		(4, '897465831', 4),
		(5, '458712589', 5)
	;
--
-- DELETE FROM contacto;
-- SELECT * FROM contacto;

-- Povoamento da tabela "roupaLocalizacao"
INSERT INTO roupaLocalizacao 
	(pecaLoc_quantidade, peca_id, loc_id)
	VALUES
		(1, 1, 1),
		(2, 2, 2),
		(3, 3, 3),
		(4, 4, 4),
		(5, 5, 5)
	;
--
-- DELETE FROM roupaLocalizacao;
-- SELECT * FROM roupaLocalizacao;


-- ------------------------------------------------------
-- <fim>
-- ------------------------------------------------------