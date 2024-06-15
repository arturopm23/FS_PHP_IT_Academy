-- MySQL Workbench Forward Engineering
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `optica` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `optica` ;
-- -----------------------------------------------------
-- Table `optica`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`clientes` (
  `cliente_id` INT NOT NULL AUTO_INCREMENT,
  `cliente_nombre` VARCHAR(50) NOT NULL,
  `cliente_zip` VARCHAR(20) NOT NULL,
  `cliente_telefono` VARCHAR(20) NOT NULL,
  `cliente_correo` VARCHAR(100) NOT NULL,
  `cliente_registro` DATETIME NOT NULL,
  `cliente_referido` INT NULL DEFAULT NULL,
  PRIMARY KEY (`cliente_id`),
  INDEX `cliente_referido` (`cliente_referido` ASC) VISIBLE,
  CONSTRAINT `clientes_ibfk_1`
    FOREIGN KEY (`cliente_referido`)
    REFERENCES `optica`.`clientes` (`cliente_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;
-- -----------------------------------------------------
-- Table `optica`.`proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`proveedor` (
  `proveedor_id` INT NOT NULL AUTO_INCREMENT,
  `proveedor_nombre` VARCHAR(50) NOT NULL,
  `proveedor_calle` VARCHAR(200) NOT NULL,
  `proveedor_numero` VARCHAR(50) NOT NULL,
  `proveedor_piso` VARCHAR(50) NULL DEFAULT NULL,
  `proveedor_puerta` VARCHAR(50) NULL DEFAULT NULL,
  `proveedor_ciudad` VARCHAR(50) NOT NULL,
  `proveedor_zip` VARCHAR(20) NOT NULL,
  `proveedor_pais` VARCHAR(50) NOT NULL,
  `proveedor_telefono` VARCHAR(20) NOT NULL,
  `proveedor_fax` VARCHAR(20) NULL DEFAULT NULL,
  `proveedor_nif` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`proveedor_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;
-- -----------------------------------------------------
-- Table `optica`.`marca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`marca` (
  `marca_id` INT NOT NULL AUTO_INCREMENT,
  `proveedor_id` INT NOT NULL,
  `marca_nombre` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`marca_id`),
  INDEX `proveedor_id` (`proveedor_id` ASC) VISIBLE,
  CONSTRAINT `marca_ibfk_1`
    FOREIGN KEY (`proveedor_id`)
    REFERENCES `optica`.`proveedor` (`proveedor_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;
-- -----------------------------------------------------
-- Table `optica`.`gafas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`gafas` (
  `gafas_id` INT NOT NULL AUTO_INCREMENT,
  `marca_id` INT NOT NULL,
  `gafas_grad_izq` VARCHAR(50) NOT NULL,
  `gafas_grad_der` VARCHAR(50) NOT NULL,
  `gafas_montura` VARCHAR(50) NOT NULL,
  `gafas_color_montura` VARCHAR(50) NOT NULL,
  `gafas_color_vid_izq` VARCHAR(50) NOT NULL,
  `gafas_color_vid_der` VARCHAR(50) NOT NULL,
  `gafas_precio` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`gafas_id`),
  INDEX `marca_id` (`marca_id` ASC) VISIBLE,
  CONSTRAINT `gafas_ibfk_1`
    FOREIGN KEY (`marca_id`)
    REFERENCES `optica`.`marca` (`marca_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;
-- -----------------------------------------------------
-- Table `optica`.`staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`staff` (
  `staff_id` INT NOT NULL AUTO_INCREMENT,
  `staff_nombre` VARCHAR(50) NOT NULL,
  `staff_puesto` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`staff_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;
-- -----------------------------------------------------
-- Table `optica`.`ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`ventas` (
  `ventas_id` INT NOT NULL AUTO_INCREMENT,
  `cliente_id` INT NOT NULL,
  `ventas_fecha` DATETIME NOT NULL,
  `staff_id` INT NOT NULL,
  `gafas_gafas_id` INT NOT NULL,
  PRIMARY KEY (`ventas_id`),
  INDEX `cliente_id` (`cliente_id` ASC) VISIBLE,
  INDEX `staff_id` (`staff_id` ASC) VISIBLE,
  INDEX `fk_ventas_gafas1_idx` (`gafas_gafas_id` ASC) VISIBLE,
  CONSTRAINT `ventas_ibfk_1`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `optica`.`clientes` (`cliente_id`),
  CONSTRAINT `ventas_ibfk_2`
    FOREIGN KEY (`staff_id`)
    REFERENCES `optica`.`staff` (`staff_id`),
  CONSTRAINT `fk_ventas_gafas1`
    FOREIGN KEY (`gafas_gafas_id`)
    REFERENCES `optica`.`gafas` (`gafas_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
