# 🔧 Clase 4 (Parte 2) – Instalación y Configuración de Base de Datos

**Objetivo:**  
Instalar XAMPP, crear la base de datos del proyecto, definir el esquema de tablas, cargar datos iniciales y configurar la conexión JDBC desde Java.

⏱️ **Duración estimada:** 40 minutos

**Distribución del tiempo:**
- Instalación de XAMPP y verificación (5 min)
- Creación de base de datos y esquema (10 min)
- Scripts SQL de datos iniciales (10 min)
- Configuración de Java y prueba de conexión (15 min)

<!-- TOC -->
* [🔧 Clase 4 (Parte 2) – Instalación y Configuración de Base de Datos](#-clase-4-parte-2--instalación-y-configuración-de-base-de-datos)
  * [⏱️ Distribución del Tiempo](#-distribución-del-tiempo)
  * [🎯 Objetivos de Esta Parte](#-objetivos-de-esta-parte)
  * [📦 Paso 1: Instalación de XAMPP (5 min)](#-paso-1-instalación-de-xampp-5-min)
    * [¿Qué es XAMPP?](#qué-es-xampp)
    * [Descarga e Instalación](#descarga-e-instalación)
      * [Windows:](#windows)
      * [Linux:](#linux)
      * [macOS:](#macos)
    * [Iniciar Servicios](#iniciar-servicios)
      * [Windows:](#windows-1)
      * [Linux:](#linux-1)
      * [macOS:](#macos-1)
    * [Verificar Instalación](#verificar-instalación)
    * [Solución de Problemas Comunes](#solución-de-problemas-comunes)
      * [Puerto 3306 en uso:](#puerto-3306-en-uso)
      * [MySQL no inicia:](#mysql-no-inicia)
  * [🗃️ Paso 2: Creación de la Base de Datos (10 min)](#-paso-2-creación-de-la-base-de-datos-10-min)
    * [Acceder a phpMyAdmin](#acceder-a-phpmyadmin)
    * [Crear Base de Datos](#crear-base-de-datos)
    * [Crear Esquema de Tablas](#crear-esquema-de-tablas)
    * [Script SQL: 01_schema.sql](#script-sql-01_schemasql)
    * [Ejecutar el Script](#ejecutar-el-script)
    * [Verificar Tablas Creadas](#verificar-tablas-creadas)
  * [🌱 Paso 3: Datos Iniciales (Seed) (10 min)](#-paso-3-datos-iniciales-seed-10-min)
    * [Script SQL: 02_seed.sql](#script-sql-02_seedsql)
    * [Ejecutar Script de Seed](#ejecutar-script-de-seed)
    * [Verificar Datos Cargados](#verificar-datos-cargados)
  * [⚙️ Paso 4: Configuración de Java (15 min)](#-paso-4-configuración-de-java-15-min)
    * [4.1 Descargar MySQL Connector/J](#41-descargar-mysql-connectorj)
    * [4.2 Agregar al Proyecto](#42-agregar-al-proyecto)
      * [NetBeans:](#netbeans)
      * [IntelliJ IDEA:](#intellij-idea)
    * [4.3 Crear application.properties](#43-crear-applicationproperties)
    * [4.4 Crear DatabaseConnectionFactory](#44-crear-databaseconnectionfactory)
    * [4.5 Probar la Conexión](#45-probar-la-conexión)
    * [4.6 Ejecutar Test](#46-ejecutar-test)
  * [✅ Verificación Final](#-verificación-final)
  * [🐛 Troubleshooting](#-troubleshooting)
    * [Error: Access denied for user 'root'@'localhost'](#error-access-denied-for-user-rootlocalhost)
    * [Error: No suitable driver found](#error-no-suitable-driver-found)
    * [Error: Unknown database 'pixelandbean'](#error-unknown-database-pixelandbean)
    * [Error: Communications link failure](#error-communications-link-failure)
  * [📊 Diagrama de Arquitectura Final](#-diagrama-de-arquitectura-final)
  * [💡 Siguiente Paso](#-siguiente-paso)
<!-- TOC -->

---

## ⏱️ Distribución del Tiempo

| Actividad               | Duración   |
|-------------------------|------------|
| Instalación XAMPP       | 5 min      |
| Base de datos y esquema | 10 min     |
| Datos iniciales         | 10 min     |
| Configuración Java      | 15 min     |
| **Total**               | **40 min** |

---

## 🎯 Objetivos de Esta Parte

Al finalizar esta sección habrás:

1. ✅ Instalado y configurado XAMPP correctamente
2. ✅ Creado la base de datos `pixelandbean`
3. ✅ Definido todas las tablas del sistema
4. ✅ Cargado datos iniciales (usuarios, productos)
5. ✅ Agregado MySQL Connector/J al proyecto
6. ✅ Creado archivo de configuración `application.properties`
7. ✅ Implementado `DatabaseConnectionFactory`
8. ✅ Probado la conexión exitosamente desde Java

---

## 📦 Paso 1: Instalación de XAMPP (5 min)

### ¿Qué es XAMPP?

**XAMPP** es un paquete de software que incluye:
- **Apache** (servidor web)
- **MySQL/MariaDB** (base de datos)
- **PHP** (lenguaje de programación)
- **phpMyAdmin** (administrador web de MySQL)

Nos permite tener un servidor de base de datos MySQL funcionando en nuestra computadora de forma sencilla.

### Descarga e Instalación

#### Windows:

1. Ir a: https://www.apachefriends.org
2. Descargar **XAMPP for Windows** (versión 8.x)
3. Ejecutar el instalador
4. Ruta recomendada: `C:\xampp`
5. Componentes mínimos:
   - ✅ Apache
   - ✅ MySQL
   - ✅ phpMyAdmin
   - ⬜ Perl (opcional)
   - ⬜ FileZilla (opcional)

#### Linux:

```bash
# Ubuntu/Debian
wget https://www.apachefriends.org/xampp-files/8.2.12/xampp-linux-x64-8.2.12-0-installer.run
chmod +x xampp-linux-x64-8.2.12-0-installer.run
sudo ./xampp-linux-x64-8.2.12-0-installer.run

# Instalación en: /opt/lampp
```

#### macOS:

1. Descargar **XAMPP for OS X** desde la web oficial
2. Abrir el archivo .dmg
3. Arrastrar XAMPP a Applications
4. Instalación en: `/Applications/XAMPP`

### Iniciar Servicios

#### Windows:

1. Abrir **XAMPP Control Panel** (desde el menú inicio)
2. Iniciar módulo **Apache** (opcional para este proyecto)
3. Iniciar módulo **MySQL** ✅ **IMPORTANTE**

```
Module     Status
Apache     [Start] [Stop]
MySQL      [Start] [Stop]  ← Hacer clic en Start
```

#### Linux:

```bash
sudo /opt/lampp/lampp start

# Solo MySQL (si ya tienes Apache corriendo)
sudo /opt/lampp/lampp startmysql
```

#### macOS:

```bash
# Desde XAMPP Manager
# O desde terminal:
sudo /Applications/XAMPP/xamppfiles/xampp start
```

### Verificar Instalación

1. Abrir navegador
2. Ir a: http://localhost/phpmyadmin
3. Deberías ver la interfaz de phpMyAdmin

**✅ Si ves phpMyAdmin, MySQL está funcionando correctamente.**

### Solución de Problemas Comunes

#### Puerto 3306 en uso:

```bash
# Windows: Ver qué proceso usa el puerto
netstat -ano | findstr :3306

# Linux/macOS
lsof -i :3306

# Soluciones:
1. Cerrar otra instancia de MySQL
2. Cambiar puerto en XAMPP (my.ini/my.cnf)
```

#### MySQL no inicia:

```bash
# Ver logs de error
# Windows: C:\xampp\mysql\data\mysql_error.log
# Linux: /opt/lampp/logs/mysql_error.log
```

**Causa común:** MySQL se cerró incorrectamente la última vez.

**Solución:**
```bash
# Reparar base de datos (con XAMPP cerrado)
# Windows
cd C:\xampp\mysql\bin
mysql_upgrade --force

# Linux
cd /opt/lampp/bin
./mysql_upgrade --force
```

---

## 🗃️ Paso 2: Creación de la Base de Datos (10 min)

### Acceder a phpMyAdmin

1. Abrir navegador
2. Ir a: http://localhost/phpmyadmin
3. Usuario por defecto: `root`
4. Contraseña: (vacía, dejar en blanco)

### Crear Base de Datos

**Opción 1: Desde phpMyAdmin (recomendado para principiantes)**

1. Clic en **"Nueva"** en el panel izquierdo
2. Nombre de la base de datos: `pixelandbean`
3. Cotejamiento: `utf8mb4_unicode_ci` ✅ (soporte completo de Unicode)
4. Clic en **"Crear"**

**Opción 2: Desde SQL**

1. Ir a la pestaña **SQL** en phpMyAdmin
2. Ejecutar:
```sql
CREATE DATABASE pixelandbean 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;
```

### Crear Esquema de Tablas

Vamos a crear todas las tablas necesarias para el proyecto.

### Script SQL: 01_schema.sql

Crear archivo: `/docs/sql/01_schema.sql`

```sql
-- ============================================
-- Script de Creación de Esquema
-- Proyecto: Pixel & Bean
-- Base de Datos: pixelandbean
-- ============================================

USE pixelandbean;

-- Limpiar tablas existentes (cuidado en producción)
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS venta_detalle;
DROP TABLE IF EXISTS venta;
DROP TABLE IF EXISTS producto;
DROP TABLE IF EXISTS usuario;
SET FOREIGN_KEY_CHECKS = 1;

-- ============================================
-- Tabla: usuario
-- ============================================
CREATE TABLE usuario (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL, -- 255 para hash (SHA-256 = 64 chars, bcrypt = 60)
    nombre_completo VARCHAR(100),
    rol ENUM('ADMIN', 'OPERADOR') NOT NULL DEFAULT 'OPERADOR',
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    INDEX idx_username (username),
    INDEX idx_rol (rol),
    INDEX idx_activo (activo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- Tabla: producto
-- ============================================
CREATE TABLE producto (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    categoria ENUM('BEBIDA', 'SNACK', 'TIEMPO_ARCADE') NOT NULL,
    tipo VARCHAR(50), -- Específico por categoría: "Espresso", "Brownie", "15 minutos"
    descripcion TEXT,
    precio DECIMAL(10,2) NOT NULL CHECK (precio > 0),
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    INDEX idx_nombre (nombre),
    INDEX idx_categoria (categoria),
    INDEX idx_activo (activo),
    
    UNIQUE KEY uk_nombre (nombre) -- Nombre único
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- Tabla: venta
-- ============================================
CREATE TABLE venta (
    id INT PRIMARY KEY AUTO_INCREMENT,
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario_id INT NOT NULL,
    total DECIMAL(10,2) NOT NULL CHECK (total >= 0),
    estado ENUM('ACTIVA', 'ANULADA') NOT NULL DEFAULT 'ACTIVA',
    observaciones TEXT,
    
    FOREIGN KEY (usuario_id) REFERENCES usuario(id),
    
    INDEX idx_fecha_hora (fecha_hora),
    INDEX idx_usuario (usuario_id),
    INDEX idx_estado (estado)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- Tabla: venta_detalle
-- ============================================
CREATE TABLE venta_detalle (
    id INT PRIMARY KEY AUTO_INCREMENT,
    venta_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    precio_unitario DECIMAL(10,2) NOT NULL CHECK (precio_unitario > 0),
    subtotal DECIMAL(10,2) NOT NULL CHECK (subtotal >= 0),
    
    FOREIGN KEY (venta_id) REFERENCES venta(id) ON DELETE CASCADE,
    FOREIGN KEY (producto_id) REFERENCES producto(id),
    
    INDEX idx_venta (venta_id),
    INDEX idx_producto (producto_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- Resumen de Tablas Creadas
-- ============================================
SHOW TABLES;
```

### Ejecutar el Script

**Opción 1: Desde phpMyAdmin**

1. Seleccionar base de datos `pixelandbean` en panel izquierdo
2. Ir a pestaña **SQL**
3. Copiar y pegar el contenido completo de `01_schema.sql`
4. Clic en **Continuar**
5. Verificar mensaje: "4 filas afectadas" o similar

**Opción 2: Desde línea de comandos**

```bash
# Windows (desde directorio del proyecto)
cd C:\xampp\mysql\bin
mysql -u root < C:\ruta\completa\al\proyecto\docs\sql\01_schema.sql

# Linux/macOS
cd /opt/lampp/bin
./mysql -u root < /ruta/completa/al/proyecto/docs/sql/01_schema.sql
```

### Verificar Tablas Creadas

En phpMyAdmin:
1. Seleccionar base de datos `pixelandbean`
2. Ver panel izquierdo, deberías ver:
   - ✅ usuario
   - ✅ producto
   - ✅ venta
   - ✅ venta_detalle

3. Hacer clic en cada tabla y ver pestaña **Estructura** para verificar columnas

---

## 🌱 Paso 3: Datos Iniciales (Seed) (10 min)

Ahora vamos a cargar datos de prueba en las tablas.

### Script SQL: 02_seed.sql

Crear archivo: `/docs/sql/02_seed.sql`

```sql
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
(2, 3, 1, 1800.00, 1800.00);  -- 1 Americano

-- Venta 3: Venta anulada (ayer)
INSERT INTO venta (fecha_hora, usuario_id, total, estado, observaciones) VALUES
(NOW() - INTERVAL 1 DAY, 2, 2500.00, 'ANULADA', 'Cliente canceló orden');

INSERT INTO venta_detalle (venta_id, producto_id, cantidad, precio_unitario, subtotal) VALUES
(3, 4, 1, 2500.00, 2500.00); -- 1 Latte

-- Venta 4: Venta grande con múltiples productos (ayer)
INSERT INTO venta (fecha_hora, usuario_id, total, estado) VALUES
(NOW() - INTERVAL 1 DAY - INTERVAL 5 HOUR, 3, 12500.00, 'ACTIVA');

INSERT INTO venta_detalle (venta_id, producto_id, cantidad, precio_unitario, subtotal) VALUES
(4, 23, 1, 8000.00, 8000.00),  -- Pase diario
(4, 5, 1, 2800.00, 2800.00),   -- Mocha
(4, 17, 1, 1800.00, 1800.00);  -- Croissant

-- Venta 5: Venta de la semana pasada
INSERT INTO venta (fecha_hora, usuario_id, total, estado) VALUES
(NOW() - INTERVAL 7 DAY, 2, 5400.00, 'ACTIVA');

INSERT INTO venta_detalle (venta_id, producto_id, cantidad, precio_unitario, subtotal) VALUES
(5, 1, 3, 1500.00, 4500.00),  -- 3 Espresso
(5, 10, 1, 1500.00, 1500.00), -- 1 Brownie
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
```

### Ejecutar Script de Seed

**Desde phpMyAdmin:**

1. Base de datos `pixelandbean` seleccionada
2. Pestaña **SQL**
3. Copiar y pegar contenido de `02_seed.sql`
4. Clic en **Continuar**

**Desde línea de comandos:**

```bash
# Windows
cd C:\xampp\mysql\bin
mysql -u root pixelandbean < C:\ruta\proyecto\docs\sql\02_seed.sql

# Linux/macOS
cd /opt/lampp/bin
./mysql -u root pixelandbean < /ruta/proyecto/docs/sql/02_seed.sql
```

### Verificar Datos Cargados

En phpMyAdmin:

```sql
-- Ver usuarios
SELECT * FROM usuario;
-- Resultado esperado: 5 usuarios (2 admin, 3 operadores)

-- Ver productos
SELECT categoria, COUNT(*) as total FROM producto GROUP BY categoria;
-- Resultado esperado:
-- BEBIDA: 9
-- SNACK: 8
-- TIEMPO_ARCADE: 5

-- Ver ventas
SELECT COUNT(*) FROM venta;
-- Resultado esperado: 5 ventas
```

---

## ⚙️ Paso 4: Configuración de Java (15 min)

Ahora configuramos el proyecto Java para conectarse a la base de datos.

### 4.1 Descargar MySQL Connector/J

**Opción 1: Descarga manual**

1. Ir a: https://dev.mysql.com/downloads/connector/j/
2. Seleccionar **Platform Independent**
3. Descargar archivo ZIP
4. Extraer y ubicar el archivo `mysql-connector-j-8.2.0.jar`

**Opción 2: Maven** (si usas Maven)

```xml
<dependency>
    <groupId>com.mysql</groupId>
    <artifactId>mysql-connector-j</artifactId>
    <version>8.2.0</version>
</dependency>
```

### 4.2 Agregar al Proyecto

#### NetBeans:

1. Clic derecho en el proyecto
2. **Properties** → **Libraries**
3. Clic en **Add JAR/Folder**
4. Seleccionar `mysql-connector-j-8.2.0.jar`
5. Clic en **OK**

#### IntelliJ IDEA:

1. **File** → **Project Structure** (Ctrl+Alt+Shift+S)
2. **Modules** → **Dependencies**
3. Clic en **+** → **JARs or directories**
4. Seleccionar `mysql-connector-j-8.2.0.jar`
5. Clic en **OK**

### 4.3 Crear application.properties

Crear archivo en la **raíz del proyecto**: `application.properties`

```properties
# ============================================
# Configuración de Base de Datos
# ============================================
db.url=jdbc:mysql://localhost:3306/pixelandbean?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true
db.username=root
db.password=
db.driver=com.mysql.cj.jdbc.Driver

# ============================================
# Configuración de Aplicación
# ============================================
app.name=Pixel & Bean
app.version=1.0.0
app.author=Tu Nombre o Equipo
```

**Nota:** Si tu MySQL tiene contraseña, completa `db.password=tupassword`

### 4.4 Crear DatabaseConnectionFactory

Crear paquete: `cl.tuusuario.pnb.util`  
Crear clase: `DatabaseConnectionFactory.java`

```java
package cl.tuusuario.pnb.util;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 * Factory para obtener conexiones a la base de datos.
 * Centraliza la configuración y gestión de conexiones JDBC.
 * 
 * @author Tu Nombre
 */
public class DatabaseConnectionFactory {
    
    private static String url;
    private static String username;
    private static String password;
    private static String driver;
    
    // Bloque estático: se ejecuta una sola vez al cargar la clase
    static {
        try {
            // Cargar configuración desde application.properties
            Properties props = new Properties();
            props.load(new FileInputStream("application.properties"));
            
            // Leer propiedades
            url = props.getProperty("db.url");
            username = props.getProperty("db.username");
            password = props.getProperty("db.password");
            driver = props.getProperty("db.driver");
            
            // Registrar driver JDBC (opcional en JDBC 4.0+, pero recomendado)
            Class.forName(driver);
            
            System.out.println("✅ Configuración de base de datos cargada correctamente");
            System.out.println("   URL: " + url);
            System.out.println("   Usuario: " + username);
            
        } catch (IOException e) {
            System.err.println("❌ Error al cargar application.properties");
            e.printStackTrace();
            throw new RuntimeException("No se pudo cargar la configuración de BD", e);
            
        } catch (ClassNotFoundException e) {
            System.err.println("❌ Driver JDBC no encontrado: " + driver);
            e.printStackTrace();
            throw new RuntimeException("Driver JDBC no disponible", e);
        }
    }
    
    /**
     * Obtiene una nueva conexión a la base de datos.
     * 
     * El caller es responsable de cerrar la conexión cuando termine de usarla.
     * Se recomienda usar try-with-resources:
     * 
     * <pre>
     * try (Connection conn = DatabaseConnectionFactory.getConnection()) {
     *     // Usar conexión
     * }
     * </pre>
     * 
     * @return Connection activa a la base de datos
     * @throws SQLException si no se puede establecer conexión
     */
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(url, username, password);
    }
    
    /**
     * Prueba la conexión a la base de datos.
     * 
     * @return true si la conexión es exitosa, false en caso contrario
     */
    public static boolean testConnection() {
        try (Connection conn = getConnection()) {
            boolean valid = conn != null && !conn.isClosed();
            if (valid) {
                System.out.println("✅ Conexión a base de datos exitosa");
                System.out.println("   Catálogo: " + conn.getCatalog());
            }
            return valid;
        } catch (SQLException e) {
            System.err.println("❌ Error al conectar a base de datos");
            System.err.println("   Mensaje: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Obtiene la URL de conexión configurada.
     * Útil para debugging o logging.
     */
    public static String getUrl() {
        return url;
    }
    
    /**
     * Obtiene el usuario configurado.
     */
    public static String getUsername() {
        return username;
    }
}
```

### 4.5 Probar la Conexión

Crear clase de prueba: `TestConnection.java` en paquete raíz o `util`

```java
package cl.tuusuario.pnb;

import cl.tuusuario.pnb.util.DatabaseConnectionFactory;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 * Clase para probar la conexión a la base de datos.
 * Ejecutar como aplicación Java independiente.
 */
public class TestConnection {
    
    public static void main(String[] args) {
        System.out.println("===========================================");
        System.out.println("   PRUEBA DE CONEXIÓN A BASE DE DATOS    ");
        System.out.println("===========================================\n");
        
        // Test 1: Probar conexión básica
        System.out.println("Test 1: Conexión básica");
        boolean connected = DatabaseConnectionFactory.testConnection();
        
        if (!connected) {
            System.err.println("\n❌ No se pudo conectar a la base de datos.");
            System.err.println("Verifica que:");
            System.err.println("  1. XAMPP MySQL esté iniciado");
            System.err.println("  2. Base de datos 'pixelandbean' exista");
            System.err.println("  3. application.properties esté en la raíz del proyecto");
            System.err.println("  4. MySQL Connector/J esté agregado al proyecto");
            return;
        }
        
        System.out.println("\n-------------------------------------------\n");
        
        // Test 2: Consultar usuarios
        System.out.println("Test 2: Consultar usuarios");
        try (Connection conn = DatabaseConnectionFactory.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT id, username, rol FROM usuario")) {
            
            System.out.println("\nUsuarios en la base de datos:");
            System.out.println("ID | Username       | Rol");
            System.out.println("---|----------------|----------");
            
            int count = 0;
            while (rs.next()) {
                count++;
                int id = rs.getInt("id");
                String username = rs.getString("username");
                String rol = rs.getString("rol");
                System.out.printf("%-3d| %-15s| %s%n", id, username, rol);
            }
            
            System.out.println("\n✅ Total de usuarios: " + count);
            
        } catch (Exception e) {
            System.err.println("❌ Error al consultar usuarios:");
            e.printStackTrace();
        }
        
        System.out.println("\n-------------------------------------------\n");
        
        // Test 3: Consultar productos
        System.out.println("Test 3: Consultar productos");
        try (Connection conn = DatabaseConnectionFactory.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT categoria, COUNT(*) as total FROM producto GROUP BY categoria")) {
            
            System.out.println("\nProductos por categoría:");
            System.out.println("Categoría       | Total");
            System.out.println("----------------|------");
            
            while (rs.next()) {
                String categoria = rs.getString("categoria");
                int total = rs.getInt("total");
                System.out.printf("%-16s| %d%n", categoria, total);
            }
            
            System.out.println("\n✅ Consulta exitosa");
            
        } catch (Exception e) {
            System.err.println("❌ Error al consultar productos:");
            e.printStackTrace();
        }
        
        System.out.println("\n===========================================");
        System.out.println("   PRUEBA COMPLETADA                      ");
        System.out.println("===========================================");
    }
}
```

### 4.6 Ejecutar Test

**NetBeans:**
1. Clic derecho en `TestConnection.java`
2. **Run File** (Shift+F6)

**IntelliJ IDEA:**
1. Clic derecho en `TestConnection.java`
2. **Run 'TestConnection.main()'** (Ctrl+Shift+F10)

**Resultado esperado:**

```
===========================================
   PRUEBA DE CONEXIÓN A BASE DE DATOS    
===========================================

Test 1: Conexión básica
✅ Configuración de base de datos cargada correctamente
   URL: jdbc:mysql://localhost:3306/pixelandbean?useSSL=false&serverTimezone=UTC
   Usuario: root
✅ Conexión a base de datos exitosa
   Catálogo: pixelandbean

-------------------------------------------

Test 2: Consultar usuarios

Usuarios en la base de datos:
ID | Username       | Rol
---|----------------|----------
1  | admin          | ADMIN
2  | operador       | OPERADOR
3  | juan.perez     | OPERADOR
4  | maria.lopez    | ADMIN
5  | carlos.gomez   | OPERADOR

✅ Total de usuarios: 5

-------------------------------------------

Test 3: Consultar productos

Productos por categoría:
Categoría       | Total
----------------|------
BEBIDA          | 9
SNACK           | 8
TIEMPO_ARCADE   | 5

✅ Consulta exitosa

===========================================
   PRUEBA COMPLETADA                      
===========================================
```

---

## ✅ Verificación Final

Confirma que tienes:

1. ✅ **XAMPP instalado** y MySQL corriendo
2. ✅ **Base de datos `pixelandbean`** creada
3. ✅ **4 tablas creadas:** usuario, producto, venta, venta_detalle
4. ✅ **Datos iniciales cargados:** 5 usuarios, 22 productos, 5 ventas
5. ✅ **MySQL Connector/J** agregado al proyecto
6. ✅ **application.properties** configurado correctamente
7. ✅ **DatabaseConnectionFactory** implementado
8. ✅ **Test de conexión** ejecutado exitosamente

---

## 🐛 Troubleshooting

### Error: Access denied for user 'root'@'localhost'

**Causa:** Contraseña incorrecta o usuario no existe.

**Solución:**
```sql
-- Desde phpMyAdmin o línea de comandos
-- Resetear contraseña de root (si es necesario)
ALTER USER 'root'@'localhost' IDENTIFIED BY '';
FLUSH PRIVILEGES;
```

### Error: No suitable driver found

**Causa:** MySQL Connector/J no está en el classpath.

**Solución:**
1. Verificar que el JAR esté agregado en Libraries del proyecto
2. Verificar que `db.driver=com.mysql.cj.jdbc.Driver` esté correcto
3. Limpiar y reconstruir proyecto (Clean & Build)

### Error: Unknown database 'pixelandbean'

**Causa:** Base de datos no existe.

**Solución:**
```sql
-- Crear base de datos
CREATE DATABASE pixelandbean CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

### Error: Communications link failure

**Causa:** MySQL no está corriendo o puerto incorrecto.

**Solución:**
1. Abrir XAMPP Control Panel
2. Verificar que MySQL esté **Started** (verde)
3. Si no, hacer clic en **Start**
4. Verificar puerto en `my.ini` (debería ser 3306)

---

## 📊 Diagrama de Arquitectura Final

```
┌─────────────────────────────────────────┐
│   Aplicación Java (PixelAndBean)        │
│  ┌───────────────────────────────────┐  │
│  │  DatabaseConnectionFactory        │  │
│  │  - Carga application.properties   │  │
│  │  - Registra driver JDBC           │  │
│  │  - Provee Connection              │  │
│  └───────────────┬───────────────────┘  │
└──────────────────┼──────────────────────┘
                   │ JDBC
                   │ (mysql-connector-j)
                   ↓
┌─────────────────────────────────────────┐
│         MySQL Server (XAMPP)            │
│  ┌───────────────────────────────────┐  │
│  │  Base de datos: pixelandbean      │  │
│  │    - usuario (5 registros)        │  │
│  │    - producto (22 registros)      │  │
│  │    - venta (5 registros)          │  │
│  │    - venta_detalle (12 registros) │  │
│  └───────────────────────────────────┘  │
└─────────────────────────────────────────┘
```

---

## 💡 Siguiente Paso

¡Excelente! Ya tienes la base de datos configurada y conectada desde Java.

Ahora es momento de migrar los repositorios de datos mock a repositorios reales con JDBC.

**Continúa con:**  
➡️ **[03-repository-implementation.md](03-repository-implementation.md)** – Implementación completa de repositorios con JDBC

---

> 🧠 *"Una base de datos bien diseñada es la columna vertebral de cualquier sistema empresarial."*

