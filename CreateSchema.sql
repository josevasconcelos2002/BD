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

-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION,TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Marca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Marca` (
  `Nome` VARCHAR(75) NOT NULL,
  `Pais_Origem` VARCHAR(75) NOT NULL,
  `Descricao` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`nome`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Coleção`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Colecao` (
  `Id` INT NOT NULL,
  `Nome` VARCHAR(75) NOT NULL,
  `Ano` DATE NOT NULL,
  `Descricao` VARCHAR(255) NOT NULL,
  `Estacao` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Peça de Roupa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PecaDRoupa` (
  `Id` INT NOT NULL,
  `Nome` VARCHAR(75) NOT NULL,
  `Genero` VARCHAR(20) NOT NULL,
  `Tamanho` VARCHAR(10) NOT NULL,
  `Stock` INT NOT NULL,
  `Cor` VARCHAR(45) NOT NULL,
  `Descricao` VARCHAR(255) NOT NULL,
  `Tipo` VARCHAR(45) NOT NULL,
  `PrecoVenda` DECIMAL(8,2) NOT NULL,
  `Promocao` INT NULL,
  `Marca_nome` VARCHAR(75) NOT NULL,
  `Colecao_id` INT NULL,
  PRIMARY KEY (`Id`, `Marca_nome`),
  INDEX `fk_PecaDRoupa_Marca_idx` (`Marca_nome` ASC) VISIBLE,
  INDEX `fk_PecaDRoupa_Colecao1_idx` (`Colecao_id` ASC) VISIBLE,
  CONSTRAINT `fk_PecaDRoupa_Marca`
    FOREIGN KEY (`Marca_nome`)
    REFERENCES `mydb`.`Marca` (`Nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PecaDRoupa_Colecao1`
    FOREIGN KEY (`Colecao_id`)
    REFERENCES `mydb`.`Colecao` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;



-- -----------------------------------------------------
-- Table `mydb`.`Fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Fornecedor` (
  `NIF` INT NOT NULL,
  `Nome` VARCHAR(75) NOT NULL,
  `Rua` VARCHAR(100) NOT NULL,
  `Email` VARCHAR(75) NOT NULL,
  `Telefone` INT NOT NULL,
  `Localidade` VARCHAR(100) NOT NULL,
  `CodPost` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`NIF`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`RoupaFornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`RoupaFornecedor` (
  `PecaDRoupa_id` INT NOT NULL,
  `Roupa_Marca_nome` VARCHAR(75) NOT NULL,
  `Fornecedor_NIF` INT NOT NULL,
  `PrecoComp` DECIMAL(8) NOT NULL,
  `DataFornecimento` DATE NOT NULL,
  `Quantidade` INT NOT NULL,
  PRIMARY KEY (`PecaDRoupa_id`, `Roupa_Marca_nome`, `Fornecedor_NIF`),
  INDEX `fk_PecaDRoupa_has_Fornecedor_Fornecedor1_idx` (`Fornecedor_NIF` ASC) VISIBLE,
  INDEX `fk_PecaDRoupa_has_Fornecedor_PecaDRoupa1_idx` (`PecaDRoupa_id` ASC, `Roupa_Marca_nome` ASC) VISIBLE,
  CONSTRAINT `fk_PecaDRoupa_has_Fornecedor_PecaDRoupa1`
    FOREIGN KEY (`PecaDRoupa_id` , `Roupa_Marca_nome`)
    REFERENCES `mydb`.`PecaDRoupa` (`id` , `Marca_nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PecaDRoupa_has_Fornecedor_Fornecedor1`
    FOREIGN KEY (`Fornecedor_NIF`)
    REFERENCES `mydb`.`Fornecedor` (`NIF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ColeçãoFornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ColecaoFornecedor` (
  `Colecao_id` INT NOT NULL,
  `Fornecedor_NIF` INT NOT NULL,
  `PrecoComp` DECIMAL(8,2) NOT NULL,
  `DataFornecimento` DATE NOT NULL,
  `Quantidade` INT NOT NULL,
  PRIMARY KEY (`Colecao_id`, `Fornecedor_NIF`),
  INDEX `fk_Colecao_has_Fornecedor_Fornecedor1_idx` (`Fornecedor_NIF` ASC) VISIBLE,
  INDEX `fk_Colecao_has_Fornecedor_Colecao1_idx` (`Colecao_id` ASC) VISIBLE,
  CONSTRAINT `fk_Colecao_has_Fornecedor_Colecao1`
    FOREIGN KEY (`Colecao_id`)
    REFERENCES `mydb`.`Colecao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Colecao_has_Fornecedor_Fornecedor1`
    FOREIGN KEY (`Fornecedor_NIF`)
    REFERENCES `mydb`.`Fornecedor` (`NIF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
  ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- ------------------------------------------------------
-- <fim>
-- ------------------------------------------------------
