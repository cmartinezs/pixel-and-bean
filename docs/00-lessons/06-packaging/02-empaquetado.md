# 📦 Parte 2: Empaquetado y Configuración Externa (35 minutos)

En esta parte aprenderemos a empaquetar la aplicación como un archivo .jar ejecutable con configuración externa y dependencias incluidas.

---

## 🎯 Objetivos

- Configurar archivo MANIFEST.MF
- Generar archivo .jar ejecutable
- Incluir dependencias externas
- Configuración con application.properties externo
- Crear scripts de ejecución
- Probar el empaquetado

---

## ⚙️ Paso 1: Configuración Externa con Properties (8 min)

### Crear Lector de Configuración

```java
package cl.cmartinezs.pnb.util;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * Lector de configuración desde application.properties
 */
public class ConfigLoader {
    
    private static final String CONFIG_FILE = "application.properties";
    private static Properties properties;
    
    static {
        cargarConfiguracion();
    }
    
    /**
     * Carga la configuración desde el archivo
     */
    private static void cargarConfiguracion() {
        properties = new Properties();
        
        try {
            // Intentar cargar desde archivo externo primero
            try (InputStream input = new FileInputStream(CONFIG_FILE)) {
                properties.load(input);
                System.out.println("Configuración cargada desde archivo externo");
            } catch (IOException e) {
                // Si no existe, cargar desde recursos internos
                try (InputStream input = ConfigLoader.class.getClassLoader()
                        .getResourceAsStream(CONFIG_FILE)) {
                    if (input != null) {
                        properties.load(input);
                        System.out.println("Configuración cargada desde recursos internos");
                    } else {
                        System.err.println("No se encontró archivo de configuración");
                    }
                }
            }
        } catch (IOException e) {
            System.err.println("Error al cargar configuración: " + e.getMessage());
        }
    }
    
    /**
     * Obtiene una propiedad como String
     */
    public static String getProperty(String key) {
        return properties.getProperty(key);
    }
    
    /**
     * Obtiene una propiedad con valor por defecto
     */
    public static String getProperty(String key, String defaultValue) {
        return properties.getProperty(key, defaultValue);
    }
    
    /**
     * Obtiene configuración de base de datos
     */
    public static String getDbUrl() {
        return getProperty("db.url", "jdbc:mysql://localhost:3306/pixelandbean");
    }
    
    public static String getDbUsername() {
        return getProperty("db.username", "root");
    }
    
    public static String getDbPassword() {
        return getProperty("db.password", "");
    }
    
    public static String getDbDriver() {
        return getProperty("db.driver", "com.mysql.cj.jdbc.Driver");
    }
    
    /**
     * Obtiene configuración de aplicación
     */
    public static String getAppName() {
        return getProperty("app.name", "Pixel & Bean");
    }
    
    public static String getAppVersion() {
        return getProperty("app.version", "1.0.0");
    }
    
    public static String getAppAuthor() {
        return getProperty("app.author", "Equipo de Desarrollo");
    }
}
```

### Actualizar DatabaseConnectionFactory

```java
package cl.cmartinezs.pnb.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnectionFactory {
    
    private final String url;
    private final String username;
    private final String password;
    
    public DatabaseConnectionFactory() {
        // Cargar desde configuración
        this.url = ConfigLoader.getDbUrl();
        this.username = ConfigLoader.getDbUsername();
        this.password = ConfigLoader.getDbPassword();
        
        // Cargar driver
        try {
            Class.forName(ConfigLoader.getDbDriver());
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Driver JDBC no encontrado", e);
        }
    }
    
    public Connection getConnection() throws SQLException {
        return DriverManager.getConnection(url, username, password);
    }
}
```

### Archivo application.properties

Crear en la raíz del proyecto:

