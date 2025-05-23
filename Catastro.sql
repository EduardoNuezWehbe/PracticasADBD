-- MySQL Script generated by MySQL Workbench
-- vie 13 nov 2020 14:06:51 WET
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Bloque`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Bloque` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Bloque` (
  `idConstrucción` INT NOT NULL AUTO_INCREMENT,
  `Bloquecol` VARCHAR(45) NULL,
  PRIMARY KEY (`idConstrucción`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Piso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Piso` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Piso` (
  `Superficie` INT NULL,
  `Letra` VARCHAR(1) NOT NULL,
  `Planta` INT NOT NULL,
  `bloque` INT NULL,
  INDEX `bloque_idx` (`bloque` ASC),
  PRIMARY KEY (`Letra`, `Planta`),
  CONSTRAINT `bloque`
    FOREIGN KEY (`bloque`)
    REFERENCES `mydb`.`Bloque` (`idConstrucción`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Unifamiliar`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Unifamiliar` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Unifamiliar` (
  `Superficie` INT NULL,
  `NumeroHabitaciones` VARCHAR(45) NULL,
  `idConstrucción` INT GENERATED ALWAYS AS (),
  PRIMARY KEY (`idConstrucción`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Persona`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Persona` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Persona` (
  `DNI` VARCHAR(9) NOT NULL,
  `Fecha_nacimiento` DATE NULL,
  `Estudios` VARCHAR(45) NULL,
  `Nombre` VARCHAR(20) NULL,
  `Cabeza_familia` VARCHAR(9) NOT NULL,
  `piso` VARCHAR(45) NULL,
  `Unifamiliar` INT NULL,
  PRIMARY KEY (`DNI`),
  INDEX `piso_idx` (`piso` ASC),
  INDEX `Cabeza_familia_idx` (`Cabeza_familia` ASC),
  INDEX `unifamiliar_idx` (`Unifamiliar` ASC),
  CONSTRAINT `Cabeza_familia`
    FOREIGN KEY (`Cabeza_familia`)
    REFERENCES `mydb`.`Persona` (`DNI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `piso`
    FOREIGN KEY (`piso`)
    REFERENCES `mydb`.`Piso` (`Letra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `unifamiliar`
    FOREIGN KEY (`Unifamiliar`)
    REFERENCES `mydb`.`Unifamiliar` (`idConstrucción`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Zona`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Zona` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Zona` (
  `Nombre` VARCHAR(45) GENERATED ALWAYS AS (),
  `Zona` VARCHAR(45) NULL,
  `Ubicacion` VARCHAR(45) NULL,
  `Concejal` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Nombre`),
  UNIQUE INDEX `Concejal_UNIQUE` (`Concejal` ASC),
  UNIQUE INDEX `Ubicacion_UNIQUE` (`Ubicacion` ASC),
  UNIQUE INDEX `Zona_UNIQUE` (`Zona` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Calle`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Calle` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Calle` (
  `Nombre` VARCHAR(45) NOT NULL,
  `Carriles` INT NULL,
  `Longitud` INT NULL,
  `Zona` VARCHAR(45) NOT NULL,
  `Tipo` VARCHAR(45) NULL,
  PRIMARY KEY (`Nombre`),
  UNIQUE INDEX `Zona_UNIQUE` (`Zona` ASC),
  CONSTRAINT `zona`
    FOREIGN KEY (`Zona`)
    REFERENCES `mydb`.`Zona` (`Nombre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Construcción`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Construcción` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Construcción` (
  `Numero` INT NOT NULL,
  `CoordenadaGeografica` VARCHAR(45) NOT NULL,
  `Superficie` INT NOT NULL,
  `calle` VARCHAR(45) NOT NULL,
  `Bloque` INT NULL,
  `Unifamiliar` INT NULL,
  UNIQUE INDEX `CoordenadaGeografica_UNIQUE` (`CoordenadaGeografica` ASC),
  INDEX `calle_idx` (`calle` ASC),
  PRIMARY KEY (`Numero`),
  INDEX `bloque_idx` (`Bloque` ASC),
  INDEX `unifamiliar_idx` (`Unifamiliar` ASC),
  CONSTRAINT `calle`
    FOREIGN KEY (`calle`)
    REFERENCES `mydb`.`Calle` (`Nombre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `bloque`
    FOREIGN KEY (`Bloque`)
    REFERENCES `mydb`.`Bloque` (`idConstrucción`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `unifamiliar`
    FOREIGN KEY (`Unifamiliar`)
    REFERENCES `mydb`.`Unifamiliar` (`idConstrucción`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
