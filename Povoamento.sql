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
-- Povoamento da tabela "colecao"
INSERT INTO colecao
	(id, nome, ano, descricao, Estacao)
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
	(colecao_id, fornecedor_NIF, PrecoComp, DataFornecimento, quantidade)
	VALUES
		(1, 10549492, 29.99, '2023-05-15', 50),
		(1, 51916191, 35.99, '2023-05-16', 40),
		(2, 51679649, 79.99, '2023-05-17', 20),
		(2, 15479563, 49.99, '2023-05-18', 30),
		(3, 79836214, 59.99, '2023-05-19', 25)
	;
--
-- DELETE FROM colecaofornecedor;
-- SELECT * FROM colecaofornecedor;

--
-- Povoamento da tabela "fornecedor"
INSERT INTO fornecedor 
	(NIF, Nome, Rua, Email, Telefone, Localidade, CodPost)
	VALUES 
		(10549492, 'EntregaRoup.lda', 'Rua da Liberdade', 'email1@example.com', '123456789', 'Lisboa', '12345-678'),
		(51916191, 'Roupa&Roupinha', 'Avenida Infante Dom Henrique', 'email2@example.com', '987654321', 'Porto', '98765-432'),
		(51679649, 'PeçasDRoupa.com', 'Travessa do Comércio', 'email3@example.com', '998765420', 'Braga', '54321-678'),
		(15479563, 'RoupaDelivery', 'Praça da República', 'email4@example.com', '675008976', 'Coimbra', '87654-321'),
		(79836214, 'PumaFornecedores', 'Rua dos Lusíadas', 'email5@example.com', '776879332', 'Faro', '23456-789')
	;

--
-- DELETE FROM fornecedor;
-- SELECT * FROM fornecedor;

--
-- Povoamento da tabela "marca"
INSERT INTO marca 
	(Nome, Pais_Origem, Descricao)
	VALUES 
		('Zara', 'Espanha', 'Marca global de moda conhecida por suas tendências e preços acessíveis.'),
		('Gucci', 'Itália', 'Marca de luxo que oferece roupas, acessórios e artigos de couro sofisticados.'),
		('Nike', 'Estados Unidos', 'Marca líder em sportswear, oferecendo roupas esportivas e calçados inovadores.'),
		('H&M', 'Suécia', 'Marca de moda acessível com uma ampla gama de roupas para mulheres, homens e crianças.'),
		('Chanel', 'França', 'Marca icônica de moda, perfumes e acessórios de luxo, conhecida por seu estilo clássico e elegante.')
	;
--
-- DELETE FROM marca;
-- SELECT * FROM marca;

--
-- Povoamento da tabela "PecaDRoupa"
INSERT INTO PecaDRoupa 
	(Id, Nome, Genero, Tamanho, Stock, Cor, Descricao, Tipo, PrecoVenda, Promocao, Marca_nome, Colecao_id)
	VALUES 
		(1, 'Camiseta Branca', 'Unissex', 'M', 50, 'Branco', 'Camiseta básica de algodão', 'Camiseta', 19.99, 0, 'Zara', 1),
		(2, 'Calça Jeans Skinny', 'Feminino', '38', 30, 'Azul', 'Calça jeans justa e moderna', 'Calça', 49.99, 1, 'H&M', NULL),
		(3, 'Blazer Preto', 'Masculino', 'L', 20, 'Preto', 'Blazer elegante para ocasiões formais', 'Blazer', 99.99, 0, 'Gucci', 2),
		(4, 'Vestido Floral', 'Feminino', 'S', 15, 'Estampado', 'Vestido com estampa floral romântica', 'Vestido', 79.99, 0, 'Chanel', 3),
		(5, 'Moletom Cinza', 'Unissex', 'XL', 40, 'Cinza', 'Moletom confortável para dias frios', 'Moletom', 59.99, 0, 'Nike', NULL),
		(6, 'Jaqueta de Couro', 'Feminino', 'M', 10, 'Preto', 'Jaqueta de couro clássica', 'Jaqueta', 149.99, 0, 'Zara', 4),
		(7, 'Bermuda Jeans', 'Masculino', '32', 25, 'Azul', 'Bermuda jeans casual', 'Bermuda', 39.99, 0, 'H&M', NULL),
		(8, 'Camisa Listrada', 'Masculino', 'L', 35, 'Azul e Branco', 'Camisa de algodão com listras', 'Camisa', 29.99, 0, 'Gucci', NULL),
		(9, 'Vestido de Festa', 'Feminino', 'M', 12, 'Preto', 'Vestido elegante para ocasiões especiais', 'Vestido', 129.99, 0, 'Chanel', 5),
		(10, 'Moletom com Capuz', 'Unissex', 'S', 20, 'Cinza', 'Moletom confortável com capuz', 'Moletom', 69.99, 1, 'Nike', NULL),
		(11, 'Camiseta Estampada', 'Unissex', 'XL', 30, 'Branco', 'Camiseta com estampa moderna', 'Camiseta', 24.99, 0, 'Zara', 6),
		(12, 'Calça de Moletom', 'Feminino', '40', 18, 'Cinza', 'Calça de moletom confortável', 'Calça', 44.99, 0, 'H&M', NULL)
	;
--
-- DELETE FROM PecaDRoupa;
-- SELECT * FROM PecaDRoupa;

--
-- Povoamento da tabela "roupafornecedor"
INSERT INTO roupafornecedor 
	(PecaDRoupa_id, Roupa_Marca_nome, Fornecedor_NIF, PrecoComp, DataFornecimento, Quantidade)
	VALUES
		(1, 'Zara', 10549492, 29.99, '2023-05-15', 50),
		(2, 'H&M', 51916191, 35.99, '2023-05-16', 40),
		(3, 'Gucci', 51679649, 79.99, '2023-05-17', 20),
		(4, 'Chanel', 15479563, 49.99, '2023-05-18', 30),
		(5, 'Nike', 79836214, 59.99, '2023-05-19', 25)
	;
--
-- DELETE FROM roupafornecedor;
-- SELECT * FROM roupafornecedor;

-- ------------------------------------------------------
-- <fim>
-- ------------------------------------------------------
