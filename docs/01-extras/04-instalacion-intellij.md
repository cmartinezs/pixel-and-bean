# 💡 Instalación de IntelliJ IDEA Community Edition

**Propósito:** Guía completa para instalar IntelliJ IDEA Community Edition, el IDE opcional pero recomendado para lógica de negocio y refactorización avanzada.

> 💡 **Nota:** IntelliJ IDEA es **opcional** en este curso. NetBeans es suficiente, pero IntelliJ ofrece herramientas superiores de refactorización y análisis de código que pueden ser útiles desde la Clase 3 en adelante.

---

## 📚 Tabla de Contenidos

<!-- TOC -->
* [💡 Instalación de IntelliJ IDEA Community Edition](#-instalación-de-intellij-idea-community-edition)
  * [📚 Tabla de Contenidos](#-tabla-de-contenidos)
  * [🎯 ¿Por qué IntelliJ IDEA?](#-por-qué-intellij-idea)
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

## 🎯 ¿Por qué IntelliJ IDEA?

IntelliJ IDEA complementa a NetBeans con herramientas avanzadas:

### Ventajas principales:
- ✅ **Refactoring superior:** Herramientas de refactorización más potentes
- ✅ **Análisis de código:** Detección inteligente de problemas
- ✅ **Autocompletado avanzado:** IntelliSense más preciso
- ✅ **Depuración potente:** Debugger con evaluación de expresiones
- ✅ **Integración Git:** Manejo visual excelente de Git
- ✅ **Base de datos:** Database tools integrados (útil para Clase 4+)

### ¿Cuándo usaremos IntelliJ?
- 🔧 Escribir lógica de negocio (Controladores, Servicios)
- 🗃️ Trabajar con DAOs y JDBC (Clase 4+)
- 🔄 Refactorización a MVC (Clase 3)
- 🐛 Depuración avanzada de problemas complejos

### NetBeans vs IntelliJ

| Característica | NetBeans | IntelliJ IDEA |
|----------------|----------|---------------|
| **Editor Visual Swing** | ⭐⭐⭐⭐⭐ | ⭐ |
| **Refactoring** | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| **Autocompletado** | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| **Depuración** | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| **Database Tools** | ⭐⭐ | ⭐⭐⭐⭐⭐ |
| **Facilidad de uso** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ |

**Estrategia recomendada:**
- 🎨 **NetBeans:** Para diseñar interfaces gráficas
- 💻 **IntelliJ:** Para escribir lógica y refactorización

---

## 📋 Pre-requisitos

Antes de instalar IntelliJ IDEA, asegúrate de tener:

✅ **Java JDK 17 o superior instalado**
- Si no lo tienes, sigue la guía: **[02-instalacion-java.md](02-instalacion-java.md)**

✅ **Verificar que Java esté configurado:**
```bash
java -version
javac -version
```

---

## 🪟 Instalación en Windows

### Paso 1: Descargar IntelliJ IDEA

1. Visita [jetbrains.com/idea/download](https://www.jetbrains.com/idea/download/)
2. **Importante:** Descarga **IntelliJ IDEA Community Edition** (gratuita)
   - ⚠️ **NO** descargues la versión Ultimate (es de pago)
3. Selecciona **Windows (.exe)**
4. Espera a que termine la descarga

### Paso 2: Ejecutar el Instalador

1. **Ejecuta el archivo descargado** (ej: `ideaIC-2024.3.exe`)
2. Si aparece el control de cuentas de usuario (UAC), haz clic en **Sí**
3. **Bienvenida:** Clic en **Next**
4. **Ubicación de instalación:**
   ```
   C:\Program Files\JetBrains\IntelliJ IDEA Community Edition 2024.3
   ```
5. **Opciones de instalación (marca estas):**
   - ✅ **Create Desktop Shortcut** (64-bit launcher)
   - ✅ **Update PATH variable** (restart needed)
   - ✅ **Add "Open Folder as Project"**
   - ✅ **.java** - Open files with extension .java using IntelliJ IDEA
   - ✅ **Update context menu** - Add "Open Folder as Project"
   - ⬜ **.groovy**, **.kt**, **.kts** (opcional)
6. **Start Menu Folder:** Deja por defecto
7. Clic en **Install**
8. Espera a que termine (3-5 minutos)
9. ✅ **Run IntelliJ IDEA Community Edition**
10. Clic en **Finish**
11. **Reinicia el computador** si actualizaste el PATH

### Paso 3: Primera ejecución

IntelliJ se abrirá automáticamente después de instalar.

---

## 🍎 Instalación en macOS

### Método 1: Descarga directa (Recomendado)

#### Paso 1: Descargar IntelliJ IDEA

1. Visita [jetbrains.com/idea/download](https://www.jetbrains.com/idea/download/)
2. Descarga **IntelliJ IDEA Community Edition**
3. Selecciona **macOS (.dmg)** - Compatible con Apple Silicon y Intel

#### Paso 2: Instalar desde DMG

1. Abre el archivo `.dmg` descargado
2. Arrastra el ícono de **IntelliJ IDEA CE** a la carpeta **Applications**
3. Espera a que termine de copiar
4. Expulsa el volumen del instalador

#### Paso 3: Primera ejecución

1. Abre **Finder** → **Applications**
2. Localiza **IntelliJ IDEA CE**
3. **Clic derecho** → **Abrir** (la primera vez)
4. Si aparece un aviso de seguridad:
   - Clic en **Abrir** para confirmar

> ⚠️ **Importante:** En macOS, usa clic derecho → Abrir la primera vez para evitar el bloqueo de seguridad.

### Método 2: Homebrew

```bash
# Instalar IntelliJ IDEA Community con Homebrew Cask
brew install --cask intellij-idea-ce

# Verificar instalación
ls /Applications/ | grep -i "IntelliJ IDEA"
```

### Método 3: JetBrains Toolbox (Recomendado si usas múltiples IDEs de JetBrains)

```bash
# Instalar JetBrains Toolbox
brew install --cask jetbrains-toolbox

# Abre Toolbox y desde ahí instala IntelliJ IDEA CE
```

---

## 🐧 Instalación en Linux

### Ubuntu / Debian / Linux Mint

#### Opción 1: Snap (Más fácil, recomendado)

```bash
# Instalar IntelliJ IDEA Community desde Snap
sudo snap install intellij-idea-community --classic

# Verificar instalación
intellij-idea-community --version

# Ejecutar
intellij-idea-community
```

#### Opción 2: Descarga manual (Más control)

```bash
# Descargar el archivo .tar.gz
wget https://download.jetbrains.com/idea/ideaIC-2024.3.tar.gz

# Extraer en /opt
sudo tar -xzf ideaIC-2024.3.tar.gz -C /opt/

# Renombrar para facilitar actualizaciones
sudo mv /opt/idea-IC-* /opt/intellij-idea-community

# Crear enlace simbólico
sudo ln -s /opt/intellij-idea-community/bin/idea.sh /usr/local/bin/idea

# Ejecutar
idea
```

#### Opción 3: Flatpak

```bash
# Agregar repositorio de Flathub (si no lo tienes)
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Instalar IntelliJ IDEA Community
flatpak install flathub com.jetbrains.IntelliJ-IDEA-Community

# Ejecutar
flatpak run com.jetbrains.IntelliJ-IDEA-Community
```

### Fedora / RHEL / CentOS

```bash
# Usando Snap
sudo dnf install snapd
sudo snap install intellij-idea-community --classic

# O descarga manual (igual que Ubuntu)
```

### Arch Linux

```bash
# Desde AUR (requiere yay o paru)
yay -S intellij-idea-community-edition

# O desde repositorios oficiales
sudo pacman -S intellij-idea-community-edition
```

### Crear lanzador de escritorio (si instalaste manualmente)

Crea el archivo `~/.local/share/applications/intellij-idea.desktop`:

```ini
[Desktop Entry]
Version=1.0
Type=Application
Name=IntelliJ IDEA Community
Icon=/opt/intellij-idea-community/bin/idea.svg
Exec=/opt/intellij-idea-community/bin/idea.sh %f
Comment=Integrated Development Environment
Categories=Development;IDE;
Terminal=false
StartupWMClass=jetbrains-idea
```

---

## ⚙️ Configuración Inicial

### Primera ejecución de IntelliJ IDEA

#### 1. Importar configuraciones (opcional)

Al abrir por primera vez:
- **Do not import settings** (si es tu primera instalación)
- O importa desde una versión anterior si la tienes

#### 2. Seleccionar tema

- **Light:** Tema claro (IntelliJ Light)
- **Dark:** Tema oscuro (Darcula) ← Recomendado por muchos desarrolladores

#### 3. Instalar plugins sugeridos (opcional)

IntelliJ sugerirá plugins según el tipo de desarrollo. Para este curso:
- ✅ **Git** (generalmente pre-instalado)
- ⬜ Otros plugins (pueden saltarse por ahora)

#### 4. Configurar el JDK

**Método 1: Desde la pantalla de bienvenida**
1. Clic en **Configure** (esquina inferior derecha) o ⚙️
2. **Structure for New Projects**
3. **Project Settings → Project**
4. **SDK:** Si no aparece el JDK 17:
   - Clic en **Add SDK → JDK**
   - Navega a la carpeta de tu JDK
   - Clic en **OK**

**Método 2: Desde un proyecto abierto**
1. **File → Project Structure** (Ctrl+Alt+Shift+S)
2. **Project Settings → Project**
3. **SDK:** Selecciona JDK 17 o agrégalo si no está

### Configuraciones recomendadas

#### Optimizar rendimiento

**File → Settings → Appearance & Behavior → System Settings → Memory Settings**
- Aumenta la memoria si tienes RAM suficiente:
  - **Mínimo:** 2048 MB
  - **Recomendado:** 4096 MB (si tienes 8GB+ de RAM)

#### Editor de código

**File → Settings → Editor → General:**
- ✅ **Change font size with Ctrl+Mouse Wheel:** Activado
- ✅ **Show whitespaces:** Trailing (recomendado)

**File → Settings → Editor → Font:**
- **Font:** JetBrains Mono (incluido) o tu preferido
- **Size:** 14-16 (según tu preferencia)
- ✅ **Enable ligatures:** Activado (opcional, hace el código más legible)

#### Autoguardado

**File → Settings → Appearance & Behavior → System Settings:**
- ✅ **Autosave files on frame deactivation:** Activado
- ✅ **Save files when switching to a different application:** Activado

#### Git

**File → Settings → Version Control → Git:**
- **Path to Git executable:** IntelliJ lo detecta automáticamente
- Si no lo encuentra:
  - **Windows:** `C:\Program Files\Git\bin\git.exe`
  - **macOS:** `/usr/bin/git` o `/usr/local/bin/git`
  - **Linux:** `/usr/bin/git`

---

## 🔌 Plugins Recomendados

### Instalar plugins:

**File → Settings → Plugins** (o **IntelliJ IDEA → Preferences → Plugins** en macOS)

#### Pestaña **Marketplace:**

Busca e instala estos plugins:

#### Esenciales para el curso:
- ✅ **Database Navigator** - Herramientas de base de datos (útil para Clase 4+)
  - Permite conectar y explorar MySQL
  - Ejecutar queries directamente
- ✅ **Markdown** - Soporte para archivos .md (generalmente pre-instalado)

#### Opcionales pero útiles:
- 🔵 **Rainbow Brackets** - Colorea paréntesis/llaves anidadas
- 🔵 **Key Promoter X** - Te enseña atajos de teclado
- 🔵 **GitToolBox** - Información adicional de Git en el editor
- 🔵 **SonarLint** - Análisis de calidad de código en tiempo real

### Cómo instalar:
1. Busca el plugin por nombre
2. Clic en **Install**
3. **Restart IDE** cuando termine

---

## ✅ Verificación de la Instalación

### Prueba 1: Crear un proyecto Java

1. En la pantalla de bienvenida, clic en **New Project**
2. **New Project:**
   - **Name:** `TestIntelliJ`
   - **Location:** Selecciona una carpeta
   - **Language:** Java
   - **Build system:** IntelliJ (o Ant/Maven según prefieras)
   - **JDK:** Selecciona tu JDK 17
3. Clic en **Create**

**Si el proyecto se crea sin errores, IntelliJ está correctamente instalado.**

### Prueba 2: Crear y ejecutar una clase

1. Clic derecho en `src` → **New → Java Class**
2. **Name:** `Main`
3. Agrega el código:
   ```java
   public class Main {
       public static void main(String[] args) {
           System.out.println("IntelliJ IDEA está funcionando!");
       }
   }
   ```
4. Clic derecho en el archivo → **Run 'Main.main()'**
5. Deberías ver el output en la consola

✅ **Si ves el mensaje impreso, todo está perfecto!**

### Prueba 3: Conectar con Git (opcional)

1. **VCS → Get from Version Control**
2. Si puedes ver la ventana de clonación, Git está integrado correctamente

---

## ⚠️ Problemas Comunes

### 1. "Cannot start under Java X" (versión incorrecta de Java)

**Causa:** IntelliJ intenta ejecutarse con una versión incorrecta de Java.

**Solución:**
1. Edita el archivo de configuración:
   - **Windows:** `%APPDATA%\JetBrains\IntelliJIdea{version}\idea64.exe.jdk`
   - **macOS:** `~/Library/Application Support/JetBrains/IntelliJIdea{version}/idea.jdk`
   - **Linux:** `~/.config/JetBrains/IntelliJIdea{version}/idea64.vmoptions`
2. Especifica la ruta de tu JDK 17

### 2. IntelliJ muy lento o se congela

**Solución:**
1. Aumenta la memoria (ver sección de configuración)
2. Desactiva plugins que no uses
3. Invalida cachés: **File → Invalidate Caches → Invalidate and Restart**

### 3. "SDK is not defined" al crear proyecto

**Solución:**
1. **File → Project Structure → SDKs**
2. Clic en **+ → Add JDK**
3. Selecciona la carpeta de tu JDK 17

### 4. Git no se detecta automáticamente

**Solución:**
1. **File → Settings → Version Control → Git**
2. **Path to Git executable:** Especifica manualmente:
   - Windows: `C:\Program Files\Git\bin\git.exe`
   - macOS/Linux: `/usr/bin/git`
3. Clic en **Test** para verificar

### 5. "Cannot run program" al ejecutar código

**Causa:** El JDK del proyecto no está configurado correctamente.

**Solución:**
1. **File → Project Structure → Project**
2. **SDK:** Verifica que esté seleccionado tu JDK 17
3. **Language level:** Debe ser 17 o superior

### 6. Plugins no se instalan

**Solución:**
1. Verifica tu conexión a internet
2. **File → Settings → Appearance & Behavior → System Settings → HTTP Proxy**
3. Configura el proxy si es necesario
4. Reinicia IntelliJ

---

## 🔗 Recursos Adicionales

### Documentación Oficial
- [IntelliJ IDEA Documentation](https://www.jetbrains.com/help/idea/)
- [Getting Started Guide](https://www.jetbrains.com/help/idea/getting-started.html)
- [Keyboard Shortcuts](https://www.jetbrains.com/help/idea/mastering-keyboard-shortcuts.html)

### Tutoriales
- [IntelliJ IDEA for Beginners](https://www.jetbrains.com/help/idea/getting-started.html)
- [IntelliJ IDEA Video Tutorials](https://www.youtube.com/c/intellijidea)
- [JetBrains Academy](https://www.jetbrains.com/academy/)

### Atajos de teclado útiles
| Acción | Windows/Linux | macOS |
|--------|---------------|-------|
| Buscar en todo | Doble Shift | Doble Shift |
| Autocompletar | Ctrl+Space | Ctrl+Space |
| Refactorizar | Ctrl+Alt+Shift+T | ⌘+T |
| Ejecutar | Shift+F10 | ⌃+R |
| Depurar | Shift+F9 | ⌃+D |
| Project Structure | Ctrl+Alt+Shift+S | ⌘+; |

### Comunidad
- [IntelliJ IDEA Community Forum](https://intellij-support.jetbrains.com/hc/en-us/community/topics)
- [JetBrains Blog](https://blog.jetbrains.com/)
- [Stack Overflow - IntelliJ IDEA Tag](https://stackoverflow.com/questions/tagged/intellij-idea)

---

## 🎯 Siguiente Paso

Una vez que IntelliJ IDEA esté instalado correctamente:

➡️ **Empieza el curso:** [Clase 1 - Introducción a GUI](../00-lessons/01-gui-components/00-intro.md)

O vuelve al índice:

⬅️ **[Índice de Extras](00-index.md)**

---

> 💡 **Consejo:** IntelliJ tiene una curva de aprendizaje, pero una vez que dominas los atajos de teclado, es extremadamente productivo.

> ⚡ **Tip:** Presiona **Shift dos veces** para buscar cualquier cosa (archivos, clases, acciones). Es el atajo más útil de IntelliJ.

---

**Última actualización:** Noviembre 2025  
**Versión recomendada:** IntelliJ IDEA Community Edition 2024.3 (o superior)  
**Licencia:** Apache License 2.0 (Gratuita y Open Source)

