# ☕ Instalación de Java 17+ (JDK)

**Propósito:** Guía completa para instalar Java Development Kit 17 o superior en cualquier sistema operativo.

> 💡 **Nota:** Java 17 es una versión LTS (Long Term Support), lo que significa que recibirá actualizaciones de seguridad y soporte extendido. Es la versión recomendada para este curso.

---

## 📚 Tabla de Contenidos

<!-- TOC -->
* [☕ Instalación de Java 17+ (JDK)](#-instalación-de-java-17-jdk)
  * [📚 Tabla de Contenidos](#-tabla-de-contenidos)
  * [🎯 ¿Qué es el JDK?](#-qué-es-el-jdk)
  * [🪟 Instalación en Windows](#-instalación-en-windows)
  * [🍎 Instalación en macOS](#-instalación-en-macos)
  * [🐧 Instalación en Linux](#-instalación-en-linux)
  * [✅ Verificación de la Instalación](#-verificación-de-la-instalación)
  * [⚠️ Problemas Comunes](#-problemas-comunes)
  * [🔗 Recursos Adicionales](#-recursos-adicionales)
<!-- TOC -->

---

## 🎯 ¿Qué es el JDK?

**JDK (Java Development Kit)** es el kit de desarrollo necesario para:
- ✅ Compilar código Java (`javac`)
- ✅ Ejecutar aplicaciones Java (`java`)
- ✅ Depurar aplicaciones
- ✅ Crear documentación (Javadoc)
- ✅ Empaquetar aplicaciones (JAR)

**JDK vs JRE:**
- **JDK:** Incluye herramientas de desarrollo + JRE
- **JRE (Java Runtime Environment):** Solo para ejecutar aplicaciones Java

> Para este curso necesitas el **JDK completo**, no solo el JRE.

---

## 🪟 Instalación en Windows

### Paso 1: Descargar el JDK

Tienes dos opciones principales:

**Opción 1: Oracle JDK (oficial)**
- Visita [oracle.com/java/technologies/downloads](https://www.oracle.com/java/technologies/downloads/)
- Selecciona **Java 17 (LTS)** o superior
- Descarga **Windows x64 Installer (.exe)**

**Opción 2: OpenJDK (código abierto, recomendado)**
- Visita [adoptium.net](https://adoptium.net/)
- Selecciona:
  - **Version:** 17 (LTS)
  - **Operating System:** Windows
  - **Architecture:** x64
- Descarga el instalador **.msi**

### Paso 2: Ejecutar el Instalador

1. **Ejecuta el archivo descargado** (ej: `OpenJDK17U-jdk_x64_windows.msi`)
2. Acepta los términos y condiciones
3. **Ubicación de instalación recomendada:**
   ```
   C:\Program Files\Java\jdk-17
   ```
   > 💡 Anota esta ruta, la necesitarás para configurar variables de entorno
4. Deja marcadas todas las opciones por defecto
5. Clic en **Install** y espera a que termine

### Paso 3: Configurar Variables de Entorno

Este paso es **crucial** para que Windows reconozca los comandos de Java.

#### 3.1 Abrir Variables de Entorno:

**Método 1 (Windows 10/11):**
1. Presiona `Windows + X`
2. Selecciona **Sistema**
3. Clic en **Configuración avanzada del sistema** (panel derecho)
4. Clic en **Variables de entorno**

**Método 2 (Cualquier Windows):**
1. Presiona `Windows + R`
2. Escribe: `sysdm.cpl`
3. Pestaña **Opciones avanzadas**
4. Clic en **Variables de entorno**

#### 3.2 Crear la variable JAVA_HOME:

1. En la sección **Variables del sistema** (parte inferior), clic en **Nueva**
2. **Nombre de la variable:** `JAVA_HOME`
3. **Valor de la variable:** Ruta donde instalaste Java
   ```
   C:\Program Files\Java\jdk-17
   ```
   > ⚠️ Ajusta la ruta si instalaste en otra ubicación
4. Clic en **Aceptar**

#### 3.3 Agregar Java al PATH:

1. En **Variables del sistema**, busca la variable `Path`
2. Selecciónala y clic en **Editar**
3. Clic en **Nuevo**
4. Agrega: `%JAVA_HOME%\bin`
5. Clic en **Aceptar** en todas las ventanas

### Paso 4: Verificar la Instalación

1. Abre una **nueva** ventana de **CMD** o **PowerShell**
   > ⚠️ Importante: Debe ser una ventana nueva para que cargue las variables de entorno

2. Ejecuta:
   ```bash
   java -version
   ```
   
   **Output esperado:**
   ```
   openjdk version "17.0.9" 2023-10-17
   OpenJDK Runtime Environment Temurin-17.0.9+9 (build 17.0.9+9)
   OpenJDK 64-Bit Server VM Temurin-17.0.9+9 (build 17.0.9+9, mixed mode, sharing)
   ```

3. Verifica el compilador:
   ```bash
   javac -version
   ```
   
   **Output esperado:**
   ```
   javac 17.0.9
   ```

4. Verifica JAVA_HOME:
   ```bash
   echo %JAVA_HOME%
   ```
   
   **Output esperado:**
   ```
   C:\Program Files\Java\jdk-17
   ```

✅ **Si todos los comandos funcionan correctamente, ¡Java está instalado!**

---

## 🍎 Instalación en macOS

### Opción 1: Con Homebrew (Recomendado)

Homebrew es un gestor de paquetes para macOS que facilita la instalación y actualización.

#### Paso 1: Instalar Homebrew (si no lo tienes)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

#### Paso 2: Instalar OpenJDK 17

```bash
# Actualizar Homebrew
brew update

# Instalar OpenJDK 17
brew install openjdk@17
```

#### Paso 3: Configurar el enlace simbólico

```bash
# Para que el sistema reconozca el JDK
sudo ln -sfn /opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-17.jdk
```

#### Paso 4: Configurar variables de entorno

Edita tu archivo de configuración de shell:

**Para zsh (por defecto en macOS Catalina+):**
```bash
echo 'export JAVA_HOME=/opt/homebrew/opt/openjdk@17' >> ~/.zshrc
echo 'export PATH="$JAVA_HOME/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

**Para bash:**
```bash
echo 'export JAVA_HOME=/opt/homebrew/opt/openjdk@17' >> ~/.bash_profile
echo 'export PATH="$JAVA_HOME/bin:$PATH"' >> ~/.bash_profile
source ~/.bash_profile
```

### Opción 2: Instalador Manual

1. Descarga el instalador **.dmg** desde [adoptium.net](https://adoptium.net/)
2. Abre el archivo descargado
3. Arrastra el ícono de Java a **Aplicaciones**
4. Sigue el asistente de instalación

### Verificar la Instalación

```bash
java -version
javac -version
echo $JAVA_HOME
```

---

## 🐧 Instalación en Linux

### Ubuntu / Debian / Linux Mint

#### Opción 1: Desde repositorios oficiales (más fácil)

```bash
# Actualizar lista de paquetes
sudo apt update

# Instalar OpenJDK 17
sudo apt install openjdk-17-jdk -y

# Verificar instalación
java -version
javac -version
```

#### Opción 2: Instalar versión específica de Adoptium

```bash
# Agregar repositorio de Adoptium
wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | sudo apt-key add -
echo "deb https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | sudo tee /etc/apt/sources.list.d/adoptium.list

# Actualizar e instalar
sudo apt update
sudo apt install temurin-17-jdk -y
```

#### Configurar JAVA_HOME

```bash
# Encontrar la ruta de instalación
sudo update-alternatives --config java

# La ruta será algo como: /usr/lib/jvm/java-17-openjdk-amd64

# Agregar al .bashrc o .zshrc
echo 'export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64' >> ~/.bashrc
echo 'export PATH=$PATH:$JAVA_HOME/bin' >> ~/.bashrc
source ~/.bashrc
```

### Fedora / RHEL / CentOS

```bash
# Instalar OpenJDK 17
sudo dnf install java-17-openjdk-devel -y

# Configurar alternativas
sudo alternatives --config java

# Configurar JAVA_HOME
echo 'export JAVA_HOME=/usr/lib/jvm/java-17-openjdk' >> ~/.bashrc
echo 'export PATH=$PATH:$JAVA_HOME/bin' >> ~/.bashrc
source ~/.bashrc
```

### Arch Linux

```bash
# Instalar OpenJDK 17
sudo pacman -S jdk17-openjdk

# Configurar por defecto
sudo archlinux-java set java-17-openjdk

# Verificar
archlinux-java status
```

---

## ✅ Verificación de la Instalación

Después de instalar en cualquier sistema operativo, ejecuta estos comandos:

### 1. Verificar la versión de Java

```bash
java -version
```

**Output esperado (puede variar ligeramente):**
```
openjdk version "17.0.9" 2023-10-17
OpenJDK Runtime Environment (build 17.0.9+9)
OpenJDK 64-Bit Server VM (build 17.0.9+9, mixed mode, sharing)
```

### 2. Verificar el compilador

```bash
javac -version
```

**Output esperado:**
```
javac 17.0.9
```

### 3. Verificar JAVA_HOME

**Windows:**
```bash
echo %JAVA_HOME%
```

**macOS/Linux:**
```bash
echo $JAVA_HOME
```

**Output esperado:** La ruta donde instalaste Java

### 4. Compilar y ejecutar un programa de prueba

Crea un archivo `Test.java`:

```java
public class Test {
    public static void main(String[] args) {
        System.out.println("Java está funcionando correctamente!");
        System.out.println("Versión: " + System.getProperty("java.version"));
    }
}
```

Compila y ejecuta:

```bash
javac Test.java
java Test
```

**Output esperado:**
```
Java está funcionando correctamente!
Versión: 17.0.9
```

✅ **Si ves este mensaje, ¡todo está perfecto!**

---

## ⚠️ Problemas Comunes

### 1. "java no se reconoce como comando" (Windows)

**Causa:** Las variables de entorno no están configuradas o no se han cargado.

**Solución:**
1. Verifica que `JAVA_HOME` esté creado correctamente
2. Verifica que `%JAVA_HOME%\bin` esté en el PATH
3. **Cierra y abre una nueva terminal** (crucial)
4. Si persiste, reinicia el computador

### 2. "Multiple Java versions found" (macOS/Linux)

**Causa:** Tienes varias versiones de Java instaladas.

**Solución en macOS:**
```bash
# Ver versiones instaladas
/usr/libexec/java_home -V

# Configurar la versión 17 por defecto
export JAVA_HOME=$(/usr/libexec/java_home -v 17)
```

**Solución en Linux (Ubuntu):**
```bash
# Ver versiones instaladas
sudo update-alternatives --config java

# Seleccionar la versión 17
```

### 3. "Permission denied" al crear JAVA_HOME (macOS/Linux)

**Solución:**
```bash
# Editar con permisos de superusuario
sudo nano ~/.bashrc  # o ~/.zshrc

# O cambiar permisos del archivo
chmod 644 ~/.bashrc
```

### 4. Variables de entorno no se cargan automáticamente

**Windows:**
- Asegúrate de cerrar **todas** las ventanas de terminal antes de abrir una nueva
- Como última opción, reinicia el computador

**macOS/Linux:**
- Verifica que agregaste las variables al archivo correcto (`.bashrc`, `.zshrc`, `.bash_profile`)
- Ejecuta `source ~/.bashrc` (o el archivo correspondiente)
- Cierra y abre la terminal

### 5. "The JAVA_HOME environment variable is not defined correctly"

**Causa:** La ruta en JAVA_HOME no apunta a una instalación válida de Java.

**Solución:**
1. Verifica la ruta con `echo $JAVA_HOME` o `echo %JAVA_HOME%`
2. Asegúrate de que la carpeta contenga las subcarpetas `bin`, `lib`, etc.
3. Si la ruta es incorrecta, configúrala nuevamente siguiendo los pasos anteriores

---

## 🔗 Recursos Adicionales

### Documentación Oficial
- [Oracle Java SE Documentation](https://docs.oracle.com/en/java/javase/17/)
- [OpenJDK Documentation](https://openjdk.org/projects/jdk/17/)
- [Adoptium Temurin](https://adoptium.net/)

### Tutoriales
- [Java Tutorial - Oracle](https://docs.oracle.com/javase/tutorial/)
- [Learn Java - W3Schools](https://www.w3schools.com/java/)

### Herramientas útiles
- [SDKMAN! (gestor de versiones Java para Linux/macOS)](https://sdkman.io/)
- [jEnv (cambiar entre versiones de Java)](https://www.jenv.be/)

---

## 🎯 Siguiente Paso

Una vez que Java esté instalado correctamente, continúa con:

➡️ **[02-instalacion-netbeans.md](02-instalacion-netbeans.md)** - Instalación de NetBeans IDE

O vuelve al índice:

⬅️ **[Índice de Extras](00-index.md)**

---

> 💡 **Consejo:** Guarda la ruta de instalación de Java en un lugar seguro. La necesitarás para configurar otros IDEs y herramientas.

---

**Última actualización:** Noviembre 2025  
**Versión de Java recomendada:** 17 (LTS) o superior

