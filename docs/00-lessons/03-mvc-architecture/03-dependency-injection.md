# 🔌 Clase 3 (Parte 3) – Inyección de Dependencias e Integración

**Objetivo:**  
Crear un contenedor IoC manual (ApplicationContext), ensamblar todas las capas mediante inyección de dependencias y refactorizar las vistas para usar la nueva arquitectura.

⏱️ **Duración estimada:** 30 minutos

**Distribución del tiempo:**
- Crear ApplicationContext (10 min)
- Refactorizar LoginForm (5 min)
- Refactorizar UsuariosPanel (8 min)
- Refactorizar ProductosPanel (5 min)
- Pruebas y limpieza (2 min)

> 📌 **Pre-requisito:**  
> Antes de comenzar esta parte, asegúrate de haber completado la **[Parte 2: Refactorización a Capas](02-refactoring-layers.md)**.

<!-- TOC -->
* [🔌 Clase 3 (Parte 3) – Inyección de Dependencias e Integración](#-clase-3-parte-3--inyección-de-dependencias-e-integración)
  * [🗂️ Estructura de esta sesión](#-estructura-de-esta-sesión)
  * [🏗️ Paso 1 – Crear ApplicationContext (Contenedor IoC)](#-paso-1--crear-applicationcontext-contenedor-ioc)
  * [🔐 Paso 2 – Refactorizar LoginForm](#-paso-2--refactorizar-loginform)
  * [👥 Paso 3 – Refactorizar UsuariosPanel](#-paso-3--refactorizar-usuariospanel)
  * [📦 Paso 4 – Refactorizar ProductosPanel](#-paso-4--refactorizar-productospanel)
  * [🧪 Paso 5 – Pruebas y Validación](#-paso-5--pruebas-y-validación)
  * [🧹 Paso 6 – Limpieza y Versionamiento](#-paso-6--limpieza-y-versionamiento)
  * [✅ Resultado Final de la Clase 3](#-resultado-final-de-la-clase-3)
  * [💡 Próxima Clase](#-próxima-clase)
<!-- TOC -->

---

## 🗂️ Estructura de esta sesión

| Tarea | Complejidad | Tiempo |
|-------|-------------|--------|
| ApplicationContext | ⭐⭐⭐⭐⭐ | 10 min |
| Refactorizar LoginForm | ⭐⭐⭐ | 5 min |
| Refactorizar UsuariosPanel | ⭐⭐⭐⭐ | 8 min |
| Refactorizar ProductosPanel | ⭐⭐⭐ | 5 min |
| Pruebas | ⭐⭐ | 2 min |

---

## 🏗️ Paso 1 – Crear ApplicationContext (Contenedor IoC)

El `ApplicationContext` es nuestro **contenedor de Inversión de Control manual**. Es el corazón de la inyección de dependencias.

### ¿Qué hace ApplicationContext?

1. **Crea todas las instancias** (repositorios, servicios, controladores)
2. **Conecta las dependencias** (inyección por constructor)
3. **Proporciona acceso global** mediante Singleton
4. **Centraliza la configuración** (fácil cambiar implementaciones)

### Crear ApplicationContext.java

```java
package cl.tuusuario.pnb.app;

import cl.tuusuario.pnb.controller.*;
import cl.tuusuario.pnb.repository.*;
import cl.tuusuario.pnb.service.*;

/**
 * Contenedor de Inversión de Control (IoC) manual
 * Responsable de:
 * - Crear todas las instancias de repositorios, servicios y controladores
 * - Inyectar dependencias mediante constructores
 * - Proporcionar acceso centralizado a los componentes
 */
public class ApplicationContext {
    
    // Singleton
    private static ApplicationContext instance;
    
    // ============= REPOSITORIOS =============
    private IUsuarioRepository usuarioRepository;
    private IProductoRepository productoRepository;
    private IVentaRepository ventaRepository;
    
    // ============= SERVICIOS =============
    private UsuarioService usuarioService;
    private ProductoService productoService;
    private VentaService ventaService;
    
    // ============= CONTROLADORES =============
    private LoginController loginController;
    private UsuarioController usuarioController;
    private ProductoController productoController;
    private VentaController ventaController;
    
    /**
     * Constructor privado (Singleton)
     */
    private ApplicationContext() {
        inicializar();
    }
    
    /**
     * Obtiene la instancia única del contexto
     */
    public static ApplicationContext getInstance() {
        if (instance == null) {
            instance = new ApplicationContext();
        }
        return instance;
    }
    
    /**
     * Inicializa todos los componentes con sus dependencias
     */
    private void inicializar() {
        System.out.println("🔧 Inicializando ApplicationContext...");
        
        // 1. Crear repositorios (sin dependencias)
        inicializarRepositorios();
        
        // 2. Crear servicios (inyectando repositorios)
        inicializarServicios();
        
        // 3. Crear controladores (inyectando servicios)
        inicializarControllers();
        
        System.out.println("✅ ApplicationContext inicializado correctamente");
    }
    
    /**
     * Paso 1: Inicializar repositorios
     * Por ahora usamos implementaciones Mock
     * En la Clase 4, cambiaremos a implementaciones JDBC
     */
    private void inicializarRepositorios() {
        System.out.println("  📦 Creando repositorios Mock...");
        
        // Crear instancias Mock
        usuarioRepository = new UsuarioRepositoryMock();
        productoRepository = new ProductoRepositoryMock();
        ventaRepository = new VentaRepositoryMock();
        
        System.out.println("  ✓ Repositorios creados");
    }
    
    /**
     * Paso 2: Inicializar servicios con inyección de dependencias
     */
    private void inicializarServicios() {
        System.out.println("  💼 Creando servicios e inyectando repositorios...");
        
        // Inyectar repositorios en servicios (DI por constructor)
        usuarioService = new UsuarioService(usuarioRepository);
        productoService = new ProductoService(productoRepository);
        ventaService = new VentaService(ventaRepository);
        
        System.out.println("  ✓ Servicios creados");
    }
    
    /**
     * Paso 3: Inicializar controladores con inyección de dependencias
     */
    private void inicializarControllers() {
        System.out.println("  🎮 Creando controladores e inyectando servicios...");
        
        // Inyectar servicios en controladores (DI por constructor)
        loginController = new LoginController(usuarioService);
        usuarioController = new UsuarioController(usuarioService);
        productoController = new ProductoController(productoService);
        ventaController = new VentaController(ventaService);
        
        System.out.println("  ✓ Controladores creados");
    }
    
    // ============= GETTERS PÚBLICOS =============
    
    /**
     * Obtiene el controlador de login
     */
    public LoginController getLoginController() {
        return loginController;
    }
    
    /**
     * Obtiene el controlador de usuarios
     */
    public UsuarioController getUsuarioController() {
        return usuarioController;
    }
    
    /**
     * Obtiene el controlador de productos
     */
    public ProductoController getProductoController() {
        return productoController;
    }
    
    /**
     * Obtiene el controlador de ventas
     */
    public VentaController getVentaController() {
        return ventaController;
    }
    
    /**
     * Reinicia el contexto (útil para testing)
     */
    public static void reset() {
        instance = null;
    }
}
```

### ¿Cómo funciona el flujo de inyección?

```
ApplicationContext.getInstance()
│
├─> inicializarRepositorios()
│   ├─> usuarioRepository = new UsuarioRepositoryMock()
│   ├─> productoRepository = new ProductoRepositoryMock()
│   └─> ventaRepository = new VentaRepositoryMock()
│
├─> inicializarServicios()
│   ├─> usuarioService = new UsuarioService(usuarioRepository) ← DI
│   ├─> productoService = new ProductoService(productoRepository) ← DI
│   └─> ventaService = new VentaService(ventaRepository) ← DI
│
└─> inicializarControllers()
    ├─> loginController = new LoginController(usuarioService) ← DI
    ├─> usuarioController = new UsuarioController(usuarioService) ← DI
    ├─> productoController = new ProductoController(productoService) ← DI
    └─> ventaController = new VentaController(ventaService) ← DI
```
**Ventajas de este enfoque:**
- ✅ **Centralizado:** Todas las dependencias en un solo lugar
- ✅ **Fácil de cambiar:** Cambiar de Mock a JDBC solo requiere modificar `inicializarRepositorios()`
- ✅ **Singleton:** Una única instancia compartida en toda la aplicación
- ✅ **Testeable:** Podemos hacer `reset()` para testing
---
## 🔐 Paso 2 – Refactorizar LoginForm
Ahora vamos a conectar el `LoginForm` con el `LoginController`.
### Nota importante:
En esta sección solo proporcionaremos los **cambios clave** que se deben realizar. No necesitas reescribir todo el archivo, solo agrega o modifica las partes indicadas.
### Cambios en LoginForm.java:
**1. Agregar campo del controller (al inicio de la clase):**
```java
private LoginController controller;
```
**2. En el constructor, inicializar el controller:**
```java
public LoginForm() {
    // Obtener controller del contexto
    this.controller = ApplicationContext.getInstance().getLoginController();
    initComponents(); // Ya existente
    setLocationRelativeTo(null); // Ya existente
}
```
**3. Modificar el método btnLoginActionPerformed:**
```java
private void btnLoginActionPerformed(ActionEvent evt) {
    String username = txtUsername.getText().trim();
    String password = new String(txtPassword.getPassword());
    if (username.isEmpty() || password.isEmpty()) {
        JOptionPane.showMessageDialog(this,
            "Por favor completa todos los campos",
            "Validación",
            JOptionPane.WARNING_MESSAGE);
        return;
    }
    try {
        Usuario usuario = controller.autenticar(username, password);
        JOptionPane.showMessageDialog(this,
            "¡Bienvenido " + usuario.getNombreCompleto() + "!",
            "Login exitoso",
            JOptionPane.INFORMATION_MESSAGE);
        this.dispose();
        new MainFrame(usuario).setVisible(true);
    } catch (Exception e) {
        JOptionPane.showMessageDialog(this,
            e.getMessage(),
            "Error de autenticación",
            JOptionPane.ERROR_MESSAGE);
        txtPassword.setText("");
    }
}
```
### Modificar MainFrame para recibir Usuario:
**1. Agregar campo:**
```java
private Usuario usuarioActual;
```
**2. Modificar constructor:**
```java
public MainFrame(Usuario usuario) {
    this.usuarioActual = usuario;
    initComponents();
    setupNavigation(); // Ya existente
    personalizarPorRol();
    setLocationRelativeTo(null);
}
private void personalizarPorRol() {
    setTitle("Pixel & Bean - " + usuarioActual.getNombreCompleto() + 
             " (" + usuarioActual.getRol() + ")");
}
```
---
## 👥 Paso 3 – Refactorizar UsuariosPanel
### Cambios clave en UsuariosPanel.java:
**1. Agregar campo del controller:**
```java
private UsuarioController controller;
```
**2. En el constructor:**
```java
public UsuariosPanel() {
    this.controller = ApplicationContext.getInstance().getUsuarioController();
    initComponents();
    setupTable(); // Ya existente
    setupListeners(); // Ya existente
    cargarUsuarios(); // Modificado abajo
    limpiarFormulario(); // Ya existente
}
```
**3. Modificar cargarUsuarios():**
```java
private void cargarUsuarios() {
    try {
        List<Usuario> usuarios = controller.listarTodos();
        tableModel.setUsuarios(usuarios);
    } catch (Exception e) {
        JOptionPane.showMessageDialog(this,
            "Error al cargar usuarios: " + e.getMessage(),
            "Error",
            JOptionPane.ERROR_MESSAGE);
    }
}
```
**4. Modificar btnGuardarActionPerformed:**
```java
private void btnGuardarActionPerformed(ActionEvent evt) {
    String username = txtUsername.getText().trim();
    String password = new String(txtPassword.getPassword()).trim();
    String nombreCompleto = txtNombreCompleto.getText().trim();
    String rol = (String) cmbRol.getSelectedItem();
    boolean activo = chkActivo.isSelected();
    try {
        if (usuarioSeleccionado == null) {
            controller.crear(username, password, nombreCompleto, rol);
            JOptionPane.showMessageDialog(this,
                "Usuario creado exitosamente",
                "Éxito",
                JOptionPane.INFORMATION_MESSAGE);
        } else {
            controller.actualizar(usuarioSeleccionado.getId(), username, password,
                                nombreCompleto, rol, activo);
            JOptionPane.showMessageDialog(this,
                "Usuario actualizado exitosamente",
                "Éxito",
                JOptionPane.INFORMATION_MESSAGE);
        }
        limpiarFormulario();
        cargarUsuarios();
    } catch (IllegalArgumentException e) {
        JOptionPane.showMessageDialog(this,
            e.getMessage(),
            "Validación",
            JOptionPane.WARNING_MESSAGE);
    } catch (RuntimeException e) {
        JOptionPane.showMessageDialog(this,
            e.getMessage(),
            "Error",
            JOptionPane.ERROR_MESSAGE);
    }
}
```
**5. Modificar btnEliminarActionPerformed:**
```java
private void btnEliminarActionPerformed(ActionEvent evt) {
    if (usuarioSeleccionado == null) return;
    int respuesta = JOptionPane.showConfirmDialog(this,
        "¿Eliminar el usuario '" + usuarioSeleccionado.getUsername() + "'?",
        "Confirmar",
        JOptionPane.YES_NO_OPTION);
    if (respuesta == JOptionPane.YES_OPTION) {
        try {
            controller.eliminar(usuarioSeleccionado.getId());
            JOptionPane.showMessageDialog(this,
                "Usuario eliminado",
                "Éxito",
                JOptionPane.INFORMATION_MESSAGE);
            limpiarFormulario();
            cargarUsuarios();
        } catch (RuntimeException e) {
            JOptionPane.showMessageDialog(this,
                e.getMessage(),
                "Error",
                JOptionPane.ERROR_MESSAGE);
        }
    }
}
```
**6. Agregar búsqueda en setupListeners():**
```java
private void setupListeners() {
    // ...código existente de selección...
    // Búsqueda en tiempo real
    txtBuscar.getDocument().addDocumentListener(new javax.swing.event.DocumentListener() {
        public void insertUpdate(javax.swing.event.DocumentEvent e) { filtrar(); }
        public void removeUpdate(javax.swing.event.DocumentEvent e) { filtrar(); }
        public void changedUpdate(javax.swing.event.DocumentEvent e) { }
        private void filtrar() {
            String texto = txtBuscar.getText();
            List<Usuario> usuarios = controller.buscar(texto);
            tableModel.setUsuarios(usuarios);
        }
    });
}
```
---
## 📦 Paso 4 – Refactorizar ProductosPanel
### Cambios similares a UsuariosPanel:
**1. Agregar controller:**
```java
private ProductoController controller;
public ProductosPanel() {
    this.controller = ApplicationContext.getInstance().getProductoController();
    // ...resto igual
}
```
**2. Cargar productos:**
```java
private void cargarProductos() {
    List<Producto> productos = controller.listarTodos();
    tableModel.setProductos(productos);
}
```
**3. Guardar:**
```java
private void btnGuardarActionPerformed(ActionEvent evt) {
    try {
        String nombre = txtNombre.getText();
        String categoria = (String) cmbCategoria.getSelectedItem();
        String tipo = (String) cmbTipo.getSelectedItem();
        double precio = Double.parseDouble(txtPrecio.getText());
        if (productoSeleccionado == null) {
            controller.crear(nombre, categoria, tipo, precio);
        } else {
            controller.actualizar(productoSeleccionado.getId(), nombre,
                                categoria, tipo, precio, chkActivo.isSelected());
        }
        JOptionPane.showMessageDialog(this, "Producto guardado");
        limpiarFormulario();
        cargarProductos();
    } catch (Exception e) {
        JOptionPane.showMessageDialog(this, e.getMessage(), "Error",
            JOptionPane.ERROR_MESSAGE);
    }
}
```
> 💡 **Patrón repetitivo:** Todas las vistas siguen el mismo patrón. Los estudiantes deben aplicar el mismo concepto en VentasPanel y ReportesPanel.
---
## 🧪 Paso 5 – Pruebas y Validación
### Verificar que la aplicación funcione:
1. **Compilar el proyecto** (eliminar errores si los hay)
2. **Ejecutar la aplicación**
3. **Probar login:**
   - Usuario: `admin` / Password: `admin123`
   - Debe entrar correctamente
4. **Probar gestión de usuarios:**
   - Crear nuevo usuario
   - Editar usuario existente
   - Intentar eliminar el último admin (debe dar error)
   - Buscar usuarios
5. **Probar gestión de productos:**
   - Crear producto
   - Editar producto
   - Cambiar estado
### Verificar que las validaciones funcionen:
- ❌ Crear usuario sin username → Error
- ❌ Crear usuario con password corta → Error
- ❌ Crear usuario con username duplicado → Error
- ❌ Crear producto con precio 0 → Error
---
## 🧹 Paso 6 – Limpieza y Versionamiento
### Limpieza:
```bash
# Eliminar imports no usados
# En NetBeans: Clic derecho → Fix Imports
# En IntelliJ: Ctrl+Alt+O
# Formatear código
# En NetBeans: Alt+Shift+F
# En IntelliJ: Ctrl+Alt+L
```
### Git:
```bash
git add .
git commit -m "feat: Implementar arquitectura MVC con IoC
- Crear ApplicationContext (contenedor IoC)
- Implementar inyección de dependencias
- Refactorizar vistas para usar controladores
- Separar completamente UI de lógica de negocio
Clase 3 completada"
git push origin main
```
---
## ✅ Resultado Final de la Clase 3
### Arquitectura completa:
```
┌──────────────┐
│     GUI      │  ← LoginForm, UsuariosPanel, ProductosPanel
└──────┬───────┘
       │ usa
       ↓
┌──────────────┐
│  CONTROLLER  │  ← LoginController, UsuarioController, etc.
└──────┬───────┘
       │ usa
       ↓
┌──────────────┐
│   SERVICE    │  ← UsuarioService, ProductoService, etc.
└──────┬───────┘
       │ usa
       ↓
┌──────────────┐
│  REPOSITORY  │  ← IUsuarioRepository (interfaz)
└──────┬───────┘
       │ implementa
       ↓
┌──────────────┐
│     MOCK     │  ← UsuarioRepositoryMock (temporal)
└──────────────┘
```
### Logros:
- ✅ Arquitectura en capas implementada
- ✅ Separación de responsabilidades (SoC)
- ✅ Inversión de Control (IoC) manual
- ✅ Inyección de Dependencias por constructor
- ✅ Interfaces como contratos
- ✅ Aplicación funcionando con datos Mock
- ✅ **Preparado para conectar BD en Clase 4**
---
## 💡 Próxima Clase
**Clase 4: Conexión a Base de Datos con JDBC**
Lo mejor de nuestra arquitectura:
```java
// Clase 3 (ahora):
usuarioRepository = new UsuarioRepositoryMock();
// Clase 4 (próxima):
usuarioRepository = new UsuarioRepositoryJDBC(connection);
// ¡Y TODO el resto del código sigue igual! 🎉
```
**Cambios necesarios en Clase 4:**
- Crear `UsuarioRepositoryJDBC` que implemente `IUsuarioRepository`
- Crear `ProductoRepositoryJDBC` que implemente `IProductoRepository`
- Crear `VentaRepositoryJDBC` que implemente `IVentaRepository`
- Modificar **solo** `ApplicationContext.inicializarRepositorios()`
- Services, Controllers y Vistas **NO cambian**
---
> 🏗️ *"La buena arquitectura hace que los cambios futuros sean triviales."*
>
> 🎯 *"Si puedes cambiar la fuente de datos sin tocar 90% del código, lo hiciste bien."*
**¡Clase 3 completada-20 /home/tuusuario/Github/tuusuario/PixelAndBean/docs/00-lessons/03-mvc-architecture/03-dependency-injection.md* 🎊
