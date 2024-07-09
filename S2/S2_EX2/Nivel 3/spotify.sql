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
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `spotify`.`suscripcion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`suscripcion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `inicio` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `renovacion` DATETIME NOT NULL,
  `pago` ENUM('tarjeta', 'Paypal') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `spotify`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`usuario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(150) NOT NULL,
  `contrasena` VARCHAR(50) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `nacimiento` DATETIME NOT NULL,
  `sexo` ENUM('Masculino', 'Femenino', 'Otro') NOT NULL,
  `pais` VARCHAR(45) NULL,
  `cp` INT(5) NULL,
  `plan_id` INT NOT NULL,
  `suscripcion_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_usuario_plan_idx` (`plan_id` ASC) VISIBLE,
  INDEX `fk_usuario_suscripcion_idx` (`suscripcion_id` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_plan`
    FOREIGN KEY (`plan_id`)
    REFERENCES `spotify`.`plan` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_usuario_suscripcion`
    FOREIGN KEY (`suscripcion_id`)
    REFERENCES `spotify`.`suscripcion` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `spotify`.`tarjeta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`tarjeta` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `numero` VARCHAR(19) NOT NULL,
  `caducidad` DATETIME NOT NULL,
  `cvv` INT(3) NOT NULL,
  `usuario_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tarjeta_usuario_idx` (`usuario_id` ASC) VISIBLE,
  CONSTRAINT `fk_tarjeta_usuario`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `spotify`.`usuario` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `spotify`.`paypal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`paypal` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `usuario` VARCHAR(100) NULL,
  `usuario_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_paypal_usuario_idx` (`usuario_id` ASC) VISIBLE,
  CONSTRAINT `fk_paypal_usuario`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `spotify`.`usuario` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `spotify`.`pago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`pago` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATETIME NULL,
  `total` DECIMAL(10,2) NULL,
  `usuario_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_pago_usuario_idx` (`usuario_id` ASC) VISIBLE,
  CONSTRAINT `fk_pago_usuario`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `spotify`.`usuario` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `spotify`.`estado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`estado` (
  `id` TINYINT(1) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `fecha_eliminacion` DATETIME NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `spotify`.`playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`playlist` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(100) NOT NULL,
  `num_canciones` INT NOT NULL,
  `creacion` DATETIME NOT NULL,
  `estado_id` TINYINT(1) NOT NULL,
  `fecha_eliminacion` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_playlist_estado_idx` (`estado_id` ASC) VISIBLE,
  CONSTRAINT `fk_playlist_estado`
    FOREIGN KEY (`estado_id`)
    REFERENCES `spotify`.`estado` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `spotify`.`usuario_playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`usuario_playlist` (
  `usuario_id` INT NOT NULL,
  `playlist_id` INT NOT NULL,
  PRIMARY KEY (`usuario_id`, `playlist_id`),
  INDEX `fk_usuario_playlist_playlist_idx` (`playlist_id` ASC) VISIBLE,
  INDEX `fk_usuario_playlist_usuario_idx` (`usuario_id` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_playlist_usuario`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `spotify`.`usuario` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_usuario_playlist_playlist`
    FOREIGN KEY (`playlist_id`)
    REFERENCES `spotify`.`playlist` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `spotify`.`artista`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`artista` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `imagen` VARCHAR(255) NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `spotify`.`artista_relacionado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`artista_relacionado` (
  `principal_id` INT NOT NULL,
  `relacionado_id` INT NOT NULL,
  PRIMARY KEY (`principal_id`, `relacionado_id`),
  INDEX `fk_artista_relacionado_principal_idx` (`principal_id` ASC) VISIBLE,
  INDEX `fk_artista_relacionado_relacionado_idx` (`relacionado_id` ASC) VISIBLE,
  CONSTRAINT `fk_artista_relacionado_principal`
    FOREIGN KEY (`principal_id`)
    REFERENCES `spotify`.`artista` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_artista_relacionado_relacionado`
    FOREIGN KEY (`relacionado_id`)
    REFERENCES `spotify`.`artista` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `spotify`.`album`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`album` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(100) NOT NULL,
  `publicacion` INT NOT NULL,
  `imagen` VARCHAR(255) NULL,
  `artista_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `unique_album_artista` (`id`, `artista_id`), -- Unique index added
  INDEX `fk_album_artista_idx` (`artista_id` ASC) VISIBLE,
  CONSTRAINT `fk_album_artista`
    FOREIGN KEY (`artista_id`)
    REFERENCES `spotify`.`artista` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `spotify`.`cancion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`cancion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(100) NOT NULL,
  `duracion` INT NOT NULL,
  `reproducciones` INT NOT NULL DEFAULT 0,
  `album_id` INT NOT NULL,
  `artista_id` INT NOT NULL,
  `usuario_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cancion_album_idx` (`album_id` ASC, `artista_id` ASC) VISIBLE,
  INDEX `fk_cancion_usuario_idx` (`usuario_id` ASC) VISIBLE,
  CONSTRAINT `fk_cancion_album`
    FOREIGN KEY (`album_id`, `artista_id`)
    REFERENCES `spotify`.`album` (`id`, `artista_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_cancion_usuario`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `spotify`.`usuario` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `spotify`.`cancion_playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`cancion_playlist` (
  `cancion_id` INT NOT NULL,
  `playlist_id` INT NOT NULL,
  PRIMARY KEY (`cancion_id`, `playlist_id`),
  INDEX `fk_cancion_playlist_playlist_idx` (`playlist_id` ASC) VISIBLE,
  INDEX `fk_cancion_playlist_cancion_idx` (`cancion_id` ASC) VISIBLE,
  CONSTRAINT `fk_cancion_playlist_cancion`
    FOREIGN KEY (`cancion_id`)
    REFERENCES `spotify`.`cancion` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_cancion_playlist_playlist`
    FOREIGN KEY (`playlist_id`)
    REFERENCES `spotify`.`playlist` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `spotify`.`reproduccion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`reproduccion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATETIME NOT NULL,
  `ubicacion` VARCHAR(100) NULL,
  `cancion_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_reproduccion_cancion_idx` (`cancion_id` ASC) VISIBLE,
  CONSTRAINT `fk_reproduccion_cancion`
    FOREIGN KEY (`cancion_id`)
    REFERENCES `spotify`.`cancion` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

