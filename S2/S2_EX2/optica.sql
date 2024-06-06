DROP TABLE IF EXISTS `ventas`;
DROP TABLE IF EXISTS `clientes`;
DROP TABLE IF EXISTS `gafas`;
DROP TABLE IF EXISTS `marca`;
DROP TABLE IF EXISTS `proveedor`;
DROP TABLE IF EXISTS `staff`;

CREATE TABLE IF NOT EXISTS `proveedor` (
    `proveedor_id` int NOT NULL AUTO_INCREMENT,
    `proveedor_nombre` varchar(50) NOT NULL,
    `proveedor_calle` varchar(200) NOT NULL,
    `proveedor_numero` varchar(50) NOT NULL,
    `proveedor_piso` varchar(50) NULL,
    `proveedor_puerta` varchar(50) NULL,
    `proveedor_ciudad` varchar(50) NOT NULL,
    `proveedor_zip` varchar(20) NOT NULL,
    `proveedor_pais` varchar(50) NOT NULL,
    `proveedor_telefono` varchar(20) NOT NULL,
    `proveedor_fax` varchar(20) NULL,
    `proveedor_nif` varchar(20) NOT NULL,
    PRIMARY KEY (`proveedor_id`)
);

CREATE TABLE IF NOT EXISTS `marca` (
    `marca_id` int NOT NULL AUTO_INCREMENT,
    `proveedor_id` int NOT NULL,
    `marca_nombre` varchar(50) NOT NULL,
    PRIMARY KEY (`marca_id`),
    FOREIGN KEY (`proveedor_id`) REFERENCES `proveedor` (`proveedor_id`)
);

CREATE TABLE IF NOT EXISTS `staff` (
    `staff_id` int NOT NULL AUTO_INCREMENT,
    `staff_nombre` varchar(50) NOT NULL,
    `staff_puesto` varchar(50) NOT NULL,
    PRIMARY KEY (`staff_id`)
);

CREATE TABLE IF NOT EXISTS `clientes` (
    `cliente_id` int NOT NULL AUTO_INCREMENT,
    `cliente_nombre` varchar(50) NOT NULL,
    `cliente_zip` varchar(20) NOT NULL,
    `cliente_telefono` varchar(20) NOT NULL,
    `cliente_correo` varchar(100) NOT NULL,
    `cliente_registro` datetime NOT NULL,
    `cliente_referido` int NULL,
    PRIMARY KEY (`cliente_id`),
    FOREIGN KEY (`cliente_referido`) REFERENCES `clientes` (`cliente_id`)
);

CREATE TABLE IF NOT EXISTS `gafas` (
    `gafas_id` int NOT NULL AUTO_INCREMENT,
    `marca_id` int NOT NULL,
    `gafas_grad_izq` varchar(50) NOT NULL,
    `gafas_grad_der` varchar(50) NOT NULL,
    `gafas_montura` varchar(50) NOT NULL,
    `gafas_color_montura` varchar(50) NOT NULL,
    `gafas_color_vid_izq` varchar(50) NOT NULL,
    `gafas_color_vid_der` varchar(50) NOT NULL,
    `gafas_precio` decimal(10,2) NOT NULL,
    PRIMARY KEY (`gafas_id`),
    FOREIGN KEY (`marca_id`) REFERENCES `marca` (`marca_id`)
);

CREATE TABLE IF NOT EXISTS `ventas` (
    `ventas_id` int NOT NULL AUTO_INCREMENT,
    `cliente_id` int NOT NULL,
    `ventas_fecha` datetime NOT NULL,
    `staff_id` int NOT NULL,
    PRIMARY KEY (`ventas_id`),
    FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`cliente_id`),
    FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`)
);

INSERT INTO `proveedor` (`proveedor_nombre`, `proveedor_calle`, `proveedor_numero`, `proveedor_piso`, `proveedor_puerta`, `proveedor_ciudad`, `proveedor_zip`, `proveedor_pais`, `proveedor_telefono`, `proveedor_fax`, `proveedor_nif`) VALUES
('Proveedor A', 'Calle Principal', '123', '1', 'A', 'Ciudad A', '12345', 'Pais A', '123456789', '123456789', 'NIF123A'),
('Proveedor B', 'Avenida Secundaria', '456', NULL, NULL, 'Ciudad B', '67890', 'Pais B', '987654321', NULL, 'NIF456B');

INSERT INTO `marca` (`proveedor_id`, `marca_nombre`) VALUES
(1, 'Marca A'),
(2, 'Marca B');

INSERT INTO `staff` (`staff_nombre`, `staff_puesto`) VALUES
('Empleado 1', 'Vendedor'),
('Empleado 2', 'Gerente');

INSERT INTO `clientes` (`cliente_nombre`, `cliente_zip`, `cliente_telefono`, `cliente_correo`, `cliente_registro`, `cliente_referido`) VALUES
('Cliente 1', '12345', '123456789', 'cliente1@example.com', '2023-01-01 10:00:00', NULL),
('Cliente 2', '67890', '987654321', 'cliente2@example.com', '2023-02-01 11:00:00', 1);

INSERT INTO `gafas` (`marca_id`, `gafas_grad_izq`, `gafas_grad_der`, `gafas_montura`, `gafas_color_montura`, `gafas_color_vid_izq`, `gafas_color_vid_der`, `gafas_precio`) VALUES
(1, '1.0', '1.5', 'Metalica', 'Negro', 'Transparente', 'Transparente', 99.99),
(2, '2.0', '2.5', 'Plastica', 'Rojo', 'Azul', 'Verde', 149.99);

INSERT INTO `ventas` (`cliente_id`, `ventas_fecha`, `staff_id`) VALUES
(1, '2023-03-01 12:00:00', 1),
(2, '2023-03-02 13:00:00', 2);