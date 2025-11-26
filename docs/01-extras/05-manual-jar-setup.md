# Configuración manual de JAR — MySQL Connector/J

Este documento complementa la guía técnica de JDBC y proporciona instrucciones detalladas para descargar e incluir manualmente el conector JDBC de MySQL en proyectos Java con NetBeans o IntelliJ IDEA.

## Lista de verificación rápida
1. Descargar el JAR del conector MySQL (oficial o Maven Central).
2. Agregar el JAR al classpath del proyecto en el IDE.
3. Verificar la configuración con una prueba de conexión.
4. (Opcional) Instalar en repositorio local Maven para proyectos gestionados.
5. Compile and run a quick test.
## 1) Descargar MySQL Connector/J
4. Handle module system (if using Java 9+).
### Opción A: Sitio oficial de MySQL
1. Visita: https://dev.mysql.com/downloads/connector/j/
2. Selecciona **Platform Independent** (ZIP).
3. Descarga y descomprime el archivo ZIP.
4. Localiza el JAR: `mysql-connector-j-8.3.0.jar` (o la versión descargada).
(Optional) verify SHA or PGP if provided by the project.
### Opción B: Maven Central (descarga directa)
- URL directa para versión 8.3.0:
  ```
  https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/8.3.0/mysql-connector-j-8.3.0.jar
  ```
- Busca otras versiones en: https://search.maven.org/ → `mysql-connector-j`
(Optional) verify SHA or PGP if provided by the project.
### Opción C: Línea de comandos
```bash
# Crear carpeta para librerías
mkdir -p libs
4. Click OK. NetBeans adds it to the project classpath.
# Descargar con curl
curl -L -o libs/mysql-connector-j-8.3.0.jar \
  "https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/8.3.0/mysql-connector-j-8.3.0.jar"
4. Optionally create a named Library (Project Settings → Libraries) and attach the JAR for reuse.
# O con wget
wget -O libs/mysql-connector-j-8.3.0.jar \
  "https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/8.3.0/mysql-connector-j-8.3.0.jar"
```
## 3) Add JAR in IntelliJ IDEA (non-Maven project)
**Verificación de integridad (opcional):**
```bash
# Descargar checksum
curl -L -o libs/mysql-connector-j-8.3.0.jar.sha1 \
  "https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/8.3.0/mysql-connector-j-8.3.0.jar.sha1"
3. Select "Compile" scope (or as appropriate).
# Verificar
sha1sum libs/mysql-connector-j-8.3.0.jar
cat libs/mysql-connector-j-8.3.0.jar.sha1
# Los hash deben coincidir
```
Notes:
## 2) Configuración en NetBeans
Command:
### Para proyectos Java SE o Ant
1. **Clic derecho** en el proyecto → **Properties**.
2. Selecciona **Libraries** en el panel izquierdo.
3. En la pestaña **Compile**, haz clic en **Add JAR/Folder**.
4. Navega y selecciona `mysql-connector-j-8.3.0.jar`.
5. Haz clic en **OK** para aplicar.

**Verificación:**
- Expande **Libraries** en el árbol del proyecto.
- Deberías ver el JAR listado bajo "Compile-time Libraries".

### Para proyectos Maven
**No agregues el JAR manualmente.** En su lugar:
1. Abre `pom.xml`.
2. Agrega la dependencia en la sección `<dependencies>`:
```xml
<dependency>
    <groupId>com.mysql</groupId>
    <artifactId>mysql-connector-j</artifactId>
    <version>8.3.0</version>
</dependency>
```
3. NetBeans sincronizará automáticamente desde Maven Central.

**Excepción:** Si necesitas un JAR local modificado, instálalo en el repo local (ver sección 4).

## 3) Configuración en IntelliJ IDEA

### Para proyectos Java estándar
1. Menú **File** → **Project Structure** (`Ctrl+Alt+Shift+S` / `Cmd+;`).
2. Ve a **Modules** → selecciona tu módulo → pestaña **Dependencies**.
3. Haz clic en **+** → **JARs or directories**.
4. Selecciona `mysql-connector-j-8.3.0.jar`.
5. Configura **Scope** como **Compile**.
6. Haz clic en **OK**.

### Opción: Biblioteca global reutilizable
1. En **Project Structure** → **Libraries**.
2. Haz clic en **+** → **Java**.
3. Selecciona el JAR y asigna un nombre (ej: `MySQL Connector 8.3`).
4. En **Modules** → **Dependencies**, agrega la biblioteca creada.
5. Ventaja: reutilizable en múltiples proyectos.

### Para proyectos Maven/Gradle
**No agregues JARs manualmente.** Edita `pom.xml` o `build.gradle`:

**Maven:**
  -Dfile=/path/to/mylib-1.2.3.jar \
  -DgroupId=com.example \
    <groupId>com.mysql</groupId>
    <artifactId>mysql-connector-j</artifactId>
    <version>8.3.0</version>
- Create `libs/` in project and place JAR there.
  <groupId>com.example</groupId>
  <artifactId>mylib</artifactId>
**Gradle:**
  - `mvn install:install-file -Dfile=libs/mylib-1.2.3.jar -DgroupId=com.example -DartifactId=mylib -Dversion=1.2.3 -Dpackaging=jar`

    implementation 'com.mysql:mysql-connector-j:8.3.0'



IntelliJ sincronizará automáticamente al recargar el proyecto.

## 4) Instalar en repositorio local Maven

Útil cuando tienes un JAR local y trabajas con proyectos Maven/Gradle:

```bash
mvn install:install-file \
  -Dfile=libs/mysql-connector-j-8.3.0.jar \
  -DgroupId=com.mysql \
  -DartifactId=mysql-connector-j \
  -Dversion=8.3.0 \
  -Dpackaging=jar
```

Luego, agrega la dependencia normal en tu `pom.xml` o `build.gradle`.

**Para Gradle con carpeta libs:**

// build.gradle
dependencies {
    implementation files('libs/mysql-connector-j-8.3.0.jar')
}
