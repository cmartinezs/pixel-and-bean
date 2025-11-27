-- =========================================
-- Script: Actualizar contraseñas a hash SHA-256
-- Proyecto: Pixel & Bean
-- Fecha: 27 de noviembre de 2025
-- =========================================

USE pixelandbean;

-- Actualizar contraseñas de usuarios existentes a formato hash SHA-256
-- Este script debe ejecutarse después de implementar PasswordHasher

-- admin123 → SHA-256: 240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9
UPDATE usuario
SET password = '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9'
WHERE username = 'admin';

-- op123 → SHA-256: a80e3c87dcb08e52e6c7d3bc40d3f22ae3dc0a8f5e88d2e3c832daeba064f6b4
UPDATE usuario
SET password = 'a80e3c87dcb08e52e6c7d3bc40d3f22ae3dc0a8f5e88d2e3c832daeba064f6b4'
WHERE username = 'operador';

-- Verificar actualización
SELECT
    id,
    username,
    LEFT(password, 30) as password_hash,
    rol,
    activo
FROM usuario
ORDER BY id;

-- Nota: Las contraseñas originales eran:
-- admin: admin123
-- operador: op123
--
-- ⚠️ IMPORTANTE: Después de ejecutar este script, debes usar las contraseñas
-- originales para iniciar sesión, ya que el sistema aplicará el hash automáticamente
-- durante la autenticación.

