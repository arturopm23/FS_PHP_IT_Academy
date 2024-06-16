SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema spotify
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `spotify` DEFAULT CHARACTER SET utf8;
USE `spotify`;

-- -----------------------------------------------------
-- Table `spotify`.`plan`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`plan` (
  `plan_id` INT NOT NULL AUTO_INCREMENT,
  `plan_nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`plan_id`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `spotify`.`suscripcion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`suscripcion` (
  `suscripcion_id` INT NOT NULL AUTO_INCREMENT,
  `suscripcion_inicio` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `suscripcion_renovacion` DATETIME NOT NULL,
  `suscripcion_pago` ENUM('tarjeta', 'Paypal') NOT NULL,
  PRIMARY KEY (`suscripcion_id`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `spotify`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`usuario` (
  `usuario_id` INT NOT NULL AUTO_INCREMENT,
  `usuario_email` VARCHAR(150) NOT NULL,
  `usuario_contraseña` VARCHAR(50) NOT NULL,
  `usuario_nombre` VARCHAR(45) NOT NULL,
  `usuario_nacimiento` DATETIME NOT NULL,
  `usuario_sexo` ENUM('Masculino', 'Femenino', 'Otro') NOT NULL,
  `usuario_pais` VARCHAR(45) NULL,
  `usuario_cp` INT(5) NULL,
  `plan_plan_id` INT NOT NULL,
  `suscripcion_suscripcion_id` INT NULL,
  PRIMARY KEY (`usuario_id`),
  INDEX `fk_usuario_plan1_idx` (`plan_plan_id` ASC) VISIBLE,
  INDEX `fk_usuario_suscripcion1_idx` (`suscripcion_suscripcion_id` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_plan1`
    FOREIGN KEY (`plan_plan_id`)
    REFERENCES `spotify`.`plan` (`plan_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_usuario_suscripcion1`
    FOREIGN KEY (`suscripcion_suscripcion_id`)
    REFERENCES `spotify`.`suscripcion` (`suscripcion_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `spotify`.`tarjeta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`tarjeta` (
  `tarjeta_id` INT NOT NULL AUTO_INCREMENT,
  `tarjeta_numero` VARCHAR(19) NOT NULL,
  `tarjeta_caducidad` DATETIME NOT NULL,
  `tarjeta_cvv` INT(3) NOT NULL,
  `usuario_usuario_id` INT NOT NULL,
  PRIMARY KEY (`tarjeta_id`),
  INDEX `fk_tarjeta_usuario1_idx` (`usuario_usuario_id` ASC) VISIBLE,
  CONSTRAINT `fk_tarjeta_usuario1`
    FOREIGN KEY (`usuario_usuario_id`)
    REFERENCES `spotify`.`usuario` (`usuario_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `spotify`.`paypal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`paypal` (
  `paypal_id` INT NOT NULL AUTO_INCREMENT,
  `paypal_usuario` VARCHAR(100) NULL,
  `usuario_usuario_id` INT NOT NULL,
  PRIMARY KEY (`paypal_id`),
  INDEX `fk_paypal_usuario1_idx` (`usuario_usuario_id` ASC) VISIBLE,
  CONSTRAINT `fk_paypal_usuario1`
    FOREIGN KEY (`usuario_usuario_id`)
    REFERENCES `spotify`.`usuario` (`usuario_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `spotify`.`pagos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`pagos` (
  `pagos_id` INT NOT NULL AUTO_INCREMENT,
  `pagos_fecha` DATETIME NULL,
  `pagos_total` DECIMAL(10,2) NULL,
  `usuario_usuario_id` INT NOT NULL,
  PRIMARY KEY (`pagos_id`),
  INDEX `fk_pagos_usuario1_idx` (`usuario_usuario_id` ASC) VISIBLE,
  CONSTRAINT `fk_pagos_usuario1`
    FOREIGN KEY (`usuario_usuario_id`)
    REFERENCES `spotify`.`usuario` (`usuario_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `spotify`.`estado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`estado` (
  `estado_id` TINYINT(1) NOT NULL,
  `estado_nombre` VARCHAR(45) NOT NULL,
  `estado_fechaEliminacion` DATETIME NULL,
  PRIMARY KEY (`estado_id`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `spotify`.`playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`playlist` (
  `playlist_id` INT NOT NULL AUTO_INCREMENT,
  `playlist_titulo` VARCHAR(100) NOT NULL,
  `playlist_numCanciones` INT NOT NULL,
  `playlist_creacion` DATETIME NOT NULL,
  `estado_estado_id` TINYINT(1) NOT NULL,
  `playlist_fechaEliminacion` DATETIME NULL,
  PRIMARY KEY (`playlist_id`),
  INDEX `fk_playlist_estado1_idx` (`estado_estado_id` ASC) VISIBLE,
  CONSTRAINT `fk_playlist_estado1`
    FOREIGN KEY (`estado_estado_id`)
    REFERENCES `spotify`.`estado` (`estado_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `spotify`.`usuario_has_playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`usuario_has_playlist` (
  `usuario_usuario_id` INT NOT NULL,
  `playlist_playlist_id` INT NOT NULL,
  PRIMARY KEY (`usuario_usuario_id`, `playlist_playlist_id`),
  INDEX `fk_usuario_has_playlist_playlist1_idx` (`playlist_playlist_id` ASC) VISIBLE,
  INDEX `fk_usuario_has_playlist_usuario1_idx` (`usuario_usuario_id` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_has_playlist_usuario1`
    FOREIGN KEY (`usuario_usuario_id`)
    REFERENCES `spotify`.`usuario` (`usuario_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_usuario_has_playlist_playlist1`
    FOREIGN KEY (`playlist_playlist_id`)
    REFERENCES `spotify`.`playlist` (`playlist_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `spotify`.`artista`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`artista` (
  `artista_id` INT NOT NULL AUTO_INCREMENT,
  `artista_nombre` VARCHAR(100) NOT NULL,
  `artista_imagen` VARCHAR(255) NULL,
  PRIMARY KEY (`artista_id`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `spotify`.`artista_relacionado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`artista_relacionado` (
  `artista_principal_id` INT NOT NULL,
  `artista_relacionado_id` INT NOT NULL,
  PRIMARY KEY (`artista_principal_id`, `artista_relacionado_id`),
  INDEX `fk_artista_relacionado_artista1_idx` (`artista_principal_id` ASC) VISIBLE,
  INDEX `fk_artista_relacionado_artista2_idx` (`artista_relacionado_id` ASC) VISIBLE,
  CONSTRAINT `fk_artista_relacionado_artista1`
    FOREIGN KEY (`artista_principal_id`)
    REFERENCES `spotify`.`artista` (`artista_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_artista_relacionado_artista2`
    FOREIGN KEY (`artista_relacionado_id`)
    REFERENCES `spotify`.`artista` (`artista_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `spotify`.`album`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`album` (
  `album_id` INT NOT NULL AUTO_INCREMENT,
  `album_titulo` VARCHAR(100) NOT NULL,
  `album_publicacion` INT NOT NULL,
  `album_imagen` VARCHAR(255) NULL,
  `artista_artista_id` INT NOT NULL,
  PRIMARY KEY (`album_id`),
  UNIQUE INDEX `unique_album_artista` (`album_id`, `artista_artista_id`), -- Unique index added
  INDEX `fk_album_artista1_idx` (`artista_artista_id` ASC) VISIBLE,
  CONSTRAINT `fk_album_artista1`
    FOREIGN KEY (`artista_artista_id`)
    REFERENCES `spotify`.`artista` (`artista_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `spotify`.`cancion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`cancion` (
  `cancion_id` INT NOT NULL AUTO_INCREMENT,
  `cancion_titulo` VARCHAR(100) NOT NULL,
  `cancion_duracion` INT NOT NULL,
  `cancion_reproducciones` INT NOT NULL DEFAULT 0,
  `album_album_id` INT NOT NULL,
  `album_artista_id` INT NOT NULL,
  `usuario_usuario_id` INT NOT NULL,
  PRIMARY KEY (`cancion_id`),
  UNIQUE INDEX `cancion_id_UNIQUE` (`cancion_id` ASC) VISIBLE,
  INDEX `fk_cancion_album1_idx` (`album_album_id` ASC, `album_artista_id` ASC) VISIBLE,
  INDEX `fk_cancion_usuario1_idx` (`usuario_usuario_id` ASC) VISIBLE,
  CONSTRAINT `fk_cancion_album1`
    FOREIGN KEY (`album_album_id`, `album_artista_id`)
    REFERENCES `spotify`.`album` (`album_id`, `artista_artista_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_cancion_usuario1`
    FOREIGN KEY (`usuario_usuario_id`)
    REFERENCES `spotify`.`usuario` (`usuario_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `spotify`.`playlist_has_cancion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`playlist_has_cancion` (
  `playlist_playlist_id` INT NOT NULL,
  `cancion_cancion_id` INT NOT NULL,
  `usuario_usuario_id` INT NOT NULL,
  `fecha_adicion` DATETIME NOT NULL,
  PRIMARY KEY (`playlist_playlist_id`, `cancion_cancion_id`, `usuario_usuario_id`),
  INDEX `fk_playlist_has_cancion_cancion1_idx` (`cancion_cancion_id` ASC) VISIBLE,
  INDEX `fk_playlist_has_cancion_playlist1_idx` (`playlist_playlist_id` ASC) VISIBLE,
  INDEX `fk_playlist_has_cancion_usuario1_idx` (`usuario_usuario_id` ASC) VISIBLE,
  CONSTRAINT `fk_playlist_has_cancion_playlist1`
    FOREIGN KEY (`playlist_playlist_id`)
    REFERENCES `spotify`.`playlist` (`playlist_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_playlist_has_cancion_cancion1`
    FOREIGN KEY (`cancion_cancion_id`)
    REFERENCES `spotify`.`cancion` (`cancion_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_playlist_has_cancion_usuario1`
    FOREIGN KEY (`usuario_usuario_id`)
    REFERENCES `spotify`.`usuario` (`usuario_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `spotify`.`usuario_sigue_artista`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`usuario_sigue_artista` (
  `usuario_usuario_id` INT NOT NULL,
  `artista_artista_id` INT NOT NULL,
  PRIMARY KEY (`usuario_usuario_id`, `artista_artista_id`),
  INDEX `fk_usuario_sigue_artista_artista1_idx` (`artista_artista_id` ASC) VISIBLE,
  INDEX `fk_usuario_sigue_artista_usuario1_idx` (`usuario_usuario_id` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_sigue_artista_usuario1`
    FOREIGN KEY (`usuario_usuario_id`)
    REFERENCES `spotify`.`usuario` (`usuario_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_usuario_sigue_artista_artista1`
    FOREIGN KEY (`artista_artista_id`)
    REFERENCES `spotify`.`artista` (`artista_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `spotify`.`usuario_favorito_album`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`usuario_favorito_album` (
  `usuario_usuario_id` INT NOT NULL,
  `album_album_id` INT NOT NULL,
  PRIMARY KEY (`usuario_usuario_id`, `album_album_id`),
  INDEX `fk_usuario_favorito_album_album1_idx` (`album_album_id` ASC) VISIBLE,
  INDEX `fk_usuario_favorito_album_usuario1_idx` (`usuario_usuario_id` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_favorito_album_usuario1`
    FOREIGN KEY (`usuario_usuario_id`)
    REFERENCES `spotify`.`usuario` (`usuario_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_usuario_favorito_album_album1`
    FOREIGN KEY (`album_album_id`)
    REFERENCES `spotify`.`album` (`album_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `spotify`.`usuario_favorito_cancion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`usuario_favorito_cancion` (
  `usuario_usuario_id` INT NOT NULL,
  `cancion_cancion_id` INT NOT NULL,
  PRIMARY KEY (`usuario_usuario_id`, `cancion_cancion_id`),
  INDEX `fk_usuario_favorito_cancion_cancion1_idx` (`cancion_cancion_id` ASC) VISIBLE,
  INDEX `fk_usuario_favorito_cancion_usuario1_idx` (`usuario_usuario_id` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_favorito_cancion_usuario1`
    FOREIGN KEY (`usuario_usuario_id`)
    REFERENCES `spotify`.`usuario` (`usuario_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_usuario_favorito_cancion_cancion1`
    FOREIGN KEY (`cancion_cancion_id`)
    REFERENCES `spotify`.`cancion` (`cancion_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- Inserciones de datos para la base de datos spotify

-- Inserciones para la tabla `plan`
INSERT INTO `plan` (`plan_nombre`) VALUES
('Plan Básico'),
('Plan Premium'),
('Plan Familiar');

-- Inserciones para la tabla `suscripcion`
INSERT INTO `suscripcion` (`suscripcion_inicio`, `suscripcion_renovacion`, `suscripcion_pago`) VALUES
('2024-06-01 12:00:00', '2024-07-01 12:00:00', 'tarjeta'),
('2024-05-15 10:00:00', '2024-06-15 10:00:00', 'Paypal'),
('2024-06-05 08:00:00', '2024-07-05 08:00:00', 'tarjeta');

-- Inserciones para la tabla `usuario`
INSERT INTO `usuario` (`usuario_email`, `usuario_contraseña`, `usuario_nombre`, `usuario_nacimiento`, `usuario_sexo`, `usuario_pais`, `usuario_cp`, `plan_plan_id`, `suscripcion_suscripcion_id`) VALUES
('usuario1@example.com', 'contraseña1', 'Usuario 1', '1990-01-01', 'Masculino', 'España', 28001, 1, 1),
('usuario2@example.com', 'contraseña2', 'Usuario 2', '1985-05-15', 'Femenino', 'México', 11550, 2, 2),
('usuario3@example.com', 'contraseña3', 'Usuario 3', '1995-08-20', 'Otro', 'Argentina', 1000, 3, 3);

-- Inserciones para la tabla `artista`
INSERT INTO `artista` (`artista_nombre`, `artista_imagen`) VALUES
('Artista 1', 'imagen1.jpg'),
('Artista 2', 'imagen2.jpg'),
('Artista 3', 'imagen3.jpg');

-- Inserciones para la tabla `album`
INSERT INTO `album` (`album_titulo`, `album_publicacion`, `album_imagen`, `artista_artista_id`) VALUES
('Álbum 1', 2020, 'album1.jpg', 1),
('Álbum 2', 2018, 'album2.jpg', 2),
('Álbum 3', 2021, 'album3.jpg', 3);

-- Inserciones para la tabla `cancion`
INSERT INTO `cancion` (`cancion_titulo`, `cancion_duracion`, `cancion_reproducciones`, `album_album_id`, `album_artista_id`, `usuario_usuario_id`) VALUES
('Canción 1', 240, 1000, 1, 1, 1),
('Canción 2', 180, 800, 1, 1, 2),
('Canción 3', 200, 1200, 2, 2, 1),
('Canción 4', 220, 900, 3, 3, 3);

-- Inserciones para la tabla `playlist`
INSERT INTO `playlist` (`playlist_titulo`, `playlist_numCanciones`, `playlist_creacion`, `estado_estado_id`, `playlist_fechaEliminacion`) VALUES
('Mis favoritas', 3, '2024-06-01 15:00:00', 1, NULL),
('Música para correr', 2, '2024-06-10 09:00:00', 1, NULL),
('Relax', 1, '2024-06-05 18:00:00', 1, NULL);

-- Inserciones para la tabla `estado`
INSERT INTO `estado` (`estado_id`, `estado_nombre`, `estado_fechaEliminacion`) VALUES
(1, 'Activo', NULL),
(2, 'Inactivo', NULL);

-- Inserciones para la tabla `artista_relacionado`
INSERT INTO `artista_relacionado` (`artista_principal_id`, `artista_relacionado_id`) VALUES
(1, 2),
(1, 3),
(2, 1),
(2, 3),
(3, 1),
(3, 2);

-- Inserciones para la tabla `usuario_has_playlist`
INSERT INTO `usuario_has_playlist` (`usuario_usuario_id`, `playlist_playlist_id`) VALUES
(1, 1),
(1, 2),
(2, 1),
(3, 3);

-- Inserciones para la tabla `usuario_sigue_artista`
INSERT INTO `usuario_sigue_artista` (`usuario_usuario_id`, `artista_artista_id`) VALUES
(1, 1),
(2, 2),
(3, 3);

-- Inserciones para la tabla `usuario_favorito_album`
INSERT INTO `usuario_favorito_album` (`usuario_usuario_id`, `album_album_id`) VALUES
(1, 1),
(2, 2),
(3, 3);

-- Inserciones para la tabla `usuario_favorito_cancion`
INSERT INTO `usuario_favorito_cancion` (`usuario_usuario_id`, `cancion_cancion_id`) VALUES
(1, 1),
(2, 2),
(3, 3);

-- Inserciones para la tabla `pagos`
INSERT INTO `pagos` (`pagos_fecha`, `pagos_total`, `usuario_usuario_id`) VALUES
('2024-06-01 10:00:00', 10.00, 1),
('2024-05-15 09:30:00', 15.00, 2),
('2024-06-05 11:00:00', 5.00, 3);

-- Inserciones para la tabla `tarjeta`
INSERT INTO `tarjeta` (`tarjeta_numero`, `tarjeta_caducidad`, `tarjeta_cvv`, `usuario_usuario_id`) VALUES
('1111222233334444', '2025-12-31', 123, 1),
('5555666677778888', '2024-10-31', 456, 2);

-- Inserciones para la tabla `paypal`
INSERT INTO `paypal` (`paypal_usuario`, `usuario_usuario_id`) VALUES
('paypal_usuario1', 1),
('paypal_usuario2', 2);

-- Restaurar configuraciones originales
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