```properties
# Configuración de Base de Datos
db.url=jdbc:mysql://localhost:3306/pixelandbean?useSSL=false&serverTimezone=UTC
db.username=root
db.password=
db.driver=com.mysql.cj.jdbc.Driver

# Configuración de Aplicación
app.name=Pixel & Bean
app.version=1.0.0
app.author=Tu Nombre o Equipo

# Otras configuraciones
app.debug=false
app.log.level=INFO
```

---

## 📋 Paso 2: Configurar MANIFEST.MF (5 min)

### Crear archivo MANIFEST.MF

Crear en `src/META-INF/MANIFEST.MF`:

```
Manifest-Version: 1.0
Main-Class: cl.cmartinezs.pnb.PixelAndBean
Class-Path: lib/mysql-connector-j-8.2.0.jar
Created-By: Maven 3.8.1 (o tu herramienta)
Implementation-Title: Pixel and Bean
Implementation-Version: 1.0.0
Implementation-Vendor: Equipo de Desarrollo

```

**Nota importante:** El archivo debe terminar con una línea en blanco.

### Estructura de Directorios para Empaquetado

```
PixelAndBean/
├── PixelAndBean.jar          (ejecutable principal)
├── application.properties     (configuración externa)
├── lib/                       (dependencias)
│   └── mysql-connector-j-8.2.0.jar
├── docs/                      (documentación)
│   └── sql/
│       ├── 01_schema.sql
│       └── 02_seed.sql
├── README.md
└── run.bat / run.sh           (scripts de ejecución)
```

---

## 🔨 Paso 3: Generar JAR con NetBeans (8 min)

### Opción 1: Build con NetBeans

1. **Configurar el proyecto:**
   - Clic derecho en el proyecto → Properties
   - Build → Packaging
   - Marcar "Copy Dependent Libraries"
   - JAR File: `dist/PixelAndBean.jar`

2. **Copiar recursos:**
   - Asegurarse de que `/resources/` esté en el classpath
   - Incluir `application.properties` en `src/`

3. **Build:**
   ```
   Clic derecho en proyecto → Clean and Build
   ```

4. **Resultado:**
   ```
   dist/
   ├── PixelAndBean.jar
   └── lib/
       └── mysql-connector-j-8.2.0.jar
   ```

### Opción 2: Build con Ant manualmente

Crear `build.xml` si no existe:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project name="PixelAndBean" default="jar" basedir=".">
    
    <property name="src.dir" value="src"/>
    <property name="build.dir" value="build"/>
    <property name="dist.dir" value="dist"/>
    <property name="lib.dir" value="lib"/>
    
    <!-- Compilar -->
    <target name="compile">
        <mkdir dir="${build.dir}"/>
        <javac srcdir="${src.dir}" 
               destdir="${build.dir}"
               includeantruntime="false"
               encoding="UTF-8">
            <classpath>
                <fileset dir="${lib.dir}">
                    <include name="**/*.jar"/>
                </fileset>
            </classpath>
        </javac>
        
        <!-- Copiar recursos -->
        <copy todir="${build.dir}">
            <fileset dir="${src.dir}">
                <include name="**/*.properties"/>
                <include name="**/*.png"/>
                <include name="**/*.jpg"/>
            </fileset>
        </copy>
    </target>
    
    <!-- Crear JAR -->
    <target name="jar" depends="compile">
        <mkdir dir="${dist.dir}"/>
        <mkdir dir="${dist.dir}/lib"/>
        
        <!-- Copiar dependencias -->
        <copy todir="${dist.dir}/lib">
            <fileset dir="${lib.dir}">
                <include name="**/*.jar"/>
            </fileset>
        </copy>
        
        <!-- Crear JAR ejecutable -->
        <jar destfile="${dist.dir}/PixelAndBean.jar" 
             basedir="${build.dir}"
             manifest="src/META-INF/MANIFEST.MF">
        </jar>
        
        <!-- Copiar configuración -->
        <copy file="application.properties" todir="${dist.dir}"/>
    </target>
    
    <!-- Limpiar -->
    <target name="clean">
        <delete dir="${build.dir}"/>
        <delete dir="${dist.dir}"/>
    </target>
    
