-- ------------------------------------------------------
-- ------------------------------------------------------
-- Universidade do Minho
-- Licenciatura em Engenharia Informática
-- Unidade Curricular de Bases de Dados
-- 
-- Caso de Estudo: A loja da Dona Lola
-- Script com várias queries, selects e procedures
-- Ano letivo 22/23
-- ------------------------------------------------------
-- ------------------------------------------------------

-- Queries relacionadas aos requisitos --
USE mydb;

-- Listar todas as peças de roupa de acordo com a sua localização::
SELECT PR.*
FROM PecaDeRoupa PR
JOIN RoupaLocalizacao RL ON PR.peca_id = RL.peca_id
JOIN Localizacao L ON RL.loc_id = L.loc_id
ORDER BY L.loc_descricao;

-- Listar peças através da Marca e da Coleção:
SELECT PR.*
FROM PecaDeRoupa PR
JOIN Marca M ON PR.marca_id = M.marca_id
JOIN ColecaoFornecedor CF ON PR.peca_id = CF.peca_id
JOIN Colecao C ON CF.colecao_id = C.colecao_id
WHERE M.marca_descricao = 'H&M' AND C.colecao_nome = 'Primavera/Verão 2023';

-- Listar os fornecedores:
SELECT *
FROM Fornecedor;

-- Mostrar as peças de roupa e as coleções fornecidas por um determinado fornecedor:
SELECT PR.*, C.colecao_nome
FROM PecaDeRoupa PR
JOIN ColecaoFornecedor CF ON PR.peca_id = CF.peca_id
JOIN Colecao C ON CF.colecao_id = C.colecao_id
JOIN Fornecedor F ON CF.for_NIF = F.NIF
WHERE F.for_nome = 'Roupa&Roupinha';

-- Relatório do stock a um determinado momento:
USE mydb;
SELECT PR.peca_id, PR.peca_nome, SUM(RL.pecaLoc_quantidade) AS stock_atual
FROM PecaDeRoupa PR
JOIN RoupaLocalizacao RL ON RL.peca_id = PR.peca_id
GROUP BY PR.peca_id, PR.peca_nome;

-- Listar a quantidade e o preço de compra de uma peça a um fornecedor:
SELECT PR.peca_nome, PF.pecaFor_precocompra, PF.quantidade
FROM PecaDeRoupa PR
JOIN PecaFornecedor PF ON PR.peca_id = PF.peca_id
JOIN Fornecedor F ON PF.for_NIF = F.NIF
WHERE PR.peca_id = '1' AND F.for_nome = 'EntregaRoup.lda';

-- Listar peças de acordo com o seu Género:
SELECT PR.*
FROM PecaDeRoupa PR
JOIN Genero G ON PR.genero_id = G.genero_id
WHERE G.genero_descricao = 'Masculino';

-- Fim (requesitos) --



-- Selecionar todos os registros da tabela "genero"
USE mydb;
SELECT * FROM genero;

-- Selecionar todos os registros da tabela "tipo"
USE mydb;
SELECT * FROM tipo;

-- Selecionar todos os registros da tabela "marca"
USE mydb;
SELECT * FROM marca;

-- Selecionar todos os registros da tabela "colecao"
USE mydb;
SELECT * FROM colecao;

-- Selecionar todos os registros da tabela "colecaofornecedor"
USE mydb;
SELECT * FROM colecaofornecedor;

-- Selecionar todos os registros da tabela "fornecedor"
USE mydb;
SELECT * FROM fornecedor;

-- Selecionar todos os registros da tabela "PecaDeRoupa"
USE mydb;
SELECT * FROM PecaDeRoupa;

-- Selecionar todos os registros da tabela "PecaFornecedor"
USE mydb;
SELECT * FROM PecaFornecedor;

-- Selecionar todos os registros da tabela "localizacao"
USE mydb;
SELECT * FROM localizacao;

-- Selecionar todos os registros da tabela "contacto"
USE mydb;
SELECT * FROM contacto;

-- Selecionar todos os registros da tabela "roupaLocalizacao"
USE mydb;
SELECT * FROM roupaLocalizacao;

-- Selecionar todas as peças de roupa de uma determinada marca
USE mydb;
SELECT * FROM PecaDeRoupa WHERE marca_id = 1;

-- Selecionar todas as peças de roupa femininas
USE mydb;
SELECT * FROM PecaDeRoupa WHERE genero_id = 2;

-- Selecionar todas as peças de roupa que estão em promoção
USE mydb;
SELECT * FROM PecaDeRoupa WHERE promocao = 1;

-- Selecionar o total de peças de roupa em stock
USE mydb;
SELECT SUM(stock) AS total_stock FROM PecaDeRoupa;

-- Seleciona os fornecedores de uma determinada peça e muda o nome do for_nome na tabela
USE mydb;
SELECT PR.peca_nome, CONCAT('O ', F.for_nome) AS NOME_do_FORNECEDOR
FROM PecaDeRoupa PR
JOIN PecaFornecedor PF ON PF.peca_id = PR.peca_id
JOIN Fornecedor F ON F.NIF = PF.for_NIF;


-- Criar uma view para listar todas as peças de roupa disponíveis em cada localização
USE mydb;
CREATE VIEW PecasPorLocalizacao AS
SELECT r.peca_id, r.peca_nome, l.loc_descricao, l.loc_localizacao
FROM PecaDeRoupa r
JOIN roupaLocalizacao rl ON r.peca_id = rl.peca_id
JOIN localizacao l ON rl.loc_id = l.loc_id;

