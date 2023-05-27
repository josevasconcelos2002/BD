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
-- Table `mydb`.`Marca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Marca` (
  `nome` VARCHAR(75) NOT NULL,
  `país_Origem` VARCHAR(75) NOT NULL,
  `descrição` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`nome`));


-- -----------------------------------------------------
-- Table `mydb`.`Coleção`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Coleção` (
  `id` INT NOT NULL,
  `nome` VARCHAR(75) NOT NULL,
  `ano` DATE NOT NULL,
  `descrição` VARCHAR(255) NOT NULL,
  `Estação` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `mydb`.`Peça de Roupa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Peça de Roupa` (
  `id` INT NOT NULL,
  `nome` VARCHAR(75) NOT NULL,
  `gênero` VARCHAR(20) NOT NULL,
  `tamanho` VARCHAR(10) NOT NULL,
  `stock` INT NOT NULL,
  `cor` VARCHAR(45) NOT NULL,
  `descrição` VARCHAR(255) NOT NULL,
  `tipo` VARCHAR(45) NOT NULL,
  `preçoVenda` DECIMAL(8,2) NOT NULL,
  `Promoção` INT NULL,
  `Marca_nome` VARCHAR(75) NOT NULL,
  `Coleção_id` INT NOT NULL,
  PRIMARY KEY (`id`, `Marca_nome`, `Coleção_id`),
  INDEX `fk_Peça de Roupa_Marca_idx` (`Marca_nome` ASC) VISIBLE,
  INDEX `fk_Peça de Roupa_Coleção1_idx` (`Coleção_id` ASC) VISIBLE,
  CONSTRAINT `fk_Peça de Roupa_Marca`
    FOREIGN KEY (`Marca_nome`)
    REFERENCES `mydb`.`Marca` (`nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Peça de Roupa_Coleção1`
    FOREIGN KEY (`Coleção_id`)
    REFERENCES `mydb`.`Coleção` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`Fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Fornecedor` (
  `NIF` INT NOT NULL,
  `nome` VARCHAR(75) NOT NULL,
  `rua` VARCHAR(100) NOT NULL,
  `email` VARCHAR(75) NOT NULL,
  `telefone` INT NOT NULL,
  `Localidade` VARCHAR(100) NOT NULL,
  `CodPost` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`NIF`));


-- -----------------------------------------------------
-- Table `mydb`.`RoupaFornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`RoupaFornecedor` (
  `Peça de Roupa_id` INT NOT NULL,
  `Roupa_Marca_nome` VARCHAR(75) NOT NULL,
  `Fornecedor_NIF` INT NOT NULL,
  `PreçoComp` DECIMAL(8) NOT NULL,
  `DataFornecimento` DATE NOT NULL,
  `Quantidade` INT NOT NULL,
  PRIMARY KEY (`Peça de Roupa_id`, `Roupa_Marca_nome`, `Fornecedor_NIF`),
  INDEX `fk_Peça de Roupa_has_Fornecedor_Fornecedor1_idx` (`Fornecedor_NIF` ASC) VISIBLE,
  INDEX `fk_Peça de Roupa_has_Fornecedor_Peça de Roupa1_idx` (`Peça de Roupa_id` ASC, `Roupa_Marca_nome` ASC) VISIBLE,
  CONSTRAINT `fk_Peça de Roupa_has_Fornecedor_Peça de Roupa1`
    FOREIGN KEY (`Peça de Roupa_id` , `Roupa_Marca_nome`)
    REFERENCES `mydb`.`Peça de Roupa` (`id` , `Marca_nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Peça de Roupa_has_Fornecedor_Fornecedor1`
    FOREIGN KEY (`Fornecedor_NIF`)
    REFERENCES `mydb`.`Fornecedor` (`NIF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`ColeçãoFornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ColeçãoFornecedor` (
  `Coleção_id` INT NOT NULL,
  `Fornecedor_NIF` INT NOT NULL,
  `PreçoComp` DECIMAL(8,2) NOT NULL,
  `DataFornecimento` DATE NOT NULL,
  `Quantidade` INT NOT NULL,
  PRIMARY KEY (`Coleção_id`, `Fornecedor_NIF`),
  INDEX `fk_Coleção_has_Fornecedor_Fornecedor1_idx` (`Fornecedor_NIF` ASC) VISIBLE,
  INDEX `fk_Coleção_has_Fornecedor_Coleção1_idx` (`Coleção_id` ASC) VISIBLE,
  CONSTRAINT `fk_Coleção_has_Fornecedor_Coleção1`
    FOREIGN KEY (`Coleção_id`)
    REFERENCES `mydb`.`Coleção` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Coleção_has_Fornecedor_Fornecedor1`
    FOREIGN KEY (`Fornecedor_NIF`)
    REFERENCES `mydb`.`Fornecedor` (`NIF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