</project>
```

Ejecutar:
```bash
ant clean jar
```

### Opción 3: JAR con Maven

Si usas Maven, agregar en `pom.xml`:

```xml
<build>
    <plugins>
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-jar-plugin</artifactId>
            <version>3.2.0</version>
            <configuration>
                <archive>
                    <manifest>
                        <mainClass>cl.cmartinezs.pnb.PixelAndBean</mainClass>
                        <addClasspath>true</addClasspath>
                        <classpathPrefix>lib/</classpathPrefix>
                    </manifest>
                </archive>
            </configuration>
        </plugin>
        
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-dependency-plugin</artifactId>
            <version>3.2.0</version>
            <executions>
                <execution>
                    <id>copy-dependencies</id>
                    <phase>package</phase>
                    <goals>
                        <goal>copy-dependencies</goal>
                    </goals>
                    <configuration>
                        <outputDirectory>${project.build.directory}/lib</outputDirectory>
                    </configuration>
                </execution>
            </executions>
        </plugin>
    </plugins>
</build>
```

Ejecutar:
```bash
mvn clean package
```

---

## 🚀 Paso 4: Scripts de Ejecución (5 min)

### Script para Windows (run.bat)

```batch
@echo off
echo ========================================
echo    Pixel and Bean - Sistema de Gestion
echo ========================================
echo.

REM Verificar Java
java -version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Java no esta instalado o no esta en el PATH
    echo Por favor instale Java 17 o superior
    pause
    exit /b 1
)

REM Verificar JAR
if not exist "PixelAndBean.jar" (
    echo ERROR: No se encuentra PixelAndBean.jar
    echo Asegurese de ejecutar este script desde el directorio correcto
    pause
    exit /b 1
)

REM Verificar configuracion
if not exist "application.properties" (
    echo ADVERTENCIA: No se encuentra application.properties
    echo Se usara configuracion por defecto
    echo.
)

REM Ejecutar aplicacion
echo Iniciando aplicacion...
echo.
java -jar PixelAndBean.jar

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ERROR: La aplicacion termino con errores
    pause
)
```

### Script para Linux/Mac (run.sh)

```bash
#!/bin/bash

echo "========================================"
echo "   Pixel and Bean - Sistema de Gestión"
echo "========================================"
echo ""

# Verificar Java
if ! command -v java &> /dev/null; then
    echo "ERROR: Java no está instalado o no está en el PATH"
    echo "Por favor instale Java 17 o superior"
    exit 1
fi

# Verificar JAR
if [ ! -f "PixelAndBean.jar" ]; then
    echo "ERROR: No se encuentra PixelAndBean.jar"
    echo "Asegúrese de ejecutar este script desde el directorio correcto"
    exit 1
fi

# Verificar configuración
if [ ! -f "application.properties" ]; then
    echo "ADVERTENCIA: No se encuentra application.properties"
    echo "Se usará configuración por defecto"
    echo ""
fi

# Ejecutar aplicación
echo "Iniciando aplicación..."
echo ""
java -jar PixelAndBean.jar

if [ $? -ne 0 ]; then
    echo ""
    echo "ERROR: La aplicación terminó con errores"
    read -p "Presione Enter para continuar..."
fi
```

Dar permisos de ejecución en Linux/Mac:
```bash
chmod +x run.sh
```

---

## ✅ Paso 5: Verificación y Pruebas (9 min)

### Checklist de Verificación

```bash
# 1. Verificar estructura de archivos
PixelAndBean/
├── PixelAndBean.jar             ✓
├── application.properties        ✓
├── run.bat                       ✓
├── run.sh                        ✓
├── lib/
│   └── mysql-connector-j-*.jar  ✓
└── README.md                     ✓

