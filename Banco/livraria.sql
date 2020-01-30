-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema livraria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema livraria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `livraria` DEFAULT CHARACTER SET utf8 ;
USE `livraria` ;

-- -----------------------------------------------------
-- Table `livraria`.`Autores`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `livraria`.`Autores` ;

CREATE TABLE IF NOT EXISTS `livraria`.`Autores` (
  `idAutores` INT NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `dataNascimento` VARCHAR(45) NOT NULL,
  `dataFalecimento` VARCHAR(45) NULL,
  `localNascimento` VARCHAR(45) NOT NULL,
  `localFalescimento` VARCHAR(45) NULL,
  `resumo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idAutores`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `livraria`.`Categoria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `livraria`.`Categoria` ;

CREATE TABLE IF NOT EXISTS `livraria`.`Categoria` (
  `idCategoria` INT NOT NULL AUTO_INCREMENT,
  `Categoria` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCategoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `livraria`.`Estado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `livraria`.`Estado` ;

CREATE TABLE IF NOT EXISTS `livraria`.`Estado` (
  `Sigla` INT NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Sigla`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cidade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `livraria`.`Cidade` ;

CREATE TABLE IF NOT EXISTS `livraria`.`Cidade` (
  `idCidade` INT NOT NULL,
  `Sigla` VARCHAR(45) NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Estado_Sigla` INT NOT NULL,
  PRIMARY KEY (`idCidade`),
  INDEX `fk_Cidade_Estado_idx` (`Estado_Sigla` ASC),
  CONSTRAINT `fk_Cidade_Estado`
    FOREIGN KEY (`Estado_Sigla`)
    REFERENCES `mydb`.`Estado` (`Sigla`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `livraria`.`TipoEnd`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `livraria`.`TipoEnd` ;

CREATE TABLE IF NOT EXISTS `livraria`.`TipoEnd` (
  `idTipoEnd` INT NOT NULL,
  `tipoEnd` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTipoEnd`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `livraria`.`Endereco`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `livraria`.`Endereco` ;

CREATE TABLE IF NOT EXISTS `livraria`.`Endereco` (
  `idEndereco` INT NOT NULL,
  `Rua` VARCHAR(45) NOT NULL,
  `Bairro` VARCHAR(45) NOT NULL,
  `Complemento` VARCHAR(45) NOT NULL,
  `Cidade_idCidade` INT NOT NULL,
  `TipoEnd_idTipoEnd` INT NOT NULL,
  PRIMARY KEY (`idEndereco`),
  INDEX `fk_Endereco_Cidade1_idx` (`Cidade_idCidade` ASC),
  INDEX `fk_Endereco_TipoEnd1_idx` (`TipoEnd_idTipoEnd` ASC),
  CONSTRAINT `fk_Endereco_Cidade1`
    FOREIGN KEY (`Cidade_idCidade`)
    REFERENCES `mydb`.`Cidade` (`idCidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Endereco_TipoEnd1`
    FOREIGN KEY (`TipoEnd_idTipoEnd`)
    REFERENCES `mydb`.`TipoEnd` (`idTipoEnd`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `livraria`.`Email`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `livraria`.`Email` ;

CREATE TABLE IF NOT EXISTS `livraria`.`Email` (
  `idEmail` INT NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idEmail`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `livraria`.`Telefone`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `livraria`.`Telefone` ;

CREATE TABLE IF NOT EXISTS `livraria`.`Telefone` (
  `idTelefone` INT NOT NULL,
  `numero` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTelefone`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `livraria`.`Editora`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `livraria`.`Editora` ;

CREATE TABLE IF NOT EXISTS `livraria`.`Editora` (
  `CNPJ` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `Endereco_idEndereco` INT NOT NULL,
  `Email_idEmail` INT NOT NULL,
  `Telefone_idTelefone` INT NOT NULL,
  PRIMARY KEY (`CNPJ`),
  INDEX `fk_Editora_Endereco1_idx` (`Endereco_idEndereco` ASC) ,
  INDEX `fk_Editora_Email1_idx` (`Email_idEmail` ASC) ,
  INDEX `fk_Editora_Telefone1_idx` (`Telefone_idTelefone` ASC) ,
  CONSTRAINT `fk_Editora_Endereco1`
    FOREIGN KEY (`Endereco_idEndereco`)
    REFERENCES `mydb`.`Endereco` (`idEndereco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Editora_Email1`
    FOREIGN KEY (`Email_idEmail`)
    REFERENCES `mydb`.`Email` (`idEmail`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Editora_Telefone1`
    FOREIGN KEY (`Telefone_idTelefone`)
    REFERENCES `mydb`.`Telefone` (`idTelefone`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Livro`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `livraria`.`Livro` ;

CREATE TABLE IF NOT EXISTS `livraria`.`Livro` (
  `ISBN` INT UNSIGNED NOT NULL,
  `titulo` VARCHAR(45) NOT NULL,
  `formato` VARCHAR(45) NOT NULL,
  `paginas` VARCHAR(45) NOT NULL,
  `datapub` VARCHAR(45) NOT NULL,
  `preco` VARCHAR(45) NOT NULL,
  `custo` VARCHAR(45) NOT NULL,
  `lucro` VARCHAR(45) NOT NULL,
  `resumo` VARCHAR(300) NOT NULL,
  `Autores_idAutores` INT NOT NULL,
  `Categoria_idCategoria` INT NOT NULL,
  `Editora_CNPJ` INT NOT NULL,
  PRIMARY KEY (`ISBN`, `Autores_idAutores`),
  INDEX `fk_Livro_Autores1_idx` (`Autores_idAutores` ASC) ,
  INDEX `fk_Livro_Categoria1_idx` (`Categoria_idCategoria` ASC) ,
  INDEX `fk_Livro_Editora1_idx` (`Editora_CNPJ` ASC),
  CONSTRAINT `fk_Livro_Autores1`
    FOREIGN KEY (`Autores_idAutores`)
    REFERENCES `mydb`.`Autores` (`idAutores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Livro_Categoria1`
    FOREIGN KEY (`Categoria_idCategoria`)
    REFERENCES `mydb`.`Categoria` (`idCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Livro_Editora1`
    FOREIGN KEY (`Editora_CNPJ`)
    REFERENCES `mydb`.`Editora` (`CNPJ`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `livraria`.`Cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `livraria`.`Cliente` ;

CREATE TABLE IF NOT EXISTS `livraria`.`Cliente` (
  `CPF` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `dataNascimento` VARCHAR(45) NOT NULL,
  `formaPag` VARCHAR(45) NOT NULL,
  `Endereco_idEndereco` INT NOT NULL,
  `Telefone_idTelefone` INT NOT NULL,
  `Email_idEmail` INT NOT NULL,
  PRIMARY KEY (`CPF`),
  INDEX `fk_Cliente_Endereco1_idx` (`Endereco_idEndereco` ASC) ,
  INDEX `fk_Cliente_Telefone1_idx` (`Telefone_idTelefone` ASC) ,
  INDEX `fk_Cliente_Email1_idx` (`Email_idEmail` ASC),
  CONSTRAINT `fk_Cliente_Endereco1`
    FOREIGN KEY (`Endereco_idEndereco`)
    REFERENCES `mydb`.`Endereco` (`idEndereco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cliente_Telefone1`
    FOREIGN KEY (`Telefone_idTelefone`)
    REFERENCES `mydb`.`Telefone` (`idTelefone`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cliente_Email1`
    FOREIGN KEY (`Email_idEmail`)
    REFERENCES `mydb`.`Email` (`idEmail`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `livraria`.`Carrinho`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `livraria`.`Carrinho` ;

CREATE TABLE IF NOT EXISTS `livraria`.`Carrinho` (
  `idCarrinho` INT NOT NULL,
  `Cliente_CPF` INT NOT NULL,
  PRIMARY KEY (`idCarrinho`, `Cliente_CPF`),
  INDEX `fk_Carrinho_Cliente1_idx` (`Cliente_CPF` ASC) ,
  CONSTRAINT `fk_Carrinho_Cliente1`
    FOREIGN KEY (`Cliente_CPF`)
    REFERENCES `mydb`.`Cliente` (`CPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `livraria`.`Pedidos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `livraria`.`Pedidos` ;

CREATE TABLE IF NOT EXISTS `livraria`.`Pedidos` (
  `idPedidos` INT NOT NULL,
  `Cliente_CPF` INT NOT NULL,
  PRIMARY KEY (`idPedidos`),
  INDEX `fk_Pedidos_Cliente1_idx` (`Cliente_CPF` ASC) ,
  CONSTRAINT `fk_Pedidos_Cliente1`
    FOREIGN KEY (`Cliente_CPF`)
    REFERENCES `mydb`.`Cliente` (`CPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `livraria`.`Estoque`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `livraria`.`Estoque` ;

CREATE TABLE IF NOT EXISTS `livraria`.`Estoque` (
  `Livro_ISBN` INT UNSIGNED NOT NULL,
  `Livro_Autores_idAutores` INT NOT NULL,
  `Quantidade` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Livro_ISBN`, `Livro_Autores_idAutores`),
  CONSTRAINT `fk_Estoque_Livro1`
    FOREIGN KEY (`Livro_ISBN` , `Livro_Autores_idAutores`)
    REFERENCES `mydb`.`Livro` (`ISBN` , `Autores_idAutores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `livraria`.`Autores_has_Livro`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `livraria`.`Autores_has_Livro` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Autores_has_Livro` (
  `Autores_idAutores` INT NOT NULL,
  `Livro_ISBN` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`Autores_idAutores`, `Livro_ISBN`),
  INDEX `fk_Autores_has_Livro_Livro1_idx` (`Livro_ISBN` ASC) ,
  INDEX `fk_Autores_has_Livro_Autores1_idx` (`Autores_idAutores` ASC),
  CONSTRAINT `fk_Autores_has_Livro_Autores1`
    FOREIGN KEY (`Autores_idAutores`)
    REFERENCES `mydb`.`Autores` (`idAutores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Autores_has_Livro_Livro1`
    FOREIGN KEY (`Livro_ISBN`)
    REFERENCES `mydb`.`Livro` (`ISBN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `livraria`.`Livro_has_Pedidos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `livraria`.`Livro_has_Pedidos` ;

CREATE TABLE IF NOT EXISTS `livraria`.`Livro_has_Pedidos` (
  `Livro_ISBN` INT UNSIGNED NOT NULL,
  `Livro_Autores_idAutores` INT NOT NULL,
  `Pedidos_idPedidos` INT NOT NULL,
  PRIMARY KEY (`Livro_ISBN`, `Livro_Autores_idAutores`, `Pedidos_idPedidos`),
  INDEX `fk_Livro_has_Pedidos_Pedidos1_idx` (`Pedidos_idPedidos` ASC) ,
  INDEX `fk_Livro_has_Pedidos_Livro1_idx` (`Livro_ISBN` ASC, `Livro_Autores_idAutores` ASC) ,
  CONSTRAINT `fk_Livro_has_Pedidos_Livro1`
    FOREIGN KEY (`Livro_ISBN` , `Livro_Autores_idAutores`)
    REFERENCES `mydb`.`Livro` (`ISBN` , `Autores_idAutores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Livro_has_Pedidos_Pedidos1`
    FOREIGN KEY (`Pedidos_idPedidos`)
    REFERENCES `mydb`.`Pedidos` (`idPedidos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `livraria`.`Livro_has_Carrinho`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `livraria`.`Livro_has_Carrinho` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Livro_has_Carrinho` (
  `Livro_ISBN` INT UNSIGNED NOT NULL,
  `Livro_Autores_idAutores` INT NOT NULL,
  `Carrinho_idCarrinho` INT NOT NULL,
  PRIMARY KEY (`Livro_ISBN`, `Livro_Autores_idAutores`, `Carrinho_idCarrinho`),
  INDEX `fk_Livro_has_Carrinho_Carrinho1_idx` (`Carrinho_idCarrinho` ASC) ,
  INDEX `fk_Livro_has_Carrinho_Livro1_idx` (`Livro_ISBN` ASC, `Livro_Autores_idAutores` ASC) ,
  CONSTRAINT `fk_Livro_has_Carrinho_Livro1`
    FOREIGN KEY (`Livro_ISBN` , `Livro_Autores_idAutores`)
    REFERENCES `mydb`.`Livro` (`ISBN` , `Autores_idAutores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Livro_has_Carrinho_Carrinho1`
    FOREIGN KEY (`Carrinho_idCarrinho`)
    REFERENCES `mydb`.`Carrinho` (`idCarrinho`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
