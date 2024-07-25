-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema optica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `optica` DEFAULT CHARACTER SET utf8mb4 ;
USE `optica` ;

-- -----------------------------------------------------
-- Table `optica`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`clientes` (
  `cliente_id` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  `apellido` VARCHAR(50) NOT NULL,
  `direccion` VARCHAR(200) NOT NULL,
  `ciudad` VARCHAR(50) NOT NULL,
  `estado` VARCHAR(50) NOT NULL,
  `codigo_postal` CHAR(5) NOT NULL,
  `telefono` CHAR(10) NOT NULL,
  `correo` VARCHAR(100) NOT NULL,
  `fecha_registro` DATETIME NOT NULL,
  `cliente_referido` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`cliente_id`),
  INDEX `cliente_referido_idx` (`cliente_referido` ASC),
  CONSTRAINT `clientes_ibfk_1` FOREIGN KEY (`cliente_referido`) REFERENCES `clientes` (`cliente_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 7 DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `optica`.`proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`proveedor` (
  `proveedor_id` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre_empresa` VARCHAR(100) NOT NULL,
  `direccion` VARCHAR(200) NOT NULL,
  `ciudad` VARCHAR(50) NOT NULL,
  `estado` VARCHAR(50) NOT NULL,
  `codigo_postal` CHAR(5) NOT NULL,
  `pais` VARCHAR(50) NOT NULL,
  `telefono` CHAR(10) NOT NULL,
  `fax` CHAR(10) NULL DEFAULT NULL,
  `nif` CHAR(9) NOT NULL,
  PRIMARY KEY (`proveedor_id`)
) ENGINE = InnoDB AUTO_INCREMENT = 5 DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `optica`.`marca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`marca` (
  `marca_id` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  `proveedor_id` INT(11) NOT NULL,
  PRIMARY KEY (`marca_id`),
  INDEX `proveedor_id_idx` (`proveedor_id` ASC),
  CONSTRAINT `marca_ibfk_1` FOREIGN KEY (`proveedor_id`) REFERENCES `proveedor` (`proveedor_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 5 DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `optica`.`gafas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`gafas` (
  `gafas_id` INT(11) NOT NULL AUTO_INCREMENT,
  `marca_id` INT(11) NOT NULL,
  `graduacion_izquierda` DECIMAL(5,2) NOT NULL,
  `graduacion_derecha` DECIMAL(5,2) NOT NULL,
  `montura` ENUM('flotante', 'pasta', 'metálica') NOT NULL,
  `color_montura` VARCHAR(100) NOT NULL DEFAULT 'transparente',
  `color_vidrio_izquierdo` ENUM('transparente', 'negro', 'azul', 'marron', 'rojo', 'naranja', 'burdeos') NOT NULL,
  `color_vidrio_derecho` ENUM('transparente', 'negro', 'azul', 'marron', 'rojo', 'naranja', 'burdeos') NOT NULL DEFAULT 'transparente',
  `precio` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`gafas_id`),
  INDEX `marca_id_idx` (`marca_id` ASC),
  CONSTRAINT `gafas_ibfk_1` FOREIGN KEY (`marca_id`) REFERENCES `marca` (`marca_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 5 DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `optica`.`staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`staff` (
  `staff_id` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  `puesto` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`staff_id`)
) ENGINE = InnoDB AUTO_INCREMENT = 5 DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `optica`.`ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`ventas` (
  `ventas_id` INT(11) NOT NULL AUTO_INCREMENT,
  `cliente_id` INT(11) NOT NULL,
  `fecha_venta` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `staff_id` INT(11) NOT NULL,
  `gafas_id` INT(11) NOT NULL,
  PRIMARY KEY (`ventas_id`),
  INDEX `cliente_id_idx` (`cliente_id` ASC),
  INDEX `staff_id_idx` (`staff_id` ASC),
  INDEX `gafas_id_idx` (`gafas_id` ASC),
  CONSTRAINT `ventas_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`cliente_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ventas_ibfk_2` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ventas_ibfk_3` FOREIGN KEY (`gafas_id`) REFERENCES `gafas` (`gafas_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 5 DEFAULT CHARACTER SET = utf8mb4;

-- Inserciones de ejemplo para la base de datos optica

-- Inserciones para la tabla `clientes`
INSERT INTO `optica`.`clientes` (`nombre`, `apellido`, `direccion`, `ciudad`, `estado`, `codigo_postal`, `telefono`, `correo`, `fecha_registro`, `cliente_referido`) VALUES
('Juan', 'Pérez', 'Calle Principal 123', 'Ciudad A', 'Estado 1', '28001', '123456789', 'juan.perez@example.com', '2024-06-01 10:00:00', NULL),
('María', 'Gómez', 'Avenida Central 456', 'Ciudad B', 'Estado 2', '28002', '987654321', 'maria.gomez@example.com', '2024-06-02 11:00:00', 1),
('Carlos', 'Martínez', 'Plaza Mayor 789', 'Ciudad C', 'Estado 3', '28003', '555666777', 'carlos.martinez@example.com', '2024-06-03 12:00:00', 2);

-- Inserciones para la tabla `proveedor`
INSERT INTO `optica`.`proveedor` (`nombre_empresa`, `direccion`, `ciudad`, `estado`, `codigo_postal`, `pais`, `telefono`, `fax`, `nif`) VALUES
('Gafas y Más', 'Calle Proveedor 1', 'Ciudad Proveedor 1', 'Estado Proveedor 1', '28001', 'España', '111222333', '111222334', 'NIF111'),
('Visión Clara', 'Avenida Proveedor 2', 'Ciudad Proveedor 2', 'Estado Proveedor 2', '28002', 'España', '222333444', '222333445', 'NIF222');

-- Inserciones para la tabla `marca`
INSERT INTO `optica`.`marca` (`nombre`, `proveedor_id`) VALUES
('Elegancia', 1),
('EstiloPlus', 2);

-- Inserciones para la tabla `gafas`
INSERT INTO `optica`.`gafas` (`marca_id`, `graduacion_izquierda`, `graduacion_derecha`, `montura`, `color_montura`, `color_vidrio_izquierdo`, `color_vidrio_derecho`, `precio`) VALUES
(1, 1.50, 1.50, 'flotante', 'negro', 'azul', 'azul', 150.00),
(2, -2.00, -2.00, 'pasta', 'rojo', 'transparente', 'transparente', 180.00);


-- Inserciones para la tabla `staff`
INSERT INTO `optica`.`staff` (`nombre`, `puesto`) VALUES
('Luisa', 'Vendedor'),
('Pedro', 'Recepcionista');

-- Inserciones para la tabla `ventas`
INSERT INTO `optica`.`ventas` (`cliente_id`, `fecha_venta`, `staff_id`, `gafas_id`) VALUES
(1, '2024-06-04 10:00:00', 1, 1),
(2, '2024-06-05 11:00:00', 2, 2);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;