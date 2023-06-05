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

-- Selecionar todos os registros da tabela "genero"
SELECT * FROM genero;

-- Selecionar todos os registros da tabela "tipo"
SELECT * FROM tipo;

-- Selecionar todos os registros da tabela "marca"
SELECT * FROM marca;

-- Selecionar todos os registros da tabela "colecao"
SELECT * FROM colecao;

-- Selecionar todos os registros da tabela "colecaofornecedor"
SELECT * FROM colecaofornecedor;

-- Selecionar todos os registros da tabela "fornecedor"
SELECT * FROM fornecedor;

-- Selecionar todos os registros da tabela "PecaDeRoupa"
SELECT * FROM PecaDeRoupa;

-- Selecionar todos os registros da tabela "PecaFornecedor"
SELECT * FROM PecaFornecedor;

-- Selecionar todos os registros da tabela "localizacao"
SELECT * FROM localizacao;

-- Selecionar todos os registros da tabela "contacto"
SELECT * FROM contacto;

-- Selecionar todos os registros da tabela "roupaLocalizacao"
SELECT * FROM roupaLocalizacao;

-- Selecionar todas as peças de roupa de uma determinada marca
USE mydb;
SELECT * FROM PecaDeRoupa WHERE marca_id = 1;

-- Selecionar todas as peças de roupa femininas
USE mydb;
SELECT * FROM PecaDeRoupa WHERE genero_id = 2;

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

-- Selecionar todas as peças de roupa que estão em promoção
USE mydb;
SELECT * FROM PecaDeRoupa WHERE promocao = 1;

-- Selecionar o total de peças de roupa em stock
USE mydb;
SELECT SUM(stock) AS total_stock FROM PecaDeRoupa;

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

-- Criação da Procedure
-- A procedure GetTotalStockByCollection recebe um parâmetro collection_id para 
-- especificar a coleção desejada e retorna a soma total do estoque de todas as 
-- peças de roupa relacionadas a essa coleção.
DELIMITER //

CREATE PROCEDURE GetTotalStockByCollection(IN collection_id INT, OUT total_stock INT)
BEGIN
    SELECT SUM(stock) INTO total_stock
    FROM PecaDeRoupa
    WHERE peca_id IN (
        SELECT peca_id
        FROM colecaofornecedor
        WHERE colecao_id = collection_id
    );
END //

DELIMITER ;

-- Criação de select
-- O select complexo retorna informações detalhadas sobre as peças de roupa que possuem 
-- estoque acima da média geral. Ele realiza joins entre as tabelas PecaDeRoupa, colecaofornecedor, colecao e fornecedor 
-- para obter os dados necessários. Os resultados são ordenados pelo estoque de forma decrescente.
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


-- Criação da Procedure
-- A procedure GetAvailableProductsByLocation recebe um parâmetro location_id para especificar a localização desejada e retorna o número de 
-- produtos disponíveis nessa localização. Ele verifica se a quantidade do produto na tabela roupaLocalizacao é maior que 0.
DELIMITER //

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
END //

DELIMITER ;

-- Criação de select
-- O select complexo retorna informações sobre os produtos, incluindo o nome da peça de roupa, a descrição da marca, o nome
-- da coleção e a quantidade total de produtos disponíveis em todos os fornecedores. A cláusula GROUP BY agrupa os resultados 
-- com base no nome da peça de roupa, a descrição da marca e o nome da coleção. A cláusula HAVING filtra os resultados para 
-- incluir apenas os produtos que têm uma quantidade igual ou superior a 2. Os resultados são ordenados pela quantidade de forma decrescente.
SELECT p.peca_nome, m.marca_descricao, c.colecao_nome, COUNT(*) AS quantidade
FROM PecaDeRoupa p
JOIN marca m ON p.marca_id = m.marca_id
JOIN colecaofornecedor cf ON p.peca_id = cf.peca_id
JOIN colecao c ON cf.colecao_id = c.colecao_id
JOIN PecaFornecedor pf ON p.peca_id = pf.peca_id
GROUP BY p.peca_nome, m.marca_descricao, c.colecao_nome
HAVING COUNT(*) >= 2
ORDER BY quantidade DESC;


-- ------------------------------------------------------
-- <fim>
-- ------------------------------------------------------
