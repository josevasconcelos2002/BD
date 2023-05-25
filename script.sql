-- MySQL Script generated by MySQL Workbench
-- qui 25 mai 2023 19:53:49
-- Model: New Model    Version: 1.0
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
  `nome` VARCHAR(50) NOT NULL,
  `país_Origem` VARCHAR(255) NOT NULL,
  `descrição` VARCHAR(45) NULL,
  `Peça de Roupa_id` INT NOT NULL,
  `Peça de Roupa_Marca_nome` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`nome`, `Peça de Roupa_id`, `Peça de Roupa_Marca_nome`),
  INDEX `fk_Marca_Peça de Roupa1_idx` (`Peça de Roupa_id` ASC, `Peça de Roupa_Marca_nome` ASC) VISIBLE,
  CONSTRAINT `fk_Marca_Peça de Roupa1`
    FOREIGN KEY (`Peça de Roupa_id` , `Peça de Roupa_Marca_nome`)
    REFERENCES `mydb`.`Peça de Roupa` (`id` , `Marca_nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`Coleção`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Coleção` (
  `id` INT NOT NULL,
  `nome` VARCHAR(255) NOT NULL,
  `ano` VARCHAR(45) NOT NULL,
  `descrição` VARCHAR(45) NOT NULL,
  `Estação` VARCHAR(45) NOT NULL,
  `Peça de Roupa_id` INT NOT NULL,
  `Peça de Roupa_Marca_nome` VARCHAR(50) NOT NULL,
  `Peça de Roupa_Coleção_id` INT NOT NULL,
  PRIMARY KEY (`id`, `Peça de Roupa_id`, `Peça de Roupa_Marca_nome`, `Peça de Roupa_Coleção_id`),
  INDEX `fk_Coleção_Peça de Roupa1_idx` (`Peça de Roupa_id` ASC, `Peça de Roupa_Marca_nome` ASC, `Peça de Roupa_Coleção_id` ASC) VISIBLE,
  CONSTRAINT `fk_Coleção_Peça de Roupa1`
    FOREIGN KEY (`Peça de Roupa_id` , `Peça de Roupa_Marca_nome` , `Peça de Roupa_Coleção_id`)
    REFERENCES `mydb`.`Peça de Roupa` (`id` , `Marca_nome` , `Coleção_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`Peça de Roupa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Peça de Roupa` (
  `id` INT NOT NULL,
  `nome` VARCHAR(255) NOT NULL,
  `gênero` VARCHAR(20) NOT NULL,
  `tamanho` VARCHAR(45) NOT NULL,
  `stock` INT NOT NULL,
  `cor` VARCHAR(45) NOT NULL,
  `descrição` VARCHAR(45) NOT NULL,
  `tipo` VARCHAR(45) NOT NULL,
  `preçoVenda` VARCHAR(45) NOT NULL,
  `Promoção` VARCHAR(45) NULL,
  `Marca_nome` VARCHAR(50) NOT NULL,
  `Coleção_id` INT NOT NULL,
  PRIMARY KEY (`id`, `Marca_nome`, `Coleção_id`),
  INDEX `fk_Peça de Roupa_Marca1_idx` (`Marca_nome` ASC) VISIBLE,
  INDEX `fk_Peça de Roupa_Coleção1_idx` (`Coleção_id` ASC) VISIBLE,
  CONSTRAINT `fk_Peça de Roupa_Marca1`
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
  `nome` VARCHAR(255) NOT NULL,
  `morada` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `telefone` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`NIF`));


-- -----------------------------------------------------
-- Table `mydb`.`Peça de Roupa_has_Fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Peça de Roupa_has_Fornecedor` (
  `Peça de Roupa_id` INT NOT NULL,
  `Peça de Roupa_Marca_nome` VARCHAR(50) NOT NULL,
  `Peça de Roupa_Coleção_id` INT NOT NULL,
  `Fornecedor_NIF` INT NOT NULL,
  `Preço_compra` INT NOT NULL,
  `Data_Fornecimento` VARCHAR(45) NOT NULL,
  `Quantidade` INT NOT NULL,
  PRIMARY KEY (`Peça de Roupa_id`, `Peça de Roupa_Marca_nome`, `Peça de Roupa_Coleção_id`, `Fornecedor_NIF`),
  INDEX `fk_Peça de Roupa_has_Fornecedor_Fornecedor1_idx` (`Fornecedor_NIF` ASC) VISIBLE,
  INDEX `fk_Peça de Roupa_has_Fornecedor_Peça de Roupa1_idx` (`Peça de Roupa_id` ASC, `Peça de Roupa_Marca_nome` ASC, `Peça de Roupa_Coleção_id` ASC) VISIBLE,
  CONSTRAINT `fk_Peça de Roupa_has_Fornecedor_Peça de Roupa1`
    FOREIGN KEY (`Peça de Roupa_id` , `Peça de Roupa_Marca_nome` , `Peça de Roupa_Coleção_id`)
    REFERENCES `mydb`.`Peça de Roupa` (`id` , `Marca_nome` , `Coleção_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Peça de Roupa_has_Fornecedor_Fornecedor1`
    FOREIGN KEY (`Fornecedor_NIF`)
    REFERENCES `mydb`.`Fornecedor` (`NIF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`Coleção_has_Fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Coleção_has_Fornecedor` (
  `Coleção_id` INT NOT NULL,
  `Coleção_Peça de Roupa_id` INT NOT NULL,
  `Coleção_Peça de Roupa_Marca_nome` VARCHAR(50) NOT NULL,
  `Coleção_Peça de Roupa_Coleção_id` INT NOT NULL,
  `Fornecedor_NIF` INT NOT NULL,
  PRIMARY KEY (`Coleção_id`, `Coleção_Peça de Roupa_id`, `Coleção_Peça de Roupa_Marca_nome`, `Coleção_Peça de Roupa_Coleção_id`, `Fornecedor_NIF`),
  INDEX `fk_Coleção_has_Fornecedor_Fornecedor1_idx` (`Fornecedor_NIF` ASC) VISIBLE,
  INDEX `fk_Coleção_has_Fornecedor_Coleção1_idx` (`Coleção_id` ASC, `Coleção_Peça de Roupa_id` ASC, `Coleção_Peça de Roupa_Marca_nome` ASC, `Coleção_Peça de Roupa_Coleção_id` ASC) VISIBLE,
  CONSTRAINT `fk_Coleção_has_Fornecedor_Coleção1`
    FOREIGN KEY (`Coleção_id` , `Coleção_Peça de Roupa_id` , `Coleção_Peça de Roupa_Marca_nome` , `Coleção_Peça de Roupa_Coleção_id`)
    REFERENCES `mydb`.`Coleção` (`id` , `Peça de Roupa_id` , `Peça de Roupa_Marca_nome` , `Peça de Roupa_Coleção_id`)
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
