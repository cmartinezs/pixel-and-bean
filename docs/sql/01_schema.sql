-- ============================================
SHOW TABLES;
-- ============================================
-- Resumen de Tablas Creadas
-- ============================================

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
    INDEX idx_producto (producto_id)
    INDEX idx_venta (venta_id),

    FOREIGN KEY (producto_id) REFERENCES producto(id),
    FOREIGN KEY (venta_id) REFERENCES venta(id) ON DELETE CASCADE,

    subtotal DECIMAL(10,2) NOT NULL CHECK (subtotal >= 0),
    precio_unitario DECIMAL(10,2) NOT NULL CHECK (precio_unitario > 0),
    cantidad INT NOT NULL CHECK (cantidad > 0),
    producto_id INT NOT NULL,
    venta_id INT NOT NULL,
    id INT PRIMARY KEY AUTO_INCREMENT,
CREATE TABLE venta_detalle (
-- ============================================
-- Tabla: venta_detalle
-- ============================================

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
    INDEX idx_estado (estado)
    INDEX idx_usuario (usuario_id),
    INDEX idx_fecha_hora (fecha_hora),

    FOREIGN KEY (usuario_id) REFERENCES usuario(id),

    observaciones TEXT,
    estado ENUM('ACTIVA', 'ANULADA') NOT NULL DEFAULT 'ACTIVA',
    total DECIMAL(10,2) NOT NULL CHECK (total >= 0),
    usuario_id INT NOT NULL,
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id INT PRIMARY KEY AUTO_INCREMENT,
CREATE TABLE venta (
-- ============================================
-- Tabla: venta
-- ============================================

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
    UNIQUE KEY uk_nombre (nombre) -- Nombre único

    INDEX idx_activo (activo),
    INDEX idx_categoria (categoria),
    INDEX idx_nombre (nombre),

    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    precio DECIMAL(10,2) NOT NULL CHECK (precio > 0),
    descripcion TEXT,
    tipo VARCHAR(50), -- Específico por categoría: "Espresso", "Brownie", "15 minutos"
    categoria ENUM('BEBIDA', 'SNACK', 'TIEMPO_ARCADE') NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    id INT PRIMARY KEY AUTO_INCREMENT,
CREATE TABLE producto (
-- ============================================
-- Tabla: producto
-- ============================================

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
    INDEX idx_activo (activo)
    INDEX idx_rol (rol),
    INDEX idx_username (username),

    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    rol ENUM('ADMIN', 'OPERADOR') NOT NULL DEFAULT 'OPERADOR',
    nombre_completo VARCHAR(100),
    password VARCHAR(255) NOT NULL, -- 255 para hash (SHA-256 = 64 chars, bcrypt = 60)
    username VARCHAR(50) NOT NULL UNIQUE,
    id INT PRIMARY KEY AUTO_INCREMENT,
CREATE TABLE usuario (
-- ============================================
-- Tabla: usuario
-- ============================================

SET FOREIGN_KEY_CHECKS = 1;
DROP TABLE IF EXISTS usuario;
DROP TABLE IF EXISTS producto;
DROP TABLE IF EXISTS venta;
DROP TABLE IF EXISTS venta_detalle;
SET FOREIGN_KEY_CHECKS = 0;
-- Limpiar tablas existentes (cuidado en producción)

USE pixelandbean;

-- ============================================
-- Base de Datos: pixelandbean
-- Proyecto: Pixel & Bean
-- Script de Creación de Esquema

