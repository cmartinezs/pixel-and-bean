# 📖 Clase 1 (Parte 1) – Introducción al Proyecto Pixel & Bean

**Objetivo:**  
Comprender el contexto del proyecto completo, los conceptos técnicos fundamentales de **Java Swing** y prepararse para construir interfaces gráficas profesionales.

⏱️ **Duración estimada:** 1 hora pedagógica (40 minutos)

**Distribución del tiempo:**
- Presentación del proyecto y alcance (10 min)
- Conceptos técnicos fundamentales (25 min)
- Preparación del entorno y dudas (5 min)

<!-- TOC -->
* [📖 Clase 1 (Parte 1) – Introducción al Proyecto Pixel & Bean](#-clase-1-parte-1--introducción-al-proyecto-pixel--bean)
  * [🎯 Contexto del Proyecto Completo](#-contexto-del-proyecto-completo)
    * [**Lo que completaremos en clase (Core):**](#lo-que-completaremos-en-clase-core)
    * [**Lo que queda como trabajo autónomo:**](#lo-que-queda-como-trabajo-autónomo)
  * [🗺️ Mapa del Curso – 6 Clases](#-mapa-del-curso--6-clases)
  * [🧰 Requisitos previos](#-requisitos-previos)
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
  * [💡 Siguiente Paso](#-siguiente-paso)
<!-- TOC -->

---

## 🎯 Contexto del Proyecto Completo

Este es el primer paso de un proyecto de **6 clases** donde construiremos un sistema de gestión completo para un **Café-Arcade llamado "Pixel & Bean"**.

### **Lo que completaremos en clase (Core):**
- ✅ **Login con roles** (ADMIN, OPERADOR)
- ✅ **CRUD completo:** Usuarios y Productos
- ✅ **Ventas básicas** (registro simple de venta)
- ✅ **Reportes básicos** (ventas del día)
- ✅ **Empaquetado JAR** ejecutable para distribución

### **Lo que queda como trabajo autónomo:**
- 📚 **Ventas complejas** (carrito con múltiples productos)
- 📚 **Anular ventas** (gestión de cancelaciones)
- 📚 **Top 5 productos** más vendidos
- 📚 **Export a CSV** de reportes

> 📌 **Importante:** Consulta el **README.md** del proyecto para ver el alcance completo, tecnologías utilizadas y la estructura detallada de la base de datos.

---

## 🗺️ Mapa del Curso – 6 Clases

| Clase | Tema Principal                       | Duración         | Entregas                             |
|-------|--------------------------------------|------------------|--------------------------------------|
| **1** | Intro + GUI Base (Login y MainFrame) | 2.5 hrs (100min) | Proyecto base con navegación         |
| **2** | Componentes y Eventos (Pre-MVC)      | 2.5 hrs (100min) | Alpha UI con todas las pantallas     |
| **3** | MVC + Modelo de Datos                | 2.5 hrs (100min) | Arquitectura MVC completa            |
| **4** | Persistencia (MySQL + JDBC)          | 2.5 hrs (100min) | CRUD funcional con BD real           |
| **5** | Lógica de Negocio + Validaciones     | 2.5 hrs (100min) | Ventas y reportes operativos         |
| **6** | Empaquetado + Testing                | 2.5 hrs (100min) | JAR ejecutable con manual de usuario |

**Total:** 15 horas pedagógicas (10 horas cronológicas)

---

## 🧰 Requisitos previos

Antes de comenzar la parte práctica, asegúrate de tener las herramientas instaladas y configuradas:

### Herramientas necesarias:

- ✅ **Java 17+** instalado y configurado en el PATH
- ✅ **NetBeans IDE 26** (para diseño visual de interfaces)
- ✅ **IntelliJ IDEA Community Edition** (opcional, para lógica de negocio)
- ✅ **Git/GitHub** configurado para control de versiones

### Conocimientos básicos:
  - Clases y objetos en Java
  - Métodos y constructores
  - Paquetes y organización de código
  - Conceptos básicos de orientación a objetos

### 🔧 Guías de Instalación

Si aún no has instalado las herramientas, consulta estas guías detalladas:

| Herramienta | Guía de Instalación | Obligatoria |
|-------------|---------------------|-------------|
| **Java 17+** | **[02-instalacion-java.md](../../01-extras/02-instalacion-java.md)** | ✅ Sí |
| **NetBeans IDE 26** | **[03-instalacion-netbeans.md](../../01-extras/03-instalacion-netbeans.md)** | ✅ Sí |
| **IntelliJ IDEA CE** | **[04-instalacion-intellij.md](../../01-extras/04-instalacion-intellij.md)** | ⚪ Opcional |
| **Git** | **[01-git-basico.md](../../01-extras/01-git-basico.md)** | ✅ Sí |

> 💡 **Recomendación:** Instala todas las herramientas **antes** de la primera clase para aprovechar al máximo el tiempo. Las guías incluyen instrucciones paso a paso para Windows, macOS y Linux.

> 🎯 **Nota sobre IntelliJ:** Aunque es opcional, IntelliJ IDEA será muy útil desde la Clase 3 en adelante para refactorización y trabajo con bases de datos.

- ✅ **Java 17** instalado y configurado en el PATH
- ✅ **NetBeans IDE 26** (para diseño visual de interfaces)
- ✅ **IntelliJ IDEA Community Edition** (opcional, para lógica de negocio)
- ✅ **Git/GitHub** configurado para control de versiones
- ✅ Conocimientos básicos de:
  - Clases y objetos en Java
  - Métodos y constructores
  - Paquetes y organización de código
  - Conceptos básicos de orientación a objetos

> 💡 **Recomendación:** Si no tienes experiencia previa con Git, consulta nuestra **[Guía Básica de Git](../../01-extras/01-git-basico.md)** que cubre todos los comandos esenciales que necesitarás para el curso.

---

## 📚 Apartado Técnico – Conceptos en Profundidad

Esta sección explica los fundamentos técnicos de cada tecnología y concepto que utilizaremos durante el curso, para que comprendas **por qué** y **cómo** funcionan las herramientas que estamos usando.

### 🔷 1. Java Swing – Framework de GUI

**¿Qué es Swing?**  
Swing es un conjunto de bibliotecas (paquete `javax.swing`) que forma parte del JFC (Java Foundation Classes). Fue introducido en Java 1.2 como sucesor de AWT (Abstract Window Toolkit) y sigue siendo ampliamente usado para aplicaciones de escritorio.

**Características principales:**
- **Independencia de plataforma:** Los componentes Swing son dibujados completamente por Java, no dependen de componentes nativos del sistema operativo.
- **Look & Feel pluggable:** Permite cambiar la apariencia de la aplicación sin modificar el código (Metal, Nimbus, Windows, macOS, etc.).
- **Modelo de componentes ligeros:** Los componentes Swing son "lightweight" (ligeros), heredan de `JComponent` y se renderizan en un solo `JFrame` nativo.
- **Thread-safety:** Swing NO es thread-safe. Todas las actualizaciones de UI deben ejecutarse en el **Event Dispatch Thread (EDT)**.

**Componentes principales que usaremos:**
- **JFrame:** Ventana principal con borde, barra de título y botones de control (minimizar, maximizar, cerrar).
- **JLabel:** Etiqueta de texto o imagen.
- **JTextField:** Campo de entrada de texto de una línea.
- **JPasswordField:** Campo de entrada de contraseña (oculta los caracteres).
- **JButton:** Botón que dispara eventos al hacer clic.
- **JTable:** Tabla para mostrar datos tabulares (usado en CRUD).
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
              ├── JTable
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

**Ejemplo del problema sin EDT:**
```java
// ❌ MAL - Operación larga en el hilo principal
button.addActionListener(e -> {
    // Esta consulta podría tardar 5 segundos
    List<Product> products = database.getAllProducts(); // CONGELA LA UI
    updateTable(products);
});

// ✅ BIEN - Operación larga en un thread secundario
button.addActionListener(e -> {
    new SwingWorker<List<Product>, Void>() {
        @Override
        protected List<Product> doInBackground() throws Exception {
            return database.getAllProducts(); // Se ejecuta en background
        }
        
        @Override
        protected void done() {
            try {
                List<Product> products = get();
                updateTable(products); // Se actualiza en el EDT
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }.execute();
});
```

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

**Ejemplo práctico:**
```java
// Forma tradicional (clase anónima)
button.addActionListener(new ActionListener() {
    @Override
    public void actionPerformed(ActionEvent e) {
        System.out.println("Botón presionado");
    }
});

// Forma moderna (lambda)
button.addActionListener(e -> System.out.println("Botón presionado"));

// Con referencia a método
button.addActionListener(this::handleButtonClick);
```

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
```java
this.dispose(); // Cierra el login y libera recursos
```
Esto libera los recursos de una ventana cuando ya no se necesita. Es importante para evitar memory leaks en aplicaciones con múltiples ventanas.

**Diferencias clave:**
- **`dispose()`:** Libera recursos de la ventana pero la aplicación sigue corriendo.
- **`setVisible(false)`:** Oculta la ventana pero mantiene sus recursos en memoria.
- **`System.exit(0)`:** Termina completamente la aplicación Java.

---

### 🔷 6. Seguridad en el Login Mock

**¿Por qué usar `JPasswordField` y no `JTextField`?**
- `JPasswordField` oculta los caracteres mientras se escriben (muestra puntos o asteriscos).
- Internamente, almacena la contraseña como `char[]` en lugar de `String`.

**¿Por qué `char[]` es más seguro que `String`?**
- Los `String` en Java son inmutables y permanecen en memoria (String pool) hasta que el Garbage Collector los elimine.
- Un array `char[]` puede ser sobrescrito con ceros (`Arrays.fill(password, '0')`) inmediatamente después de usarlo.
- Esto reduce el tiempo que la contraseña permanece en memoria.

**Ejemplo de buena práctica:**
```java
char[] password = txtPass.getPassword();
try {
    // Validar password
    boolean valid = authenticateUser(username, password);
    if (valid) {
        // Login exitoso
    }
} finally {
    // Limpiar la contraseña de memoria
    Arrays.fill(password, '0');
}
```

**Limitaciones del login mock (primera versión):**
- ⚠️ Contraseña hardcodeada en código fuente (muy inseguro).
- ⚠️ Sin encriptación ni hashing.
- ⚠️ Sin protección contra ataques de fuerza bruta.

**En clases futuras implementaremos:**
- Validación contra base de datos (Clase 4).
- Hashing de contraseñas con **BCrypt** o **PBKDF2** (Clase 5).
- Gestión de sesiones (Clase 5).
- Logs de intentos de acceso (Clase 6).

---

### 🔷 7. Organización de Paquetes (Naming Conventions)

**¿Por qué usar `cl.tuusuario.pnb.gui`?**  
Java utiliza la convención de **nombre de dominio invertido** para evitar conflictos de nombres entre librerías:

```
cl           → Código de país (Chile)
tuusuario    → Nombre del desarrollador/organización
pnb          → Nombre del proyecto (PixelAndBean)
gui          → Módulo o funcionalidad (interfaz gráfica)
```

**Estructura completa recomendada para proyectos MVC:**
```plaintext
cl.tuusuario.pnb/
├── gui/              # Vistas (JFrames, JDialogs, JPanels)
│   ├── LoginFrame.java
│   ├── MainFrame.java
│   ├── users/        # Vistas específicas de usuarios
│   ├── products/     # Vistas específicas de productos
│   └── sales/        # Vistas específicas de ventas
├── model/            # Modelos de datos (POJOs, entidades)
│   ├── User.java
│   ├── Product.java
│   └── Sale.java
├── controller/       # Controladores (lógica de negocio)
│   ├── UserController.java
│   └── ProductController.java
├── dao/              # Data Access Objects (acceso a BD)
│   ├── UserDAO.java
│   └── ProductDAO.java
├── service/          # Servicios de negocio (capa intermedia)
│   └── AuthService.java
├── util/             # Utilidades (validaciones, helpers)
│   ├── Validator.java
│   └── DateUtil.java
└── exception/        # Excepciones personalizadas
    └── DAOException.java
```

**Ventajas de esta organización:**
- ✅ Código organizado y fácil de navegar.
- ✅ Separación clara de responsabilidades.
- ✅ Facilita el trabajo en equipo (cada desarrollador puede trabajar en un paquete).
- ✅ Preparado para crecer y escalar.
- ✅ Facilita el testing unitario.

---

### 🔷 8. NetBeans vs IntelliJ IDEA – ¿Por qué ambos?

| Aspecto              | NetBeans                          | IntelliJ IDEA                         |
|----------------------|-----------------------------------|---------------------------------------|
| **Editor visual**    | ✅ Excelente (Matisse GUI Builder) | ⚠️ Básico (requiere plugins externos) |
| **Generación de UI** | ✅ GroupLayout automático          | ❌ Limitado                            |
| **Ant/Maven**        | ✅ Soporte nativo                  | ✅ Soporte nativo + Gradle             |
| **Refactoring**      | ✅ Bueno                           | ✅✅ Excelente                          |
| **Autocompletado**   | ✅ Bueno                           | ✅✅ Superior (IntelliSense avanzado)   |
| **Depuración**       | ✅ Completa                        | ✅✅ Más herramientas                   |
| **Plugins**          | ✅ Aceptable                       | ✅✅ Ecosistema más grande              |
| **Licencia**         | ✅ 100% Open Source (Apache 2.0)   | ⚠️ Community (limitada) + Ultimate ($) |

**Estrategia híbrida recomendada:**
1. **NetBeans:** Para diseñar interfaces gráficas rápidamente con el editor visual.
2. **IntelliJ IDEA:** Para escribir lógica de negocio, controladores, DAOs y refactorización avanzada.

**¿Se puede usar solo uno?**  
Sí, pero perderás ventajas:
- Solo NetBeans: Refactoring y autocompletado menos potente.
- Solo IntelliJ: Diseño de UI manual y tedioso.

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
                <attribute name="Main-Class" value="cl.tuusuario.pnb.PixelAndBean"/>
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
- **Maven:** Gestión de dependencias más potente, repositorios centralizados (POM.xml).
- **Gradle:** Más flexible, usa DSL (Groovy/Kotlin), mejor rendimiento, usado en Android.

> 💡 Para este proyecto educativo, Ant es suficiente. En proyectos empresariales reales, Maven o Gradle son más recomendables.

---

### 🔷 10. JOptionPane – Diálogos Modales

**¿Qué es un diálogo modal?**  
Es una ventana que bloquea la interacción con la ventana padre hasta que se cierre.

**Tipos de diálogos en `JOptionPane`:**
```java
// Mensaje informativo
JOptionPane.showMessageDialog(parent, "Mensaje", "Título", JOptionPane.INFORMATION_MESSAGE);

// Mensaje de error
JOptionPane.showMessageDialog(parent, "Error crítico", "Error", JOptionPane.ERROR_MESSAGE);

// Confirmación (Sí/No/Cancelar)
int respuesta = JOptionPane.showConfirmDialog(parent, "¿Estás seguro?", "Confirmar", 
    JOptionPane.YES_NO_CANCEL_OPTION);

// Entrada de texto
String nombre = JOptionPane.showInputDialog(parent, "Ingresa tu nombre:");

// Selección de opciones
String[] opciones = {"Opción 1", "Opción 2", "Opción 3"};
String seleccion = (String) JOptionPane.showInputDialog(parent, "Elige una opción:", "Selección", 
    JOptionPane.QUESTION_MESSAGE, null, opciones, opciones[0]);
```

**Tipos de íconos:**
- `ERROR_MESSAGE` → ❌ Rojo (errores críticos)
- `WARNING_MESSAGE` → ⚠️ Amarillo (advertencias)
- `INFORMATION_MESSAGE` → ℹ️ Azul (información general)
- `QUESTION_MESSAGE` → ❓ Verde (preguntas al usuario)
- `PLAIN_MESSAGE` → Sin ícono

**Valores de retorno en confirmaciones:**
- `JOptionPane.YES_OPTION` (0)
- `JOptionPane.NO_OPTION` (1)
- `JOptionPane.CANCEL_OPTION` (2)
- `JOptionPane.CLOSED_OPTION` (-1)

---

### 🔷 11. Expresiones Lambda y Referencias a Métodos

**Código que usaremos:**
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
- ✅ Menos boilerplate (código repetitivo).
- ✅ Facilita la programación funcional.
- ✅ Mejor rendimiento (el compilador puede optimizar).

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

// Referencias a métodos
button.addActionListener(this::handleClick);
```

**Requisitos para usar lambdas:**
- La interfaz debe ser **funcional** (tener un solo método abstracto).
- Ejemplos: `Runnable`, `ActionListener`, `Comparator`, `Predicate`, etc.

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

## 💡 Siguiente Paso

Ahora que comprendes los conceptos técnicos fundamentales, estás listo para la parte práctica:

➡️ **[01-ventanas-base.md](02-main-windows.md)** – Creación del proyecto y construcción de las ventanas Login y MainFrame.

---

> 🧠 *"El conocimiento de los fundamentos técnicos te permitirá no solo copiar código, sino entender cada decisión de diseño."*

