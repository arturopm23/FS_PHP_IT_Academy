-- -----------------------------------------------------
-- Schema youtube
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `youtube` DEFAULT CHARACTER SET utf8 ;

USE `youtube`;

-- -----------------------------------------------------
-- Table `youtube`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`usuario` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `mail` VARCHAR(150) NOT NULL,
  `nacimiento` DATETIME NOT NULL,
  `sexo` ENUM('Masculino', 'Femenino', 'Otro') NOT NULL,
  `pais` VARCHAR(100) NOT NULL,
  `cp` INT(5) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `unique_id` (`id` ASC)
) ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `youtube`.`canal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`canal` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `descripcion` TEXT NULL DEFAULT NULL,
  `nombre` VARCHAR(100) NOT NULL,
  `creacion` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  `usuario_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`, `usuario_id`),
  INDEX `fk_canal_usuario1_idx` (`usuario_id` ASC),
  CONSTRAINT `fk_canal_usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `youtube`.`usuario` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `youtube`.`suscripciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`suscripciones` (
  `usuario_id` INT(11) NOT NULL,
  `canal_id` INT(11) NOT NULL,
  INDEX `fk_suscripciones_usuario1_idx` (`usuario_id` ASC),
  INDEX `fk_suscripciones_canal1_idx` (`canal_id` ASC),
  CONSTRAINT `fk_suscripciones_usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `youtube`.`usuario` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_suscripciones_canal1`
    FOREIGN KEY (`canal_id`)
    REFERENCES `youtube`.`canal` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `youtube`.`video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`video` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(200) NOT NULL,
  `descripcion` TEXT NULL DEFAULT NULL,
  `size` INT(11) NOT NULL,
  `nombreArchivo` VARCHAR(200) NOT NULL,
  `duracion` INT(11) NOT NULL,
  `thumbnail` BLOB NOT NULL,
  `reproducciones` INT(11) NOT NULL,
  `likes` INT(11) NOT NULL,
  `dislikes` INT(11) NOT NULL,
  `estado` ENUM('publico', 'oculto', 'privado') NOT NULL,
  `publicacion` DATETIME NOT NULL,
  `usuario_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_video_usuario1_idx` (`usuario_id` ASC),
  CONSTRAINT `fk_video_usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `youtube`.`usuario` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `youtube`.`comentario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`comentario` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `usuario_id` INT(11) NOT NULL,
  `video_id` INT(11) NOT NULL,
  `texto` TEXT NOT NULL,
  `fecha` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  `likes` INT(11) NOT NULL,
  `dislikes` INT(11) NOT NULL,
  PRIMARY KEY (`id`, `usuario_id`, `video_id`),
  UNIQUE INDEX `unique_comentario` (`id` ASC, `usuario_id` ASC),
  INDEX `fk_usuario_has_video_video1_idx` (`video_id` ASC),
  INDEX `fk_usuario_has_video_usuario1_idx` (`usuario_id` ASC),
  CONSTRAINT `fk_usuario_has_video_usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `youtube`.`usuario` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_usuario_has_video_video1`
    FOREIGN KEY (`video_id`)
    REFERENCES `youtube`.`video` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `youtube`.`etiqueta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`etiqueta` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `youtube`.`feedback`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`feedback` (
  `id` INT(11) NOT NULL,
  `like` ENUM('like', 'dislike') NOT NULL,
  `usuario_id` INT(11) NOT NULL,
  `video_id` INT(11) NOT NULL,
  `fecha` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  INDEX `fk_feedback_usuario1_idx` (`usuario_id` ASC),
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_feedback_usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `youtube`.`usuario` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_feedback_video1`
    FOREIGN KEY (`video_id`)
    REFERENCES `youtube`.`video` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `youtube`.`feedback_comentario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`feedback_comentario` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `like` ENUM('like', 'dislike') NOT NULL,
  `fecha` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  `comentario_id` INT(11) NOT NULL,
  `usuario_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_feedback_comentario_comentario1_idx` (`comentario_id` ASC),
  CONSTRAINT `fk_feedback_comentario_comentario1`
    FOREIGN KEY (`comentario_id`)
    REFERENCES `youtube`.`comentario` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_feedback_comentario_usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `youtube`.`usuario` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `youtube`.`playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`playlist` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(150) NOT NULL,
  `fecha` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  `estado` ENUM('publico', 'privado') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `youtube`.`playlist_video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`playlist_video` (
  `playlist_id` INT(11) NOT NULL,
  `video_id` INT(11) NOT NULL,
  PRIMARY KEY (`playlist_id`, `video_id`),
  INDEX `fk_playlist_video_video1_idx` (`video_id` ASC),
  INDEX `fk_playlist_video_playlist1_idx` (`playlist_id` ASC),
  CONSTRAINT `fk_playlist_video_playlist1`
    FOREIGN KEY (`playlist_id`)
    REFERENCES `youtube`.`playlist` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_playlist_video_video1`
    FOREIGN KEY (`video_id`)
    REFERENCES `youtube`.`video` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `youtube`.`video_etiqueta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`video_etiqueta` (
  `video_id` INT(11) NOT NULL,
  `etiqueta_id` INT(11) NOT NULL,
  PRIMARY KEY (`video_id`, `etiqueta_id`),
  INDEX `fk_video_etiqueta_etiqueta1_idx` (`etiqueta_id` ASC),
  INDEX `fk_video_etiqueta_video1_idx` (`video_id` ASC),
  CONSTRAINT `fk_video_etiqueta_etiqueta1`
    FOREIGN KEY (`etiqueta_id`)
    REFERENCES `youtube`.`etiqueta` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_video_etiqueta_video1`
    FOREIGN KEY (`video_id`)
    REFERENCES `youtube`.`video` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- Insertar datos de muestra en la tabla `usuario`
