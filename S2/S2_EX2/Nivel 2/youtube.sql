--- Configuración inicial
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- Crear el esquema YouTube
CREATE SCHEMA IF NOT EXISTS `YouTube` DEFAULT CHARACTER SET utf8;
USE `YouTube`;

-- Crear tabla `canal`
CREATE TABLE IF NOT EXISTS `canal` (
  `canal_id` INT NOT NULL AUTO_INCREMENT,
  `canal_descripcion` TEXT,
  `canal_nombre` VARCHAR(100) NOT NULL,
  `canal_creacion` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`canal_id`)
) ENGINE=InnoDB;

-- Crear tabla `usuario`
CREATE TABLE IF NOT EXISTS `usuario` (
  `usuario_id` INT NOT NULL AUTO_INCREMENT,
  `usuario_mail` VARCHAR(150) NOT NULL,
  `usuario_nacimiento` DATETIME NOT NULL,
  `usuario_sexo` ENUM('Masculino', 'Femenino', 'Otro') NOT NULL,
  `usuario_pais` VARCHAR(100) NOT NULL,
  `usuario_cp` INT(5),
  `canal_canal_id` INT NOT NULL,
  PRIMARY KEY (`usuario_id`, `canal_canal_id`),
  UNIQUE INDEX `unique_usuario_id` (`usuario_id`), -- Agregar un índice único a `usuario_id`
  UNIQUE INDEX `unique_canal_canal_id` (`canal_canal_id`), -- Agregar un índice único a `canal_canal_id`
  INDEX `fk_usuario_canal1_idx` (`canal_canal_id`),
  CONSTRAINT `fk_usuario_canal1`
    FOREIGN KEY (`canal_canal_id`)
    REFERENCES `canal` (`canal_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Crear tabla `estado`
CREATE TABLE IF NOT EXISTS `estado` (
  `estado_id` INT NOT NULL AUTO_INCREMENT,
  `estado_nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`estado_id`)
) ENGINE=InnoDB;

