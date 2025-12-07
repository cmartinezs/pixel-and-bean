-- ============================================
-- Script de Corrección: Agregar producto_nombre a venta_detalle
-- Proyecto: Pixel & Bean
-- Fecha: 2025-12-07
-- Propósito: Mantener historial del nombre del producto en ventas
-- ============================================

USE pixelandbean;

-- ============================================
-- Corrección: Agregar columna producto_nombre
-- ============================================

-- Verificar si la columna ya existe antes de agregarla
SET @col_exists = (
    SELECT COUNT(*)
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA = 'pixelandbean'
    AND TABLE_NAME = 'venta_detalle'
    AND COLUMN_NAME = 'producto_nombre'
);

-- Agregar columna si no existe
SET @sql = IF(@col_exists = 0,
    'ALTER TABLE venta_detalle ADD COLUMN producto_nombre VARCHAR(100) AFTER producto_id COMMENT ''Nombre del producto en el momento de la venta (historial)''',
    'SELECT ''La columna producto_nombre ya existe'' AS mensaje'
);

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- ============================================
-- Llenar datos existentes
-- ============================================

-- Actualizar registros existentes con el nombre actual del producto
UPDATE venta_detalle vd
INNER JOIN producto p ON vd.producto_id = p.id
SET vd.producto_nombre = p.nombre
WHERE vd.producto_nombre IS NULL OR vd.producto_nombre = '';

-- ============================================
-- Verificación
-- ============================================

SELECT
    'venta_detalle' as tabla,
    COUNT(*) as total_registros,
    SUM(CASE WHEN producto_nombre IS NOT NULL AND producto_nombre != '' THEN 1 ELSE 0 END) as con_nombre,
    SUM(CASE WHEN producto_nombre IS NULL OR producto_nombre = '' THEN 1 ELSE 0 END) as sin_nombre
FROM venta_detalle;

-- Mostrar estructura actualizada
DESCRIBE venta_detalle;

-- ============================================
-- Resultado Esperado:
-- - Columna producto_nombre agregada
-- - Todos los registros existentes actualizados
-- ============================================