INSERT INTO `youtube`.`usuario` (`id`, `mail`, `nacimiento`, `sexo`, `pais`, `cp`) VALUES
(1, 'usuario1@example.com', '1990-05-15', 'Masculino', 'México', 12345),
(2, 'usuario2@example.com', '1985-08-20', 'Femenino', 'España', 28001),
(3, 'usuario3@example.com', '1995-03-10', 'Otro', 'Argentina', 1001);

-- Insertar datos de muestra en la tabla `canal`
INSERT INTO `youtube`.`canal` (`id`, `descripcion`, `nombre`, `creacion`, `usuario_id`) VALUES
(1, 'Canal de música variada', 'Mi Canal de Música', '2023-01-01 10:00:00', 1),
(2, 'Canal de viajes y aventuras', 'Viajes y Aventuras con María', '2023-01-02 09:30:00', 2),
(3, 'Canal de videojuegos retro', 'RetroGames 80s', '2023-01-03 15:45:00', 3);

-- Insertar datos de muestra en la tabla `suscripciones`
INSERT INTO `youtube`.`suscripciones` (`usuario_id`, `canal_id`) VALUES
(1, 2),
(2, 1),
(3, 2),
(3, 3);

-- Insertar datos de muestra en la tabla `video`
INSERT INTO `youtube`.`video` (`id`, `titulo`, `descripcion`, `size`, `nombreArchivo`, `duracion`, `thumbnail`, `reproducciones`, `likes`, `dislikes`, `estado`, `publicacion`, `usuario_id`) VALUES
(1, 'Introducción a la Música Clásica', 'Este video introduce los conceptos básicos de la música clásica.', 500, 'introduccion_musica_clasica.mp4', 600, '', 1000, 500, 20, 'publico', '2023-01-01 12:00:00', 1),
(2, 'Explorando Barcelona en un Día', 'Un recorrido por los lugares más emblemáticos de Barcelona.', 800, 'explorando_barcelona.mp4', 900, '', 800, 300, 10, 'publico', '2023-01-02 10:30:00', 2),
(3, 'Gameplay de Super Mario Bros', 'Revive la nostalgia con este gameplay del clásico de Nintendo.', 700, 'gameplay_super_mario.mp4', 750, '', 1200, 600, 25, 'publico', '2023-01-03 14:15:00', 3);

-- Insertar datos de muestra en la tabla `comentario`
INSERT INTO `youtube`.`comentario` (`id`, `usuario_id`, `video_id`, `texto`, `fecha`, `likes`, `dislikes`) VALUES
(1, 1, 2, '¡Qué increíble recorrido por Barcelona!', '2023-01-02 11:00:00', 10, 1),
(2, 2, 1, 'Muy interesante la introducción a la música clásica.', '2023-01-01 13:30:00', 15, 2),
(3, 3, 3, 'Este gameplay me trae recuerdos de mi infancia.', '2023-01-03 15:00:00', 20, 0);

-- Insertar datos de muestra en la tabla `etiqueta`
INSERT INTO `youtube`.`etiqueta` (`id`, `nombre`) VALUES
(1, 'Música Clásica'),
(2, 'Barcelona'),
(3, 'Videojuegos Retro');

-- Insertar datos de muestra en la tabla `video_etiqueta`
INSERT INTO `youtube`.`video_etiqueta` (`video_id`, `etiqueta_id`) VALUES
(1, 1),
(2, 2),
(3, 3);

-- Insertar datos de muestra en la tabla `feedback`
INSERT INTO `youtube`.`feedback` (`id`, `like`, `usuario_id`, `video_id`, `fecha`) VALUES
(1, 'like', 1, 2, '2023-01-02 11:30:00'),
(2, 'dislike', 2, 1, '2023-01-01 14:00:00'),
(3, 'like', 3, 3, '2023-01-03 15:30:00');

-- Insertar datos de muestra en la tabla `feedback_comentario`
INSERT INTO `youtube`.`feedback_comentario` (`id`, `like`, `fecha`, `comentario_id`, `usuario_id`) VALUES
(1, 'like', '2023-01-02 11:30:00', 1, 2),
(2, 'dislike', '2023-01-01 14:00:00', 2, 3),
(3, 'like', '2023-01-03 15:30:00', 3, 1);

-- Insertar datos de muestra en la tabla `playlist`
INSERT INTO `youtube`.`playlist` (`id`, `nombre`, `fecha`, `estado`) VALUES
(1, 'Mis Favoritos', '2023-01-01 14:00:00', 'publico'),
(2, 'Viajes Recientes', '2023-01-02 10:00:00', 'privado'),
(3, 'Gameplays Épicos', '2023-01-03 16:00:00', 'publico');

-- Insertar datos de muestra en la tabla `playlist_video`
INSERT INTO `youtube`.`playlist_video` (`playlist_id`, `video_id`) VALUES
(1, 1),
(2, 2),
(3, 3);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
