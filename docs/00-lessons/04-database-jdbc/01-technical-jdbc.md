# 📖 Clase 4 (Parte 1) – Fundamentos de JDBC y Persistencia de Datos

**Objetivo:**  
Comprender los fundamentos de JDBC (Java Database Connectivity), la arquitectura de conexión a bases de datos, manejo de sentencias SQL desde Java, prevención de SQL Injection y buenas prácticas de gestión de conexiones.

⏱️ **Duración estimada:** 30 minutos

**Distribución del tiempo:**
- Presentación de objetivos y comparación antes/después (5 min)
- JDBC: arquitectura y componentes principales (12 min)
- PreparedStatement y seguridad (8 min)
- Connection Pool y buenas prácticas (5 min)

<!-- TOC -->
* [📖 Clase 4 (Parte 1) – Fundamentos de JDBC y Persistencia de Datos](#-clase-4-parte-1--fundamentos-de-jdbc-y-persistencia-de-datos)
  * [🎯 Objetivos de la Clase 4](#-objetivos-de-la-clase-4)
  * [🗺️ Visión General del Proyecto](#-visión-general-del-proyecto)
    * [¿Dónde estamos?](#dónde-estamos)
    * [El problema actual](#el-problema-actual)
    * [La solución: JDBC + MySQL](#la-solución-jdbc--mysql)
  * [📚 Apartado Técnico – JDBC y Base de Datos](#-apartado-técnico--jdbc-y-base-de-datos)
    * [🔷 1. ¿Qué es JDBC?](#-1-qué-es-jdbc)
    * [🔷 2. Arquitectura de JDBC](#-2-arquitectura-de-jdbc)
    * [🔷 3. Driver JDBC de MySQL](#-3-driver-jdbc-de-mysql)
    * [🔷 4. Componentes Principales de JDBC](#-4-componentes-principales-de-jdbc)
    * [🔷 5. Statement vs PreparedStatement](#-5-statement-vs-preparedstatement)
    * [🔷 6. ResultSet – Navegación de Resultados](#-6-resultset--navegación-de-resultados)
    * [🔷 7. Transacciones en JDBC](#-7-transacciones-en-jdbc)
    * [🔷 8. SQL Injection y Seguridad](#-8-sql-injection-y-seguridad)
    * [🔷 9. Try-With-Resources (ARM)](#-9-try-with-resources-arm)
    * [🔷 10. Connection Pool](#-10-connection-pool)
    * [🔷 11. Patrón Factory para Conexiones](#-11-patrón-factory-para-conexiones)
    * [🔷 12. Manejo de SQLException](#-12-manejo-de-sqlexception)
  * [🎯 Resumen Técnico](#-resumen-técnico)
  * [💡 Siguiente Paso](#-siguiente-paso)
<!-- TOC -->

---

## 🎯 Objetivos de la Clase 4

Al finalizar esta clase serás capaz de:

1. **Comprender JDBC** y su rol en aplicaciones Java
2. **Conectar Java con MySQL** usando JDBC Driver
3. **Ejecutar consultas SQL** desde código Java de forma segura
4. **Prevenir SQL Injection** usando PreparedStatement
5. **Gestionar conexiones** eficientemente con Factory Pattern
6. **Manejar transacciones** para operaciones atómicas
7. **Implementar repositorios reales** con persistencia en base de datos
8. **Migrar de datos mock a datos persistentes** sin romper la aplicación

---

## 🗺️ Visión General del Proyecto

### ¿Dónde estamos?

| Clase | Estado       | Entregable                           |
|-------|--------------|--------------------------------------|
| **1** | ✅ Completada | Login + MainFrame con menú           |
| **2** | ✅ Completada | Todas las vistas con datos mock      |
| **3** | ✅ Completada | Arquitectura MVC + IoC               |
| **4** | 🔄 En curso  | **Conexión a BD (JDBC)**             |
| 5     | ⏳ Pendiente  | CRUD completo funcional              |
| 6     | ⏳ Pendiente  | Empaquetado y release                |

### El problema actual

Actualmente tenemos una excelente arquitectura, pero los datos se pierden al cerrar la aplicación:

```
┌──────────────────────────────────┐
│    UsuarioRepositoryMock         │
│  ┌────────────────────────────┐  │
│  │  List<Usuario> usuarios    │  │
│  │  = Arrays.asList(          │  │
│  │    new Usuario(1, "admin") │  │
│  │  );                        │  │
│  └────────────────────────────┘  │
│  ❌ Se pierde al cerrar          │
│  ❌ No se puede compartir        │
│  ❌ Testing difícil              │
└──────────────────────────────────┘
```

**Limitaciones actuales:**
- ❌ Datos volátiles (solo en memoria)
- ❌ Se pierden al cerrar la aplicación
- ❌ No se pueden compartir entre instancias
- ❌ No hay persistencia real
- ❌ No es escalable

### La solución: JDBC + MySQL

Vamos a conectar nuestros repositorios a una base de datos real:

```
┌──────────────────────────────────┐
│   UsuarioRepositoryImpl          │
│  ┌────────────────────────────┐  │
│  │  Connection conn =         │  │
│  │    factory.getConnection();│  │
│  │                            │  │
│  │  PreparedStatement ps =    │  │
│  │    conn.prepareStatement(  │  │
│  │      "SELECT * FROM ..."   │  │
│  │    );                      │  │
│  └────────────────────────────┘  │
└──────────┬───────────────────────┘
           │ JDBC
           ↓
┌──────────────────────────────────┐
│      MySQL Database              │
│  ┌────────────────────────────┐  │
│  │  tabla: usuario            │  │
│  │  tabla: producto           │  │
│  │  tabla: venta              │  │
│  │  tabla: venta_detalle      │  │
│  └────────────────────────────┘  │
│  ✅ Persistencia real            │
│  ✅ Compartido entre instancias  │
│  ✅ Backup y recovery            │
└──────────────────────────────────┘
```

**Beneficios:**
- ✅ Datos permanentes (persisten después de cerrar)
- ✅ Múltiples usuarios pueden acceder simultáneamente
- ✅ Backup y recuperación de datos
- ✅ Consultas complejas con SQL
- ✅ Escalable a producción

---

## 📚 Apartado Técnico – JDBC y Base de Datos

### 🔷 1. ¿Qué es JDBC?

**JDBC (Java Database Connectivity)** es una API estándar de Java que permite:
- Conectarse a bases de datos relacionales
- Ejecutar sentencias SQL
- Recuperar y manipular resultados
- Gestionar transacciones

#### Características principales:

| Característica | Descripción |
|----------------|-------------|
| **Estándar** | API definida en `java.sql.*` y `javax.sql.*` |
| **Independiente de BD** | Mismo código funciona con MySQL, PostgreSQL, Oracle, etc. |
| **Driver-based** | Cada BD provee su propio driver JDBC |
| **Thread-safe** | Diseñado para aplicaciones multi-hilo |

#### ¿Por qué usar JDBC?

```java
// ❌ Sin JDBC - Imposible
// No hay forma estándar de conectar Java con bases de datos

// ✅ Con JDBC - Simple y estándar
Connection conn = DriverManager.getConnection(url, user, pass);
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery("SELECT * FROM usuarios");
```

---

### 🔷 2. Arquitectura de JDBC

JDBC tiene una arquitectura de 4 capas:

```
┌─────────────────────────────────────┐
│   Aplicación Java (tu código)      │  ← Tu aplicación
└────────────────┬────────────────────┘
                 │
                 ↓
┌─────────────────────────────────────┐
│   JDBC API (java.sql.*)             │  ← API estándar de Java
└────────────────┬────────────────────┘
                 │
                 ↓
┌─────────────────────────────────────┐
│   JDBC Driver Manager               │  ← Gestiona drivers
└────────────────┬────────────────────┘
                 │
                 ↓
┌─────────────────────────────────────┐
│   JDBC Driver (MySQL Connector/J)   │  ← Driver específico de BD
└────────────────┬────────────────────┘
                 │ Protocolo nativo
                 ↓
┌─────────────────────────────────────┐
│   Base de Datos (MySQL Server)      │  ← Tu BD
└─────────────────────────────────────┘
```

#### Tipos de Drivers JDBC:

| Tipo | Nombre | Descripción | Uso |
|------|--------|-------------|-----|
| **Tipo 1** | JDBC-ODBC Bridge | Usa ODBC nativo | ⚠️ Obsoleto |
| **Tipo 2** | Native-API Driver | Usa bibliotecas nativas | ⚠️ Dependiente de plataforma |
| **Tipo 3** | Network Protocol | Middleware en Java | 🟡 Raro |
| **Tipo 4** | Thin Driver | 100% Java puro | ✅ **Recomendado** (MySQL Connector/J) |

**Nosotros usaremos Tipo 4:** MySQL Connector/J es 100% Java, portable y eficiente.

---

### 🔷 3. Driver JDBC de MySQL

#### ¿Qué es MySQL Connector/J?

Es el driver JDBC oficial de MySQL. Permite que aplicaciones Java se conecten a bases de datos MySQL.

#### Características:

- ✅ 100% Java (Tipo 4)
- ✅ Compatible con todas las versiones de MySQL 5.x y 8.x
- ✅ Soporta SSL/TLS
- ✅ Pooling de conexiones
- ✅ PreparedStatements optimizados

#### Agregarlo al proyecto:

**Opción 1: JAR manual (NetBeans/IntelliJ)**

Esta opción es ideal para proyectos no gestionados por Maven/Gradle o cuando necesitas control directo sobre las librerías.

#### Paso 1: Descargar el conector MySQL

**Opción A: Desde el sitio oficial de MySQL**

1. Visita: https://dev.mysql.com/downloads/connector/j/
2. Selecciona **Platform Independent** en el desplegable de sistema operativo.
3. Descarga el archivo **ZIP** (por ejemplo: `mysql-connector-j-8.3.0.zip`).
4. Descomprime el archivo y localiza el JAR: `mysql-connector-j-8.3.0.jar`.

**Opción B: Desde Maven Central (descarga directa)**

1. Abre: https://search.maven.org/
2. Busca: `mysql-connector-j` (o `mysql:mysql-connector-java` para versiones antiguas).
3. Selecciona la versión deseada (recomendado: 8.3.0 o superior).
4. Haz clic en **jar** para descargar directamente, por ejemplo:
   ```
   https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/8.3.0/mysql-connector-j-8.3.0.jar
   ```

**Opción C: Línea de comandos (wget/curl)**

```bash
# Crear carpeta libs si no existe
mkdir -p libs

# Descargar con curl
curl -L -o libs/mysql-connector-j-8.3.0.jar \
  "https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/8.3.0/mysql-connector-j-8.3.0.jar"

# O con wget
wget -O libs/mysql-connector-j-8.3.0.jar \
  "https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/8.3.0/mysql-connector-j-8.3.0.jar"
```

**Verificación (opcional):**
- Descarga también el archivo `.sha1` o `.md5` desde Maven Central.
- Verifica la integridad:
  ```bash
  sha1sum libs/mysql-connector-j-8.3.0.jar
  # Compara con el contenido del archivo .sha1
  ```

#### Paso 2: Incluir el JAR en NetBeans

**Para proyectos Java estándar o Ant:**

1. **Clic derecho** en el proyecto → **Properties** (Propiedades).
2. En el panel izquierdo, selecciona **Libraries** (Bibliotecas).
3. En la pestaña **Compile** (Compilar), haz clic en **Add JAR/Folder** (Agregar JAR/Carpeta).
4. Navega hasta el archivo `mysql-connector-j-8.3.0.jar` que descargaste.
5. Selecciona el JAR y haz clic en **Open** (Abrir).
6. Haz clic en **OK** para guardar los cambios.
7. NetBeans añadirá el JAR al classpath del proyecto.

**Verificación en NetBeans:**
- Expande el nodo **Libraries** en el árbol del proyecto.
- Deberías ver `mysql-connector-j-8.3.0.jar` listado.

**Para proyectos Maven:**
- **No uses este método**. En su lugar, agrega la dependencia en `pom.xml` (ver Opción 2).
- Si realmente necesitas un JAR local, instálalo en el repositorio local Maven (ver sección "Alternativa: Instalar en repositorio local Maven" más abajo).

**Nota sobre Ant:**
- NetBeans guarda la referencia del JAR en `nbproject/project.properties` o `nbproject/private/private.properties`.
- Si compartes el proyecto, asegúrate de documentar dónde obtener el JAR o inclúyelo en el repositorio (carpeta `libs/`).

#### Paso 3: Incluir el JAR en IntelliJ IDEA

**Para proyectos Java estándar (no Maven/Gradle):**

1. Menú **File** → **Project Structure** (o presiona `Ctrl+Alt+Shift+S` en Windows/Linux, `Cmd+;` en Mac).
2. En el panel izquierdo, selecciona **Modules**.
3. Selecciona tu módulo y ve a la pestaña **Dependencies** (Dependencias).
4. Haz clic en el botón **+** (Add) y elige **JARs or directories** (JARs o directorios).
5. Navega hasta `mysql-connector-j-8.3.0.jar` y selecciónalo.
6. Asegúrate de que el **Scope** esté configurado como **Compile** (o **Runtime** si solo lo necesitas en ejecución).
7. Haz clic en **OK** para aplicar los cambios.

**Opción alternativa: Crear una biblioteca global**

1. En **Project Structure**, ve a **Libraries** (Bibliotecas).
2. Haz clic en **+** → **Java**.
3. Selecciona el JAR de MySQL Connector.
4. Asigna un nombre (por ejemplo: `MySQL Connector 8.3.0`).
5. Luego, en **Modules** → **Dependencies**, añade esta biblioteca en lugar del JAR directo.
6. Ventaja: puedes reutilizar esta biblioteca en múltiples módulos/proyectos.

**Para proyectos Maven/Gradle:**
- **No uses este método**. Edita `pom.xml` o `build.gradle` en su lugar (ver Opción 2).
- IntelliJ sincronizará automáticamente las dependencias desde el repositorio.

**Verificación en IntelliJ:**
- Abre el panel **External Libraries** en el árbol del proyecto.
- Deberías ver `mysql-connector-j-8.3.0.jar` listado.

#### Paso 4: Probar la configuración

Crea una clase de prueba simple:

```java
package com.pixelandbean.test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class TestMySQLConnection {
    public static void main(String[] args) {
        String url = "jdbc:mysql://localhost:3306/testdb";
        String user = "root";
        String password = "yourpassword";
        
        try {
            // Intentar conexión
            Connection conn = DriverManager.getConnection(url, user, password);
            System.out.println("✅ Conexión exitosa a MySQL!");
            System.out.println("Database: " + conn.getCatalog());
            conn.close();
        } catch (SQLException e) {
            System.err.println("❌ Error de conexión:");
            e.printStackTrace();
        }
    }
}


**Ejecuta la clase:**
- NetBeans: Clic derecho → **Run File** (o `Shift+F6`).
- IntelliJ: Clic derecho → **Run 'TestMySQLConnection.main()'** (o `Ctrl+Shift+F10`).

**Resultado esperado:**
// SQL resultante: SELECT * FROM usuario WHERE username = 'admin' OR '1'='1'
✅ Conexión exitosa a MySQL!
Database: testdb
```

#### Problemas comunes y soluciones

**1. `ClassNotFoundException: com.mysql.cj.jdbc.Driver`**

- **Causa**: El JAR no está en el classpath.
- **Solución**:
  - Verifica que el JAR esté listado en las bibliotecas del proyecto.
  - En NetBeans/IntelliJ, reconstruye el proyecto (`Build → Rebuild Project`).
  - Asegúrate de que el **Scope** sea **Compile** (IntelliJ) o esté en la sección **Compile** (NetBeans).

**2. `SQLException: Access denied for user`**

- **Causa**: Credenciales incorrectas o usuario sin permisos.
- **Solución**:
  - Verifica usuario y contraseña en MySQL.
  - Asegúrate de que el usuario tenga permisos en la base de datos:
    ```sql
    GRANT ALL PRIVILEGES ON testdb.* TO 'root'@'localhost';
    FLUSH PRIVILEGES;
    ```

**3. `Communications link failure`**

- **Causa**: MySQL no está corriendo o el puerto es incorrecto.
- **Solución**:
  - Verifica que MySQL esté activo: `systemctl status mysql` (Linux) o revisa en Services (Windows).
  - Confirma el puerto (por defecto: 3306) en `my.cnf` o `my.ini`.
  - Prueba la conexión con cliente: `mysql -u root -p`.

**4. Versión del JAR incorrecta**

- **Problema**: MySQL 8+ usa `com.mysql.cj.jdbc.Driver`, versiones antiguas usan `com.mysql.jdbc.Driver`.
- **Solución**: Usa siempre la versión 8.x+ del conector (por ejemplo, 8.3.0).

**5. Timezone warnings**

- **Warning**: `The server time zone value 'XXX' is unrecognized...`
- **Solución**: Agrega parámetro a la URL:
  ```java
  String url = "jdbc:mysql://localhost:3306/testdb?serverTimezone=UTC";
  ```

#### Alternativa: Instalar en repositorio local Maven

Si trabajas con Maven pero tienes un JAR local (por ejemplo, versión modificada), puedes instalarlo en tu repositorio local (`~/.m2/repository`):

```bash
mvn install:install-file \
  -Dfile=libs/mysql-connector-j-8.3.0.jar \
  -DgroupId=com.mysql \
  -DartifactId=mysql-connector-j \
  -Dversion=8.3.0 \
  -Dpackaging=jar
```

Luego, agrega la dependencia normal en `pom.xml`:

```xml
<dependency>
    <groupId>com.mysql</groupId>
    <artifactId>mysql-connector-j</artifactId>
    <version>8.3.0</version>
</dependency>
```

**Para Gradle** (usando carpeta `libs/`):

1. Crea una carpeta `libs/` en la raíz del proyecto.
2. Coloca el JAR ahí: `libs/mysql-connector-j-8.3.0.jar`.
3. Edita `build.gradle`:

```groovy
dependencies {
    implementation files('libs/mysql-connector-j-8.3.0.jar')
}
```

O si lo instalaste en `mavenLocal`:

```groovy
repositories {
    mavenLocal()
    mavenCentral()
}

dependencies {
    implementation 'com.mysql:mysql-connector-j:8.3.0'
}
```

#### Resumen de la Opción 1

| Paso | Acción |
|------|--------|
| 1 | Descargar `mysql-connector-j-8.3.0.jar` desde MySQL oficial o Maven Central |
| 2 | NetBeans: Properties → Libraries → Add JAR/Folder |
| 3 | IntelliJ: Project Structure → Modules → Dependencies → + JAR |
| 4 | Crear clase de prueba con `DriverManager.getConnection()` |
| 5 | Ejecutar y verificar conexión exitosa |

**Ventajas:**
- Control directo sobre la versión del JAR.
- Funciona en proyectos sin sistema de build (Ant, proyectos simples).
- Útil para testing rápido o entornos sin acceso a Maven Central.

**Desventajas:**
- Debes gestionar actualizaciones manualmente.
- Difícil de compartir en equipo (cada desarrollador debe descargar el JAR).
- No gestiona dependencias transitivas automáticamente.

**Recomendación:** Para proyectos profesionales o en equipo, prefiere la Opción 2 (Maven/Gradle) que automatiza la descarga y gestión de versiones.
    ps2.executeUpdate();
    

Si tu proyecto usa Maven, agrega esta dependencia en tu archivo `pom.xml`:

} catch (SQLException e) {
    // Algo salió mal, revertir
    conn.rollback();
    throw e;
    <version>8.3.0</version>
} finally {
    // Restaurar auto-commit
    conn.setAutoCommit(true);
Maven descargará automáticamente el JAR y sus dependencias.

```

Si usas Gradle, agrega esta línea en tu archivo `build.gradle`:

- ✅ Transferencias bancarias
implementation 'com.mysql:mysql-connector-j:8.3.0'

---
Gradle descargará el conector y lo añadirá al classpath.
### 🔷 8. SQL Injection y Seguridad

#### ¿Qué es SQL Injection?

Es una técnica de ataque donde el atacante inyecta código SQL malicioso en entradas de la aplicación.

#### Ejemplo de ataque:

```java
// Usuario ingresa en el login:
// Username: admin' --
// Password: cualquier cosa

String sql = "SELECT * FROM usuario WHERE username = '" + username + "' AND password = '" + password + "'";
// SQL resultante:
// SELECT * FROM usuario WHERE username = 'admin' --' AND password = 'cualquiercosa'
// El -- comenta el resto, eliminando la verificación de password
// ¡El atacante ingresa sin saber la contraseña!
```

#### Prevención:

```java
// ✅ SIEMPRE usar PreparedStatement
String sql = "SELECT * FROM usuario WHERE username = ? AND password = ?";
PreparedStatement ps = conn.prepareStatement(sql);
ps.setString(1, username); // Escapado automáticamente
ps.setString(2, password); // Escapado automáticamente

// Ahora el input malicioso se trata como texto literal:
// SELECT * FROM usuario WHERE username = 'admin\' --' AND password = 'cualquiercosa'
// Busca un usuario llamado "admin' --" (no existe) ✅ SEGURO
```

#### Reglas de oro:

1. ✅ **NUNCA concatenar strings** para construir SQL
2. ✅ **SIEMPRE usar PreparedStatement** con parámetros (`?`)
3. ✅ **Validar inputs** en UI y backend (defensa en profundidad)
4. ✅ **Principio de mínimo privilegio:** Usuario de BD solo con permisos necesarios

---

### 🔷 9. Try-With-Resources (ARM)

Java 7 introdujo **Automatic Resource Management** para cerrar recursos automáticamente.

#### Antes de Java 7 (❌ Tedioso):

```java
Connection conn = null;
PreparedStatement ps = null;
ResultSet rs = null;

try {
    conn = factory.getConnection();
    ps = conn.prepareStatement("SELECT * FROM usuario");
    rs = ps.executeQuery();
    
    // Procesar resultados
    while (rs.next()) {
        // ...
    }
    
} catch (SQLException e) {
    e.printStackTrace();
    
} finally {
    // Cerrar en orden inverso
    if (rs != null) {
        try {
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    if (ps != null) {
        try {
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    if (conn != null) {
        try {
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
```

#### Con Try-With-Resources (✅ Limpio):

```java
try (Connection conn = factory.getConnection();
     PreparedStatement ps = conn.prepareStatement("SELECT * FROM usuario");
     ResultSet rs = ps.executeQuery()) {
    
    // Procesar resultados
    while (rs.next()) {
        // ...
    }
    
// No hay forma estándar de conectar Java con bases de datos
    e.printStackTrace();
// ✅ Con JDBC - Simple y estándar
Connection conn = DriverManager.getConnection(url, user, pass);
```
ResultSet rs = stmt.executeQuery("SELECT * FROM usuarios");
**Ventajas:**
- ✅ Código más limpio y legible
- ✅ No olvidas cerrar recursos
- ✅ Manejo correcto de excepciones en close()
- ✅ Funciona con cualquier clase que implemente `AutoCloseable`

---

### 🔷 10. Connection Pool

#### ¿Qué es?

Un **Connection Pool** es un caché de conexiones de base de datos reutilizables.

#### Problema sin pool:

```java
// Cada operación abre y cierra conexión
Connection conn = DriverManager.getConnection(...); // ❌ Lento (50-100ms)
// Hacer query
conn.close(); // ❌ Desperdicia recursos
```

**Problemas:**
- ❌ Abrir conexión es costoso (red, autenticación, handshake)
- ❌ Limita concurrencia (máximo de conexiones del servidor)
- ❌ No es escalable

#### Solución con pool:

```java
// Primera vez: crea un pool de 10 conexiones
HikariDataSource pool = new HikariDataSource();
pool.setJdbcUrl("jdbc:mysql://...");
pool.setMaximumPoolSize(10);

// Cuando necesitas conexión
Connection conn = pool.getConnection(); // ✅ Rápido (< 1ms, reutiliza existente)
// Hacer query
conn.close(); // ✅ No cierra realmente, la devuelve al pool
```

**Ventajas:**
- ✅ Mucho más rápido (reutiliza conexiones)
- ✅ Controla concurrencia automáticamente
- ✅ Escalable a cientos de usuarios

#### Librería recomendada: HikariCP

```xml
<dependency>
    <groupId>com.zaxxer</groupId>
    <artifactId>HikariCP</artifactId>
    <version>5.0.1</version>
</dependency>
```

**Nota:** Para este proyecto (6 clases), usaremos conexiones simples con `DriverManager` por simplicidad. En producción, **siempre usar Connection Pool**.

---

### 🔷 11. Patrón Factory para Conexiones

Para centralizar la lógica de conexión, usamos el **patrón Factory**.

#### Estructura:

```java
package cl.cmartinezs.pnb.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.io.FileInputStream;
import java.util.Properties;

public class DatabaseConnectionFactory {
    
    private static String url;
    private static String user;
    private static String password;
    
    // Cargar configuración una sola vez
    static {
        try {
            Properties props = new Properties();
            props.load(new FileInputStream("application.properties"));
            
            url = props.getProperty("db.url");
            user = props.getProperty("db.username");
            password = props.getProperty("db.password");
            
            // Registrar driver (opcional en JDBC 4.0+)
            Class.forName(props.getProperty("db.driver"));
            
        } catch (Exception e) {
            throw new RuntimeException("Error al cargar configuración de BD", e);
        }
    }
    
    /**
     * Obtiene una nueva conexión a la base de datos.
     * El caller es responsable de cerrarla.
     */
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(url, user, password);
    }
    
    /**
     * Prueba la conexión a la base de datos.
     */
    public static boolean testConnection() {
        try (Connection conn = getConnection()) {
            return conn != null && !conn.isClosed();
        } catch (SQLException e) {
            return false;
        }
    }
}
```

#### Archivo `application.properties`:

```properties
# Configuración de Base de Datos
db.url=jdbc:mysql://localhost:3306/pixelandbean?useSSL=false&serverTimezone=UTC
db.username=root
db.password=
db.driver=com.mysql.cj.jdbc.Driver

# Configuración de Aplicación
app.name=Pixel & Bean
app.version=1.0.0
```

#### Uso:

```java
// En cualquier repositorio
try (Connection conn = DatabaseConnectionFactory.getConnection();
     PreparedStatement ps = conn.prepareStatement(sql)) {
    
    // Usar conexión
    
} catch (SQLException e) {
    throw new RuntimeException("Error de base de datos", e);
}
```

**Ventajas:**
- ✅ Centraliza configuración
- ✅ Fácil cambiar de BD (solo modificas el factory)
// SELECT * FROM usuario WHERE username = 'admin' --' AND password = 'cualquiercosa'
- ✅ Configuración externa (no hardcodear credenciales)

---

### 🔷 12. Manejo de SQLException

`SQLException` es una **checked exception** que debe manejarse.

#### Estrategias de manejo:

**Opción 1: Try-Catch local (simple)**
```java
public Usuario buscarPorUsername(String username) {
    try (Connection conn = factory.getConnection();
         PreparedStatement ps = conn.prepareStatement("SELECT * FROM usuario WHERE username = ?")) {
        
        ps.setString(1, username);
        ResultSet rs = ps.executeQuery();
        
        if (rs.next()) {
            return mapearUsuario(rs);
        }
        return null;
        
    } catch (SQLException e) {
        e.printStackTrace(); // ⚠️ En producción: usar logger
        throw new RuntimeException("Error al buscar usuario: " + username, e);
    }
}
```

**Opción 2: Lanzar excepción personalizada (avanzado)**
```java
public class RepositoryException extends RuntimeException {
    public RepositoryException(String message, Throwable cause) {
        super(message, cause);
    }
}

public Usuario buscarPorUsername(String username) {
    try {
        // ... código JDBC ...
    } catch (SQLException e) {
        throw new RepositoryException("Error al buscar usuario: " + username, e);
    }
}
```

**Opción 3: Logging profesional (producción)**
```java
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class UsuarioRepositoryImpl implements UsuarioRepository {
    
    private static final Logger logger = LoggerFactory.getLogger(UsuarioRepositoryImpl.class);
    
    public Usuario buscarPorUsername(String username) {
        try {
            // ... código JDBC ...
        } catch (SQLException e) {
            logger.error("Error al buscar usuario: {}", username, e);
            throw new RepositoryException("Error de base de datos", e);
        }
    }
}
```

**Regla de oro:**
- ❌ **NUNCA mostrar SQLException al usuario** (expone detalles internos)
- ✅ **Loggear el error completo** para debugging
- ✅ **Mostrar mensaje amigable** al usuario ("Error al cargar datos")

---

## 🎯 Resumen Técnico

### Conceptos clave aprendidos:

| Concepto | Uso |
|----------|-----|
| **JDBC** | API estándar para conectar Java con BD |
| **Driver** | MySQL Connector/J (Tipo 4, 100% Java) |
| **Connection** | Representa conexión activa a BD |
| **PreparedStatement** | ✅ Ejecuta SQL parametrizado de forma segura |
| **Statement** | ⚠️ Evitar (vulnerable a SQL Injection) |
| **ResultSet** | Resultados de consultas SELECT |
| **Transaction** | Conjunto de operaciones atómicas (ACID) |
| **Try-With-Resources** | Cierra recursos automáticamente |
| **Connection Pool** | Reutiliza conexiones (HikariCP) |
| **Factory Pattern** | Centraliza creación de conexiones |
| **SQLException** | Excepción de JDBC (checked) |

### Flujo típico de una consulta:

```
1. Obtener Connection desde Factory
2. Preparar PreparedStatement con SQL
3. Establecer parámetros (?)
4. Ejecutar query
5. Procesar ResultSet
6. Cerrar recursos (automático con try-with-resources)
```

### Buenas prácticas:

1. ✅ **SIEMPRE usar PreparedStatement** (nunca Statement)
2. ✅ **Try-With-Resources** para gestión de recursos
3. ✅ **Cerrar recursos** en orden inverso: ResultSet → PreparedStatement → Connection
4. ✅ **Factory Pattern** para conexiones
5. ✅ **Configuración externa** (application.properties)
6. ✅ **Manejo de errores** con logging
7. ✅ **Transacciones** para operaciones multi-tabla
8. ✅ **Connection Pool** en producción (HikariCP)

---

## 💡 Siguiente Paso

Ahora que comprendes los fundamentos de JDBC, es hora de poner manos a la obra.

**Continúa con:**  
➡️ **[02-database-setup.md](02-database-setup.md)** – Instalación de XAMPP, creación de base de datos y primeros repositorios

---

> 🧠 *"JDBC es el puente entre tu lógica de negocio y tus datos. Úsalo con sabiduría y seguridad."*

