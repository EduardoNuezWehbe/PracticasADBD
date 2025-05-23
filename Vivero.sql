-- MySQL Script generated by MySQL Workbench
-- vie 13 nov 2020 14:06:00 WET
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
-- Table `mydb`.`vivero`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`vivero` ;

CREATE TABLE IF NOT EXISTS `mydb`.`vivero` (
  `ubicación` VARCHAR(45) NOT NULL,
  `id` INT NULL,
  `cierre` VARCHAR(45) NULL,
  `apertura` VARCHAR(45) NULL,
  PRIMARY KEY (`ubicación`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`zona`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`zona` ;

CREATE TABLE IF NOT EXISTS `mydb`.`zona` (
  `n_zona` INT NOT NULL,
  `ubicación` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`n_zona`, `ubicación`),
  INDEX `vivero_idx` (`ubicación` ASC),
  CONSTRAINT `vivero`
    FOREIGN KEY (`ubicación`)
    REFERENCES `mydb`.`vivero` (`ubicación`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`empleado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`empleado` ;

CREATE TABLE IF NOT EXISTS `mydb`.`empleado` (
  `dni` INT NOT NULL,
  `seguridad_social` INT NOT NULL,
  `teléfono` INT NULL,
  `nombre` VARCHAR(45) NULL,
  `apellidos` VARCHAR(45) NULL,
  PRIMARY KEY (`dni`, `seguridad_social`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`producto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`producto` ;

CREATE TABLE IF NOT EXISTS `mydb`.`producto` (
  `codigo de barras` INT NOT NULL,
  `stock` VARCHAR(45) NULL,
  `Precio` VARCHAR(45) NULL,
  `Tipo` VARCHAR(45) NULL,
  `nombre` VARCHAR(45) NULL,
  `caducidad` VARCHAR(45) NULL,
  PRIMARY KEY (`codigo de barras`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`cliente` ;

CREATE TABLE IF NOT EXISTS `mydb`.`cliente` (
  `dni` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `descuento` VARCHAR(45) NULL,
  `gasto mensual` VARCHAR(45) NULL,
  `fecha nacimiento` VARCHAR(45) NULL,
  `codigo fidelizacion` VARCHAR(45) NULL,
  PRIMARY KEY (`dni`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`pedido`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`pedido` ;

CREATE TABLE IF NOT EXISTS `mydb`.`pedido` (
  `id` INT NOT NULL,
  `fecha` VARCHAR(45) NULL,
  `dni` INT NULL,
  `empleado_dni` INT NOT NULL,
  `empleado_seguridad_social` INT NOT NULL,
  PRIMARY KEY (`id`, `empleado_dni`, `empleado_seguridad_social`),
  INDEX `dni_idx` (`dni` ASC),
  INDEX `fk_pedido_empleado1_idx` (`empleado_dni` ASC, `empleado_seguridad_social` ASC),
  CONSTRAINT `dni`
    FOREIGN KEY (`dni`)
    REFERENCES `mydb`.`cliente` (`dni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_empleado1`
    FOREIGN KEY (`empleado_dni` , `empleado_seguridad_social`)
    REFERENCES `mydb`.`empleado` (`dni` , `seguridad_social`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`asignado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`asignado` ;

CREATE TABLE IF NOT EXISTS `mydb`.`asignado` (
  `producto_codigo de barras` INT NOT NULL,
  `zona_n_zona` INT NOT NULL,
  `zona_ubicación` VARCHAR(45) NOT NULL,
  `stock` INT NOT NULL,
  PRIMARY KEY (`producto_codigo de barras`, `zona_n_zona`, `zona_ubicación`),
  INDEX `fk_producto_has_zona_zona1_idx` (`zona_n_zona` ASC, `zona_ubicación` ASC),
  INDEX `fk_producto_has_zona_producto1_idx` (`producto_codigo de barras` ASC),
  UNIQUE INDEX `stock_UNIQUE` (`stock` ASC),
  CONSTRAINT `fk_producto_has_zona_producto1`
    FOREIGN KEY (`producto_codigo de barras`)
    REFERENCES `mydb`.`producto` (`codigo de barras`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_producto_has_zona_zona1`
    FOREIGN KEY (`zona_n_zona` , `zona_ubicación`)
    REFERENCES `mydb`.`zona` (`n_zona` , `ubicación`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`trabaja`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`trabaja` ;

CREATE TABLE IF NOT EXISTS `mydb`.`trabaja` (
  `zona_n_zona` INT NOT NULL,
  `zona_ubicación` VARCHAR(45) NOT NULL,
  `empleado_dni` INT NOT NULL,
  `empleado_seguridad_social` INT NOT NULL,
  `fecha_ini` VARCHAR(45) NULL,
  `fecha_fin` VARCHAR(45) NULL,
  PRIMARY KEY (`zona_n_zona`, `zona_ubicación`, `empleado_dni`, `empleado_seguridad_social`),
  INDEX `fk_zona_has_empleado_empleado1_idx` (`empleado_dni` ASC, `empleado_seguridad_social` ASC),
  INDEX `fk_zona_has_empleado_zona1_idx` (`zona_n_zona` ASC, `zona_ubicación` ASC),
  CONSTRAINT `fk_zona_has_empleado_zona1`
    FOREIGN KEY (`zona_n_zona` , `zona_ubicación`)
    REFERENCES `mydb`.`zona` (`n_zona` , `ubicación`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_zona_has_empleado_empleado1`
    FOREIGN KEY (`empleado_dni` , `empleado_seguridad_social`)
    REFERENCES `mydb`.`empleado` (`dni` , `seguridad_social`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`esta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`esta` ;

CREATE TABLE IF NOT EXISTS `mydb`.`esta` (
  `pedido_id` INT NOT NULL,
  `pedido_empleado_dni` INT NOT NULL,
  `pedido_empleado_seguridad_social` INT NOT NULL,
  `producto_codigo de barras` INT NOT NULL,
  PRIMARY KEY (`pedido_id`, `pedido_empleado_dni`, `pedido_empleado_seguridad_social`, `producto_codigo de barras`),
  INDEX `fk_pedido_has_producto_producto1_idx` (`producto_codigo de barras` ASC),
  INDEX `fk_pedido_has_producto_pedido1_idx` (`pedido_id` ASC, `pedido_empleado_dni` ASC, `pedido_empleado_seguridad_social` ASC),
  CONSTRAINT `fk_pedido_has_producto_pedido1`
    FOREIGN KEY (`pedido_id` , `pedido_empleado_dni` , `pedido_empleado_seguridad_social`)
    REFERENCES `mydb`.`pedido` (`id` , `empleado_dni` , `empleado_seguridad_social`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_has_producto_producto1`
    FOREIGN KEY (`producto_codigo de barras`)
    REFERENCES `mydb`.`producto` (`codigo de barras`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `mydb` ;

-- -----------------------------------------------------
-- Placeholder table for view `mydb`.`view1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`view1` (`id` INT);

-- -----------------------------------------------------
-- View `mydb`.`view1`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `mydb`.`view1` ;
DROP TABLE IF EXISTS `mydb`.`view1`;
USE `mydb`;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
