# 🪟 Clase 1 (Parte 2) – Creación de Ventanas Base

**Objetivo:**  
Crear la base del proyecto en **NetBeans**, diseñar la primera interfaz **(Login)** y preparar la **ventana principal (JFrame maestro)** con su **menú superior**.

⏱️ **Duración estimada:** 1.5 horas pedagógicas (60 minutos)

**Distribución del tiempo:**
- Paso 1-2: Proyecto y paquetes (10 min)
- Paso 3: Interfaz de Login (15 min)
- Paso 4: MainFrame con menú (15 min)
- Paso 5-6: Conexión y pruebas (15 min)
- Paso 7: Limpieza y Git (5 min)

> 📌 **Pre-requisito:**  
> Antes de comenzar esta parte práctica, asegúrate de haber leído y comprendido los conceptos técnicos en **[00-intro-proyecto.md](01-technical-base.md)**.

<!-- TOC -->
* [🪟 Clase 1 (Parte 2) – Creación de Ventanas Base](#-clase-1-parte-2--creación-de-ventanas-base)
  * [🗂️ Estructura de esta clase](#-estructura-de-esta-clase)
  * [🏗️ Paso 1 – Crear el proyecto base](#-paso-1--crear-el-proyecto-base)
    * [Pasos en NetBeans:](#pasos-en-netbeans)
    * [Estructura generada:](#estructura-generada)
  * [🧱 Paso 2 – Organización de paquetes](#-paso-2--organización-de-paquetes)
    * [Pasos:](#pasos)
  * [🪟 Paso 3 – Crear la interfaz de Login](#-paso-3--crear-la-interfaz-de-login)
    * [Pasos:](#pasos-1)
    * [Diseño de la interfaz:](#diseño-de-la-interfaz)
    * [Tips de diseño:](#tips-de-diseño)
    * [Opcional: Agregar ícono de aplicación](#opcional-agregar-ícono-de-aplicación)
  * [⚙️ Paso 4 – Crear la ventana principal (JFrame Maestro)](#-paso-4--crear-la-ventana-principal-jframe-maestro)
    * [Pasos:](#pasos-2)
    * [Agregar el menú:](#agregar-el-menú)
    * [Agregar barra de estado:](#agregar-barra-de-estado)
    * [Configuración del MainFrame:](#configuración-del-mainframe)
  * [🔗 Paso 5 – Conectar Login y MainFrame](#-paso-5--conectar-login-y-mainframe)
    * [Pasos:](#pasos-3)
    * [Explicación del código:](#explicación-del-código)
  * [🧪 Paso 6 – Probar ejecución](#-paso-6--probar-ejecución)
    * [Configurar el punto de entrada:](#configurar-el-punto-de-entrada)
    * [Ejecutar el proyecto:](#ejecutar-el-proyecto)
    * [Probar el comportamiento:](#probar-el-comportamiento)
  * [🧹 Paso 7 – Limpieza y orden final](#-paso-7--limpieza-y-orden-final)
    * [Estructura esperada del proyecto:](#estructura-esperada-del-proyecto)
    * [Versionamiento con Git:](#versionamiento-con-git)
    * [Checklist final:](#checklist-final)
  * [✅ Resultado de la Clase 1](#-resultado-de-la-clase-1)
    * [Conocimientos adquiridos:](#conocimientos-adquiridos)
    * [Entregables funcionales:](#entregables-funcionales)
    * [Resumen técnico:](#resumen-técnico)
  * [💡 Próxima Clase](#-próxima-clase)
<!-- TOC -->

---

## 🗂️ Estructura de esta clase

| Etapa | Descripción                           | Resultado esperado                            |
|-------|---------------------------------------|-----------------------------------------------|
| 1️⃣   | Crear el proyecto base                | Proyecto `PixelAndBean` con clase principal   |
| 2️⃣   | Crear paquetes y organización inicial | Estructura ordenada de `cl.tuusuario.pnb.gui` |
| 3️⃣   | Diseñar GUI del Login (Swing)         | Formulario de inicio de sesión                |
| 4️⃣   | Crear la Ventana Maestra              | JFrame principal con menú                     |
| 5️⃣   | Configurar flujo Login → Principal    | Navegación entre ventanas                     |
| 6️⃣   | Ejecutar y validar comportamiento     | Aplicación funcional sin BD                   |
| 7️⃣   | Limpieza y versionamiento             | Código ordenado y subido a Git                |

---

## 🏗️ Paso 1 – Crear el proyecto base

> 💡 **Importante:** Se recomienda tener claro dónde se guardará el proyecto. Para este curso usaremos:
> - **Windows:** `C:\Users\TuUsuario\Documents\ProyectosPOO`
> - **macOS/Linux:** `~/Documents/ProyectosPOO`
> 
> También define tu paquete base (ej: `cl.tuusuario`, reemplaza `tuusuario` con tu nombre o identificador único).

### Pasos en NetBeans:

1. Abre **NetBeans IDE** → `File → New Project`.

2. En la categoría **Java with Ant**, selecciona **Java Application** → **Next**.

3. Completa los datos del proyecto:
   - **Project Name:** `PixelAndBean`
   - **Project Location:** `C:\Users\TuUsuario\Documents\ProyectosPOO`
   - **Create Main Class:** ✅ Marcado
   - **Main Class:** `cl.tuusuario.pnb.PixelAndBean`

4. Haz clic en **Finish**.

> ✅ NetBeans generará automáticamente:
> - La estructura de carpetas del proyecto
> - El archivo `build.xml` (configuración de Ant)
> - La clase principal `PixelAndBean.java` con el método `main()`

### Estructura generada:

```plaintext
PixelAndBean/
├── build.xml                 # Configuración de Ant
├── manifest.mf               # Manifiesto para el JAR
├── nbproject/                # Configuración de NetBeans
├── src/
│   └── cl/
│       └── tuusuario/
│           └── pnb/
│               └── PixelAndBean.java
└── test/                     # Carpeta para tests (opcional)
```

---

## 🧱 Paso 2 – Organización de paquetes

Ahora vamos a crear la estructura de paquetes que usaremos durante todo el proyecto.

### Pasos:

1. En el panel **Projects**, expande `Source Packages`.

2. Verás el paquete `cl.tuusuario.pnb` con la clase `PixelAndBean.java`.

3. Crea un nuevo paquete para las interfaces gráficas:
   - **Clic derecho** sobre `Source Packages` → **New → Java Package**
   - **Package Name:** `cl.tuusuario.pnb.gui`
   - **Finish**

4. El resultado debe verse así:

```plaintext
Source Packages/
└── cl.tuusuario.pnb/
    ├── gui/                      ← Nuevo paquete (vacío por ahora)
    └── PixelAndBean.java         ← Clase principal
```

> ✨ **¿Por qué un paquete `gui`?**  
> Este paquete contendrá **todas las clases visuales** (formularios `.java` con diseño Swing). Mantener separadas las vistas de la lógica es una buena práctica de organización.

---

## 🪟 Paso 3 – Crear la interfaz de Login

Ahora crearemos nuestra primera ventana usando el editor visual de NetBeans.

### Pasos:

1. **Clic derecho** sobre `cl.tuusuario.pnb.gui` → **New → JFrame Form**.

2. Completa los datos:
   - **Class Name:** `LoginFrame`
   - **Package:** `cl.tuusuario.pnb.gui`
   - **Finish**

3. NetBeans abrirá el **editor visual (Design)** con una ventana vacía.

### Diseño de la interfaz:

4. Desde el panel **Palette** (a la derecha), arrastra los siguientes componentes:

   **Componentes necesarios:**
   - 1x `JLabel` → Título: **"Pixel & Bean – Sistema de Gestión"**
   - 1x `JLabel` → Texto: **"Usuario:"**
   - 1x `JTextField` → Campo de entrada (nombre de variable: `txtUser`)
   - 1x `JLabel` → Texto: **"Contraseña:"**
   - 1x `JPasswordField` → Campo de contraseña (nombre de variable: `txtPass`)
   - 1x `JButton` → Texto: **"Iniciar sesión"** (nombre de variable: `btnLogin`)

5. **Ajusta el diseño visualmente:**
   - Selecciona el JLabel del título y desde **Properties**:
     - Font: Bold, tamaño 18-20
     - Horizontal Alignment: Center
   - Alinea los componentes para que se vean profesionales
   - Usa el GridBagLayout o deja que NetBeans use GroupLayout

### Tips de diseño:

```java
// Configuraciones recomendadas en el constructor (después de initComponents())
setTitle("Iniciar Sesión – Pixel & Bean");
setLocationRelativeTo(null);  // Centra la ventana
setResizable(false);           // Evita redimensionar
```

### Opcional: Agregar ícono de aplicación

Si deseas agregar un ícono personalizado:

1. Crea la estructura de carpetas:
   - **Clic derecho** en el proyecto → **New → Folder**
   - Nombre: `resources`
   - Dentro de `resources`, crea otra carpeta: `icons`

2. Coloca tu archivo de imagen (ej: `logo.png`, 32x32 o 64x64 píxeles) en `src/resources/icons/`.

3. En el **constructor de `LoginFrame`**, después de `initComponents();`, agrega:

```java
try {
    Image icon = ImageIO.read(getClass().getResource("/resources/icons/logo.png"));
    setIconImage(icon);
} catch (IOException e) {
    System.err.println("No se pudo cargar el ícono: " + e.getMessage());
}
```

4. Importa las clases necesarias:
   - `java.awt.Image`
   - `javax.imageio.ImageIO`
   - `java.io.IOException`

---

## ⚙️ Paso 4 – Crear la ventana principal (JFrame Maestro)

La ventana principal será el "centro de operaciones" de nuestra aplicación, con un menú completo para navegar a todas las funcionalidades.

### Pasos:

1. **Clic derecho** sobre `cl.tuusuario.pnb.gui` → **New → JFrame Form**.

2. Completa los datos:
   - **Class Name:** `MainFrame`
   - **Package:** `cl.tuusuario.pnb.gui`
   - **Finish**

### Agregar el menú:

3. En el editor visual, desde la **Palette**, arrastra un **JMenuBar** al frame.

4. Crea la estructura de menús completa:

```
📁 Archivo
   └── Cerrar sesión
   └── Salir

📁 Gestión
   └── Usuarios*
   └── Productos

📁 Operación
   └── Ventas

📁 Reportes
   └── Ventas del día
   └── Top productos

📁 Eventos
   └── Torneos

📁 Ayuda
   └── Acerca de…
```

**Cómo crear cada menú:**
- Clic derecho sobre el **JMenuBar** → **Add From Palette → Menu**
- Cambia el texto del menú (Properties → text)
- Clic derecho sobre cada **JMenu** → **Add From Palette → Menu Item**
- Cambia el texto de cada ítem

> 💡 **Notas importantes:**
> - El asterisco (*) en "Usuarios*" indica que solo será accesible para el rol **ADMIN** (se implementará en Clase 5).
> - El menú "Eventos → Torneos" es un **placeholder** que mostrará una pantalla informativa (Clase 2).
> - "Top productos" quedará como trabajo autónomo (ver README para alcance completo).

### Agregar barra de estado:

5. Arrastra un **JPanel** al final del frame (BorderLayout.SOUTH).

6. Dentro del panel, arrastra un **JLabel** con el texto inicial: `"Usuario: (sin iniciar sesión)"`

> Esta barra mostrará: usuario activo, rol y hora (se implementará en clases posteriores).

### Configuración del MainFrame:

7. En el **constructor**, después de `initComponents();`, agrega:

```java
setTitle("Pixel & Bean – Sistema de Gestión");
setSize(900, 600);
setLocationRelativeTo(null);  // Centra la ventana
setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
```

> 🧭 Esta ventana será el "frame maestro" al que accederemos después del login.

---

## 🔗 Paso 5 – Conectar Login y MainFrame

Ahora vamos a hacer que el botón de login realmente funcione y abra la ventana principal.

### Pasos:

1. Vuelve a **`LoginFrame.java`** y abre la vista **Design**.

2. Haz **clic derecho** sobre el botón **"Iniciar sesión"** → **Events → Action → actionPerformed**.

3. NetBeans te llevará automáticamente al código y creará el método del evento.

4. Escribe el siguiente código:

```java
private void btnLoginActionPerformed(java.awt.event.ActionEvent evt) {                                            
    String user = txtUser.getText();
    String pass = new String(txtPass.getPassword());

    if (user.equals("admin") && pass.equals("1234")) {
        // Login exitoso
        MainFrame main = new MainFrame();
        main.setVisible(true);
        this.dispose(); // Cierra la ventana de login
    } else {
        // Login fallido
        JOptionPane.showMessageDialog(this,
            "Usuario o contraseña incorrectos",
            "Error de autenticación",
            JOptionPane.ERROR_MESSAGE);
    }
}
```

### Explicación del código:

- **`txtUser.getText()`:** Obtiene el texto del campo de usuario.
- **`txtPass.getPassword()`:** Obtiene la contraseña como `char[]` (más seguro).
- **`new String(char[])`:** Convierte a String para comparación simple (solo para esta versión mock).
- **`if (user.equals("admin") && pass.equals("1234"))`:** Validación hardcodeada (temporal).
- **`new MainFrame().setVisible(true)`:** Crea y muestra la ventana principal.
- **`this.dispose()`:** Cierra la ventana de login y libera recursos.
- **`JOptionPane.showMessageDialog()`:** Muestra un diálogo de error si las credenciales son incorrectas.

> 🔒 **Importante sobre seguridad:**
> 
> En esta primera versión, el login es **mock** (sin conexión a base de datos).  
> Las credenciales hardcodeadas son solo para pruebas:
> - Usuario: `admin` / Contraseña: `1234`
> - Usuario: `operador` / Contraseña: `op123` (opcional para futuras pruebas)
> 
> **En clases posteriores:**
> - **Clase 4:** Validaremos contra MySQL usando JDBC
> - **Clase 5:** Implementaremos hashing de contraseñas con BCrypt
> - **Clase 5:** Agregaremos gestión de roles (ADMIN, OPERADOR)

---

## 🧪 Paso 6 – Probar ejecución

Es momento de ver nuestra aplicación en acción.

### Configurar el punto de entrada:

1. Abre la clase principal **`PixelAndBean.java`**.

2. Modifica el método `main()` para que inicie el Login:

```java
package cl.tuusuario.pnb;

import cl.tuusuario.pnb.gui.LoginFrame;

public class PixelAndBean {

    public static void main(String[] args) {
        // Ejecuta en el Event Dispatch Thread (EDT)
        java.awt.EventQueue.invokeLater(() -> {
            new LoginFrame().setVisible(true);
        });
    }
}
```

### Ejecutar el proyecto:

3. Presiona **`Shift + F6`** o haz clic en el botón **▶️ Run Project** (F6).

4. Deberías ver la ventana de **Login**.

### Probar el comportamiento:

5. **Prueba con credenciales incorrectas:**
   - Usuario: `test`
   - Contraseña: `123`
   - ❌ Debería mostrar un mensaje de error

6. **Prueba con credenciales correctas:**
   - Usuario: `admin`
   - Contraseña: `1234`
   - ✅ Debería cerrar el login y abrir el **MainFrame**

7. **Verifica el menú:**
   - Navega por los menús (Archivo, Gestión, Operación, etc.)
   - Por ahora no harán nada (los implementaremos en la Clase 2)

---

## 🧹 Paso 7 – Limpieza y orden final

Antes de finalizar, vamos a asegurarnos de que todo esté ordenado y versionado.

### Estructura esperada del proyecto:

```plaintext
PixelAndBean/
├── build.xml
├── manifest.mf
├── nbproject/
├── src/
│   ├── cl/
│   │   └── tuusuario/
│   │       └── pnb/
│   │           ├── PixelAndBean.java       # Clase principal (main)
│   │           └── gui/
│   │               ├── LoginFrame.java     # Login mock
│   │               └── MainFrame.java      # Ventana principal con menú
│   └── resources/                          # (opcional)
│       └── icons/
│           └── logo.png
└── test/
```

### Versionamiento con Git:

Si aún no has inicializado Git en tu proyecto:

```bash
cd C:\Users\TuUsuario\Documents\ProyectosPOO\PixelAndBean
git init
git add .
git commit -m "Clase 1: GUI base con login y ventana principal"
```

Si ya tienes un repositorio remoto configurado:

```bash
git push origin main
```

### Checklist final:

- ✅ El proyecto compila sin errores
- ✅ El login abre correctamente
- ✅ Las credenciales incorrectas muestran un error
- ✅ Las credenciales correctas abren el MainFrame
- ✅ El menú está completo (aunque no funcional todavía)
- ✅ El código está comentado donde sea necesario
- ✅ El código está subido a Git

---

## ✅ Resultado de la Clase 1

🎉 **¡Felicidades!** Al finalizar esta sesión has logrado:

### Conocimientos adquiridos:
- ✅ Comprendiste la estructura de un proyecto Java Swing
- ✅ Aprendiste a usar el editor visual de NetBeans (Matisse GUI Builder)
- ✅ Conociste los componentes básicos: JFrame, JLabel, JTextField, JPasswordField, JButton, JMenuBar
- ✅ Implementaste eventos básicos (ActionListener)
- ✅ Entendiste el flujo de navegación entre ventanas
- ✅ Aplicaste buenas prácticas de organización de paquetes

### Entregables funcionales:
- ✅ Proyecto base funcional y organizado
- ✅ Login operativo con validación mock (`admin` / `1234`)
- ✅ Ventana principal con menú superior completo
- ✅ Flujo completo de navegación entre ventanas
- ✅ Código versionado en Git

### Resumen técnico:
| Componente      | Función                                  | Estado       |
|-----------------|------------------------------------------|--------------|
| LoginFrame      | Autenticación de usuarios                | ✅ Funcional  |
| MainFrame       | Ventana principal con menú               | ✅ Funcional  |
| Menú Archivo    | Cerrar sesión, Salir                     | 🔄 Pendiente |
| Menú Gestión    | Usuarios, Productos                      | 🔄 Pendiente |
| Menú Operación  | Ventas                                   | 🔄 Pendiente |
| Menú Reportes   | Ventas del día, Top productos            | 🔄 Pendiente |
| Menú Eventos    | Torneos                                  | 🔄 Pendiente |
| Menú Ayuda      | Acerca de…                               | 🔄 Pendiente |

> 💡 **Recuerda:** Personaliza `cl.tuusuario` con tu propio identificador (por ejemplo, `cl.tunombre` o tu usuario preferido).

---

## 💡 Próxima Clase

**Clase 2 – Componentes y Eventos (Pre-MVC)**  

En la siguiente clase aprenderás a:

- 🎨 **Crear los layouts de todas las vistas** del proyecto:
  - Panel de gestión de Usuarios (formulario + tabla)
  - Panel de gestión de Productos (formulario + tabla)
  - Panel de Ventas (selección de producto, cantidad, registro)
  - Panel de Reportes (ventas del día, listado)
  - Pantalla informativa de Torneos (placeholder)

- 🔄 **Implementar navegación** entre pantallas:
  - Uso de **CardLayout** o **JDesktopPane** para cambiar entre vistas
  - Conectar los ítems del menú con sus respectivas vistas

- 🎯 **Manejar eventos avanzados:**
  - ActionListener para botones de acción (Guardar, Editar, Eliminar)
  - DocumentListener para validación en tiempo real
  - Selección de filas en JTable

- 🧩 **Encapsular lógica de UI:**
  - Crear métodos para cargar datos en tablas
  - Preparar stubs (simulaciones) de servicios para las operaciones CRUD
  - Validaciones básicas de formularios (campos requeridos, formatos)

- ✅ **Validaciones de formularios:**
  - Campos requeridos
  - Formatos de email, teléfono, RUT (si aplica)
  - Validación de tipos de datos

**Entregable esperado:**
- ✅ Alpha UI funcional con menú completamente navegable
- ✅ Pantallas base de todos los módulos (con datos mock)
- ✅ Eventos conectados a stubs de servicio
- ✅ Validaciones básicas implementadas

> 📋 **Tips para prepararte:**
> - Repasa los conceptos de **Listeners** en Java (ActionListener, MouseListener, KeyListener)
> - Investiga sobre **JTable** y su modelo de datos (AbstractTableModel)
> - Piensa en cómo estructurarías la navegación: ¿prefieres CardLayout (cambio de paneles) o JDesktopPane (ventanas internas)?

---

> 🧠 *"Primero haz que funcione. Luego hazlo elegante. Finalmente hazlo rápido."* – Kent Beck