# 2. Verificar contenido del JAR
jar tf PixelAndBean.jar

# Debe incluir:
# - META-INF/MANIFEST.MF
# - cl/cmartinezs/pnb/*.class
# - resources/icons/*.png (si los tienes)
# - application.properties (opcional, puede estar externo)

# 3. Verificar MANIFEST
jar xf PixelAndBean.jar META-INF/MANIFEST.MF
cat META-INF/MANIFEST.MF

# Debe contener:
# - Main-Class: cl.cmartinezs.pnb.PixelAndBean
# - Class-Path: lib/mysql-connector-j-8.2.0.jar
```

### Pruebas de Ejecución

**Prueba 1: Ejecución directa**
```bash
java -jar PixelAndBean.jar
```

**Prueba 2: Con script**
```bash
# Windows
run.bat

# Linux/Mac
./run.sh
```

**Prueba 3: En otro equipo**
1. Copiar carpeta completa a otro equipo
2. Verificar que tenga Java 17+
3. Ejecutar con script
4. Verificar que se conecte a la BD

### Solución de Problemas Comunes

**Error: "No se encuentra la clase principal"**
```bash
# Verificar MANIFEST.MF
jar xf PixelAndBean.jar META-INF/MANIFEST.MF
cat META-INF/MANIFEST.MF

# La clase principal debe ser exacta:
Main-Class: cl.cmartinezs.pnb.PixelAndBean
```

**Error: "ClassNotFoundException: com.mysql.cj.jdbc.Driver"**
```bash
# Verificar que lib/mysql-connector-j-*.jar exista
# Verificar Class-Path en MANIFEST.MF
# Ejecutar desde el directorio que contiene lib/
```

**Error: "No se puede conectar a la BD"**
```bash
# Verificar application.properties
# Verificar que XAMPP esté corriendo
# Verificar credenciales y nombre de BD
```

**Error: "No se encuentran los iconos"**
```bash
# Verificar que /resources/icons/ esté incluido en el JAR
jar tf PixelAndBean.jar | grep icons

# Si no están, agregar al build:
# NetBeans: Agregar resources/ a Source Packages
# Maven: Agregar <resources> en pom.xml
```

---

## 📦 Paso 6: Empaquetar para Distribución (Opcional)

### Crear archivo ZIP de distribución

```bash
# Crear estructura
mkdir PixelAndBean-v1.0.0

# Copiar archivos
cp dist/PixelAndBean.jar PixelAndBean-v1.0.0/
cp application.properties PixelAndBean-v1.0.0/
cp -r dist/lib PixelAndBean-v1.0.0/
cp -r docs PixelAndBean-v1.0.0/
cp README.md PixelAndBean-v1.0.0/
cp run.bat PixelAndBean-v1.0.0/
cp run.sh PixelAndBean-v1.0.0/

# Comprimir
zip -r PixelAndBean-v1.0.0.zip PixelAndBean-v1.0.0/

# O con tar
tar -czf PixelAndBean-v1.0.0.tar.gz PixelAndBean-v1.0.0/
```

---

## ✅ Checklist de Progreso

- [ ] ConfigLoader implementado
- [ ] application.properties externo funciona
- [ ] MANIFEST.MF configurado correctamente
- [ ] JAR generado exitosamente
- [ ] Dependencias incluidas en lib/
- [ ] Scripts de ejecución creados
- [ ] Pruebas en equipo local exitosas
- [ ] Pruebas en otro equipo exitosas
- [ ] Paquete de distribución creado

---

## 🔗 Navegación

- ⬅️ [Anterior: Mejoras UI y Reportes](01-ui-reportes.md)
- ⬅️ [Volver al índice de la clase](00-intro.md)
- ➡️ [Siguiente: Documentación](03-documentacion.md)

---

**Tiempo estimado:** 35 minutos  
**Dificultad:** Media-Alta

