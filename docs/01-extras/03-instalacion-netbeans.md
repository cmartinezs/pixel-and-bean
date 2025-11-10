# 🔧 Instalación de NetBeans IDE 26

**Propósito:** Guía completa para instalar Apache NetBeans IDE 26, el entorno de desarrollo principal para diseño visual de interfaces Swing.

> 💡 **Nota:** NetBeans incluye el mejor editor visual (Matisse GUI Builder) para crear interfaces gráficas en Java Swing. Es la herramienta principal que usaremos en el curso.

---

## 📚 Tabla de Contenidos

<!-- TOC -->
* [🔧 Instalación de NetBeans IDE 26](#-instalación-de-netbeans-ide-26)
  * [📚 Tabla de Contenidos](#-tabla-de-contenidos)
  * [🎯 ¿Por qué NetBeans?](#-por-qué-netbeans)
  * [📋 Pre-requisitos](#-pre-requisitos)
  * [🪟 Instalación en Windows](#-instalación-en-windows)
  * [🍎 Instalación en macOS](#-instalación-en-macos)
  * [🐧 Instalación en Linux](#-instalación-en-linux)
  * [⚙️ Configuración Inicial](#-configuración-inicial)
  * [🔌 Plugins Recomendados](#-plugins-recomendados)
  * [✅ Verificación de la Instalación](#-verificación-de-la-instalación)
  * [⚠️ Problemas Comunes](#-problemas-comunes)
  * [🔗 Recursos Adicionales](#-recursos-adicionales)
<!-- TOC -->

---

## 🎯 ¿Por qué NetBeans?

NetBeans es ideal para este curso por varias razones:

### Ventajas principales:
- ✅ **Matisse GUI Builder:** El mejor editor visual para Swing
- ✅ **Gratuito y Open Source:** Apache License 2.0
- ✅ **Integración completa:** Git, Maven, Ant incluidos
- ✅ **GroupLayout automático:** Genera layouts responsivos automáticamente
- ✅ **Code completion:** Autocompletado inteligente
- ✅ **Refactoring tools:** Herramientas de refactorización incluidas

### ¿Cuándo usaremos NetBeans?
- 🎨 Diseño de interfaces gráficas (JFrame, JPanel, JDialog)
- 📋 Crear formularios con el editor visual
- 🖱️ Conectar eventos de forma visual
- 🎯 Prototipado rápido de UI

---

## 📋 Pre-requisitos

Antes de instalar NetBeans, asegúrate de tener:

✅ **Java JDK 17 o superior instalado**
- Si no lo tienes, sigue la guía: **[02-instalacion-java.md](02-instalacion-java.md)**

✅ **Verificar que Java esté configurado:**
```bash
java -version
javac -version
```

---

## 🪟 Instalación en Windows

### Paso 1: Descargar NetBeans

1. Visita [netbeans.apache.org/download](https://netbeans.apache.org/download/index.html)
2. Descarga **Apache NetBeans 26** (o la última versión disponible)
3. Selecciona la versión que incluye **Java SE** o **All**
4. Descarga el instalador **Windows x64 (.exe)**

### Paso 2: Ejecutar el Instalador

1. **Ejecuta el archivo descargado** (ej: `Apache-NetBeans-26-bin-windows-x64.exe`)
2. Si aparece el control de cuentas de usuario (UAC), haz clic en **Sí**
3. **Bienvenida:** Clic en **Next**
4. **Licencia:** Acepta los términos → **I accept** → **Next**
5. **Ubicación de instalación:** 
   ```
   C:\Program Files\NetBeans-26
   ```
   > 💡 Puedes cambiar la ruta, pero se recomienda dejar la predeterminada
6. **Ubicación del JDK:** 
   - NetBeans detectará automáticamente tu JDK
   - Verifica que muestre tu JDK 17
   - Si no lo detecta, haz clic en **Browse** y selecciona la carpeta del JDK
7. **Opciones de instalación:**
   - ✅ Check for updates (recomendado)
   - Selecciona **Full installation** o **Complete**
8. Clic en **Install**
9. Espera a que termine la instalación (puede tomar 5-10 minutos)
10. Clic en **Finish**

### Paso 3: Crear acceso directo (Opcional)

Si el instalador no creó un acceso directo en el escritorio:
1. Ve a `C:\Program Files\NetBeans-26\netbeans\bin`
2. Clic derecho en `netbeans64.exe`
3. **Enviar a → Escritorio (crear acceso directo)**

### Paso 4: Primera ejecución

1. Abre NetBeans desde el acceso directo
2. La primera vez puede tardar un poco en cargar
3. Espera a que cargue completamente

---

## 🍎 Instalación en macOS

### Método 1: Descarga directa (Recomendado)

#### Paso 1: Descargar NetBeans

1. Visita [netbeans.apache.org/download](https://netbeans.apache.org/download/index.html)
2. Descarga **Apache NetBeans 26**
3. Selecciona la versión para **macOS (.dmg)**

#### Paso 2: Instalar desde DMG

1. Abre el archivo `.dmg` descargado
2. Arrastra el ícono de **Apache NetBeans** a la carpeta **Applications**
3. Espera a que termine de copiar
4. Expulsa el volumen del instalador

#### Paso 3: Primera ejecución

1. Abre **Finder** → **Applications**
2. Localiza **Apache NetBeans**
3. **Clic derecho** → **Abrir** (la primera vez)
4. Si aparece un aviso de seguridad:
   - Clic en **Abrir** para confirmar
   - macOS permitirá ejecutarlo

> ⚠️ **Importante:** En la primera ejecución, usa clic derecho → Abrir para evitar el bloqueo de aplicaciones no verificadas.

### Método 2: Homebrew

```bash
# Instalar NetBeans con Homebrew Cask
brew install --cask netbeans

# Verificar instalación
ls /Applications/ | grep -i netbeans
```

---

## 🐧 Instalación en Linux

### Ubuntu / Debian / Linux Mint

#### Opción 1: Desde el instalador shell (Recomendado)

```bash
# Descargar el instalador
wget https://dlcdn.apache.org/netbeans/netbeans-installers/26/Apache-NetBeans-26-bin-linux-x64.sh

# Dar permisos de ejecución
chmod +x Apache-NetBeans-26-bin-linux-x64.sh

# Ejecutar el instalador
sudo ./Apache-NetBeans-26-bin-linux-x64.sh
```

Sigue el asistente de instalación:
1. Acepta la licencia
2. Selecciona la ubicación (por defecto: `/opt/netbeans`)
3. Verifica la detección del JDK
4. Confirma la instalación

#### Opción 2: Snap

```bash
# Instalar desde Snap Store
sudo snap install netbeans --classic

# Verificar instalación
netbeans --version
```

#### Opción 3: Flatpak

```bash
# Agregar repositorio de Flathub (si no lo tienes)
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Instalar NetBeans
flatpak install flathub org.apache.netbeans

# Ejecutar
flatpak run org.apache.netbeans
```

### Fedora / RHEL / CentOS

```bash
# Descargar el instalador
wget https://dlcdn.apache.org/netbeans/netbeans-installers/26/Apache-NetBeans-26-bin-linux-x64.sh

# Dar permisos y ejecutar
chmod +x Apache-NetBeans-26-bin-linux-x64.sh
sudo ./Apache-NetBeans-26-bin-linux-x64.sh
```

### Arch Linux

```bash
# Desde AUR (requiere yay o paru)
yay -S netbeans

# O desde repositorios oficiales
sudo pacman -S netbeans
```

### Crear lanzador de escritorio (si no se creó automáticamente)

Crea el archivo `~/.local/share/applications/netbeans.desktop`:

```ini
[Desktop Entry]
Name=Apache NetBeans IDE
Comment=Integrated Development Environment
Exec=/opt/netbeans/bin/netbeans
Icon=/opt/netbeans/nb/netbeans.png
Terminal=false
Type=Application
Categories=Development;IDE;
```

---

## ⚙️ Configuración Inicial

### 1. Verificar la plataforma Java

Al abrir NetBeans por primera vez:

1. Ve a **Tools → Java Platforms** (o **NetBeans → Preferences** en macOS)
2. Deberías ver tu **JDK 17** listado
3. Si **NO aparece:**
   - Clic en **Add Platform**
   - Selecciona **Java Standard Edition**
   - Navega a la carpeta de tu JDK (ej: `C:\Program Files\Java\jdk-17`)
   - Clic en **Next** → **Finish**

### 2. Configurar opciones generales

**Tools → Options** (o **NetBeans → Preferences** en macOS)

#### Pestaña **General:**
- ✅ **Check for updates automatically:** Activado
- ✅ **Show Tips on Startup:** Desactivado (opcional)
- **HTTP Proxy:** Configura si usas proxy

#### Pestaña **Editor:**
- **Font:** Cambia si lo deseas (recomendado: Consolas, Monaco, JetBrains Mono)
- **Tab Size:** Deja en 4
- ✅ **Expand Tabs to Spaces:** Activado

#### Pestaña **Fonts & Colors:**
- Selecciona el tema que prefieras (Light/Dark)
- **Profile:** NetBeans (por defecto)

### 3. Configurar Git

**Tools → Options → Team → Versioning → Git:**
- **Git Executable:** NetBeans lo detecta automáticamente
- Si no lo encuentra:
  - **Windows:** `C:\Program Files\Git\bin\git.exe`
  - **macOS/Linux:** `/usr/bin/git`

---

## 🔌 Plugins Recomendados

### Instalar plugins:

1. **Tools → Plugins**
2. Pestaña **Available Plugins**
3. Busca e instala:

#### Esenciales para el curso:
- ✅ **GitHub** - Integración con GitHub (si no está pre-instalado)
- ✅ **Markdown Support** - Para leer documentación del proyecto

#### Opcionales pero útiles:
- 🔵 **Color Codes Preview** - Muestra colores en código
- 🔵 **QuickOpener** - Abre archivos rápidamente
- 🔵 **Code Outline** - Vista de estructura de código

### Cómo instalar:
1. Marca el checkbox del plugin
2. Clic en **Install**
3. Acepta la licencia
4. **Restart IDE** cuando termine

---

## ✅ Verificación de la Instalación

### Prueba 1: Crear un proyecto de ejemplo

1. **File → New Project**
2. Categoría: **Java with Ant**
3. Proyecto: **Java Application**
4. **Next**
5. **Project Name:** `TestNetBeans`
6. **Project Location:** Selecciona una carpeta
7. ✅ **Create Main Class:** Activado
8. **Finish**

**Si el proyecto se crea sin errores, NetBeans está correctamente instalado.**

### Prueba 2: Editor visual de GUI

1. En el proyecto creado, clic derecho sobre el paquete
2. **New → JFrame Form**
3. **Class Name:** `TestFrame`
4. **Finish**

**Si se abre el editor visual (Design), todo está perfecto.**

### Prueba 3: Ejecutar el proyecto

1. Presiona **F6** o clic en el botón ▶️ **Run Project**
2. Debe compilar y ejecutar sin errores

✅ **Si todo funciona, NetBeans está listo para usar!**

---

## ⚠️ Problemas Comunes

### 1. "Cannot find java" al iniciar NetBeans

**Causa:** NetBeans no encuentra el JDK.

**Solución:**
1. Edita el archivo de configuración:
   - **Windows:** `C:\Program Files\NetBeans-26\netbeans\etc\netbeans.conf`
   - **macOS/Linux:** `/Applications/NetBeans/NetBeans.app/Contents/Resources/NetBeans/netbeans/etc/netbeans.conf`

2. Busca la línea `netbeans_jdkhome=`
3. Descoméntala (quita el `#`) y agrega la ruta de tu JDK:
   ```
   netbeans_jdkhome="C:\Program Files\Java\jdk-17"
   ```
4. Guarda y reinicia NetBeans

### 2. NetBeans muy lento al abrir

**Causa:** Poca memoria asignada o muchos plugins.

**Solución:**
1. Edita el mismo archivo `netbeans.conf`
2. Busca la línea `netbeans_default_options=`
3. Aumenta la memoria:
   ```
   netbeans_default_options="-J-Xms256m -J-Xmx2048m -J-XX:+UseG1GC"
   ```
4. Ajusta según tu RAM disponible (2048m = 2GB)

### 3. El editor visual (Design) no funciona

**Causa:** Falta el plugin de GUI Builder.

**Solución:**
1. **Tools → Plugins → Installed**
2. Busca **GUI Builder**
3. Si no está, ve a **Available Plugins** e instálalo
4. Reinicia NetBeans

### 4. "Permission denied" al instalar en Linux

**Solución:**
```bash
# Ejecuta el instalador con sudo
sudo ./Apache-NetBeans-26-bin-linux-x64.sh
```

### 5. NetBeans no se abre en macOS

**Causa:** Bloqueo de seguridad de aplicaciones no verificadas.

**Solución:**
1. **System Preferences → Security & Privacy**
2. Pestaña **General**
3. Verás un mensaje sobre NetBeans
4. Clic en **Open Anyway**

### 6. Error "Java Platform is invalid"

**Solución:**
1. **Tools → Java Platforms**
2. Selecciona el JDK que muestra error
3. Clic en **Remove**
4. Clic en **Add Platform**
5. Selecciona la carpeta correcta de tu JDK

---

## 🔗 Recursos Adicionales

### Documentación Oficial
- [Apache NetBeans Website](https://netbeans.apache.org/)
- [NetBeans Documentation](https://netbeans.apache.org/kb/)
- [GUI Builder Tutorial](https://netbeans.apache.org/tutorial/main/kb/docs/java/quickstart-gui/)

### Tutoriales
- [NetBeans Swing GUI Builder](https://netbeans.apache.org/tutorial/main/kb/docs/java/gui-functionality/)
- [Creating a GUI Application](https://netbeans.apache.org/tutorial/main/kb/docs/java/gui-image-display/)

### Videos
- [NetBeans IDE Tutorial - YouTube](https://www.youtube.com/results?search_query=netbeans+tutorial)
- [Java Swing NetBeans GUI](https://www.youtube.com/results?search_query=netbeans+swing+gui)

### Comunidad
- [Apache NetBeans Mailing Lists](https://netbeans.apache.org/community/mailing-lists.html)
- [NetBeans GitHub](https://github.com/apache/netbeans)
- [Stack Overflow - NetBeans Tag](https://stackoverflow.com/questions/tagged/netbeans)

---

## 🎯 Siguiente Paso

Una vez que NetBeans esté instalado correctamente, puedes:

➡️ **[03-instalacion-intellij.md](03-instalacion-intellij.md)** - Instalación de IntelliJ IDEA (opcional)

O vuelve al índice:

⬅️ **[Índice de Extras](00-index.md)**

O empieza con el curso:

🎓 **[Clase 1 - Introducción a GUI](../00-lessons/01-gui-components/00-intro.md)**

---

> 💡 **Consejo:** Familiarízate con NetBeans antes de la primera clase. Crea un proyecto de prueba y explora el editor visual.

> 🎨 **Tip de diseño:** El editor visual (Matisse) usa GroupLayout por defecto, que es perfecto para formularios responsivos.

---

**Última actualización:** Noviembre 2025  
**Versión recomendada:** Apache NetBeans 26 (o superior)

