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

-- Inserciones de datos de ejemplo para la base de datos optica

-- Inserciones para la tabla `clientes`
INSERT INTO `clientes` (`cliente_nombre`, `cliente_zip`, `cliente_telefono`, `cliente_correo`, `cliente_registro`, `cliente_referido`) VALUES
('Cliente 1', '28001', '+34 123 456 789', 'cliente1@example.com', '2024-06-01 10:00:00', NULL),
('Cliente 2', '28002', '+34 987 654 321', 'cliente2@example.com', '2024-06-02 11:00:00', 1),
('Cliente 3', '28003', '+34 555 666 777', 'cliente3@example.com', '2024-06-03 12:00:00', 2);

-- Inserciones para la tabla `proveedor`
INSERT INTO `proveedor` (`proveedor_nombre`, `proveedor_calle`, `proveedor_numero`, `proveedor_piso`, `proveedor_puerta`, `proveedor_ciudad`, `proveedor_zip`, `proveedor_pais`, `proveedor_telefono`, `proveedor_fax`, `proveedor_nif`) VALUES
('Proveedor 1', 'Calle Proveedor 1', '123', '1', 'A', 'Ciudad Proveedor 1', '28001', 'España', '+34 111 222 333', '+34 111 222 334', 'NIF111'),
('Proveedor 2', 'Calle Proveedor 2', '456', '2', 'B', 'Ciudad Proveedor 2', '28002', 'España', '+34 222 333 444', '+34 222 333 445', 'NIF222');

-- Inserciones para la tabla `marca`
INSERT INTO `marca` (`proveedor_id`, `marca_nombre`) VALUES
(1, 'Marca 1'),
(2, 'Marca 2');

-- Inserciones para la tabla `gafas`
INSERT INTO `gafas` (`marca_id`, `gafas_grad_izq`, `gafas_grad_der`, `gafas_montura`, `gafas_color_montura`, `gafas_color_vid_izq`, `gafas_color_vid_der`, `gafas_precio`) VALUES
(1, '+1.00', '+1.00', 'Montura 1', 'Negro', 'Azul', 'Azul', 100.00),
(2, '-2.50', '-2.50', 'Montura 2', 'Rojo', 'Verde', 'Verde', 120.00);

-- Inserciones para la tabla `staff`
INSERT INTO `staff` (`staff_nombre`, `staff_puesto`) VALUES
('Empleado 1', 'Vendedor'),
('Empleado 2', 'Recepcionista');

-- Inserciones para la tabla `ventas`
INSERT INTO `ventas` (`cliente_id`, `ventas_fecha`, `staff_id`, `gafas_gafas_id`) VALUES
(1, '2024-06-04 10:00:00', 1, 1),
(2, '2024-06-05 11:00:00', 2, 2);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
