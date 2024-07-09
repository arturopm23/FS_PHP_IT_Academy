SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- Create schema if not exists
CREATE SCHEMA IF NOT EXISTS `spotify` DEFAULT CHARACTER SET utf8 ;
USE `spotify` ;

-- Table structure for table `artista`
CREATE TABLE IF NOT EXISTS `spotify`.`artista` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `imagen` BLOB NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Table structure for table `album`
CREATE TABLE IF NOT EXISTS `spotify`.`album` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(100) NOT NULL,
  `publicacion` INT(11) NOT NULL,
  `imagen` BLOB NULL DEFAULT NULL,
  `artista_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `unique_album_artista` (`id`, `artista_id`),
  INDEX `fk_album_artista_idx` (`artista_id`),
  CONSTRAINT `fk_album_artista`
    FOREIGN KEY (`artista_id`)
    REFERENCES `spotify`.`artista` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Table structure for table `artista_relacionado`
CREATE TABLE IF NOT EXISTS `spotify`.`artista_relacionado` (
  `principal_id` INT(11) NOT NULL,
  `relacionado_id` INT(11) NOT NULL,
  PRIMARY KEY (`principal_id`, `relacionado_id`),
  INDEX `fk_artista_relacionado_principal_idx` (`principal_id`),
  INDEX `fk_artista_relacionado_relacionado_idx` (`relacionado_id`),
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Table structure for table `usuario`
CREATE TABLE IF NOT EXISTS `spotify`.`usuario` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(150) NOT NULL,
  `contrasena` VARCHAR(50) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `nacimiento` DATETIME NOT NULL,
  `sexo` ENUM('Masculino', 'Femenino', 'Otro') NOT NULL,
  `pais` VARCHAR(45) NULL DEFAULT NULL,
  `cp` INT(5) NULL DEFAULT NULL,
  `plan` ENUM('gratuito', 'premium') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Table structure for table `cancion`
CREATE TABLE IF NOT EXISTS `spotify`.`cancion` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(100) NOT NULL,
  `duracion` INT(11) NOT NULL,
  `reproducciones` INT(11) NOT NULL DEFAULT 0,
  `album_id` INT(11) NOT NULL,
  `artista_id` INT(11) NOT NULL,
  `usuario_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cancion_album_idx` (`album_id`, `artista_id`),
  INDEX `fk_cancion_usuario_idx` (`usuario_id`),
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Table structure for table `playlist`
CREATE TABLE IF NOT EXISTS `spotify`.`playlist` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(100) NOT NULL,
  `num_canciones` INT(11) NOT NULL,
  `creacion` DATETIME NOT NULL,
  `estado_id` ENUM('activa', 'eliminada') NOT NULL,
  `fecha_eliminacion` DATETIME NULL DEFAULT NULL,
  `usuario_id_creador` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_playlist_usuario1_idx` (`usuario_id_creador`),
  CONSTRAINT `fk_playlist_usuario1`
    FOREIGN KEY (`usuario_id_creador`)
    REFERENCES `spotify`.`usuario` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Table structure for table `cancion_playlist`
