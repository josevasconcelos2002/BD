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
  `ano` DATE NOT NULL,
  `colecao_descricao` VARCHAR(255) NOT NULL,
  `estacao` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`colecao_id`));


-- -----------------------------------------------------
-- Table `mydb`.`PecaFornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PecaFornecedor` (
  `pecaFor_precocompra` DECIMAL(8) NOT NULL,
  `pecaFor_datafornecimento` DATE NOT NULL,
  `quantidade` INT NOT NULL,
  `peca_id` INT NOT NULL,
  `for_NIF` INT NOT NULL,
  PRIMARY KEY (`peca_id`, `for_NIF`),
  INDEX `idFornecedor_idx` (`for_NIF` ASC) VISIBLE,
  CONSTRAINT `idPeçaFK`
    FOREIGN KEY (`peca_id`)
    REFERENCES `mydb`.`PecaDeRoupa` (`peca_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idFornecedor`
    FOREIGN KEY (`for_NIF`)
    REFERENCES `mydb`.`Fornecedor` (`NIF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`Localizacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Localizacao` (
  `loc_id` INT NOT NULL,
  `loc_descricao` VARCHAR(45) NOT NULL,
  `loc_rua` VARCHAR(100) NOT NULL,
  `loc_localizacao` VARCHAR(100) NOT NULL,
  `loc_codigopostal` VARCHAR(45) NOT NULL,
  `loc_telefone` INT NOT NULL,
  PRIMARY KEY (`loc_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Contacto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Contacto` (
  `id` INT NOT NULL,
  `telefone` INT NOT NULL,
  `idFornecedor` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `idFornecedorFK_idx` (`idFornecedor` ASC) VISIBLE,
  CONSTRAINT `idFornecedorFK`
    FOREIGN KEY (`idFornecedor`)
    REFERENCES `mydb`.`Fornecedor` (`NIF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`RoupaLocalizacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`RoupaLocalizacao` (
  `pecaLoc_quantidade` INT NOT NULL,
  `peca_id` INT NULL,
  `loc_id` INT NULL,
  INDEX `peca_id_idx` (`peca_id` ASC) VISIBLE,
  INDEX `loc_id_idx` (`loc_id` ASC) VISIBLE,
  CONSTRAINT `peca_id`
    FOREIGN KEY (`peca_id`)
    REFERENCES `mydb`.`PecaDeRoupa` (`peca_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `loc_id`
    FOREIGN KEY (`loc_id`)
    REFERENCES `mydb`.`Localizacao` (`loc_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ColecaoFornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ColecaoFornecedor` (
  `precocompra` DECIMAL(8) NOT NULL,
  `datafornecimento` DATE NOT NULL,
  `pecaColFor_quantidade` INT NOT NULL,
  `peca_id` INT NOT NULL,
  `for_NIF` INT NOT NULL,
  `colecao_id` INT NOT NULL,
  PRIMARY KEY (`peca_id`, `for_NIF`, `colecao_id`),
  INDEX `idFornecedor_idx` (`for_NIF` ASC) VISIBLE,
  INDEX `idColecaoFK_idx` (`colecao_id` ASC) VISIBLE,
  CONSTRAINT `idPeçaFK0`
    FOREIGN KEY (`peca_id`)
    REFERENCES `mydb`.`PecaDeRoupa` (`peca_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idFornecedor0`
    FOREIGN KEY (`for_NIF`)
    REFERENCES `mydb`.`Fornecedor` (`NIF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idColecaoFK`
    FOREIGN KEY (`colecao_id`)
    REFERENCES `mydb`.`Colecao` (`colecao_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;