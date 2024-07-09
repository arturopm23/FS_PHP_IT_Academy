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
-- Table `pizzeria`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`productos` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `imagen` BLOB NULL DEFAULT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(200) NULL DEFAULT NULL,
  `precio` DECIMAL(10,2) NOT NULL,
  `tipo` ENUM('bebida', 'hamburguesa', 'pizza') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `pizzeria`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`categoria` (
  `categoria_id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `productos_id` INT(11) NOT NULL,
  PRIMARY KEY (`categoria_id`),
  INDEX `fk_categoria_productos_idx` (`productos_id` ASC),
  CONSTRAINT `fk_categoria_productos`
    FOREIGN KEY (`productos_id`)
    REFERENCES `pizzeria`.`productos` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `pizzeria`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`clientes` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(40) NOT NULL,
  `apellido` VARCHAR(100) NOT NULL,
  `direccion` VARCHAR(200) NOT NULL,
  `cp` INT(5) NOT NULL,
  `localidad` VARCHAR(45) NOT NULL,
  `provincia` VARCHAR(45) NOT NULL,
  `telefono` INT(9) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `pizzeria`.`puestos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`puestos` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `pizzeria`.`tiendas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`tiendas` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `direccion` VARCHAR(200) NOT NULL,
  `cp` INT(5) NOT NULL,
  `localidad` VARCHAR(45) NOT NULL,
  `provincia` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `pizzeria`.`empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`empleados` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(40) NOT NULL,
  `apellido` VARCHAR(100) NOT NULL,
  `NIF` VARCHAR(12) NOT NULL,
  `telefono` INT(9) NOT NULL,
  `tienda_id` INT(11) NOT NULL,
  `puesto_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_empleados_tiendas1_idx` (`tienda_id` ASC),
  INDEX `fk_empleados_puesto1_idx` (`puesto_id` ASC),
  CONSTRAINT `fk_empleados_puesto1`
    FOREIGN KEY (`puesto_id`)
    REFERENCES `pizzeria`.`puestos` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_empleados_tiendas1`
    FOREIGN KEY (`tienda_id`)
    REFERENCES `pizzeria`.`tiendas` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `pizzeria`.`comandas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`comandas` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `fecha` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  `envio` ENUM('llevar', 'recoger') NOT NULL,
  `items_totales` INT(11) NOT NULL,
  `precio_total` DECIMAL(10,2) NOT NULL,
  `fecha_entrega` DATETIME NOT NULL,
  `cliente_id` INT(11) NOT NULL,
  `direccion` VARCHAR(200) NULL DEFAULT NULL,
  `tienda_id` INT(11) NOT NULL,
  `empleado_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_comandas_clientes_idx` (`cliente_id` ASC),
  INDEX `fk_comandas_tiendas1_idx` (`tienda_id` ASC),
  INDEX `fk_comandas_empleados1_idx` (`empleado_id` ASC),
  CONSTRAINT `fk_comandas_clientes`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `pizzeria`.`clientes` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_comandas_empleados1`
    FOREIGN KEY (`empleado_id`)
    REFERENCES `pizzeria`.`empleados` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_comandas_tiendas1`
    FOREIGN KEY (`tienda_id`)
    REFERENCES `pizzeria`.`tiendas` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `pizzeria`.`comandas_has_productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`comandas_has_productos` (
  `comandas_id` INT(11) NOT NULL,
  `productos_id` INT(11) NOT NULL,
  PRIMARY KEY (`comandas_id`, `productos_id`),
  INDEX `fk_comandas_has_productos_productos1_idx` (`productos_id` ASC),
  INDEX `fk_comandas_has_productos_comandas1_idx` (`comandas_id` ASC),
  CONSTRAINT `fk_comandas_has_productos_comandas1`
    FOREIGN KEY (`comandas_id`)
    REFERENCES `pizzeria`.`comandas` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_comandas_has_productos_productos1`
    FOREIGN KEY (`productos_id`)
    REFERENCES `pizzeria`.`productos` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- Insertar datos de ejemplo en la tabla productos
INSERT INTO `productos` (`imagen`, `nombre`, `descripcion`, `precio`, `tipo`) VALUES
  (NULL, 'Coca-Cola', 'Refresco de cola', 2.50, 'bebida'),
  (NULL, 'Pizza Margarita', 'Pizza de queso y tomate', 8.99, 'pizza'),
  (NULL, 'Hamburguesa Clásica', 'Hamburguesa con queso y lechuga', 5.99, 'hamburguesa');

-- Insertar datos de ejemplo en la tabla categoria
INSERT INTO `categoria` (`nombre`, `productos_id`) VALUES
  ('Bebidas', 1),
  ('Pizzas', 2),
  ('Hamburguesas', 3);

-- Insertar datos de ejemplo en la tabla clientes
INSERT INTO `clientes` (`nombre`, `apellido`, `direccion`, `cp`, `localidad`, `provincia`, `telefono`) VALUES
  ('Juan', 'Pérez', 'Calle Mayor 123', 28001, 'Madrid', 'Madrid', 912345678),
  ('María', 'García', 'Avenida del Parque 45', 08001, 'Barcelona', 'Barcelona', 934567890),
  ('Carlos', 'López', 'Plaza Principal 7', 41001, 'Sevilla', 'Sevilla', 955678901);

-- Insertar datos de ejemplo en la tabla puestos
INSERT INTO `puestos` (`nombre`) VALUES
  ('Camarero'),
  ('Cocinero'),
  ('Repartidor');

-- Insertar datos de ejemplo en la tabla tiendas
INSERT INTO `tiendas` (`direccion`, `cp`, `localidad`, `provincia`) VALUES
  ('Calle Comercial 12', 28002, 'Madrid', 'Madrid'),
  ('Avenida Central 34', 08002, 'Barcelona', 'Barcelona');

-- Insertar datos de ejemplo en la tabla empleados
INSERT INTO `empleados` (`nombre`, `apellido`, `NIF`, `telefono`, `tienda_id`, `puesto_id`) VALUES
  ('Ana', 'Martínez', '12345678A', 678901234, 1, 1),
  ('David', 'González', '87654321B', 789012345, 1, 2),
  ('Elena', 'Sánchez', '56789123C', 890123456, 2, 3);

-- Insertar datos de ejemplo en la tabla comandas
INSERT INTO `comandas` (`fecha`, `envio`, `items_totales`, `precio_total`, `fecha_entrega`, `cliente_id`, `direccion`, `tienda_id`, `empleado_id`) VALUES
  ('2024-07-09 12:00:00', 'llevar', 2, 17.98, '2024-07-09 13:00:00', 1, 'Calle Mayor 123', 1, 3),
  ('2024-07-09 13:30:00', 'recoger', 1, 5.99, '2024-07-09 14:00:00', 2, 'Avenida del Parque 45', 2, 2),
  ('2024-07-09 14:00:00', 'llevar', 3, 23.47, '2024-07-09 15:00:00', 3, 'Plaza Principal 7', 1, 1);

-- Insertar datos de ejemplo en la tabla comandas_has_productos
INSERT INTO `comandas_has_productos` (`comandas_id`, `productos_id`) VALUES
  (1, 2),  -- Pizza Margarita
  (1, 1),  -- Coca-Cola
  (2, 3),  -- Hamburguesa Clásica
  (3, 2),  -- Pizza Margarita
  (3, 3),  -- Hamburguesa Clásica
  (3, 1);  -- Coca-Cola

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
