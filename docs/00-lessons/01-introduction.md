# 🧩 Clase 1 – Introducción a GUI y Componentes (Proyecto Pixel & Bean)

**Objetivo:**  
Comprender la estructura de un proyecto **Java Swing**, crear la base del proyecto en **NetBeans**, diseñar la primera interfaz **(Login)** y preparar la **ventana principal (JFrame maestro)** con su **menú superior**.

⏱️ **Duración estimada:** 2.5 horas pedagógicas (100 minutos)

**Distribución del tiempo:**
- Paso 1-2: Proyecto y paquetes (10 min)
- Paso 3: Interfaz de Login (25 min)
- Paso 4: MainFrame con menú (20 min)
- Paso 5-6: Conexión y pruebas (20 min)
- Paso 7: Limpieza y Git (5 min)
- Discusión y dudas (20 min)

> 📌 **Contexto del Proyecto Completo:**  
> Este es el primer paso de un proyecto de **6 clases** donde construiremos un sistema de gestión completo para un **Café-Arcade**.
> 
> **Lo que completaremos en clase (Core):**
> - ✅ Login con roles (ADMIN, OPERADOR)
> - ✅ CRUD completo: Usuarios y Productos
> - ✅ Ventas básicas (registro simple)
> - ✅ Reportes básicos (ventas del día)
> - ✅ Empaquetado JAR ejecutable
> 
> **Lo que queda como trabajo autónomo:**
> - 📚 Ventas complejas (carrito con múltiples productos)
> - 📚 Anular ventas
> - 📚 Top 5 productos más vendidos
> - 📚 Export a CSV
> 
> Consulta el **README.md** del proyecto para ver el alcance completo.