-- Drop da view PecasPorLocalizacao
USE mydb;
DROP VIEW IF EXISTS PecasPorLocalizacao;

-- Fornecedor com o maior número de peças de roupa fornecidas
USE mydb;
SELECT f.for_nome, COUNT(pf.peca_id) AS num_pecas
FROM fornecedor f
JOIN PecaFornecedor pf ON f.NIF = pf.for_NIF
GROUP BY f.for_nome
ORDER BY num_pecas DESC
LIMIT 1;

-- Selecionar as peças de roupa disponíveis em cada localização, juntamente com a quantidade em stock
USE mydb;
SELECT r.peca_nome, l.loc_descricao, rl.pecaLoc_quantidade
FROM PecaDeRoupa r
JOIN roupaLocalizacao rl ON r.peca_id = rl.peca_id
JOIN localizacao l ON rl.loc_id = l.loc_id;

-- Criação de select
-- Retorna informações detalhadas sobre as peças de roupa que possuem 
-- estoque acima da média geral. Ele realiza joins entre as tabelas PecaDeRoupa, colecaofornecedor, colecao e fornecedor 
-- para obter os dados necessários. Os resultados são ordenados pelo estoque de forma decrescente.
USE mydb;
SELECT p.peca_id, p.peca_nome, p.stock, c.colecao_nome, f.for_nome
FROM PecaDeRoupa p
JOIN colecaofornecedor cf ON p.peca_id = cf.peca_id
JOIN colecao c ON cf.colecao_id = c.colecao_id
JOIN fornecedor f ON cf.for_NIF = f.NIF
WHERE p.stock > (
    SELECT AVG(stock)
    FROM PecaDeRoupa
)
ORDER BY p.stock DESC;

-- Criação de select
-- Retorna informações sobre os produtos, incluindo o nome da peça de roupa, a descrição da marca, o nome
-- da coleção e a quantidade total de produtos disponíveis em todos os fornecedores. A cláusula GROUP BY agrupa os resultados 
-- com base no nome da peça de roupa, a descrição da marca e o nome da coleção. A cláusula HAVING filtra os resultados para 
-- incluir apenas os produtos que têm uma quantidade igual ou superior a 2. Os resultados são ordenados pela quantidade de forma decrescente.
USE mydb;
SELECT p.peca_nome, m.marca_descricao, c.colecao_nome, COUNT(*) AS quantidade
FROM PecaDeRoupa p
JOIN marca m ON p.marca_id = m.marca_id
JOIN colecaofornecedor cf ON p.peca_id = cf.peca_id
JOIN colecao c ON cf.colecao_id = c.colecao_id
JOIN PecaFornecedor pf ON p.peca_id = pf.peca_id
GROUP BY p.peca_nome, m.marca_descricao, c.colecao_nome
HAVING COUNT(*) >= 2
ORDER BY quantidade DESC;

-- ---------- PROCEDURES ---------- --

-- Criar uma stored procedure para atualizar o stock de uma peça de roupa
USE mydb;
DELIMITER //
CREATE PROCEDURE AtualizarStock(IN pecaId INT, IN novoStock INT)
BEGIN
    UPDATE PecaDeRoupa SET stock = novoStock WHERE peca_id = pecaId;
END //
DELIMITER ;

-- Chamar a stored procedure para atualizar o stock da peça de roupa com ID 1 para 100
USE mydb;
CALL AtualizarStock(1, 100);

-- Criação da Procedure
-- A procedure GetTotalStockByCollection recebe um parâmetro collection_id para 
-- especificar a coleção desejada e retorna a soma total do estoque de todas as 
-- peças de roupa relacionadas a essa coleção.
USE mydb;
DELIMITER $$

CREATE PROCEDURE GetTotalStockByCollection(IN collection_id INT, OUT total_stock INT)
BEGIN
    SELECT SUM(stock) INTO total_stock
    FROM PecaDeRoupa
    WHERE peca_id IN (
        SELECT peca_id
        FROM colecaofornecedor
        WHERE colecao_id = collection_id
    );
END $$

DELIMITER ;
USE mydb;

-- Declarar variaveis
SET @collection_id := 1;
SET @total_stock := 0;

-- Chamar o procedure
CALL GetTotalStockByCollection(@collection_id, @total_stock);

-- Devolve o resultado
SELECT @total_stock AS total_stock;


-- Criação da Procedure
-- A procedure GetAvailableProductsByLocation recebe um parâmetro location_id para especificar a localização desejada e retorna o número de 
-- produtos disponíveis nessa localização. Ele verifica se a quantidade do produto na tabela roupaLocalizacao é maior que 0.
USE mydb;
DELIMITER $$

CREATE PROCEDURE GetAvailableProductsByLocation(IN location_id INT, OUT available_products INT)
BEGIN
    SELECT COUNT(*) INTO available_products
    FROM PecaDeRoupa p
    WHERE p.peca_id IN (
        SELECT r.peca_id
        FROM roupaLocalizacao r
        WHERE r.loc_id = location_id
          AND r.pecaLoc_quantidade > 0
    );
END $$

DELIMITER ;
USE mydb;

-- Declarar variaveis 
SET @location_id := 1;
SET @available_products := 0;

-- Chama o procedure para a Loja de Roupas A
CALL GetAvailableProductsByLocation(@location_id, @available_products);

-- devolve o resultado
SELECT @available_products AS available_products;


-- ------------------------------------------------------
-- <fim>
-- ------------------------------------------------------
