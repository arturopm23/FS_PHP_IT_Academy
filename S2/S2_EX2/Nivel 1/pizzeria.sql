-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizzeria` DEFAULT CHARACTER SET utf8 ;
USE `pizzeria` ;

-- -----------------------------------------------------
-- Table `pizzeria`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`clientes` (
  `clientes_id` INT NOT NULL AUTO_INCREMENT,
  `clientes_nombre` VARCHAR(40) NOT NULL,
  `clientes_apellido` VARCHAR(100) NOT NULL,
  `clientes_direccion` VARCHAR(200) NOT NULL,
  `clientes_cp` INT(5) NOT NULL,
  `clientes_localidad` VARCHAR(45) NOT NULL,
  `clientes_provincia` VARCHAR(45) NOT NULL,
  `clientes_telefono` INT(9) NOT NULL,
  PRIMARY KEY (`clientes_id`)
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`categorias` (
  `categorias_id` INT NOT NULL AUTO_INCREMENT,
  `categorias_nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`categorias_id`)
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`productos` (
  `productos_id` INT NOT NULL AUTO_INCREMENT,
  `productos_imagen` BLOB NULL,
  `productos_nombre` VARCHAR(45) NOT NULL,
  `productos_descripcion` VARCHAR(200) NULL,
  `productos_precio` DECIMAL(10,2) NOT NULL,
  `categorias_categorias_id` INT NOT NULL,
  PRIMARY KEY (`productos_id`),
  INDEX `fk_productos_categorias1_idx` (`categorias_categorias_id` ASC),
  CONSTRAINT `fk_productos_categorias1`
    FOREIGN KEY (`categorias_categorias_id`)
    REFERENCES `pizzeria`.`categorias` (`categorias_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`tiendas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`tiendas` (
  `tiendas_id` INT NOT NULL AUTO_INCREMENT,
  `tiendas_direccion` VARCHAR(200) NOT NULL,
  `tiendas_cp` INT(5) NOT NULL,
  `tiendas_localidad` VARCHAR(45) NOT NULL,
  `tiendas_provincia` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`tiendas_id`)
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`puesto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`puesto` (
  `puesto_id` INT NOT NULL AUTO_INCREMENT,
  `puesto_nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`puesto_id`)
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`empleados` (
  `empleados_id` INT NOT NULL AUTO_INCREMENT,
  `empleados_nombre` VARCHAR(40) NOT NULL,
  `empleados_apellido` VARCHAR(100) NOT NULL,
  `empleados_NIF` VARCHAR(12) NOT NULL,
  `empleados_telefono` INT(9) NOT NULL,
  `tiendas_tiendas_id` INT NOT NULL,
  `puesto_puesto_id` INT NOT NULL,
  PRIMARY KEY (`empleados_id`),
  INDEX `fk_empleados_tiendas1_idx` (`tiendas_tiendas_id` ASC),
  INDEX `fk_empleados_puesto1_idx` (`puesto_puesto_id` ASC),
  CONSTRAINT `fk_empleados_tiendas1`
    FOREIGN KEY (`tiendas_tiendas_id`)
    REFERENCES `pizzeria`.`tiendas` (`tiendas_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_empleados_puesto1`
    FOREIGN KEY (`puesto_puesto_id`)
    REFERENCES `pizzeria`.`puesto` (`puesto_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`comandas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`comandas` (
  `comandas_id` INT NOT NULL AUTO_INCREMENT,
  `comandas_fechaComanda` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `comandas_envio` ENUM('llevar', 'recoger') NOT NULL,
  `comandas_itemsTotales` INT NOT NULL,
  `comandas_precioTotal` DECIMAL(10,2) NOT NULL,
  `comandas_fechaEntrega` DATETIME NOT NULL,
  `clientes_clientes_id` INT NOT NULL,
  `comandas_direccion` VARCHAR(200) NULL,
  `productos_productos_id` INT NOT NULL,
  `tiendas_tiendas_id` INT NOT NULL,
  `empleados_empleados_id` INT NOT NULL,
  PRIMARY KEY (`comandas_id`),
  UNIQUE INDEX `comandas_envio_UNIQUE` (`comandas_envio` ASC),
  INDEX `fk_comandas_clientes_idx` (`clientes_clientes_id` ASC),
  INDEX `fk_comandas_productos1_idx` (`productos_productos_id` ASC),
  INDEX `fk_comandas_tiendas1_idx` (`tiendas_tiendas_id` ASC),
  INDEX `fk_comandas_empleados1_idx` (`empleados_empleados_id` ASC),
  CONSTRAINT `fk_comandas_clientes`
    FOREIGN KEY (`clientes_clientes_id`)
    REFERENCES `pizzeria`.`clientes` (`clientes_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_comandas_productos1`
    FOREIGN KEY (`productos_productos_id`)
    REFERENCES `pizzeria`.`productos` (`productos_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_comandas_tiendas1`
    FOREIGN KEY (`tiendas_tiendas_id`)
    REFERENCES `pizzeria`.`tiendas` (`tiendas_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_comandas_empleados1`
    FOREIGN KEY (`empleados_empleados_id`)
    REFERENCES `pizzeria`.`empleados` (`empleados_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- Eliminar la restricción UNIQUE
ALTER TABLE comandas DROP INDEX comandas_envio_UNIQUE;

-- -----------------------------------------------------
-- Insertar datos de ejemplo
-- -----------------------------------------------------

-- Insertar categorías
INSERT INTO categorias (categorias_nombre) VALUES
('Hamburguesas'),
('Pizzas'),
('Bebidas');

-- Insertar productos
INSERT INTO productos (productos_imagen, productos_nombre, productos_descripcion, productos_precio, categorias_categorias_id) VALUES
(NULL, 'Hamburguesa Clásica', 'Con lechuga, tomate y queso cheddar', 8.50, 1),
(NULL, 'Pizza Margarita', 'Mozzarella, tomate y albahaca', 10.00, 2),
(NULL, 'Coca-Cola 330ml', 'Refresco de cola', 2.50, 3);

-- Insertar tiendas
INSERT INTO tiendas (tiendas_direccion, tiendas_cp, tiendas_localidad, tiendas_provincia) VALUES
('Calle Principal, 1', 28001, 'Madrid', 'Madrid'),
('Av. Diagonal, 100', 08021, 'Barcelona', 'Barcelona');

-- Insertar puestos
INSERT INTO puesto (puesto_nombre) VALUES
('Cocinero'),
('Repartidor');

-- Insertar empleados
INSERT INTO empleados (empleados_nombre, empleados_apellido, empleados_NIF, empleados_telefono, tiendas_tiendas_id, puesto_puesto_id) VALUES
('Juan', 'Gómez', '12345678A', 666111222, 1, 1),
('Ana', 'Martínez', '87654321B', 666333444, 1, 2),
('Pedro', 'Sánchez', '98765432C', 666555666, 2, 1);

-- Insertar clientes
INSERT INTO clientes (clientes_nombre, clientes_apellido, clientes_direccion, clientes_cp, clientes_localidad, clientes_provincia, clientes_telefono) VALUES
('María', 'Gómez', 'Calle Sol, 123', 28001, 'Madrid', 'Madrid', 666111222),
('Elena', 'López', 'Av. Libertad, 456', 08021, 'Barcelona', 'Barcelona', 666333444),
('Carlos', 'Fernández', 'Plaza Mayor, 7', 41001, 'Sevilla', 'Sevilla', 666555666);

-- Insertar comandas
INSERT INTO comandas (comandas_fechaComanda, comandas_envio, comandas_itemsTotales, comandas_precioTotal, comandas_fechaEntrega, clientes_clientes_id, comandas_direccion, productos_productos_id, tiendas_tiendas_id, empleados_empleados_id) VALUES
('2024-06-15 12:00:00', 'llevar', 2, 20.50, '2024-06-15 13:00:00', 1, 'Calle Principal, 123', 1, 1, 1),
('2024-06-15 13:30:00', 'recoger', 1, 10.00, '2024-06-15 13:45:00', 2, NULL, 2, 1, 2),
('2024-06-15 18:00:00', 'llevar', 3, 30.75, '2024-06-15 19:15:00', 3, 'Av. Diagonal, 100', 3, 2, 1);

-- Restaurar configuraciones anteriores
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