CREATE TABLE IF NOT EXISTS `spotify`.`cancion_playlist` (
  `cancion_id` INT(11) NOT NULL,
  `playlist_id` INT(11) NOT NULL,
  `added` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario_id` INT(11) NOT NULL,
  PRIMARY KEY (`cancion_id`, `playlist_id`, `usuario_id`),
  INDEX `fk_cancion_playlist_playlist_idx` (`playlist_id`),
  INDEX `fk_cancion_playlist_cancion_idx` (`cancion_id`),
  INDEX `fk_cancion_playlist_usuario1_idx` (`usuario_id`),
  CONSTRAINT `fk_cancion_playlist_cancion`
    FOREIGN KEY (`cancion_id`)
    REFERENCES `spotify`.`cancion` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_cancion_playlist_playlist`
    FOREIGN KEY (`playlist_id`)
    REFERENCES `spotify`.`playlist` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_cancion_playlist_usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `spotify`.`usuario` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Table structure for table `suscripcion`
CREATE TABLE IF NOT EXISTS `spotify`.`suscripcion` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `inicio` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  `renovacion` DATETIME NOT NULL,
  `pago` ENUM('tarjeta', 'Paypal') NOT NULL,
  `usuario_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_suscripcion_usuario1_idx` (`usuario_id`),
  CONSTRAINT `fk_suscripcion_usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `spotify`.`usuario` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Table structure for table `pago`
CREATE TABLE IF NOT EXISTS `spotify`.`pago` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `fecha` DATETIME NOT NULL,
  `total` DECIMAL(10,2) NOT NULL,
  `suscripcion_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_pago_suscripcion1_idx` (`suscripcion_id`),
  CONSTRAINT `fk_pago_suscripcion1`
    FOREIGN KEY (`suscripcion_id`)
    REFERENCES `spotify`.`suscripcion` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Table structure for table `paypal`
CREATE TABLE IF NOT EXISTS `spotify`.`paypal` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `pago_id` INT(11) NOT NULL,
  `usuario` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_paypal_pago1_idx` (`pago_id`),
  CONSTRAINT `fk_paypal_pago1`
    FOREIGN KEY (`pago_id`)
    REFERENCES `spotify`.`pago` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Table structure for table `reproduccion`
CREATE TABLE IF NOT EXISTS `spotify`.`reproduccion` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `fecha` DATETIME NOT NULL,
  `ubicacion` VARCHAR(100) NOT NULL,
  `cancion_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_reproduccion_cancion_idx` (`cancion_id`),
  CONSTRAINT `fk_reproduccion_cancion`
    FOREIGN KEY (`cancion_id`)
    REFERENCES `spotify`.`cancion` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Table structure for table `tarjeta`
CREATE TABLE IF NOT EXISTS `spotify`.`tarjeta` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `numero` VARCHAR(19) NOT NULL,
  `caducidad` DATETIME NOT NULL,
  `cvv` INT(3) NOT NULL,
  `pago_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tarjeta_pago1_idx` (`pago_id`),
  CONSTRAINT `fk_tarjeta_pago1`
    FOREIGN KEY (`pago_id`)
    REFERENCES `spotify`.`pago` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Table structure for table `usuario_playlist`
CREATE TABLE IF NOT EXISTS `spotify`.`usuario_playlist` (
  `usuario_id` INT(11) NOT NULL,
  `playlist_id` INT(11) NOT NULL,
  PRIMARY KEY (`usuario_id`, `playlist_id`),
  INDEX `fk_usuario_playlist_playlist_idx` (`playlist_id`),
  INDEX `fk_usuario_playlist_usuario_idx` (`usuario_id`),
  CONSTRAINT `fk_usuario_playlist_playlist`
    FOREIGN KEY (`playlist_id`)
    REFERENCES `spotify`.`playlist` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_usuario_playlist_usuario`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `spotify`.`usuario` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Table structure for table `usuario_sigue_artista`
CREATE TABLE IF NOT EXISTS `spotify`.`usuario_sigue_artista` (
  `usuario_id` INT(11) NOT NULL,
  `artista_id` INT(11) NOT NULL,
  INDEX `fk_usuario_sigue_artista_usuario1_idx` (`usuario_id`),
  INDEX `fk_usuario_sigue_artista_artista1_idx` (`artista_id`),
  CONSTRAINT `fk_usuario_sigue_artista_usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `spotify`.`usuario` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_usuario_sigue_artista_artista1`
    FOREIGN KEY (`artista_id`)
    REFERENCES `spotify`.`artista` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Table structure for table `cancion_favorita`
CREATE TABLE IF NOT EXISTS `spotify`.`cancion_favorita` (
  `usuario_id` INT(11) NOT NULL,
  `cancion_id` INT(11) NOT NULL,
  INDEX `fk_cancion_favorita_usuario1_idx` (`usuario_id`),
  INDEX `fk_cancion_favorita_cancion1_idx` (`cancion_id`),
  CONSTRAINT `fk_cancion_favorita_usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `spotify`.`usuario` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_cancion_favorita_cancion1`
    FOREIGN KEY (`cancion_id`)
    REFERENCES `spotify`.`cancion` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Table structure for table `album_favorito`
CREATE TABLE IF NOT EXISTS `spotify`.`album_favorito` (
  `usuario_id` INT(11) NOT NULL,
  `album_id` INT(11) NOT NULL,
  INDEX `fk_album_favorito_usuario1_idx` (`usuario_id`),
  INDEX `fk_album_favorito_album1_idx` (`album_id`),
  CONSTRAINT `fk_album_favorito_usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `spotify`.`usuario` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_album_favorito_album1`
    FOREIGN KEY (`album_id`)
    REFERENCES `spotify`.`album` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Insertar datos en la tabla `artista`
INSERT INTO `artista` (`nombre`, `imagen`)
VALUES
  ('Artista A', NULL),
  ('Artista B', NULL),
  ('Artista C', NULL);

-- Insertar datos en la tabla `album`
INSERT INTO `album` (`titulo`, `publicacion`, `imagen`, `artista_id`)
VALUES
  ('Álbum 1', 2020, NULL, 1),
  ('Álbum 2', 2018, NULL, 2),
  ('Álbum 3', 2022, NULL, 3);

-- Insertar datos en la tabla `usuario`
INSERT INTO `usuario` (`email`, `contrasena`, `nombre`, `nacimiento`, `sexo`, `pais`, `cp`, `plan`)
VALUES
  ('usuario1@example.com', 'contraseña1', 'Usuario 1', '1990-05-15', 'Masculino', 'País 1', 12345, 'premium'),
  ('usuario2@example.com', 'contraseña2', 'Usuario 2', '1985-08-20', 'Femenino', 'País 2', 54321, 'gratuito'),
  ('usuario3@example.com', 'contraseña3', 'Usuario 3', '2000-02-10', 'Otro', 'País 3', NULL, 'premium');

-- Insertar datos en la tabla `cancion`
INSERT INTO `cancion` (`titulo`, `duracion`, `reproducciones`, `album_id`, `artista_id`, `usuario_id`)
VALUES
  ('Canción 1', 240, 100, 1, 1, 1),
  ('Canción 2', 180, 50, 2, 2, 2),
  ('Canción 3', 200, 80, 3, 3, 3);

-- Insertar datos en la tabla `playlist`
INSERT INTO `playlist` (`titulo`, `num_canciones`, `creacion`, `estado_id`, `fecha_eliminacion`, `usuario_id_creador`)
VALUES
  ('Playlist 1', 5, '2023-01-01', 'activa', NULL, 1),
  ('Playlist 2', 3, '2023-02-15', 'activa', NULL, 2),
  ('Playlist 3', 10, '2023-03-20', 'eliminada', '2023-04-01', 3);

-- Insertar datos en la tabla `cancion_playlist`
INSERT INTO `cancion_playlist` (`cancion_id`, `playlist_id`, `added`, `usuario_id`)
VALUES
  (1, 1, '2023-01-02 08:00:00', 1),
  (2, 1, '2023-01-02 09:30:00', 1),
  (3, 2, '2023-02-16 10:00:00', 2);

-- Insertar datos en la tabla `suscripcion`
INSERT INTO `suscripcion` (`inicio`, `renovacion`, `pago`, `usuario_id`)
VALUES
  ('2023-01-01', '2023-02-01', 'tarjeta', 1),
  ('2023-02-15', '2023-03-15', 'Paypal', 2),
  ('2023-03-20', '2023-04-20', 'tarjeta', 3);

-- Insertar datos en la tabla `pago`
INSERT INTO `pago` (`fecha`, `total`, `suscripcion_id`)
VALUES
  ('2023-01-01', 10.50, 1),
  ('2023-02-15', 0.00, 2),
  ('2023-03-20', 5.00, 3);

-- Insertar datos en la tabla `paypal`
INSERT INTO `paypal` (`pago_id`, `usuario`)
VALUES
  (2, 'Usuario 2'),
  (3, 'Usuario 3');

-- Insertar datos en la tabla `reproduccion`
INSERT INTO `reproduccion` (`fecha`, `ubicacion`, `cancion_id`)
VALUES
  ('2023-01-05 10:00:00', 'Dispositivo A', 1),
  ('2023-02-20 15:30:00', 'Dispositivo B', 2),
  ('2023-03-25 20:45:00', 'Dispositivo C', 3);

-- Insertar datos en la tabla `tarjeta`
INSERT INTO `tarjeta` (`numero`, `caducidad`, `cvv`, `pago_id`)
VALUES
  ('1234567890123456', '2024-01-01', 123, 1),
  ('9876543210987654', '2025-02-01', 456, 3);

-- Insertar datos en la tabla `usuario_playlist`
INSERT INTO `usuario_playlist` (`usuario_id`, `playlist_id`)
VALUES
  (1, 1),
  (2, 1),
  (3, 3);

-- Insertar datos en la tabla `usuario_sigue_artista`
INSERT INTO `usuario_sigue_artista` (`usuario_id`, `artista_id`)
VALUES
  (1, 1),
  (2, 2),
  (3, 3);

-- Insertar datos en la tabla `cancion_favorita`
INSERT INTO `cancion_favorita` (`usuario_id`, `cancion_id`)
VALUES
  (1, 1),
  (2, 2),
  (3, 3);

-- Insertar datos en la tabla `album_favorito`
INSERT INTO `album_favorito` (`usuario_id`, `album_id`)
VALUES
  (1, 1),
  (2, 2),
  (3, 3);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
