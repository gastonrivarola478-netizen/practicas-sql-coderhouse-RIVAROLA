CREATE TABLE clientes (
id_cliente INT, -- Número entero que identifica a cada cliente
nombre varchar (100), -- cadena de texto variable hasta 100 caracteres
perfil_bio varchar (MAX), -- cadena de texto sin límites, para notas
fecha_registro date -- registro de fecha, no importa la hora del registro
);
CREATE TABLE productos (
id_producto INT, -- Número entero que identifica cada producto
descripcion varchar (255), -- cadena de texto variable hasta 255 caracteres
precio DECIMAL (10,2),-- Importe exacto con centavos; no FLOAT porque redondea
esta_activo BIT -- para verificar estados con números 1 (activo) y 0 (no activo)
);