<!-- TOC -->
* [🧩 Clase 1 – Introducción a GUI y Componentes (Proyecto Pixel & Bean)](#-clase-1--introducción-a-gui-y-componentes-proyecto-pixel--bean)
  * [🗂️ Estructura de esta clase](#-estructura-de-esta-clase)
  * [🧰 Requisitos previos](#-requisitos-previos)
  * [🏗️ Paso 1 – Crear el proyecto base](#-paso-1--crear-el-proyecto-base)
  * [🧱 Paso 2 – Organización de paquetes](#-paso-2--organización-de-paquetes)
  * [🪟 Paso 3 – Crear la interfaz de Login](#-paso-3--crear-la-interfaz-de-login)
  * [⚙️ Paso 4 – Crear la ventana principal (JFrame Maestro)](#-paso-4--crear-la-ventana-principal-jframe-maestro)
  * [🔗 Paso 5 – Conectar Login y MainFrame](#-paso-5--conectar-login-y-mainframe)
  * [🧪 Paso 6 – Probar ejecución](#-paso-6--probar-ejecución)
  * [🧹 Paso 7 – Limpieza y orden final](#-paso-7--limpieza-y-orden-final)
  * [✅ Resultado de la Clase 1](#-resultado-de-la-clase-1)
  * [📚 Apartado Técnico – Conceptos en Profundidad](#-apartado-técnico--conceptos-en-profundidad)
    * [🔷 1. Java Swing – Framework de GUI](#-1-java-swing--framework-de-gui)
    * [🔷 2. Event Dispatch Thread (EDT)](#-2-event-dispatch-thread-edt)
    * [🔷 3. Gestores de Diseño (Layout Managers)](#-3-gestores-de-diseño-layout-managers)
    * [🔷 4. Modelo de Eventos en Swing](#-4-modelo-de-eventos-en-swing)
    * [🔷 5. Ciclo de Vida de una Ventana (JFrame)](#-5-ciclo-de-vida-de-una-ventana-jframe)
    * [🔷 6. Seguridad en el Login Mock](#-6-seguridad-en-el-login-mock)
    * [🔷 7. Organización de Paquetes (Naming Conventions)](#-7-organización-de-paquetes-naming-conventions)
    * [🔷 8. NetBeans vs IntelliJ IDEA – ¿Por qué ambos?](#-8-netbeans-vs-intellij-idea--por-qué-ambos)
    * [🔷 9. Proyecto Java with Ant – ¿Qué es Ant?](#-9-proyecto-java-with-ant--qué-es-ant)
    * [🔷 10. JOptionPane – Diálogos Modales](#-10-joptionpane--diálogos-modales)
    * [🔷 11. Expresiones Lambda y Referencias a Métodos](#-11-expresiones-lambda-y-referencias-a-métodos)
  * [🎯 Resumen Técnico](#-resumen-técnico)
  * [💡 Próxima Clase](#-próxima-clase)
<!-- TOC -->

---

## 🗂️ Estructura de esta clase

| Etapa | Descripción                           | Resultado esperado                          |
|-------|---------------------------------------|---------------------------------------------|
| 1️⃣   | Crear el proyecto base                | Proyecto `PixelAndBean` con clase principal |
| 2️⃣   | Crear paquetes y organización inicial | Estructura ordenada de `cl.tuusuario.gui`  |
| 3️⃣   | Diseñar GUI del Login (Swing)         | Formulario de inicio de sesión              |
| 4️⃣   | Crear la Ventana Maestra              | JFrame principal con menú                   |
| 5️⃣   | Configurar flujo Login → Principal    | Navegación entre ventanas                   |
| 6️⃣   | Ejecutar y validar comportamiento     | Aplicación funcional sin BD                 |

---

## 🧰 Requisitos previos

- **Java 17** instalado.  
- **NetBeans IDE 26** (recomendado para diseño de GUI).  
- **IntelliJ IDEA Community Edition** (para la lógica y organización final).  
- **Git/GitHub** para versionar.  
- Conocimientos básicos de clases, métodos y paquetes en Java.

---

## 🏗️ Paso 1 – Crear el proyecto base

> Se recomienda tener claro donde se guardará el proyecto (ej: `C:\Users\TuUsuario\Documents\ProyectosPOO`). Además cual será el paquete base (`cl.tuusuario`).

1. Abre **NetBeans** → `File → New Project`.
2. En la categoría **Java with Ant**, elige **Java Application** → **Next**.
3. Completa los datos:
   - **Project Name:** `PixelAndBean`
   - **Project Location:** tu carpeta de trabajo o `C:\Users\TuUsuario\Documents\ProyectosPOO`
   - **Main Class:** `cl.tuusuario.PixelAndBean`
4. Haz clic en **Finish**.

> 💡 NetBeans genera automáticamente la estructura inicial y una clase `pixelandbean.java` con el método `main()`.

---

## 🧱 Paso 2 – Organización de paquetes

1. En el panel **Projects**, expande `Source Packages`.
2. Crea un nuevo paquete:
   - Clic derecho sobre *Source Packages* → **New → Java Package**
   - **Package Name:** `cl.tuusuario.gui`
3. El resultado debe verse así:
```plaintext
Source Packages/
└── cl.tuusuario/
    ├── gui/
    └── PixelAndBean.java
```
> ✨ Este paquete contendrá todas las clases visuales (formularios `.java` con diseño Swing).

---

## 🪟 Paso 3 – Crear la interfaz de Login

1. Clic derecho sobre `cl.tuusuario.gui` → **New → JFrame Form**.  
   - **Class Name:** `LoginFrame`
   - **Package:** `cl.tuusuario.gui`
2. NetBeans abrirá el **editor visual (Design)**.
3. Desde el panel **Palette**, arrastra los siguientes componentes:
   - `JLabel` (x2) → “Usuario:” / “Contraseña:”
   - `JTextField` → para el usuario.
   - `JPasswordField` → para la contraseña.
   - `JButton` → texto “Iniciar sesión”.
   - `JLabel` adicional para el título: “Pixel & Bean – Login”.
4. Ajusta colores, fuentes y tamaños usando el panel **Properties**.
5. Opcional: añade el ícono del proyecto (desde `/resources/icons/` si existe).
    - Crea la estructura de carpetas: clic derecho en el proyecto → **New → Folder** → nombra `resources`, dentro crea `icons`.
    - Coloca tu archivo de imagen (ej: `logo.png`, 32x32 o 64x64 píxeles) en `src/resources/icons/`.
    - En el constructor de `LoginFrame`, después de `initComponents();`, agrega:
      ```java
      try {
          Image icon = ImageIO.read(getClass().getResource("/resources/icons/logo.png"));
          setIconImage(icon);
      } catch (IOException e) {
          System.err.println("No se pudo cargar el ícono: " + e.getMessage());
      }
      ```
    - Importa las clases necesarias: `java.awt.Image`, `javax.imageio.ImageIO`, `java.io.IOException`.

**Tips visuales:**
- Usa `GroupLayout` (por defecto en NetBeans).
- Centra el formulario: `setLocationRelativeTo(null);` en el constructor.
- Título de ventana: `"Iniciar Sesión – Pixel & Bean"`.

---

## ⚙️ Paso 4 – Crear la ventana principal (JFrame Maestro)

1. Clic derecho → **New → JFrame Form**  
   - **Class Name:** `MainFrame`
   - **Package:** `cl.tuusuario.gui`
2. En el editor:
   - Añade un **JMenuBar** (desde la paleta).
   - Crea los menús (estructura completa del proyecto):
     ```
     Archivo | Gestión | Operación | Reportes | Eventos | Ayuda
     ```
   - En cada menú, agrega **JMenuItems**:
     - **Archivo** → "Cerrar sesión", "Salir"
     - **Gestión** → "Usuarios*", "Productos"
     - **Operación** → "Ventas"
     - **Reportes** → "Ventas del día", "Top productos"
     - **Eventos** → "Torneos"
     - **Ayuda** → "Acerca de…"
   
   > 💡 **Notas importantes:**
   > - El asterisco (*) en "Usuarios*" indica que solo será accesible para el rol **ADMIN** (se implementará en Clase 5).
   > - El menú "Eventos → Torneos" es un **placeholder** que mostrará una pantalla informativa (Clase 2).
   > - "Top productos" se moverá a trabajo autónomo (consulta el README para alcance completo).

3. Agrega una **barra de estado** (un `JPanel` al final con un `JLabel`).
   - Esta barra mostrará: usuario activo, rol y hora (se implementará en clases posteriores)
4. Configura el título: `"Pixel & Bean – Sistema de Gestión"`  
   y el tamaño inicial: `setSize(900, 600);`

> 🧭 Esta será la ventana “central” a la que se accederá tras el login.

---

## 🔗 Paso 5 – Conectar Login y MainFrame

1. En el botón **Iniciar sesión**, genera un evento:  
   - Selecciona el botón → pestaña **Events → Action → actionPerformed**.
2. Escribe el siguiente código simple:

```java
private void btnLoginActionPerformed(java.awt.event.ActionEvent evt) {
    String user = txtUser.getText();
    String pass = new String(txtPass.getPassword());

    if (user.equals("admin") && pass.equals("1234")) {
        MainFrame main = new MainFrame();
        main.setVisible(true);
        this.dispose(); // Cierra el login
    } else {
        JOptionPane.showMessageDialog(this, 
            "Usuario o contraseña incorrectos",
            "Error", JOptionPane.ERROR_MESSAGE);
    }
}
```
> 🔒 En esta primera versión, el login es **mock** (sin conexión a base de datos).  
> En clases posteriores, el sistema validará credenciales reales desde MySQL mediante JDBC.
> 
> 💡 **Nota sobre credenciales:**  
> Las credenciales `admin/1234` y `operador/op123` que usamos aquí coincidirán con los datos de seed 
> que crearemos en **Clase 4** cuando conectemos la base de datos. Por ahora son hardcodeadas para pruebas.

---

## 🧪 Paso 6 – Probar ejecución

1. Abre la clase principal **PixelAndBean.java**.
2. Dentro del método `main()`, llama al formulario de login:

```java
public static void main(String[] args) {
    java.awt.EventQueue.invokeLater(() -> {
        new LoginFrame().setVisible(true);
    });
}
```
3. Ejecuta el proyecto (`Shift + F6` o botón ▶️ “Run Project”).

4. Prueba el comportamiento del **Login**:

    - Usuario: `admin`
    - Contraseña: `1234`
    - ✅ Correcto → se abre la **ventana principal**
    - ❌ Incorrecto → muestra un mensaje de error

   Código completo del evento del botón **Iniciar Sesión**:

   ````java
   private void btnLoginActionPerformed(java.awt.event.ActionEvent evt) {                                            
       String user = txtUser.getText();
       String pass = new String(txtPass.getPassword());

       if (user.equals("admin") && pass.equals("1234")) {
           MainFrame main = new MainFrame();
           main.setVisible(true);
           this.dispose(); // Cierra el login
       } else {
           JOptionPane.showMessageDialog(this,
               "Usuario o contraseña incorrectos",
               "Error", JOptionPane.ERROR_MESSAGE);
       }
   }
    ````
---
## 🧹 Paso 7 – Limpieza y orden final

Estructura esperada del proyecto:

````plaintext
src/
└── cl/tuusuario/
    ├── PixelAndBean.java       # Clase principal (main)
    └── gui/
        ├── LoginFrame.java     # Login mock
        └── MainFrame.java      # Ventana principal con menú
```` 
> 🔄 Guarda los cambios en Git:
> ````bash
> git add .
> git commit -m "Clase 1: GUI base con login y ventana principal"
> ````
---
## ✅ Resultado de la Clase 1

Al finalizar esta sesión tendrás:

- ✅ Proyecto base funcional y organizado.
- ✅ Login operativo con validación mock (`admin` / `1234`).
- ✅ Ventana principal con menú superior.
- ✅ Flujo completo de navegación entre ventanas.

**Resumen de lo logrado:**
- Comprendiste cómo crear un proyecto en NetBeans paso a paso.
- Aprendiste a estructurar los paquetes de forma ordenada (`cl.tuusuario.gui`).
- Diseñaste interfaces gráficas usando el editor visual de NetBeans.
- Implementaste eventos básicos de botones y validaciones simples.
- Consolidaste la lógica de inicio de sesión y carga de la ventana principal.
- Conociste la estructura completa del menú que implementaremos en el proyecto.

> 💡 **Recuerda:** Personaliza `cl.tuusuario` con tu propio identificador (por ejemplo, `cl.tunombre` o el que prefieras).

---

## 📚 Apartado Técnico – Conceptos en Profundidad

Esta sección explica los fundamentos técnicos de cada tecnología y concepto utilizado en la Clase 1, para que comprendas **por qué** y **cómo** funcionan las herramientas que estamos usando.

### 🔷 1. Java Swing – Framework de GUI

**¿Qué es Swing?**  
Swing es un conjunto de bibliotecas (paquete `javax.swing`) que forma parte del JFC (Java Foundation Classes). Fue introducido en Java 1.2 como sucesor de AWT (Abstract Window Toolkit) y sigue siendo ampliamente usado para aplicaciones de escritorio.

**Características principales:**
- **Independencia de plataforma:** Los componentes Swing son dibujados completamente por Java, no dependen de componentes nativos del sistema operativo.
- **Look & Feel pluggable:** Permite cambiar la apariencia de la aplicación sin modificar el código (Metal, Nimbus, Windows, macOS, etc.).
- **Modelo de componentes ligeros:** Los componentes Swing son "lightweight" (ligeros), heredan de `JComponent` y se renderizan en un solo `JFrame` nativo.
- **Thread-safety:** Swing NO es thread-safe. Todas las actualizaciones de UI deben ejecutarse en el **Event Dispatch Thread (EDT)**.

**Componentes principales usados en esta clase:**
- **JFrame:** Ventana principal con borde, barra de título y botones de control (minimizar, maximizar, cerrar).
- **JLabel:** Etiqueta de texto o imagen.
- **JTextField:** Campo de entrada de texto de una línea.
- **JPasswordField:** Campo de entrada de contraseña (oculta los caracteres).
- **JButton:** Botón que dispara eventos al hacer clic.
- **JMenuBar, JMenu, JMenuItem:** Sistema de menús desplegables.
- **JPanel:** Contenedor genérico para organizar componentes.

**Jerarquía básica:**
```
java.awt.Component
  └── java.awt.Container
        └── javax.swing.JComponent
              ├── JLabel
              ├── JTextField
              ├── JPasswordField
              ├── JButton
              └── JPanel
```

---

### 🔷 2. Event Dispatch Thread (EDT)

**¿Qué es el EDT?**  
Es el hilo (thread) especial de Java Swing encargado de:
1. Procesar todos los eventos de la interfaz gráfica (clics, teclas, movimientos del mouse).
2. Actualizar y repintar los componentes visuales.

**¿Por qué usamos `EventQueue.invokeLater()`?**
```java
java.awt.EventQueue.invokeLater(() -> {
    new LoginFrame().setVisible(true);
});
```

Este código **asegura** que la creación y visualización del `LoginFrame` se ejecute en el EDT, no en el hilo principal (`main`). Esto previene problemas de concurrencia y garantiza que la UI responda correctamente.

**Alternativa:**  
`SwingUtilities.invokeLater()` hace exactamente lo mismo (de hecho, `EventQueue.invokeLater()` es el método que Swing utiliza internamente).

**Buenas prácticas:**
- ✅ Siempre inicializa componentes Swing en el EDT.
- ❌ Nunca ejecutes operaciones largas (consultas a BD, archivos, HTTP) directamente en el EDT, ya que congelarían la interfaz.
- ✅ Para tareas largas, usa `SwingWorker` o threads secundarios, luego actualiza la UI con `invokeLater()`.

---

### 🔷 3. Gestores de Diseño (Layout Managers)

**¿Qué son los Layout Managers?**  
Son objetos que controlan automáticamente el tamaño y posición de los componentes dentro de un contenedor. Java Swing incluye varios:

| Layout Manager    | Descripción                                                                    | Uso típico                      |
|-------------------|--------------------------------------------------------------------------------|---------------------------------|
| **BorderLayout**  | Divide el contenedor en 5 regiones: NORTH, SOUTH, EAST, WEST, CENTER           | Ventanas principales            |
| **FlowLayout**    | Coloca componentes en fila, de izquierda a derecha, ajustando al tamaño        | Paneles simples de botones      |
| **GridLayout**    | Matriz de celdas de igual tamaño                                               | Calculadoras, paneles regulares |
| **BoxLayout**     | Organiza componentes en una única fila o columna                               | Barras de herramientas          |
| **GridBagLayout** | El más flexible pero complejo, con control total sobre posición y tamaño       | Formularios complejos           |
| **GroupLayout**   | Diseñado para herramientas visuales (NetBeans), con layout horizontal/vertical | Editor visual de NetBeans       |

**¿Por qué NetBeans usa GroupLayout?**  
`GroupLayout` fue creado específicamente para ser usado por herramientas visuales de diseño. Permite:
- Definir grupos horizontales y verticales de componentes.
- Alineación automática.
- Redimensionamiento inteligente.
- Generación de código limpio (aunque algo verboso).

**Ejemplo conceptual:**
```java
GroupLayout layout = new GroupLayout(panel);
panel.setLayout(layout);

// Grupo horizontal: [Label] [TextField]
layout.setHorizontalGroup(
    layout.createSequentialGroup()
        .addComponent(lblUser)
        .addComponent(txtUser)
);

// Grupo vertical: ambos alineados en la misma línea
layout.setVerticalGroup(
    layout.createParallelGroup()
        .addComponent(lblUser)
        .addComponent(txtUser)
);
```

En la práctica, NetBeans genera este código automáticamente cuando arrastras componentes en el editor visual.

---

### 🔷 4. Modelo de Eventos en Swing

**¿Cómo funcionan los eventos?**  
Swing implementa el patrón **Observer** (también conocido como **Listener Pattern**):
1. Un componente (ej: `JButton`) es la **fuente del evento**.
2. Un objeto "escucha" ese evento implementando una interfaz **Listener** (ej: `ActionListener`).
3. Cuando el usuario interactúa con el componente, se dispara el evento y se invoca el método del listener.

**Jerarquía de eventos:**
```
java.util.EventObject
  └── java.awt.AWTEvent
        ├── ActionEvent      // Clic en botón, Enter en campo de texto
        ├── MouseEvent       // Clics, movimientos, arrastres del mouse
        ├── KeyEvent         // Teclas presionadas
        ├── WindowEvent      // Apertura, cierre, minimización de ventanas
        └── FocusEvent       // Componente obtiene/pierde el foco
```

**Tipos de Listeners comunes:**

| Listener           | Métodos principales           | Uso                                    |
|--------------------|-------------------------------|----------------------------------------|
| `ActionListener`   | `actionPerformed()`           | Botones, menús, Enter en text fields   |
| `MouseListener`    | `mouseClicked()`, `mouseEntered()`, etc. | Detectar clics y movimientos |
| `KeyListener`      | `keyPressed()`, `keyReleased()`, `keyTyped()` | Detectar teclas            |
| `WindowListener`   | `windowClosing()`, `windowOpened()`, etc. | Eventos de ventana         |
| `FocusListener`    | `focusGained()`, `focusLost()` | Cambios de foco entre componentes     |

**Ejemplo del código que usamos:**
```java
private void btnLoginActionPerformed(java.awt.event.ActionEvent evt) {
    // evt contiene información del evento (fuente, timestamp, etc.)
    String user = txtUser.getText();
    String pass = new String(txtPass.getPassword());
    // ...
}
```

- **`ActionEvent evt`:** Objeto que contiene detalles del evento (qué componente lo disparó, cuándo, etc.).
- **`getText()`:** Método de `JTextField` que devuelve el texto actual.
- **`getPassword()`:** Método de `JPasswordField` que devuelve un `char[]` (por seguridad, no String).
- **`new String(char[])`:** Convierte el array de caracteres a String (solo para validación simple; en producción, evita crear Strings con contraseñas).

---

### 🔷 5. Ciclo de Vida de una Ventana (JFrame)

**Estados de un JFrame:**
1. **Creación:** `JFrame frame = new JFrame("Título");`
2. **Configuración:** Tamaño, posición, operación de cierre, etc.
3. **Población:** Agregar componentes (botones, paneles, menús).
4. **Visualización:** `frame.setVisible(true);`
5. **Cierre:** `frame.dispose();` (libera recursos) o `System.exit(0);` (termina la aplicación).

**Operaciones de cierre importantes:**
```java
setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);  // Cierra aplicación al cerrar ventana
setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE); // Solo cierra la ventana
setDefaultCloseOperation(JFrame.DO_NOTHING_ON_CLOSE); // Maneja el cierre manualmente
```

**¿Por qué usamos `dispose()`?**  
En el código del login:
```java
this.dispose(); // Cierra el login
```
Esto libera los recursos de la ventana de login cuando ya no se necesita. Es importante para evitar memory leaks en aplicaciones con múltiples ventanas.

---

### 🔷 6. Seguridad en el Login Mock

**¿Por qué usar `JPasswordField` y no `JTextField`?**
- `JPasswordField` oculta los caracteres mientras se escriben (muestra puntos o asteriscos).
- Internamente, almacena la contraseña como `char[]` en lugar de `String`.

**¿Por qué `char[]` es más seguro que `String`?**
- Los `String` en Java son inmutables y permanecen en memoria (String pool) hasta que el Garbage Collector los elimine.
- Un array `char[]` puede ser sobrescrito con ceros (`Arrays.fill(password, '0')`) inmediatamente después de usarlo.
- Esto reduce el tiempo que la contraseña permanece en memoria.

**Ejemplo de buena práctica (para futura implementación):**
```java
char[] password = txtPass.getPassword();
try {
    // Validar password
    boolean valid = authenticateUser(username, password);
} finally {
    // Limpiar la contraseña de memoria
    Arrays.fill(password, '0');
}
```

**Limitaciones del login mock:**
- ⚠️ Contraseña hardcodeada en código fuente (muy inseguro).
- ⚠️ Sin encriptación ni hashing.
- ⚠️ Sin protección contra ataques de fuerza bruta.

**En clases futuras implementaremos:**
- Validación contra base de datos.
- Hashing de contraseñas con **BCrypt** o **PBKDF2**.
- Gestión de sesiones.
- Logs de intentos de acceso.

---

### 🔷 7. Organización de Paquetes (Naming Conventions)

**¿Por qué usar `cl.tuusuario.gui`?**  
Java utiliza la convención de **nombre de dominio invertido** para evitar conflictos de nombres entre librerías:

```
cl           → Código de país (Chile)
cmartinezs   → Nombre del desarrollador/organización
gui          → Módulo o funcionalidad (interfaz gráfica)
```

**Estructura recomendada para proyectos MVC:**
```plaintext
cl.tuusuario/
├── gui/              # Vistas (JFrames, JDialogs, JPanels)
├── model/            # Modelos de datos (POJOs, entidades)
├── controller/       # Controladores (lógica de negocio)
├── dao/              # Data Access Objects (acceso a BD)
├── service/          # Servicios de negocio
├── util/             # Utilidades (validaciones, helpers)
└── exception/        # Excepciones personalizadas
```

**Ventajas:**
- ✅ Código organizado y fácil de navegar.
- ✅ Separación clara de responsabilidades.
- ✅ Facilita el trabajo en equipo.
- ✅ Preparado para crecer y escalar.

---

### 🔷 8. NetBeans vs IntelliJ IDEA – ¿Por qué ambos?

| Aspecto             | NetBeans                                  | IntelliJ IDEA                          |
|---------------------|-------------------------------------------|----------------------------------------|
| **Editor visual**   | ✅ Excelente (Matisse GUI Builder)       | ⚠️ Básico (requiere plugins externos)  |
| **Generación de UI**| ✅ GroupLayout automático                | ❌ Limitado                            |
| **Ant/Maven**       | ✅ Soporte nativo                        | ✅ Soporte nativo + Gradle             |
| **Refactoring**     | ✅ Bueno                                 | ✅✅ Excelente                         |
| **Autocompletado**  | ✅ Bueno                                 | ✅✅ Superior (IntelliSense avanzado)  |
| **Depuración**      | ✅ Completa                              | ✅✅ Más herramientas                  |
| **Plugins**         | ✅ Aceptable                             | ✅✅ Ecosistema más grande             |

**Estrategia híbrida recomendada:**
1. **NetBeans:** Para diseñar interfaces gráficas rápidamente con el editor visual.
2. **IntelliJ IDEA:** Para escribir lógica de negocio, controladores, DAOs y refactorización.

---

### 🔷 9. Proyecto Java with Ant – ¿Qué es Ant?

**Apache Ant** (Another Neat Tool) es una herramienta de automatización de builds similar a Make, pero basada en XML y específica para Java.

**Archivos clave en un proyecto Ant:**
- **`build.xml`:** Define las tareas de compilación, empaquetado, ejecución.
- **`nbproject/`:** Configuración específica de NetBeans.
- **`manifest.mf`:** Archivo de manifiesto del JAR (Main-Class, versión, etc.).

**Ejemplo de `build.xml` básico:**
```xml
<project name="PixelAndBean" default="jar" basedir=".">
    <target name="compile">
        <javac srcdir="src" destdir="build/classes"/>
    </target>
    
    <target name="jar" depends="compile">
        <jar destfile="dist/PixelAndBean.jar" basedir="build/classes">
            <manifest>
                <attribute name="Main-Class" value="cl.tuusuario.PixelAndBean"/>
            </manifest>
        </jar>
    </target>
</project>
```

**Comandos Ant comunes:**
```bash
ant compile    # Compila el código fuente
ant jar        # Genera el archivo JAR
ant run        # Ejecuta la aplicación
ant clean      # Limpia archivos compilados
```

**Alternativas modernas:**
- **Maven:** Gestión de dependencias más potente, repositorios centralizados.
- **Gradle:** Más flexible, usa DSL (Groovy/Kotlin), mejor rendimiento.

> Para este proyecto educativo, Ant es suficiente. En proyectos reales, Maven o Gradle son más recomendables.

---

### 🔷 10. JOptionPane – Diálogos Modales

**¿Qué es un diálogo modal?**  
Es una ventana que bloquea la interacción con la ventana padre hasta que se cierre.

**Tipos de diálogos en `JOptionPane`:**
```java
// Mensaje informativo
JOptionPane.showMessageDialog(parent, "Mensaje", "Título", JOptionPane.INFORMATION_MESSAGE);

// Confirmación (Sí/No)
int respuesta = JOptionPane.showConfirmDialog(parent, "¿Estás seguro?", "Confirmar", JOptionPane.YES_NO_OPTION);

// Entrada de texto
String nombre = JOptionPane.showInputDialog(parent, "Ingresa tu nombre:");

// Selección de opciones
String[] opciones = {"Opción 1", "Opción 2", "Opción 3"};
String seleccion = (String) JOptionPane.showInputDialog(parent, "Elige una opción:", "Selección", 
    JOptionPane.QUESTION_MESSAGE, null, opciones, opciones[0]);
```

**Tipos de íconos:**
- `ERROR_MESSAGE` → ❌ Rojo
- `WARNING_MESSAGE` → ⚠️ Amarillo
- `INFORMATION_MESSAGE` → ℹ️ Azul
- `QUESTION_MESSAGE` → ❓ Verde
- `PLAIN_MESSAGE` → Sin ícono

---

### 🔷 11. Expresiones Lambda y Referencias a Métodos

**Código que usamos:**
```java
java.awt.EventQueue.invokeLater(() -> {
    new LoginFrame().setVisible(true);
});
```

**¿Qué es `() -> { ... }`?**  
Es una **expresión lambda** (introducida en Java 8), que representa una función anónima.

**Equivalente sin lambda:**
```java
java.awt.EventQueue.invokeLater(new Runnable() {
    @Override
    public void run() {
        new LoginFrame().setVisible(true);
    }
});
```

**Ventajas de las lambdas:**
- ✅ Código más conciso y legible.
- ✅ Menos boilerplate.
- ✅ Facilita la programación funcional.

**Sintaxis de lambdas:**
```java
// Sin parámetros
() -> System.out.println("Hola")

// Un parámetro (paréntesis opcionales)
x -> x * 2

// Múltiples parámetros
(a, b) -> a + b

// Bloque de código
(x, y) -> {
    int suma = x + y;
    return suma * 2;
}
```

---

## 🎯 Resumen Técnico

| Concepto              | Uso en el proyecto                                       | Importancia       |
|-----------------------|----------------------------------------------------------|-------------------|
| **Swing**             | Framework para construir toda la interfaz gráfica        | ⭐⭐⭐⭐⭐        |
| **EDT**               | Garantiza thread-safety en la UI                         | ⭐⭐⭐⭐⭐        |
| **GroupLayout**       | Diseño visual automático en NetBeans                     | ⭐⭐⭐⭐          |
| **ActionListener**    | Captura eventos de botones y menús                       | ⭐⭐⭐⭐⭐        |
| **JPasswordField**    | Entrada segura de contraseñas                            | ⭐⭐⭐⭐          |
| **dispose()**         | Libera recursos de ventanas cerradas                     | ⭐⭐⭐⭐          |
| **Paquetes**          | Organización lógica del código                           | ⭐⭐⭐⭐⭐        |
| **Lambdas**           | Código más limpio y expresivo                            | ⭐⭐⭐            |
| **JOptionPane**       | Diálogos rápidos sin crear ventanas personalizadas       | ⭐⭐⭐⭐          |
| **Ant**               | Automatización de compilación y empaquetado              | ⭐⭐⭐            |

---

## 💡 Próxima Clase

**Clase 2 – Componentes y Eventos (Pre-MVC)**  

En la siguiente clase aprenderás a:
- 🎨 **Crear layouts de todas las vistas** del proyecto (Usuarios, Productos, Ventas, Reportes, Eventos)
- 🔄 **Implementar navegación** entre pantallas usando **CardLayout** o **JDesktopPane**
- 🎯 **Manejar eventos avanzados:** ActionListener, DocumentListener, selección en JTable
- 🧩 **Encapsular lógica de UI** y delegar llamadas a una capa de servicio simulada (stubs)
- ✅ **Validaciones de formularios** en la UI (campos requeridos, formatos simples)

**Entregable de Clase 2:**
- Alpha UI funcional con menú completamente navegable
- Pantallas base de todos los módulos (aunque sin lógica real todavía)
- Eventos conectados a stubs de servicio (preparando para MVC en Clase 3)

> 📋 **Tips para prepararte:**
> - Repasa los conceptos de **Listeners** en Java
> - Revisa el apartado técnico de esta clase sobre **Modelo de Eventos en Swing**
> - Piensa en la estructura de navegación: ¿CardLayout o JDesktopPane? (veremos ambas opciones)

---

> 🧠 *"Primero haz que funcione. Luego hazlo elegante."*
