USE Ventas_Tech_DB

-- Consulta 1 — Resumen ejecutivo mensual

SELECT MONTH (fecha_venta) AS mes
, SUM (cantidad * precio_unitario) AS total_facturado
, COUNT (cantidad) AS cantidad_pedidos
, AVG (cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY MONTH (fecha_venta)
;

--Consulta 2 — Ranking de productos Top 5 

SELECT TOP 5 id_producto,
SUM (cantidad) AS unidades_vendidas,
SUM (cantidad * precio_unitario) AS total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC
;

--Consulta 3 — Clientes recurrentes 

SELECT (id_cliente),
COUNT (cantidad) AS cantidad_pedidos,
SUM (cantidad*precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1
;

--Consulta 4 — Productos por encima/por debajo del promedio

WITH totales_producto AS (
    SELECT id_producto,
           SUM(cantidad * precio_unitario) AS total_facturado
    FROM ventas
    GROUP BY id_producto
)
SELECT id_producto,
       total_facturado,
       CASE WHEN total_facturado > (SELECT AVG(total_facturado) FROM totales_producto)
            THEN 'Por encima'
            ELSE 'Por debajo'
       END AS comparacion_promedio
FROM totales_producto
;

-- HALLAZGOS
-- El producto 1 concentra el 55,9% de la facturación (3600 de 6444).
-- Clientes de bajo ticket: Los clientes 2 y 4 tiene los ticket más bajos
-- El producto 2 fue el que más unidades vendió, y el producto 4 fue el que menos facturo estando por debajo del promedio. 

