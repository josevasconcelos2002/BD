-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Genero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Genero` (
  `genero_id` INT NOT NULL,
  `genero_descricao` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`genero_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Tipo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Tipo` (
  `tipo_id` INT NOT NULL,
  `tipo_descricao` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`tipo_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Marca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Marca` (
  `marca_id` INT NOT NULL,
  `marca_descricao` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`marca_id`));


-- -----------------------------------------------------
-- Table `mydb`.`PecaDeRoupa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PecaDeRoupa` (
  `peca_id` INT NOT NULL,
  `peca_nome` VARCHAR(75) NOT NULL,
  `tamanho` VARCHAR(10) NOT NULL,
  `stock` INT NOT NULL,
  `cor` VARCHAR(45) NOT NULL,
  `peca_descricao` VARCHAR(255) NOT NULL,
  `precovenda` DECIMAL(8,2) NOT NULL,
  `promocao` INT NULL,
  `genero_id` INT NOT NULL,
  `tipo_id` INT NOT NULL,
  `marca_id` INT NOT NULL,
  PRIMARY KEY (`peca_id`),
  INDEX `idGeneroFK_idx` (`genero_id` ASC) VISIBLE,
  INDEX `idTipoFK_idx` (`tipo_id` ASC) VISIBLE,
  INDEX `idMarcaFK_idx` (`marca_id` ASC) VISIBLE,
  CONSTRAINT `idGeneroFK`
    FOREIGN KEY (`genero_id`)
    REFERENCES `mydb`.`Genero` (`genero_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idTipoFK`
    FOREIGN KEY (`tipo_id`)
    REFERENCES `mydb`.`Tipo` (`tipo_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idMarcaFK`
    FOREIGN KEY (`marca_id`)
    REFERENCES `mydb`.`Marca` (`marca_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`Fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Fornecedor` (
  `NIF` INT NOT NULL,
  `for_nome` VARCHAR(75) NOT NULL,
  `for_rua` VARCHAR(100) NOT NULL,
  `for_localidade` VARCHAR(100) NOT NULL,
  `for_codigopostal` VARCHAR(45) NOT NULL,
  `for_email` VARCHAR(75) NOT NULL,
  PRIMARY KEY (`NIF`));


-- -----------------------------------------------------
-- Table `mydb`.`Colecao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Colecao` (
  `colecao_id` INT NOT NULL,
  `colecao_nome` VARCHAR(75) NOT NULL,
... (116 linhas)
Recolher
criacaoDB.sql
8 KB
sleep — Hoje às 18:17
povoamento 
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
... (114 linhas)
Recolher
povoamento.sql
8 KB
﻿
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
-- Povoamento da tabela "marca"
INSERT INTO marca 
	(marca_id, marca_descricao)
	VALUES 
		('Zara', 'Marca global de moda conhecida por suas tendências e preços acessíveis.'),
		('Gucci', 'Marca de luxo que oferece roupas, acessórios e artigos de couro sofisticados.'),
		('Nike', 'Marca líder em sportswear, oferecendo roupas esportivas e calçados inovadores.'),
		('H&M', 'Marca de moda acessível com uma ampla gama de roupas para mulheres, homens e crianças.'),
		('Chanel', 'Marca icônica de moda, perfumes e acessórios de luxo, conhecida por seu estilo clássico e elegante.')
	;
--
-- DELETE FROM marca;
-- SELECT * FROM marca;

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
-- Povoamento da tabela "Localizacao"
INSERT INTO localizacao 
	(loc_id, loc_descricao, loc_rua, loc_localizacao, loc_codigopostal,loc_telefone)
	VALUES
		(1, NULL, NULL, NULL, NULL, NULL),
		(2, NULL, NULL, NULL, NULL, NULL),
		(3, NULL, NULL, NULL, NULL, NULL),
		(4, NULL, NULL, NULL, NULL, NULL),
		(5, NULL, NULL, NULL, NULL, NULL)
	;
--
-- DELETE FROM localizacao;
-- SELECT * FROM localizacao;

--
-- Povoamento da tabela "Contacto"
INSERT INTO contacto 
	(id, telefone, idFornecedor)
	VALUES
		(1, NULL, NULL),
		(2, NULL, NULL),
		(3, NULL, NULL),
		(4, NULL, NULL),
		(5, NULL, NULL)
	;
--
-- DELETE FROM contacto;
-- SELECT * FROM contacto;

--
-- Povoamento da tabela "RoupaLocalizacao"
INSERT INTO roupaLocalizacao 
	(pecaLoc_quantidade, peca_id, loc_id)
	VALUES
		(1, NULL, NULL),
		(2, NULL, NULL),
		(3, NULL, NULL),
		(4, NULL, NULL),
		(5, NULL, NULL)
	;
--
-- DELETE FROM roupaLocalizacao;
-- SELECT * FROM roupaLocalizacao;


-- ------------------------------------------------------
-- <fim>
-- ------------------------------------------------------