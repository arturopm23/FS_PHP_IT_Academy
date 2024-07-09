--- Configuración inicial
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- Crear el esquema YouTube
CREATE SCHEMA IF NOT EXISTS `YouTube` DEFAULT CHARACTER SET utf8;
USE `YouTube`;

-- Crear tabla `canal`
CREATE TABLE IF NOT EXISTS `canal` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descripcion` TEXT,
  `nombre` VARCHAR(100) NOT NULL,
  `creacion` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

-- Crear tabla `usuario`
CREATE TABLE IF NOT EXISTS `usuario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `mail` VARCHAR(150) NOT NULL,
  `nacimiento` DATETIME NOT NULL,
  `sexo` ENUM('Masculino', 'Femenino', 'Otro') NOT NULL,
  `pais` VARCHAR(100) NOT NULL,
  `cp` INT(5),
  `canal_id` INT NOT NULL,
  PRIMARY KEY (`id`, `canal_id`),
  UNIQUE INDEX `unique_id` (`id`), -- Agregar un índice único a `id`
  UNIQUE INDEX `unique_canal_id` (`canal_id`), -- Agregar un índice único a `canal_id`
  INDEX `fk_usuario_canal1_idx` (`canal_id`),
  CONSTRAINT `fk_usuario_canal1`
    FOREIGN KEY (`canal_id`)
    REFERENCES `canal` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Crear tabla `estado`
CREATE TABLE IF NOT EXISTS `estado` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

-- Crear tabla `video`
CREATE TABLE IF NOT EXISTS `video` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(200) NOT NULL,
  `descripcion` TEXT,
  `size` INT NOT NULL,
  `nombreArchivo` VARCHAR(200) NOT NULL,
  `duracion` INT NOT NULL,
  `thumbnail` BLOB NOT NULL,
  `reproducciones` INT NOT NULL,
  `likes` INT NOT NULL,
  `dislikes` INT NOT NULL,
  `estado_id` INT NOT NULL,
  `publicacion` DATETIME,
  `usuario_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_video_estado_idx` (`estado_id`),
  INDEX `fk_video_usuario1_idx` (`usuario_id`),
  CONSTRAINT `fk_video_estado`
    FOREIGN KEY (`estado_id`)
    REFERENCES `estado` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_video_usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `usuario` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Crear tabla `etiqueta`
CREATE TABLE IF NOT EXISTS `etiqueta` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

-- Crear tabla intermedia `video_etiqueta`
CREATE TABLE IF NOT EXISTS `video_etiqueta` (
  `video_id` INT NOT NULL,
  `etiqueta_id` INT NOT NULL,
  PRIMARY KEY (`video_id`, `etiqueta_id`),
  INDEX `fk_video_etiqueta_etiqueta1_idx` (`etiqueta_id`),
  INDEX `fk_video_etiqueta_video1_idx` (`video_id`),
  CONSTRAINT `fk_video_etiqueta_video1`
    FOREIGN KEY (`video_id`)
    REFERENCES `video` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_video_etiqueta_etiqueta1`
    FOREIGN KEY (`etiqueta_id`)
    REFERENCES `etiqueta` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Crear tabla `suscripciones`
CREATE TABLE IF NOT EXISTS `suscripciones` (
  `usuario_id` INT NOT NULL,
  `canal_id` INT NOT NULL,
  `usuario_canal_id` INT NOT NULL,
  PRIMARY KEY (`usuario_id`, `canal_id`),
  INDEX `fk_usuario_has_canal_canal1_idx` (`canal_id`),
  INDEX `fk_suscripciones_usuario1_idx` (`usuario_canal_id`),
  CONSTRAINT `fk_usuario_has_canal_canal1`
    FOREIGN KEY (`canal_id`)
    REFERENCES `canal` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_suscripciones_usuario1`
    FOREIGN KEY (`usuario_canal_id`)
    REFERENCES `usuario` (`canal_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Crear tabla `feedback`
CREATE TABLE IF NOT EXISTS `feedback` (
  `like` TINYINT(1),
  `usuario_id` INT NOT NULL,
  `video_id` INT NOT NULL,
  `fecha` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `dislike` TINYINT(1),
  INDEX `fk_feedback_usuario1_idx` (`usuario_id`),
  PRIMARY KEY (`video_id`),
  CONSTRAINT `fk_feedback_usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `usuario` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_feedback_video1`
    FOREIGN KEY (`video_id`)
    REFERENCES `video` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Crear tabla `estado_playlist`
CREATE TABLE IF NOT EXISTS `estado_playlist` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

-- Crear tabla `playlist`
CREATE TABLE IF NOT EXISTS `playlist` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(150),
  `fecha` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `estado_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_playlist_estado_playlist1_idx` (`estado_id`),
  CONSTRAINT `fk_playlist_estado_playlist1`
    FOREIGN KEY (`estado_id`)
    REFERENCES `estado_playlist` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Crear tabla intermedia `playlist_video`
CREATE TABLE IF NOT EXISTS `playlist_video` (
  `playlist_id` INT NOT NULL,
  `video_id` INT NOT NULL,
  PRIMARY KEY (`playlist_id`, `video_id`),
  INDEX `fk_playlist_video_video1_idx` (`video_id`),
  INDEX `fk_playlist_video_playlist1_idx` (`playlist_id`),
  CONSTRAINT `fk_playlist_video_playlist1`
    FOREIGN KEY (`playlist_id`)
    REFERENCES `playlist` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_playlist_video_video1`
    FOREIGN KEY (`video_id`)
    REFERENCES `video` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Crear tabla `comentario`
CREATE TABLE IF NOT EXISTS `comentario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `usuario_id` INT NOT NULL,
  `video_id` INT NOT NULL,
  `texto` TEXT,
  `fecha` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `likes` INT NOT NULL,
  `dislikes` INT NOT NULL,
  PRIMARY KEY (`id`, `usuario_id`, `video_id`),
  UNIQUE INDEX `unique_comentario` (`id`, `usuario_id`), -- Agregar un índice único a `id` y `usuario_id`
  INDEX `fk_usuario_has_video_video1_idx` (`video_id`),
  INDEX `fk_usuario_has_video_usuario1_idx` (`usuario_id`),
  CONSTRAINT `fk_usuario_has_video_usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `usuario` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_usuario_has_video_video1`
    FOREIGN KEY (`video_id`)
    REFERENCES `video` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Crear tabla `feedback_comentario`
CREATE TABLE IF NOT EXISTS `feedback_comentario` (
  `like` TINYINT(1),
  `fecha` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `dislike` TINYINT(1),
  `comentario_id` INT NOT NULL,
  `comentario_usuario_id` INT NOT NULL,
  `usuario_id` INT NOT NULL,
  INDEX `fk_feedback_comentario_comentario1_idx` (`comentario_id`, `comentario_usuario_id`),
  PRIMARY KEY (`usuario_id`),
  CONSTRAINT `fk_feedback_comentario_comentario1`
    FOREIGN KEY (`comentario_id`, `comentario_usuario_id`)
    REFERENCES `comentario` (`id`, `usuario_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_feedback_comentario_usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `usuario` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Restaurar la configuración original
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
