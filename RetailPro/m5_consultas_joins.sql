-- ══════════════════════════════════════════
-- RetailPro — Módulo 5: Consultas con JOINs
-- Cruzando tablas para enriquecer el análisis
-- Autor: GASTON RIVAROLA
-- Base: Ventas_Tech_DB
-- ══════════════════════════════════════════

USE Ventas_Tech_DB;

-- ── Consulta 1: Vista base del proyecto (INNER JOIN) ──────────────────
-- Propósito: obtener en una sola fila la venta con el cliente, su ciudad,
-- el producto y su categoría. Es la fuente de datos principal para Power BI
-- (la ciudad sirve para filtrar y la categoría para agrupar).

SELECT v.fecha_venta,
       c.id_cliente,
       c.nombre                          AS cliente,
       c.ciudad,
       p.nombre_producto,
       cat.nombre_categoria,
       v.cantidad,
       v.precio_unitario,
       v.cantidad * v.precio_unitario    AS total
FROM ventas v
INNER JOIN clientes   c   ON v.id_cliente  = c.id_cliente
INNER JOIN productos  p   ON v.id_producto = p.id_producto
INNER JOIN categorias cat ON p.id_categoria = cat.id_categoria
ORDER BY v.fecha_venta;
-- Hallazgo: se obtienen 10 filas, una por venta, todas con cliente, producto y
-- categoría asociados: no hay ventas huérfanas. La vista está lista para Power BI.

-- ── Consulta 2: Clientes sin ventas (LEFT JOIN) ───────────────────────
-- Propósito: detectar clientes registrados que nunca compraron,
-- para que CRM los contacte.

SELECT c.nombre,
       c.email,
       c.fecha_registro
FROM clientes c
LEFT JOIN ventas v ON c.id_cliente = v.id_cliente
WHERE v.id_ventas IS NULL;
-- Hallazgo: la consulta devuelve 0 clientes; los 5 clientes registrados tienen
-- al menos una compra. CRM no tiene clientes inactivos que reactivar por ahora.

-- ── Consulta 3: Productos sin ventas (LEFT JOIN) ──────────────────────
-- Propósito: identificar productos del catálogo sin movimiento,
-- para que el área de producto decida qué hacer con ellos.

SELECT p.nombre_producto,
       cat.nombre_categoria,
       p.precio
FROM productos p
INNER JOIN categorias cat ON p.id_categoria = cat.id_categoria
LEFT JOIN ventas v        ON p.id_producto  = v.id_producto
WHERE v.id_ventas IS NULL;
-- Hallazgo: la consulta devuelve 0 productos; los 6 artículos del catálogo se
-- vendieron al menos una vez. Producto no tiene artículos sin rotación que revisar.

-- ── Consulta 4: Consolidado por período (UNION ALL) ───────────────────
-- Propósito: comparar el total vendido en dos períodos. La columna "periodo"
-- no existe en las tablas: se crea como valor fijo dentro de cada SELECT.
-- Se usa UNION ALL para que cada venta se cuente una sola vez, aunque coincida
-- con otra en todos sus valores.

SELECT periodo, SUM(total) AS total_periodo
FROM (
    SELECT v.fecha_venta,
           v.cantidad * v.precio_unitario AS total,
           'Periodo 1 (hasta 10/03/2024)' AS periodo
    FROM ventas v
    WHERE v.fecha_venta <= '2024-03-10'
    UNION ALL
    SELECT v.fecha_venta,
           v.cantidad * v.precio_unitario AS total,
           'Periodo 2 (desde 11/03/2024)' AS periodo
    FROM ventas v
    WHERE v.fecha_venta >= '2024-03-11'
) AS consolidado
GROUP BY periodo;
-- Hallazgo: el Periodo 1 vendió 3620 y el Periodo 2 vendió 2824; el primero
-- facturó más, impulsado por la venta de 2 Laptops por 2400.