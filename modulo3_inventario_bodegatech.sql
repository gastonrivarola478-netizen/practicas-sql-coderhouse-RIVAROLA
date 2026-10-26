-- ══════════════════════════════════════════
-- BodegaTech — Script de Inventario
-- Autor: Gaston Rivarola
-- Fecha: 26/10/2026
-- ══════════════════════════════════════════

-- ── SECCIÓN DDL ──────────────────────────

DROP TABLE IF EXISTS inventario;

CREATE TABLE inventario(
id_producto INT PRIMARY KEY,  -- Número entero que identifica de forma única a cada producto (clave primaria)
nombre_producto varchar (100),  -- Texto variable: el nombre tiene un largo razonable, hasta 100 caracteres
categoria varchar (50),
precio_unitario DECIMAL (10,2), -- DECIMAL guarda centavos exactos, FLOAT guarda aproximaciones y no sirve para dinero.
stock_actual INT,
stock_minimo INT,
fecha_ingreso DATE,  -- Solo importa el día de ingreso, no la hora, por eso DATE y no DATETIME
activo TINYINT  -- Número chico para marcar estado: 1 = disponible, 0 = descontinuado
);

-- ── SECCIÓN DML ──────────────────────────

-- INSERT INTO: carga de los 10 productos iniciales

INSERT INTO inventario (id_producto, nombre_producto, categoria, precio_unitario, stock_actual, stock_minimo, fecha_ingreso, activo)
VALUES (1,'Laptop Pro 15','Computación',1200.00,15,3,'2024-01-10',1),
(2,'Mouse Inalámbrico','Accesorios',28.00,80,10,'2024-01-10',1),
(3,'Monitor 4K 27"','Computación',450.00,12,2,'2024-01-15',1),
(4,'Teclado Mecánico','Accesorios',95.00,40,5,'2024-01-15',1),
(5,'Laptop Basic 14','Computación',650.00,20,3,'2024-02-01',1),
(6,'Auriculares BT Pro','Audio',120.00,35,5,'2024-02-01',1),
(7,'Hub USB-C 7 puertos','Accesorios',45.00,60,10,'2024-02-10',1),
(8,'Webcam HD 1080p','Accesorios',85.00,25,5,'2024-02-10',1),
(9,'SSD Externo 1TB','Almacenamiento',130.00,18,3,'2024-03-01',1),
(10,'Parlante Bluetooth','Audio',60.00,45,8,'2024-03-01',1);

-- UPDATE ventas del día: descuenta las unidades vendidas de Laptop, Mouse y Auriculares

UPDATE inventario
SET stock_actual = stock_actual - 3
WHERE id_producto =1;

UPDATE inventario
SET stock_actual = stock_actual - 12
WHERE id_producto =2;

UPDATE inventario
SET stock_actual = stock_actual - 5
WHERE id_producto =6;

-- UPDATE producto descontinuado: marca la Webcam como inactiva (activo = 0)

UPDATE inventario
SET activo = 0
WHERE id_producto =8;

-- SELECT de validación: muestra la tabla completa para confirmar la carga

SELECT * FROM inventario;
