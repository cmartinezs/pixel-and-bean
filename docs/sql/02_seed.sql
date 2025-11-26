-- ============================================
-- Script de Datos Iniciales (Seed)
-- Proyecto: Pixel & Bean
-- Base de Datos: pixelandbean
-- ============================================

USE pixelandbean;

-- ============================================
-- Tabla: usuario
-- ============================================
-- NOTA: Contraseñas en texto plano para desarrollo
-- En producción, usar hash (SHA-256 o bcrypt)

INSERT INTO usuario (username, password, nombre_completo, rol, activo) VALUES
('admin', 'admin123', 'Administrador del Sistema', 'ADMIN', TRUE),
('operador', 'op123', 'Operador de Caja', 'OPERADOR', TRUE),
('juan.perez', 'juan123', 'Juan Pérez', 'OPERADOR', TRUE),
('maria.lopez', 'maria123', 'María López', 'ADMIN', TRUE),
('carlos.gomez', 'carlos123', 'Carlos Gómez', 'OPERADOR', FALSE); -- Usuario inactivo

-- ============================================
-- Tabla: producto - BEBIDAS
-- ============================================
INSERT INTO producto (nombre, categoria, tipo, descripcion, precio, activo) VALUES
('Espresso', 'BEBIDA', 'Café', 'Shot de café expreso italiano', 1500.00, TRUE),
('Americano', 'BEBIDA', 'Café', 'Café americano clásico', 1800.00, TRUE),
('Cappuccino', 'BEBIDA', 'Café', 'Café con espuma de leche', 2200.00, TRUE),
('Latte', 'BEBIDA', 'Café', 'Café con leche vaporizada', 2500.00, TRUE),
('Mocha', 'BEBIDA', 'Café', 'Café con chocolate', 2800.00, TRUE),
('Té Verde', 'BEBIDA', 'Té', 'Té verde japonés', 1200.00, TRUE),
('Té Negro', 'BEBIDA', 'Té', 'Té negro english breakfast', 1200.00, TRUE),
('Jugo Natural', 'BEBIDA', 'Jugo', 'Jugo de frutas natural', 2000.00, TRUE),
('Limonada', 'BEBIDA', 'Jugo', 'Limonada artesanal', 1800.00, TRUE);

-- ============================================
-- Tabla: producto - SNACKS
-- ============================================
INSERT INTO producto (nombre, categoria, tipo, descripcion, precio, activo) VALUES
('Brownie', 'SNACK', 'Dulce', 'Brownie de chocolate casero', 1500.00, TRUE),
('Cheesecake', 'SNACK', 'Dulce', 'Tarta de queso estilo NY', 2500.00, TRUE),
('Galletas Chips', 'SNACK', 'Dulce', 'Galletas con chips de chocolate (3 unidades)', 1200.00, TRUE),
('Muffin', 'SNACK', 'Dulce', 'Muffin de arándanos', 1400.00, TRUE),
('Sandwich Mixto', 'SNACK', 'Salado', 'Sandwich de jamón y queso', 2500.00, TRUE),
('Sandwich Vegetariano', 'SNACK', 'Salado', 'Sandwich de verduras asadas', 2800.00, TRUE),
('Croissant', 'SNACK', 'Salado', 'Croissant de mantequilla', 1800.00, TRUE),
('Nachos', 'SNACK', 'Salado', 'Nachos con queso cheddar', 2200.00, TRUE);

-- ============================================
-- Tabla: producto - TIEMPO ARCADE
-- ============================================
INSERT INTO producto (nombre, categoria, tipo, descripcion, precio, activo) VALUES
('Arcade 15 min', 'TIEMPO_ARCADE', '15 minutos', 'Arriendo cabina arcade por 15 minutos', 1000.00, TRUE),
('Arcade 30 min', 'TIEMPO_ARCADE', '30 minutos', 'Arriendo cabina arcade por 30 minutos', 1800.00, TRUE),
('Arcade 60 min', 'TIEMPO_ARCADE', '60 minutos', 'Arriendo cabina arcade por 1 hora', 3000.00, TRUE),
('Pase Diario', 'TIEMPO_ARCADE', 'Día completo', 'Pase ilimitado de arcade por el día', 8000.00, TRUE),
('Torneo Entrada', 'TIEMPO_ARCADE', 'Torneo', 'Inscripción a torneo semanal', 5000.00, TRUE);

