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
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(40) NOT NULL,
  `apellido` VARCHAR(100) NOT NULL,
  `direccion` VARCHAR(200) NOT NULL,
  `cp` INT(5) NOT NULL,
  `localidad` VARCHAR(45) NOT NULL,
  `provincia` VARCHAR(45) NOT NULL,
  `telefono` INT(9) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabla `categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `categorias` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabla `productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `productos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `imagen` BLOB NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(200) NULL,
  `precio` DECIMAL(10,2) NOT NULL,
  `categoria_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_productos_categorias1_idx` (`categoria_id` ASC),
  CONSTRAINT `fk_productos_categorias1`
    FOREIGN KEY (`categoria_id`)
    REFERENCES `categorias` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabla `tiendas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tiendas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `direccion` VARCHAR(200) NOT NULL,
  `cp` INT(5) NOT NULL,
  `localidad` VARCHAR(45) NOT NULL,
  `provincia` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabla `puestos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `puestos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabla `empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empleados` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(40) NOT NULL,
  `apellido` VARCHAR(100) NOT NULL,
  `NIF` VARCHAR(12) NOT NULL,
  `telefono` INT(9) NOT NULL,
  `tienda_id` INT NOT NULL,
  `puesto_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_empleados_tiendas1_idx` (`tienda_id` ASC),
  INDEX `fk_empleados_puesto1_idx` (`puesto_id` ASC),
  CONSTRAINT `fk_empleados_tiendas1`
    FOREIGN KEY (`tienda_id`)
    REFERENCES `tiendas` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_empleados_puesto1`
    FOREIGN KEY (`puesto_id`)
    REFERENCES `puestos` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabla `comandas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `comandas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `envio` ENUM('llevar', 'recoger') NOT NULL,
  `items_totales` INT NOT NULL,
  `precio_total` DECIMAL(10,2) NOT NULL,
  `fecha_entrega` DATETIME NOT NULL,
  `cliente_id` INT NOT NULL,
  `direccion` VARCHAR(200) NULL,
  `producto_id` INT NOT NULL,
  `tienda_id` INT NOT NULL,
  `empleado_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_comandas_clientes_idx` (`cliente_id` ASC),
  INDEX `fk_comandas_productos1_idx` (`producto_id` ASC),
  INDEX `fk_comandas_tiendas1_idx` (`tienda_id` ASC),
  INDEX `fk_comandas_empleados1_idx` (`empleado_id` ASC),
  CONSTRAINT `fk_comandas_clientes`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `clientes` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_comandas_productos1`
    FOREIGN KEY (`producto_id`)
    REFERENCES `productos` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_comandas_tiendas1`
    FOREIGN KEY (`tienda_id`)
    REFERENCES `tiendas` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_comandas_empleados1`
    FOREIGN KEY (`empleado_id`)
    REFERENCES `empleados` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- Inserciones para la tabla `clientes`
INSERT INTO `clientes` (`nombre`, `apellido`, `direccion`, `cp`, `localidad`, `provincia`, `telefono`) VALUES
('Juan', 'Pérez', 'Calle Falsa 123', 28001, 'Madrid', 'Madrid', 912345678),
('Ana', 'García', 'Avenida Siempreviva 456', 28002, 'Madrid', 'Madrid', 912345679),
('Luis', 'Martínez', 'Plaza Mayor 789', 28003, 'Madrid', 'Madrid', 912345680);

-- Inserciones para la tabla `categorias`
INSERT INTO `categorias` (`nombre`) VALUES
('Pizzas'),
('Bebidas'),
('Postres');

-- Inserciones para la tabla `productos`
INSERT INTO `productos` (`imagen`, `nombre`, `descripcion`, `precio`, `categoria_id`) VALUES
(NULL, 'Pizza Margarita', 'Pizza con tomate, mozzarella y albahaca', 8.50, 1),
(NULL, 'Coca Cola', 'Refresco de cola', 1.50, 2),
(NULL, 'Tarta de queso', 'Tarta de queso con base de galleta', 4.00, 3);

-- Inserciones para la tabla `tiendas`
INSERT INTO `tiendas` (`direccion`, `cp`, `localidad`, `provincia`) VALUES
('Calle Pizzeria 1', 28001, 'Madrid', 'Madrid'),
('Calle Pizzeria 2', 28002, 'Madrid', 'Madrid');

-- Inserciones para la tabla `puestos`
INSERT INTO `puestos` (`nombre`) VALUES
('Cocinero'),
('Camarero'),
('Gerente');

-- Inserciones para la tabla `empleados`
INSERT INTO `empleados` (`nombre`, `apellido`, `NIF`, `telefono`, `tienda_id`, `puesto_id`) VALUES
('Carlos', 'López', '12345678A', 912345681, 1, 1),
('Marta', 'González', '23456789B', 912345682, 1, 2),
('Luis', 'Sánchez', '34567890C', 912345683, 2, 3);

-- Inserciones para la tabla `comandas`
INSERT INTO `comandas` (`fecha`, `envio`, `items_totales`, `precio_total`, `fecha_entrega`, `cliente_id`, `direccion`, `producto_id`, `tienda_id`, `empleado_id`)
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