-- Crear tabla `video`
CREATE TABLE IF NOT EXISTS `video` (
  `video_id` INT NOT NULL AUTO_INCREMENT,
  `video_titulo` VARCHAR(200) NOT NULL,
  `video_desc` TEXT,
  `video_size` INT NOT NULL,
  `video_nombreArchivo` VARCHAR(200) NOT NULL,
  `video_duracion` INT NOT NULL,
  `video_thumbnail` BLOB NOT NULL,
  `video_reproducciones` INT NOT NULL,
  `video_likes` INT NOT NULL,
  `video_dislikes` INT NOT NULL,
  `estado_estado_id` INT NOT NULL,
  `video_publicacion` DATETIME,
  `usuario_usuario_id` INT NOT NULL,
  PRIMARY KEY (`video_id`),
  INDEX `fk_video_estado_idx` (`estado_estado_id`),
  INDEX `fk_video_usuario1_idx` (`usuario_usuario_id`),
  CONSTRAINT `fk_video_estado`
    FOREIGN KEY (`estado_estado_id`)
    REFERENCES `estado` (`estado_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_video_usuario1`
    FOREIGN KEY (`usuario_usuario_id`)
    REFERENCES `usuario` (`usuario_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Crear tabla `etiqueta`
CREATE TABLE IF NOT EXISTS `etiqueta` (
  `etiqueta_id` INT NOT NULL AUTO_INCREMENT,
  `etiqueta_nombre` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`etiqueta_id`)
) ENGINE=InnoDB;

-- Crear tabla intermedia `video_has_etiqueta`
CREATE TABLE IF NOT EXISTS `video_has_etiqueta` (
  `video_video_id` INT NOT NULL,
  `etiqueta_etiqueta_id` INT NOT NULL,
  PRIMARY KEY (`video_video_id`, `etiqueta_etiqueta_id`),
  INDEX `fk_video_has_etiqueta_etiqueta1_idx` (`etiqueta_etiqueta_id`),
  INDEX `fk_video_has_etiqueta_video1_idx` (`video_video_id`),
  CONSTRAINT `fk_video_has_etiqueta_video1`
    FOREIGN KEY (`video_video_id`)
    REFERENCES `video` (`video_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_video_has_etiqueta_etiqueta1`
    FOREIGN KEY (`etiqueta_etiqueta_id`)
    REFERENCES `etiqueta` (`etiqueta_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Crear tabla `suscripciones`
CREATE TABLE IF NOT EXISTS `suscripciones` (
  `usuario_usuario_id` INT NOT NULL,
  `canal_canal_id` INT NOT NULL,
  `usuario_canal_canal_id` INT NOT NULL,
  PRIMARY KEY (`usuario_usuario_id`, `canal_canal_id`),
  INDEX `fk_usuario_has_canal_canal1_idx` (`canal_canal_id`),
  INDEX `fk_suscripciones_usuario1_idx` (`usuario_canal_canal_id`),
  CONSTRAINT `fk_usuario_has_canal_canal1`
    FOREIGN KEY (`canal_canal_id`)
    REFERENCES `canal` (`canal_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_suscripciones_usuario1`
    FOREIGN KEY (`usuario_canal_canal_id`)
    REFERENCES `usuario` (`canal_canal_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Crear tabla `feedback`
CREATE TABLE IF NOT EXISTS `feedback` (
  `feedback_like` TINYINT(1),
  `usuario_usuario_id` INT NOT NULL,
  `video_video_id` INT NOT NULL,
  `feedback_fecha` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `feedback_dislike` TINYINT(1),
  INDEX `fk_feedback_usuario1_idx` (`usuario_usuario_id`),
  PRIMARY KEY (`video_video_id`),
  CONSTRAINT `fk_feedback_usuario1`
    FOREIGN KEY (`usuario_usuario_id`)
    REFERENCES `usuario` (`usuario_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_feedback_video1`
    FOREIGN KEY (`video_video_id`)
    REFERENCES `video` (`video_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Crear tabla `estado_playlist`
CREATE TABLE IF NOT EXISTS `estado_playlist` (
  `estado_playlist_id` INT NOT NULL AUTO_INCREMENT,
  `estado_playlist_nombre` VARCHAR(45),
  PRIMARY KEY (`estado_playlist_id`)
) ENGINE=InnoDB;

-- Crear tabla `playlist`
CREATE TABLE IF NOT EXISTS `playlist` (
  `playlist_id` INT NOT NULL AUTO_INCREMENT,
  `playlist_nombre` VARCHAR(150),
  `playlist_fecha` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `estado_playlist_estado_playlist_id` INT NOT NULL,
  PRIMARY KEY (`playlist_id`),
  INDEX `fk_playlist_estado_playlist1_idx` (`estado_playlist_estado_playlist_id`),
  CONSTRAINT `fk_playlist_estado_playlist1`
    FOREIGN KEY (`estado_playlist_estado_playlist_id`)
    REFERENCES `estado_playlist` (`estado_playlist_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Crear tabla intermedia `playlist_has_video`
CREATE TABLE IF NOT EXISTS `playlist_has_video` (
  `playlist_playlist_id` INT NOT NULL,
  `video_video_id` INT NOT NULL,
  PRIMARY KEY (`playlist_playlist_id`, `video_video_id`),
  INDEX `fk_playlist_has_video_video1_idx` (`video_video_id`),
  INDEX `fk_playlist_has_video_playlist1_idx` (`playlist_playlist_id`),
  CONSTRAINT `fk_playlist_has_video_playlist1`
    FOREIGN KEY (`playlist_playlist_id`)
    REFERENCES `playlist` (`playlist_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_playlist_has_video_video1`
    FOREIGN KEY (`video_video_id`)
    REFERENCES `video` (`video_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Crear tabla `comentario`
CREATE TABLE IF NOT EXISTS `comentario` (
  `comentario_id` INT NOT NULL AUTO_INCREMENT,
  `usuario_usuario_id` INT NOT NULL,
  `video_video_id` INT NOT NULL,
  `comentario_texto` TEXT,
  `comentario_fecha` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `comentario_likes` INT NOT NULL,
  `comentario_dislikes` INT NOT NULL,
  PRIMARY KEY (`comentario_id`, `usuario_usuario_id`, `video_video_id`),
  UNIQUE INDEX `unique_comentario` (`comentario_id`, `usuario_usuario_id`), -- Agregar un índice único a `comentario_id` y `usuario_usuario_id`
  INDEX `fk_usuario_has_video_video1_idx` (`video_video_id`),
  INDEX `fk_usuario_has_video_usuario1_idx` (`usuario_usuario_id`),
  CONSTRAINT `fk_usuario_has_video_usuario1`
    FOREIGN KEY (`usuario_usuario_id`)
    REFERENCES `usuario` (`usuario_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_usuario_has_video_video1`
    FOREIGN KEY (`video_video_id`)
    REFERENCES `video` (`video_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Crear tabla `feedback_comentario`
CREATE TABLE IF NOT EXISTS `feedback_comentario` (
  `feedback_like` TINYINT(1),
  `feedback_fecha` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `feedback_dislike` TINYINT(1),
  `comentario_comentario_id` INT NOT NULL,
  `comentario_usuario_usuario_id` INT NOT NULL,
  `usuario_usuario_id` INT NOT NULL,
  INDEX `fk_feedback_comentario_comentario1_idx` (`comentario_comentario_id`, `comentario_usuario_usuario_id`),
  PRIMARY KEY (`usuario_usuario_id`),
  CONSTRAINT `fk_feedback_comentario_comentario1`
    FOREIGN KEY (`comentario_comentario_id`, `comentario_usuario_usuario_id`)
    REFERENCES `comentario` (`comentario_id`, `usuario_usuario_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_feedback_comentario_usuario1`
    FOREIGN KEY (`usuario_usuario_id`)
    REFERENCES `usuario` (`usuario_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Insertar datos de ejemplo en la tabla `canal`
INSERT INTO `canal` (`canal_descripcion`, `canal_nombre`, `canal_creacion`) VALUES
  ('Canal de música', 'Music Channel', '2023-01-15 10:30:00'),
  ('Canal de videojuegos', 'Gaming Channel', '2023-02-20 14:45:00'),
  ('Canal de cocina', 'Cooking Channel', '2023-03-10 08:00:00');

-- Insertar datos de ejemplo en la tabla `usuario`
INSERT INTO `usuario` (`usuario_mail`, `usuario_nacimiento`, `usuario_sexo`, `usuario_pais`, `usuario_cp`, `canal_canal_id`) VALUES
  ('usuario1@gmail.com', '1990-05-20', 'Masculino', 'España', 28001, 1),
  ('usuario2@yahoo.com', '1985-10-12', 'Femenino', 'México', 01000, 2),
  ('usuario3@hotmail.com', '2000-03-25', 'Otro', 'Argentina', 1000, 3);

-- Insertar datos de ejemplo en la tabla `estado`
INSERT INTO `estado` (`estado_nombre`) VALUES
  ('Activo'),
  ('Inactivo');

-- Insertar datos de ejemplo en la tabla `video`
INSERT INTO `video` (`video_titulo`, `video_desc`, `video_size`, `video_nombreArchivo`, `video_duracion`, `video_thumbnail`, `video_reproducciones`, `video_likes`, `video_dislikes`, `estado_estado_id`, `video_publicacion`, `usuario_usuario_id`) VALUES
  ('Tutorial de música', 'Aprende a tocar guitarra', 256, 'tutorial_musica.mp4', 300, '', 1000, 150, 10, 1, '2023-01-20 09:00:00', 1),
  ('Gameplay de Fortnite', 'Partida épica con victoria', 1024, 'fortnite_gameplay.mp4', 600, '', 5000, 300, 50, 1, '2023-02-25 15:30:00', 2),
  ('Receta de pastel de chocolate', 'Deliciosa receta paso a paso', 512, 'receta_pastel_chocolate.mp4', 480, '', 2000, 200, 20, 1, '2023-03-15 12:00:00', 3);

-- Insertar datos de ejemplo en la tabla `etiqueta`
INSERT INTO `etiqueta` (`etiqueta_nombre`) VALUES
  ('Tutorial'),
  ('Música'),
  ('Guitarra'),
  ('Fortnite'),
  ('Gameplay'),
  ('Receta'),
  ('Cocina');

-- Insertar datos de ejemplo en la tabla intermedia `video_has_etiqueta`
INSERT INTO `video_has_etiqueta` (`video_video_id`, `etiqueta_etiqueta_id`) VALUES
  (1, 1),
  (1, 2),
  (1, 3),
  (2, 4),
  (2, 5),
  (3, 6),
  (3, 7);

-- Insertar datos de ejemplo en la tabla `suscripciones`
INSERT INTO `suscripciones` (`usuario_usuario_id`, `canal_canal_id`, `usuario_canal_canal_id`) VALUES
  (1, 1, 1),
  (2, 2, 2),
  (3, 3, 3);

-- Insertar datos de ejemplo en la tabla `feedback`
INSERT INTO `feedback` (`feedback_like`, `usuario_usuario_id`, `video_video_id`, `feedback_fecha`, `feedback_dislike`) VALUES
  (1, 1, 1, '2023-01-21 10:00:00', 0),
  (1, 2, 2, '2023-02-26 16:00:00', 0),
  (1, 3, 3, '2023-03-16 13:30:00', 0);

-- Insertar datos de ejemplo en la tabla `estado_playlist`
INSERT INTO `estado_playlist` (`estado_playlist_nombre`) VALUES
  ('Pública'),
  ('Privada');

-- Insertar datos de ejemplo en la tabla `playlist`
INSERT INTO `playlist` (`playlist_nombre`, `estado_playlist_estado_playlist_id`) VALUES
  ('Mis favoritos', 1),
  ('Recetas top', 1),
  ('Gameplays destacados', 2);

-- Insertar datos de ejemplo en la tabla intermedia `playlist_has_video`
INSERT INTO `playlist_has_video` (`playlist_playlist_id`, `video_video_id`) VALUES
  (1, 1),
  (2, 3),
  (3, 2);

-- Insertar datos de ejemplo en la tabla `comentario`
INSERT INTO `comentario` (`usuario_usuario_id`, `video_video_id`, `comentario_texto`, `comentario_likes`, `comentario_dislikes`) VALUES
  (1, 1, '¡Excelente tutorial!', 10, 0),
  (2, 2, 'Me encantó el gameplay', 15, 1),
  (3, 3, 'La receta es increíble', 20, 2);

-- Insertar datos de ejemplo en la tabla `feedback_comentario`
INSERT INTO `feedback_comentario` (`feedback_like`, `feedback_dislike`, `comentario_comentario_id`, `comentario_usuario_usuario_id`, `usuario_usuario_id`) VALUES
  (1, 0, 1, 1, 2),
  (1, 0, 2, 2, 3),
  (1, 0, 3, 3, 1);

-- Restaurar configuraciones iniciales
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