-- ============================================
-- Tabla: venta - DATOS DE PRUEBA
-- ============================================
-- Venta 1: Operador vendió un café y un brownie (hoy)
INSERT INTO venta (fecha_hora, usuario_id, total, estado, observaciones) VALUES
(NOW(), 2, 3000.00, 'ACTIVA', 'Primera venta del día');

INSERT INTO venta_detalle (venta_id, producto_id, cantidad, precio_unitario, subtotal) VALUES
(1, 1, 1, 1500.00, 1500.00), -- 1 Espresso
(1, 10, 1, 1500.00, 1500.00); -- 1 Brownie

-- Venta 2: Admin vendió tiempo de arcade y bebida (hoy)
INSERT INTO venta (fecha_hora, usuario_id, total, estado) VALUES
(NOW() - INTERVAL 2 HOUR, 1, 4800.00, 'ACTIVA');

INSERT INTO venta_detalle (venta_id, producto_id, cantidad, precio_unitario, subtotal) VALUES
(2, 20, 1, 3000.00, 3000.00), -- 1 hora arcade
(2, 2, 1, 1800.00, 1800.00);  -- 1 Americano

-- Venta 3: Venta anulada (ayer)
INSERT INTO venta (fecha_hora, usuario_id, total, estado, observaciones) VALUES
(NOW() - INTERVAL 1 DAY, 2, 2500.00, 'ANULADA', 'Cliente canceló orden');

INSERT INTO venta_detalle (venta_id, producto_id, cantidad, precio_unitario, subtotal) VALUES
(3, 4, 1, 2500.00, 2500.00); -- 1 Latte

-- Venta 4: Venta grande con múltiples productos (ayer)
INSERT INTO venta (fecha_hora, usuario_id, total, estado) VALUES
(NOW() - INTERVAL 1 DAY - INTERVAL 5 HOUR, 3, 12600.00, 'ACTIVA');

INSERT INTO venta_detalle (venta_id, producto_id, cantidad, precio_unitario, subtotal) VALUES
(4, 22, 1, 8000.00, 8000.00),  -- Pase diario
(4, 5, 1, 2800.00, 2800.00),   -- Mocha
(4, 17, 1, 1800.00, 1800.00);  -- Croissant

-- Venta 5: Venta de la semana pasada
INSERT INTO venta (fecha_hora, usuario_id, total, estado) VALUES
(NOW() - INTERVAL 7 DAY, 2, 7200.00, 'ACTIVA');

INSERT INTO venta_detalle (venta_id, producto_id, cantidad, precio_unitario, subtotal) VALUES
(5, 1, 3, 1500.00, 4500.00),  -- 3 Espresso
(5, 10, 2, 1500.00, 3000.00), -- 2 Brownie
(5, 13, 1, 1200.00, 1200.00); -- Galletas

-- ============================================
-- Verificación de Datos Cargados
-- ============================================
SELECT 'Usuarios cargados:' AS Info, COUNT(*) AS Total FROM usuario;
SELECT 'Productos cargados:' AS Info, COUNT(*) AS Total FROM producto;
SELECT 'Ventas cargadas:' AS Info, COUNT(*) AS Total FROM venta;
SELECT 'Detalles de venta:' AS Info, COUNT(*) AS Total FROM venta_detalle;

-- Ver datos
SELECT * FROM usuario;
SELECT * FROM producto ORDER BY categoria, nombre;
SELECT v.id, v.fecha_hora, u.username, v.total, v.estado
FROM venta v
JOIN usuario u ON v.usuario_id = u.id
ORDER BY v.fecha_hora DESC;

