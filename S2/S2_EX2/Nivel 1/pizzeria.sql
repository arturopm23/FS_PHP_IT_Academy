-- Establecer variables para deshabilitar verificaciones de claves únicas y foráneas
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- Crear el esquema si no existe y seleccionarlo
CREATE SCHEMA IF NOT EXISTS `pizzeria` DEFAULT CHARACTER SET utf8 ;
USE `pizzeria`;

-- -----------------------------------------------------
-- Tabla `clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clientes` (
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
-- Tabla `categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `categorias` (
  `categorias_id` INT NOT NULL AUTO_INCREMENT,
  `categorias_nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`categorias_id`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabla `productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `productos` (
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
    REFERENCES `categorias` (`categorias_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabla `tiendas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tiendas` (
  `tiendas_id` INT NOT NULL AUTO_INCREMENT,
  `tiendas_direccion` VARCHAR(200) NOT NULL,
  `tiendas_cp` INT(5) NOT NULL,
  `tiendas_localidad` VARCHAR(45) NOT NULL,
  `tiendas_provincia` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`tiendas_id`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabla `puesto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `puesto` (
  `puesto_id` INT NOT NULL AUTO_INCREMENT,
  `puesto_nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`puesto_id`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabla `empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empleados` (
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
    REFERENCES `tiendas` (`tiendas_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_empleados_puesto1`
    FOREIGN KEY (`puesto_puesto_id`)
    REFERENCES `puesto` (`puesto_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabla `comandas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `comandas` (
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
  INDEX `fk_comandas_clientes_idx` (`clientes_clientes_id` ASC),
  INDEX `fk_comandas_productos1_idx` (`productos_productos_id` ASC),
  INDEX `fk_comandas_tiendas1_idx` (`tiendas_tiendas_id` ASC),
  INDEX `fk_comandas_empleados1_idx` (`empleados_empleados_id` ASC),
  CONSTRAINT `fk_comandas_clientes`
    FOREIGN KEY (`clientes_clientes_id`)
    REFERENCES `clientes` (`clientes_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_comandas_productos1`
    FOREIGN KEY (`productos_productos_id`)
    REFERENCES `productos` (`productos_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_comandas_tiendas1`
    FOREIGN KEY (`tiendas_tiendas_id`)
    REFERENCES `tiendas` (`tiendas_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_comandas_empleados1`
    FOREIGN KEY (`empleados_empleados_id`)
    REFERENCES `empleados` (`empleados_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- Inserciones para la tabla `clientes`
INSERT INTO `clientes` (`clientes_nombre`, `clientes_apellido`, `clientes_direccion`, `clientes_cp`, `clientes_localidad`, `clientes_provincia`, `clientes_telefono`) VALUES
('Juan', 'Pérez', 'Calle Falsa 123', 28001, 'Madrid', 'Madrid', 912345678),
('Ana', 'García', 'Avenida Siempreviva 456', 28002, 'Madrid', 'Madrid', 912345679),
('Luis', 'Martínez', 'Plaza Mayor 789', 28003, 'Madrid', 'Madrid', 912345680);

-- Inserciones para la tabla `categorias`
INSERT INTO `categorias` (`categorias_nombre`) VALUES
('Pizzas'),
('Bebidas'),
('Postres');

-- Inserciones para la tabla `productos`
INSERT INTO `productos` (`productos_imagen`, `productos_nombre`, `productos_descripcion`, `productos_precio`, `categorias_categorias_id`) VALUES
(NULL, 'Pizza Margarita', 'Pizza con tomate, mozzarella y albahaca', 8.50, 1),
(NULL, 'Coca Cola', 'Refresco de cola', 1.50, 2),
(NULL, 'Tarta de queso', 'Tarta de queso con base de galleta', 4.00, 3);

-- Inserciones para la tabla `tiendas`
INSERT INTO `tiendas` (`tiendas_direccion`, `tiendas_cp`, `tiendas_localidad`, `tiendas_provincia`) VALUES
('Calle Pizzeria 1', 28001, 'Madrid', 'Madrid'),
('Calle Pizzeria 2', 28002, 'Madrid', 'Madrid');

-- Inserciones para la tabla `puesto`
INSERT INTO `puesto` (`puesto_nombre`) VALUES
('Cocinero'),
('Camarero'),
('Gerente');

-- Inserciones para la tabla `empleados`
INSERT INTO `empleados` (`empleados_nombre`, `empleados_apellido`, `empleados_NIF`, `empleados_telefono`, `tiendas_tiendas_id`, `puesto_puesto_id`) VALUES
('Carlos', 'López', '12345678A', 912345681, 1, 1),
('Marta', 'González', '23456789B', 912345682, 1, 2),
('Luis', 'Sánchez', '34567890C', 912345683, 2, 3);

-- Inserciones para la tabla `comandas`
INSERT INTO `comandas` (`comandas_fechaComanda`, `comandas_envio`, `comandas_itemsTotales`, `comandas_precioTotal`, `comandas_fechaEntrega`, `clientes_clientes_id`, `comandas_direccion`, `productos_productos_id`, `tiendas_tiendas_id`, `empleados_empleados_id`)
VALUES
('2024-06-10 12:00:00', 'llevar', 2, 13.50, '2024-06-10 13:00:00', 1, 'Calle Falsa 123', 1, 1, 1),
('2024-06-10 13:30:00', 'recoger', 1, 4.00, '2024-06-10 14:00:00', 2, 'Avenida Siempreviva 456', 2, 2, 2),
('2024-06-10 14:00:00', 'llevar', 1, 1.50, '2024-06-10 14:30:00', 3, 'Plaza Mayor 789', 1, 3, 3);

-- -----------------------------------------------------
-- Restaurar configuraciones anteriores
-- -----------------------------------------------------
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
