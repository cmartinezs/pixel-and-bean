# 🔧 Guía Básica de Git - Referencia Rápida

**Propósito:** Guía de referencia rápida para estudiantes que necesitan usar Git en el proyecto Pixel & Bean.

> 💡 **Nota:** Esta guía cubre los comandos esenciales para el curso. Para temas avanzados, consulta la [documentación oficial de Git](https://git-scm.com/doc).

---

## 📚 Tabla de Contenidos

<!-- TOC -->
* [🔧 Guía Básica de Git - Referencia Rápida](#-guía-básica-de-git---referencia-rápida)
  * [📚 Tabla de Contenidos](#-tabla-de-contenidos)
  * [🎯 ¿Qué es Git?](#-qué-es-git)
  * [⚙️ Instalación y Configuración Inicial](#-instalación-y-configuración-inicial)
    * [Instalación](#instalación)
    * [Configuración inicial (solo una vez)](#configuración-inicial-solo-una-vez)
  * [🚀 Comandos Básicos del Flujo de Trabajo](#-comandos-básicos-del-flujo-de-trabajo)
    * [1. Crear un nuevo repositorio local](#1-crear-un-nuevo-repositorio-local)
    * [2. Clonar un repositorio existente](#2-clonar-un-repositorio-existente)
    * [3. Ver el estado de los archivos](#3-ver-el-estado-de-los-archivos)
    * [4. Agregar archivos al área de preparación (staging)](#4-agregar-archivos-al-área-de-preparación-staging)
    * [5. Hacer un commit (guardar cambios)](#5-hacer-un-commit-guardar-cambios)
    * [6. Ver el historial de commits](#6-ver-el-historial-de-commits)
    * [7. Subir cambios al repositorio remoto](#7-subir-cambios-al-repositorio-remoto)
    * [8. Descargar cambios del repositorio remoto](#8-descargar-cambios-del-repositorio-remoto)
  * [🌿 Trabajar con Ramas (Branches)](#-trabajar-con-ramas-branches)
    * [Ver ramas](#ver-ramas)
    * [Crear una nueva rama](#crear-una-nueva-rama)
    * [Cambiar de rama](#cambiar-de-rama)
    * [Crear y cambiar en un solo comando](#crear-y-cambiar-en-un-solo-comando)
    * [Fusionar ramas (merge)](#fusionar-ramas-merge)
    * [Eliminar una rama](#eliminar-una-rama)
  * [🔄 Flujo de Trabajo Recomendado para el Proyecto](#-flujo-de-trabajo-recomendado-para-el-proyecto)
    * [Flujo diario:](#flujo-diario)
    * [Al finalizar cada clase:](#al-finalizar-cada-clase)
  * [❌ Deshacer Cambios](#-deshacer-cambios)
    * [Descartar cambios en un archivo (antes de hacer add)](#descartar-cambios-en-un-archivo-antes-de-hacer-add)
    * [Quitar archivos del staging (después de add, antes de commit)](#quitar-archivos-del-staging-después-de-add-antes-de-commit)
    * [Modificar el último commit](#modificar-el-último-commit)
    * [Volver a un commit anterior (⚠️ usar con cuidado)](#volver-a-un-commit-anterior--usar-con-cuidado)
  * [🔗 Trabajar con Repositorios Remotos](#-trabajar-con-repositorios-remotos)
    * [Ver repositorios remotos](#ver-repositorios-remotos)
    * [Agregar un repositorio remoto](#agregar-un-repositorio-remoto)
    * [Cambiar la URL de un remoto](#cambiar-la-url-de-un-remoto)
  * [📋 .gitignore - Ignorar Archivos](#-gitignore---ignorar-archivos)
    * [Ejemplo de .gitignore para proyectos Java (NetBeans)](#ejemplo-de-gitignore-para-proyectos-java-netbeans)
  * [🎨 GitHub Desktop - Alternativa Visual](#-github-desktop---alternativa-visual)
  * [🆘 Comandos de Ayuda](#-comandos-de-ayuda)
  * [📖 Glosario de Términos](#-glosario-de-términos)
  * [🎯 Mejores Prácticas](#-mejores-prácticas)
    * [Commits:](#commits)
    * [Ramas:](#ramas)
    * [General:](#general)
  * [🔗 Recursos Adicionales](#-recursos-adicionales)
    * [Documentación oficial:](#documentación-oficial)
    * [Tutoriales interactivos:](#tutoriales-interactivos)
    * [Videos (YouTube):](#videos-youtube)
  * [❓ Problemas Comunes y Soluciones](#-problemas-comunes-y-soluciones)
    * [1. "Permission denied" al hacer push](#1-permission-denied-al-hacer-push)
    * [2. Conflictos al hacer pull](#2-conflictos-al-hacer-pull)
    * [3. Olvidé hacer commit antes de cambiar de rama](#3-olvidé-hacer-commit-antes-de-cambiar-de-rama)
    * [4. Quiero deshacer el último commit pero conservar los cambios](#4-quiero-deshacer-el-último-commit-pero-conservar-los-cambios)
<!-- TOC -->

---

## 🎯 ¿Qué es Git?

**Git** es un sistema de control de versiones distribuido que te permite:
- 📝 Guardar diferentes versiones de tu código
- 🔄 Volver a versiones anteriores si algo sale mal
- 👥 Colaborar con otros desarrolladores
- 🌿 Trabajar en múltiples funcionalidades simultáneamente (ramas)
- 📊 Mantener un historial completo de cambios

**Git vs GitHub:**
- **Git:** Herramienta de control de versiones (software local)
- **GitHub:** Plataforma web para alojar repositorios Git (servicio en la nube)

---

## ⚙️ Instalación y Configuración Inicial

### Instalación

**Windows:**
1. Descarga Git desde [git-scm.com](https://git-scm.com/download/win)
2. Ejecuta el instalador
3. Usa las opciones por defecto (recomendado)
4. Verifica la instalación:
   ```bash
   git --version
   ```

**macOS:**
```bash
# Con Homebrew
brew install git

# O descarga desde git-scm.com
```

**Linux (Ubuntu/Debian):**
```bash
sudo apt update
sudo apt install git
```

### Configuración inicial (solo una vez)

```bash
# Configurar tu nombre (aparecerá en los commits)
git config --global user.name "Tu Nombre"

# Configurar tu email (debe coincidir con GitHub)
git config --global user.email "tu.email@ejemplo.com"

# Configurar el editor por defecto (opcional)
git config --global core.editor "code --wait"  # Para VS Code
git config --global core.editor "nano"          # Para nano (terminal)

# Ver tu configuración
git config --list
```

---

## 🚀 Comandos Básicos del Flujo de Trabajo

### 1. Crear un nuevo repositorio local

```bash
# Navega a la carpeta de tu proyecto
cd C:\Users\TuUsuario\Documents\ProyectosPOO\PixelAndBean

# Inicializa el repositorio
git init
```

### 2. Clonar un repositorio existente

```bash
# Clonar desde GitHub
git clone https://github.com/usuario/repositorio.git

# Clonar en una carpeta específica
git clone https://github.com/usuario/repositorio.git nombre-carpeta
```

### 3. Ver el estado de los archivos

```bash
# Ver archivos modificados, agregados, eliminados
git status

# Versión compacta
git status -s
```

**Interpretación de los estados:**
- ❓ `??` → Archivo nuevo, no rastreado
- 🟢 `A` → Archivo agregado (staged)
- 🔴 `M` → Archivo modificado
- 🗑️ `D` → Archivo eliminado

### 4. Agregar archivos al área de preparación (staging)

```bash
# Agregar un archivo específico
git add archivo.java

# Agregar todos los archivos modificados
git add .

# Agregar todos los archivos de una carpeta
git add src/

# Agregar archivos por patrón
git add *.java
```

### 5. Hacer un commit (guardar cambios)

```bash
# Commit con mensaje
git commit -m "Descripción clara del cambio"

# Commit con mensaje detallado (abre el editor)
git commit

# Agregar y hacer commit en un solo paso (solo archivos ya rastreados)
git commit -am "Mensaje del commit"
```

**Mensajes de commit recomendados:**
```bash
git commit -m "Clase 1: Crear ventana de login"
git commit -m "Fix: Corregir validación de usuario"
git commit -m "Refactor: Mejorar organización de paquetes"
git commit -m "Docs: Actualizar README con instrucciones"
```

### 6. Ver el historial de commits

```bash
# Ver historial completo
git log

# Ver historial compacto (una línea por commit)
git log --oneline

# Ver últimos 5 commits
git log --oneline -5

# Ver historial con gráfico de ramas
git log --oneline --graph --all

# Ver cambios de un archivo específico
git log -- archivo.java
```

### 7. Subir cambios al repositorio remoto

```bash
# Subir a la rama actual
git push

# Primera vez (establecer rama remota)
git push -u origin main

# Subir a una rama específica
git push origin nombre-rama

# Forzar push (⚠️ usar con cuidado)
git push --force
```

### 8. Descargar cambios del repositorio remoto

```bash
# Descargar y fusionar cambios
git pull

# Descargar sin fusionar (solo ver cambios)
git fetch

# Fusionar después del fetch
git merge origin/main
```

---

## 🌿 Trabajar con Ramas (Branches)

Las ramas permiten trabajar en nuevas funcionalidades sin afectar el código principal.

### Ver ramas

```bash
# Ver ramas locales
git branch

# Ver ramas remotas
git branch -r

# Ver todas las ramas
git branch -a
```

### Crear una nueva rama

```bash
# Crear rama
git branch nombre-rama

# Ejemplos para el proyecto
git branch feature/login
git branch feature/productos
git branch fix/bug-validacion
```

### Cambiar de rama

```bash
# Cambiar a una rama existente
git checkout nombre-rama

# Cambiar a main/master
git checkout main
```

### Crear y cambiar en un solo comando

```bash
# Crear y cambiar a nueva rama
git checkout -b nombre-rama

# Ejemplo
git checkout -b feature/ventas
```

### Fusionar ramas (merge)

```bash
# 1. Cambiar a la rama destino (ej: main)
git checkout main

# 2. Fusionar la otra rama
git merge feature/login

# Si hay conflictos, resuélvelos y luego:
git add .
git commit -m "Merge feature/login into main"
```

### Eliminar una rama

```bash
# Eliminar rama local (después de fusionar)
git branch -d nombre-rama

# Forzar eliminación (⚠️ aunque no esté fusionada)
git branch -D nombre-rama

# Eliminar rama remota
git push origin --delete nombre-rama
```

---

## 🔄 Flujo de Trabajo Recomendado para el Proyecto

### Flujo diario:

```bash
# 1. Al empezar el día - descargar cambios
git pull

# 2. Crear una rama para la nueva funcionalidad (opcional)
git checkout -b feature/mi-funcionalidad

# 3. Trabajar en tu código...
# (editar archivos en NetBeans/IntelliJ)

# 4. Ver qué cambió
git status

# 5. Agregar cambios
git add .

# 6. Hacer commit
git commit -m "Descripción clara del cambio"

# 7. Subir cambios
git push

# 8. Si trabajas con ramas, fusionar a main
git checkout main
git merge feature/mi-funcionalidad
git push
```

### Al finalizar cada clase:

```bash
# Asegúrate de guardar todo tu trabajo
git add .
git commit -m "Clase X: Resumen de lo implementado"
git push origin main
```

---

## ❌ Deshacer Cambios

### Descartar cambios en un archivo (antes de hacer add)

```bash
# Descartar cambios en un archivo específico
git checkout -- archivo.java

# Descartar todos los cambios no guardados
git checkout -- .
```

### Quitar archivos del staging (después de add, antes de commit)

```bash
# Quitar un archivo específico del staging
git reset HEAD archivo.java

# Quitar todos los archivos del staging
git reset HEAD .
```

### Modificar el último commit

```bash
# Cambiar el mensaje del último commit
git commit --amend -m "Nuevo mensaje"

# Agregar archivos olvidados al último commit
git add archivo-olvidado.java
git commit --amend --no-edit
```

### Volver a un commit anterior (⚠️ usar con cuidado)

```bash
# Ver el historial
git log --oneline

# Volver a un commit específico (conserva cambios)
git reset --soft abc1234

# Volver a un commit específico (descarta cambios)
git reset --hard abc1234

# Volver un commit atrás
git reset --hard HEAD~1
```

---

## 🔗 Trabajar con Repositorios Remotos

### Ver repositorios remotos

```bash
# Ver remotos configurados
git remote -v

# Ver información detallada de un remoto
git remote show origin
```

### Agregar un repositorio remoto

```bash
# Agregar remote llamado "origin"
git remote add origin https://github.com/usuario/repositorio.git

# Verificar
git remote -v
```

### Cambiar la URL de un remoto

```bash
# Cambiar URL de origin
git remote set-url origin https://github.com/usuario/nuevo-repositorio.git
```

---

## 📋 .gitignore - Ignorar Archivos

El archivo `.gitignore` especifica qué archivos o carpetas Git debe ignorar.

**Crear .gitignore en la raíz del proyecto:**

### Ejemplo de .gitignore para proyectos Java (NetBeans)

```gitignore
# Archivos compilados
*.class
*.jar
*.war
*.ear

# Carpetas de build
build/
dist/
target/

# NetBeans
nbproject/private/
build/
nbbuild/
nbdist/
.nb-gradle/

# IntelliJ IDEA
.idea/
*.iml
*.iws
out/

# Eclipse
.classpath
.project
.settings/

# MacOS
.DS_Store

# Windows
Thumbs.db
desktop.ini

# Logs
*.log

# Archivos de configuración personal
application-local.properties
```

**Comandos útiles:**

```bash
# Crear el archivo .gitignore
echo "build/" >> .gitignore
echo "dist/" >> .gitignore

# Ver archivos ignorados
git status --ignored

# Ignorar un archivo que ya fue rastreado
git rm --cached archivo.java
```

---

## 🎨 GitHub Desktop - Alternativa Visual

Si prefieres una interfaz gráfica en lugar de la línea de comandos:

**Descargar:** [desktop.github.com](https://desktop.github.com/)

**Ventajas:**
- ✅ Interfaz visual intuitiva
- ✅ Ver cambios lado a lado
- ✅ Gestión fácil de ramas
- ✅ Resolución de conflictos visual
- ✅ Integración directa con GitHub

**Desventajas:**
- ⚠️ Menos control que la línea de comandos
- ⚠️ Algunas operaciones avanzadas no disponibles

**Flujo en GitHub Desktop:**
1. Clonar repositorio → `File → Clone Repository`
2. Ver cambios → Panel izquierdo
3. Hacer commit → Escribir mensaje y clic en "Commit to main"
4. Push → `Push origin`
5. Pull → `Fetch origin` → `Pull origin`

---

## 🆘 Comandos de Ayuda

```bash
# Ayuda general
git --help

# Ayuda de un comando específico
git commit --help
git log --help

# Versión corta de ayuda
git commit -h
```

---

## 📖 Glosario de Términos

| Término | Significado |
|---------|-------------|
| **Repository (Repo)** | Carpeta de proyecto rastreada por Git |
| **Commit** | Instantánea (snapshot) de cambios guardada |
| **Branch (Rama)** | Línea independiente de desarrollo |
| **Merge** | Fusionar cambios de una rama a otra |
| **Remote** | Repositorio alojado en servidor (ej: GitHub) |
| **Origin** | Nombre por defecto del repositorio remoto |
| **Clone** | Copiar un repositorio remoto a tu máquina |
| **Pull** | Descargar cambios del remoto y fusionar |
| **Push** | Subir tus commits al repositorio remoto |
| **Fetch** | Descargar cambios sin fusionar |
| **Staging Area** | Área temporal antes del commit |
| **HEAD** | Puntero al commit actual |
| **Master/Main** | Rama principal del proyecto |
| **Fork** | Copia de un repositorio en tu cuenta de GitHub |
| **Pull Request (PR)** | Solicitud para fusionar cambios |

---

## 🎯 Mejores Prácticas

### Commits:
- ✅ Haz commits frecuentes (pequeños y específicos)
- ✅ Escribe mensajes descriptivos
- ✅ Un commit = una funcionalidad/fix
- ❌ No hagas commits gigantes con muchos cambios
- ❌ No uses mensajes genéricos como "cambios" o "update"

**Buenos mensajes:**
```bash
✅ "Agregar validación de email en formulario de usuarios"
✅ "Fix: Corregir cálculo de total en ventas"
✅ "Refactor: Extraer lógica de validación a clase Validator"
✅ "Docs: Actualizar README con instrucciones de instalación"
```

**Malos mensajes:**
```bash
❌ "cambios"
❌ "fix"
❌ "asdfgh"
❌ "final final ahora si"
```

### Ramas:
- ✅ Usa nombres descriptivos: `feature/nombre`, `fix/nombre`
- ✅ Mantén la rama main/master siempre funcional
- ✅ Fusiona ramas cuando termines una funcionalidad
- ✅ Elimina ramas después de fusionarlas

### General:
- ✅ Haz `git pull` antes de empezar a trabajar
- ✅ Haz `git push` al finalizar tu sesión
- ✅ Revisa `git status` antes de hacer commit
- ✅ Usa `.gitignore` para no subir archivos innecesarios
- ❌ No subas archivos compilados (.class, .jar)
- ❌ No subas carpetas de build (build/, dist/)

---

## 🔗 Recursos Adicionales

### Documentación oficial:
- [Git Documentation](https://git-scm.com/doc)
- [GitHub Guides](https://guides.github.com/)
- [Git Cheat Sheet](https://training.github.com/downloads/github-git-cheat-sheet.pdf)

### Tutoriales interactivos:
- [Learn Git Branching](https://learngitbranching.js.org/) - Visual e interactivo
- [Git Immersion](https://gitimmersion.com/) - Tutorial paso a paso
- [Oh My Git!](https://ohmygit.org/) - Juego para aprender Git

### Videos (YouTube):
- "Git Tutorial for Beginners" - Programming with Mosh
- "Git and GitHub for Beginners" - freeCodeCamp
- "Git en Español" - Buscar tutoriales en español

---

## ❓ Problemas Comunes y Soluciones

### 1. "Permission denied" al hacer push

**Problema:** No tienes configuradas las credenciales de GitHub.

**Solución:**
```bash
# Opción 1: HTTPS con token (recomendado)
# Ve a GitHub → Settings → Developer Settings → Personal Access Tokens
# Crea un token y úsalo como contraseña

# Opción 2: SSH (avanzado)
# Configurar SSH keys (ver documentación de GitHub)
```

### 2. Conflictos al hacer pull

**Problema:** Tus cambios locales entran en conflicto con cambios remotos.

**Solución:**
```bash
# 1. Hacer pull
git pull

# 2. Git marcará los archivos con conflictos
# 3. Abre los archivos y busca:
<<<<<<< HEAD
tu código
=======
código del remoto
>>>>>>> branch-name

# 4. Edita el archivo para resolver el conflicto
# 5. Guarda los cambios y:
git add .
git commit -m "Resolver conflictos"
git push
```

### 3. Olvidé hacer commit antes de cambiar de rama

**Problema:** Intentas cambiar de rama con cambios sin guardar.

**Solución:**
```bash
# Opción 1: Guardar temporalmente (stash)
git stash
git checkout otra-rama
# Luego, para recuperar:
git stash pop

# Opción 2: Hacer commit de todos modos
git add .
git commit -m "WIP: Trabajo en progreso"
git checkout otra-rama
```

### 4. Quiero deshacer el último commit pero conservar los cambios

```bash
# Deshace el commit pero mantiene los cambios en staging
git reset --soft HEAD~1

# Deshace el commit y quita del staging (pero conserva archivos)
git reset HEAD~1
```

---

> 💡 **Consejo Final:** Git puede parecer intimidante al principio, pero con la práctica se vuelve natural. No tengas miedo de experimentar - siempre puedes volver atrás con Git!

> 🎓 **Para el curso:** Si tienes dudas sobre Git durante las clases, pregunta sin problema. Es mejor aclarar ahora que perder trabajo después.

---

**Última actualización:** Noviembre 2025  
**Autor:** Guía creada para el curso de Programación Orientada a Objetos

