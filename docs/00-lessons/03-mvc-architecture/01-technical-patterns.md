# 📖 Clase 3 (Parte 1) – Patrones de Diseño y Arquitectura MVC

**Objetivo:**  
Comprender los patrones de diseño fundamentales para aplicaciones empresariales, el patrón MVC en profundidad, Inversión de Control, Inyección de Dependencias y principios SOLID aplicados a Java Swing.

⏱️ **Duración estimada:** 30 minutos

**Distribución del tiempo:**
- Presentación de objetivos y comparación antes/después (5 min)
- Patrón MVC y separación de responsabilidades (10 min)
- IoC e Inyección de Dependencias (8 min)
- Repository, Service Layer y SOLID (7 min)

<!-- TOC -->
* [📖 Clase 3 (Parte 1) – Patrones de Diseño y Arquitectura MVC](#-clase-3-parte-1--patrones-de-diseño-y-arquitectura-mvc)
  * [🎯 Objetivos de la Clase 3](#-objetivos-de-la-clase-3)
  * [🗺️ Visión General del Proyecto](#-visión-general-del-proyecto)
    * [¿Dónde estamos?](#dónde-estamos)
    * [El problema actual](#el-problema-actual)
    * [La solución: Arquitectura en capas](#la-solución-arquitectura-en-capas)
  * [📚 Apartado Técnico – Patrones y Arquitectura](#-apartado-técnico--patrones-y-arquitectura)
    * [🔷 1. Patrón MVC (Model-View-Controller)](#-1-patrón-mvc-model-view-controller)
    * [🔷 2. Separación de Responsabilidades (SoC)](#-2-separación-de-responsabilidades-soc)
    * [🔷 3. Inversión de Control (IoC)](#-3-inversión-de-control-ioc)
    * [🔷 4. Inyección de Dependencias (DI)](#-4-inyección-de-dependencias-di)
    * [🔷 5. Patrón Repository (DAO)](#-5-patrón-repository-dao)
    * [🔷 6. Service Layer (Capa de Servicios)](#-6-service-layer-capa-de-servicios)
    * [🔷 7. SOLID – Principios de Diseño](#-7-solid--principios-de-diseño)
    * [🔷 8. Interfaces como Contratos](#-8-interfaces-como-contratos)
    * [🔷 9. Anti-patrones a Evitar](#-9-anti-patrones-a-evitar)
    * [🔷 10. MVC en Swing: Consideraciones Especiales](#-10-mvc-en-swing-consideraciones-especiales)
  * [🎯 Resumen Técnico](#-resumen-técnico)
  * [💡 Siguiente Paso](#-siguiente-paso)
<!-- TOC -->

---

## 🎯 Objetivos de la Clase 3

Al finalizar esta clase serás capaz de:

1. **Comprender y aplicar el patrón MVC** en aplicaciones Swing
2. **Separar responsabilidades** en capas bien definidas
3. **Implementar Inversión de Control** e Inyección de Dependencias manual
4. **Diseñar con interfaces** como contratos entre capas
5. **Aplicar principios SOLID** en código real
6. **Crear arquitectura escalable** preparada para crecimiento
7. **Refactorizar código existente** sin romper funcionalidad

---

## 🗺️ Visión General del Proyecto

### ¿Dónde estamos?

| Clase | Estado       | Entregable                           |
|-------|--------------|--------------------------------------|
| **1** | ✅ Completada | Login + MainFrame con menú           |
| **2** | ✅ Completada | Todas las vistas con datos mock      |
| **3** | 🔄 En curso  | **Arquitectura MVC + IoC**           |
| 4     | ⏳ Pendiente  | Conexión a BD (JDBC)                 |
| 5     | ⏳ Pendiente  | CRUD completo funcional              |
| 6     | ⏳ Pendiente  | Empaquetado y release                |

### El problema actual

Actualmente tenemos una aplicación funcional pero con código monolítico:

```
┌─────────────────────────────────────┐
│         UsuariosPanel.java          │
│  ┌───────────────────────────────┐  │
│  │  • Interfaz gráfica (UI)      │  │
│  │  • Validaciones               │  │
│  │  • Lógica de negocio          │  │
│  │  • Datos hardcodeados         │  │
│  │  • TODO mezclado en un lugar  │  │
│  └───────────────────────────────┘  │
└─────────────────────────────────────┘
```

**Problemas:**
- ❌ Código difícil de mantener
- ❌ Imposible probar sin abrir la interfaz
- ❌ No se puede reutilizar lógica
- ❌ Cambios en datos requieren modificar vistas
- ❌ Trabajo en equipo complicado

### La solución: Arquitectura en capas

Vamos a refactorizar a esta estructura:

```
┌──────────────┐
│  VIEW (GUI)  │  ← Solo interfaz gráfica
└──────┬───────┘
       │ delega eventos
       ↓
┌──────────────┐
│ CONTROLLER   │  ← Coordina flujo
└──────┬───────┘
       │ usa
       ↓
┌──────────────┐
│  SERVICE     │  ← Lógica de negocio
└──────┬───────┘
       │ persiste via
       ↓
┌──────────────┐
│ REPOSITORY   │  ← Acceso a datos
└──────┬───────┘
       │ retorna
       ↓
┌──────────────┐
│   MODEL      │  ← Entidades (POJOs)
└──────────────┘
```

**Beneficios:**
- ✅ Cada capa tiene una responsabilidad clara
- ✅ Testeable en cada nivel
- ✅ Reutilizable en diferentes contextos
- ✅ Cambiar tecnología de datos sin tocar vistas
- ✅ Múltiples desarrolladores pueden trabajar en paralelo

---

## 📚 Apartado Técnico – Patrones y Arquitectura

### 🔷 1. Patrón MVC (Model-View-Controller)

**Definición:**  
MVC es un patrón arquitectónico que separa una aplicación en tres componentes interconectados:

| Componente     | Responsabilidad                                     | En nuestro proyecto                       |
|----------------|-----------------------------------------------------|-------------------------------------------|
| **Model**      | Representar datos y lógica de negocio               | `Usuario`, `Producto`, `Venta`            |
| **View**       | Presentar información al usuario                    | `LoginForm`, `UsuariosPanel`, etc.        |
| **Controller** | Manejar entrada del usuario y actualizar Model/View | `UsuarioController`, `ProductoController` |

#### Flujo de interacción:

```
         Usuario interactúa
              │
              ↓
    ┌──────────────────┐
    │      VIEW        │
    │  (UsuariosPanel) │
    └────────┬─────────┘
             │ 1. Evento (clic botón)
             ↓
    ┌──────────────────┐
    │   CONTROLLER     │
    │(UsuarioController)│
    └────────┬─────────┘
             │ 2. Llama método
             ↓
    ┌──────────────────┐
    │    SERVICE       │
    │ (UsuarioService) │
    └────────┬─────────┘
             │ 3. Valida y persiste
             ↓
    ┌──────────────────┐
    │   REPOSITORY     │
    │(UsuarioRepository)│
    └────────┬─────────┘
             │ 4. Retorna datos
             ↓
    ┌──────────────────┐
    │      MODEL       │
    │    (Usuario)     │
    └──────────────────┘
             │ 5. Datos actualizados
             ↓
    ┌──────────────────┐
    │      VIEW        │
    │  (actualiza UI)  │
    └──────────────────┘
```

#### Ejemplo concreto:

**Antes (sin MVC):**
```java
// UsuariosPanel.java - TODO en un solo lugar
private void btnGuardarActionPerformed(ActionEvent evt) {
    // Validar
    if (txtUsername.getText().isEmpty()) {
        JOptionPane.showMessageDialog(this, "Username requerido");
        return;
    }
    
    // Crear objeto
    Usuario u = new Usuario();
    u.setUsername(txtUsername.getText());
    u.setPassword(txtPassword.getText());
    u.setRol(comboRol.getSelectedItem().toString());
    
    // "Guardar" (hardcoded)
    listaUsuarios.add(u);
    
    // Actualizar tabla
    cargarTabla();
    JOptionPane.showMessageDialog(this, "Usuario guardado");
}
```

**Después (con MVC):**
```java
// UsuariosPanel.java - SOLO UI
private UsuarioController controller;

private void btnGuardarActionPerformed(ActionEvent evt) {
    try {
        controller.guardarUsuario(
            txtUsername.getText(),
            txtPassword.getText(),
            txtNombreCompleto.getText(),
            comboRol.getSelectedItem().toString()
        );
        mostrarExito("Usuario guardado exitosamente");
        limpiarFormulario();
        cargarTabla();
    } catch (ValidationException e) {
        mostrarError(e.getMessage());
    }
}

// UsuarioController.java - Coordinación
public void guardarUsuario(String username, String password, 
                           String nombre, String rol) {
    service.crear(username, password, nombre, rol);
}

// UsuarioService.java - Lógica de negocio
public void crear(String username, String password, 
                  String nombre, String rol) {
    ValidationUtil.requireNonEmpty(username, "Username");
    ValidationUtil.requireNonEmpty(password, "Password");
    
    if (repository.existeUsername(username)) {
        throw new BusinessException("Username ya existe");
    }
    
    Usuario usuario = new Usuario();
    usuario.setUsername(username);
    usuario.setPassword(password);
    usuario.setNombreCompleto(nombre);
    usuario.setRol(rol);
    usuario.setActivo(true);
    
    repository.guardar(usuario);
}

// IUsuarioRepository.java - Contrato
public interface IUsuarioRepository {
    void guardar(Usuario usuario);
    boolean existeUsername(String username);
}

// UsuarioRepositoryMock.java - Implementación temporal
public class UsuarioRepositoryMock implements IUsuarioRepository {
    private List<Usuario> usuarios = new ArrayList<>();
    
    @Override
    public void guardar(Usuario usuario) {
        usuarios.add(usuario);
    }
    
    @Override
    public boolean existeUsername(String username) {
        return usuarios.stream()
            .anyMatch(u -> u.getUsername().equals(username));
    }
}
```

---

### 🔷 2. Separación de Responsabilidades (SoC)

**Definición:**  
Separation of Concerns es el principio de dividir un programa en secciones distintas, donde cada sección aborda una "preocupación" específica.

**En nuestro proyecto:**

| Capa | Preocupación | Ejemplo |
|------|--------------|---------|
| **GUI** | Mostrar información y capturar eventos | `UsuariosPanel` muestra formulario |
| **Controller** | Coordinar flujo entre capas | `UsuarioController` recibe evento y llama servicio |
| **Service** | Reglas de negocio y validaciones | `UsuarioService` valida username único |
| **Repository** | Acceso y persistencia de datos | `UsuarioRepository` guarda en BD |
| **Model** | Representar entidades del dominio | `Usuario` con sus atributos |

**Regla de oro:**  
> Si una clase tiene más de una razón para cambiar, viola SoC.

**Ejemplo:**
```java
// ❌ MAL: Una clase con múltiples responsabilidades
class UsuariosPanel {
    // Responsabilidad 1: UI
    private void crearInterfaz() { }
    
    // Responsabilidad 2: Validación
    private boolean validarFormulario() { }
    
    // Responsabilidad 3: Acceso a datos
    private void guardarEnBD() { }
    
    // Responsabilidad 4: Lógica de negocio
    private void aplicarReglasDeNegocio() { }
}

// ✅ BIEN: Cada clase una responsabilidad
class UsuariosPanel { /* Solo UI */ }
class UsuarioController { /* Solo coordinación */ }
class UsuarioService { /* Solo lógica de negocio */ }
class UsuarioRepository { /* Solo acceso a datos */ }
```

---

### 🔷 3. Inversión de Control (IoC)

**Definición:**  
Inversión de Control es un principio donde el flujo de control de un programa se invierte: en lugar de que tu código llame a un framework, el framework llama a tu código.

**Concepto tradicional vs IoC:**

```java
// ❌ Control tradicional (la clase crea sus dependencias)
class UsuarioController {
    private UsuarioService service;
    
    public UsuarioController() {
        // Controller decide qué implementación usar
        this.service = new UsuarioService();
    }
}

// ✅ Inversión de Control (las dependencias se inyectan)
class UsuarioController {
    private UsuarioService service;
    
    // Constructor recibe dependencias desde afuera
    public UsuarioController(UsuarioService service) {
        this.service = service;
    }
}
```

**¿Quién inyecta las dependencias?**  
Un **contenedor IoC** (en nuestro caso, lo haremos manual con `ApplicationContext`).

**Beneficios:**
- ✅ Bajo acoplamiento
- ✅ Fácil cambiar implementaciones
- ✅ Testeable (puedes inyectar mocks)
- ✅ Reutilizable

---

### 🔷 4. Inyección de Dependencias (DI)

**Definición:**  
Dependency Injection es una técnica donde un objeto recibe otros objetos que depende, en lugar de crearlos él mismo.

**Tipos de Inyección:**

#### 1. Inyección por Constructor (recomendada)
```java
class UsuarioService {
    private final IUsuarioRepository repository;
    
    // Dependencias obligatorias en constructor
    public UsuarioService(IUsuarioRepository repository) {
        this.repository = repository;
    }
}
```
✅ Garantiza que el objeto siempre esté completo  
✅ Inmutable (final)  
✅ Testeable

#### 2. Inyección por Setter
```java
class UsuarioService {
    private IUsuarioRepository repository;
    
    // Dependencia opcional vía setter
    public void setRepository(IUsuarioRepository repository) {
        this.repository = repository;
    }
}
```
⚠️ Objeto puede estar incompleto  
⚠️ Mutable

#### 3. Inyección por Interfaz
```java
interface RepositoryAware {
    void setRepository(IUsuarioRepository repository);
}

class UsuarioService implements RepositoryAware {
    private IUsuarioRepository repository;
    
    @Override
    public void setRepository(IUsuarioRepository repository) {
        this.repository = repository;
    }
}
```
⚠️ Más complejo, poco usado en proyectos pequeños

**En este proyecto usaremos Inyección por Constructor.**

**Ejemplo completo:**
```java
// 1. Interfaz del repositorio (contrato)
public interface IUsuarioRepository {
    List<Usuario> listarTodos();
    void guardar(Usuario usuario);
}

// 2. Implementación Mock
public class UsuarioRepositoryMock implements IUsuarioRepository {
    private List<Usuario> usuarios = new ArrayList<>();
    
    @Override
    public List<Usuario> listarTodos() {
        return new ArrayList<>(usuarios);
    }
    
    @Override
    public void guardar(Usuario usuario) {
        usuarios.add(usuario);
    }
}

// 3. Service con DI por constructor
public class UsuarioService {
    private final IUsuarioRepository repository;
    
    public UsuarioService(IUsuarioRepository repository) {
        this.repository = repository;
    }
    
    public List<Usuario> listarTodos() {
        return repository.listarTodos();
    }
    
    public void crear(String username, String password, 
                     String nombre, String rol) {
        // Validaciones
        Usuario u = new Usuario();
        u.setUsername(username);
        u.setPassword(password);
        u.setNombreCompleto(nombre);
        u.setRol(rol);
        
        repository.guardar(u);
    }
}

// 4. Controller con DI por constructor
public class UsuarioController {
    private final UsuarioService service;
    
    public UsuarioController(UsuarioService service) {
        this.service = service;
    }
    
    public void guardarUsuario(String username, String password,
                               String nombre, String rol) {
        service.crear(username, password, nombre, rol);
    }
    
    public List<Usuario> listarUsuarios() {
        return service.listarTodos();
    }
}

// 5. ApplicationContext - ensambla todo
public class ApplicationContext {
    private static ApplicationContext instance;
    
    // Repositorios
    private IUsuarioRepository usuarioRepository;
    
    // Servicios
    private UsuarioService usuarioService;
    
    // Controllers
    private UsuarioController usuarioController;
    
    private ApplicationContext() {
        inicializarRepositorios();
        inicializarServicios();
        inicializarControllers();
    }
    
    private void inicializarRepositorios() {
        // Por ahora Mock, después será JDBC
        usuarioRepository = new UsuarioRepositoryMock();
    }
    
    private void inicializarServicios() {
        // Inyectar repositorio en servicio
        usuarioService = new UsuarioService(usuarioRepository);
    }
    
    private void inicializarControllers() {
        // Inyectar servicio en controller
        usuarioController = new UsuarioController(usuarioService);
    }
    
    public static ApplicationContext getInstance() {
        if (instance == null) {
            instance = new ApplicationContext();
        }
        return instance;
    }
    
    public UsuarioController getUsuarioController() {
        return usuarioController;
    }
}

// 6. Vista usa el controller
public class UsuariosPanel extends JPanel {
    private UsuarioController controller;
    
    public UsuariosPanel() {
        // Obtener controller del contexto
        this.controller = ApplicationContext.getInstance()
                                             .getUsuarioController();
        initComponents();
    }
    
    private void btnGuardarActionPerformed(ActionEvent evt) {
        try {
            controller.guardarUsuario(
                txtUsername.getText(),
                txtPassword.getText(),
                txtNombreCompleto.getText(),
                comboRol.getSelectedItem().toString()
            );
            cargarTabla();
        } catch (Exception e) {
            mostrarError(e.getMessage());
        }
    }
    
    private void cargarTabla() {
        List<Usuario> usuarios = controller.listarUsuarios();
        // Actualizar JTable...
    }
}
```

---

### 🔷 5. Patrón Repository (DAO)

**Definición:**  
El patrón Repository encapsula la lógica necesaria para acceder a fuentes de datos. Centraliza la funcionalidad común de acceso a datos.

**También conocido como:** DAO (Data Access Object)

**Ventajas:**
- ✅ Abstrae el origen de datos (puede ser BD, archivo, API, mock)
- ✅ Centraliza consultas y operaciones de persistencia
- ✅ Facilita testing (podemos inyectar mocks)
- ✅ Cambiar de BD a archivo solo requiere cambiar implementación

**Estructura:**

```java
// Interfaz - Contrato de operaciones
public interface IUsuarioRepository {
    // Operaciones CRUD básicas
    Usuario buscarPorId(int id);
    List<Usuario> listarTodos();
    List<Usuario> buscarPorRol(String rol);
    void guardar(Usuario usuario);
    void actualizar(Usuario usuario);
    void eliminar(int id);
    
    // Consultas especiales
    boolean existeUsername(String username);
    Usuario buscarPorUsername(String username);
}

// Implementación Mock (para Clase 3 y 4)
public class UsuarioRepositoryMock implements IUsuarioRepository {
    private List<Usuario> usuarios = new ArrayList<>();
    private int nextId = 1;
    
    public UsuarioRepositoryMock() {
        // Datos de ejemplo
        usuarios.add(new Usuario(nextId++, "admin", "admin123", 
                                 "Administrador", "ADMIN", true));
        usuarios.add(new Usuario(nextId++, "operador", "op123", 
                                 "Operador 1", "OPERADOR", true));
    }
    
    @Override
    public Usuario buscarPorId(int id) {
        return usuarios.stream()
            .filter(u -> u.getId() == id)
            .findFirst()
            .orElse(null);
    }
    
    @Override
    public List<Usuario> listarTodos() {
        return new ArrayList<>(usuarios); // Copia defensiva
    }
    
    @Override
    public void guardar(Usuario usuario) {
        usuario.setId(nextId++);
        usuarios.add(usuario);
    }
    
    @Override
    public boolean existeUsername(String username) {
        return usuarios.stream()
            .anyMatch(u -> u.getUsername().equalsIgnoreCase(username));
    }
    
    // ... resto de métodos
}

// Implementación JDBC (para Clase 4 en adelante)
public class UsuarioRepositoryJDBC implements IUsuarioRepository {
    private Connection connection;
    
    public UsuarioRepositoryJDBC(Connection connection) {
        this.connection = connection;
    }
    
    @Override
    public Usuario buscarPorId(int id) {
        String sql = "SELECT * FROM usuario WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapearUsuario(rs);
            }
        } catch (SQLException e) {
            throw new RepositoryException("Error al buscar usuario", e);
        }
        return null;
    }
    
    @Override
    public void guardar(Usuario usuario) {
        String sql = "INSERT INTO usuario (username, password, " +
                     "nombreCompleto, rol, activo) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql, 
                                      Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, usuario.getUsername());
            stmt.setString(2, usuario.getPassword());
            stmt.setString(3, usuario.getNombreCompleto());
            stmt.setString(4, usuario.getRol());
            stmt.setBoolean(5, usuario.isActivo());
            
            stmt.executeUpdate();
            
            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                usuario.setId(rs.getInt(1));
            }
        } catch (SQLException e) {
            throw new RepositoryException("Error al guardar usuario", e);
        }
    }
    
    // ... resto de métodos
}
```

**Lo importante:**  
El Service NO sabe si está trabajando con Mock o JDBC. Solo conoce la interfaz `IUsuarioRepository`.

---

### 🔷 6. Service Layer (Capa de Servicios)

**Definición:**  
La capa de servicios contiene la lógica de negocio de la aplicación. Es el corazón del sistema.

**Responsabilidades:**
- ✅ Validaciones de negocio
- ✅ Aplicar reglas de negocio
- ✅ Orquestar operaciones complejas
- ✅ Transacciones (más adelante)
- ✅ Transformaciones de datos

**NO debe:**
- ❌ Conocer detalles de la UI (Swing, eventos, etc.)
- ❌ Conocer detalles de persistencia (SQL, archivos, etc.)
- ❌ Manejar eventos de usuario

**Ejemplo completo:**

```java
public class UsuarioService {
    private final IUsuarioRepository repository;
    
    public UsuarioService(IUsuarioRepository repository) {
        this.repository = repository;
    }
    
    /**
     * Crea un nuevo usuario con validaciones de negocio
     */
    public void crear(String username, String password, 
                     String nombreCompleto, String rol) {
        // 1. Validaciones básicas
        ValidationUtil.requireNonEmpty(username, "Username");
        ValidationUtil.requireNonEmpty(password, "Password");
        ValidationUtil.requireNonEmpty(nombreCompleto, "Nombre completo");
        ValidationUtil.requireNonEmpty(rol, "Rol");
        
        // 2. Validaciones de negocio
        if (username.length() < 4) {
            throw new ValidationException(
                "El username debe tener al menos 4 caracteres");
        }
        
        if (password.length() < 6) {
            throw new ValidationException(
                "La contraseña debe tener al menos 6 caracteres");
        }
        
        if (!rol.equals("ADMIN") && !rol.equals("OPERADOR")) {
            throw new ValidationException(
                "Rol inválido. Debe ser ADMIN u OPERADOR");
        }
        
        // 3. Reglas de negocio
        if (repository.existeUsername(username)) {
            throw new BusinessException(
                "El username '" + username + "' ya existe");
        }
        
        // 4. Crear entidad
        Usuario usuario = new Usuario();
        usuario.setUsername(username.trim().toLowerCase());
        usuario.setPassword(password); // TODO: hash en Clase 5
        usuario.setNombreCompleto(nombreCompleto.trim());
        usuario.setRol(rol);
        usuario.setActivo(true);
        
        // 5. Persistir
        repository.guardar(usuario);
    }
    
    /**
     * Actualiza un usuario existente
     */
    public void actualizar(int id, String username, String password,
                          String nombreCompleto, String rol, boolean activo) {
        // Validaciones...
        
        Usuario existente = repository.buscarPorId(id);
        if (existente == null) {
            throw new BusinessException("Usuario no encontrado");
        }
        
        // Si cambió el username, verificar que no exista
        if (!existente.getUsername().equals(username) && 
            repository.existeUsername(username)) {
            throw new BusinessException("El username ya existe");
        }
        
        existente.setUsername(username);
        if (password != null && !password.isEmpty()) {
            existente.setPassword(password);
        }
        existente.setNombreCompleto(nombreCompleto);
        existente.setRol(rol);
        existente.setActivo(activo);
        
        repository.actualizar(existente);
    }
    
    /**
     * Elimina un usuario (validando que no sea el último admin)
     */
    public void eliminar(int id) {
        Usuario usuario = repository.buscarPorId(id);
        if (usuario == null) {
            throw new BusinessException("Usuario no encontrado");
        }
        
        // Regla de negocio: No eliminar el último ADMIN
        if (usuario.getRol().equals("ADMIN")) {
            long cantidadAdmins = repository.listarTodos().stream()
                .filter(u -> u.getRol().equals("ADMIN"))
                .filter(Usuario::isActivo)
                .count();
            
            if (cantidadAdmins <= 1) {
                throw new BusinessException(
                    "No se puede eliminar el último administrador activo");
            }
        }
        
        repository.eliminar(id);
    }
    
    /**
     * Autentica un usuario
     */
    public Usuario autenticar(String username, String password) {
        ValidationUtil.requireNonEmpty(username, "Username");
        ValidationUtil.requireNonEmpty(password, "Password");
        
        Usuario usuario = repository.buscarPorUsername(username);
        
        if (usuario == null) {
            throw new AuthenticationException("Credenciales inválidas");
        }
        
        if (!usuario.isActivo()) {
            throw new AuthenticationException("Usuario inactivo");
        }
        
        // TODO: Verificar hash en Clase 5
        if (!usuario.getPassword().equals(password)) {
            throw new AuthenticationException("Credenciales inválidas");
        }
        
        return usuario;
    }
    
    /**
     * Lista todos los usuarios
     */
    public List<Usuario> listarTodos() {
        return repository.listarTodos();
    }
    
    /**
     * Lista usuarios activos solamente
     */
    public List<Usuario> listarActivos() {
        return repository.listarTodos().stream()
            .filter(Usuario::isActivo)
            .collect(Collectors.toList());
    }
}
```

---

### 🔷 7. SOLID – Principios de Diseño

SOLID es un acrónimo de cinco principios de diseño orientado a objetos:

#### **S - Single Responsibility Principle (SRP)**
> Una clase debe tener una única razón para cambiar.

```java
// ❌ MAL: Múltiples responsabilidades
class UsuarioManager {
    void guardarUsuario(Usuario u) { /* acceso a BD */ }
    void validarUsuario(Usuario u) { /* validación */ }
    void mostrarUsuario(Usuario u) { /* UI */ }
}

// ✅ BIEN: Cada clase una responsabilidad
class UsuarioRepository { void guardar(Usuario u) { } }
class UsuarioValidator { boolean validar(Usuario u) { } }
class UsuarioView { void mostrar(Usuario u) { } }
```

#### **O - Open/Closed Principle (OCP)**
> Abierto para extensión, cerrado para modificación.

```java
// ✅ BIEN: Usando interfaces y polimorfismo
interface IUsuarioRepository {
    void guardar(Usuario u);
}

// Podemos agregar nuevas implementaciones sin modificar el código existente
class UsuarioRepositoryMock implements IUsuarioRepository { }
class UsuarioRepositoryJDBC implements IUsuarioRepository { }
class UsuarioRepositoryFile implements IUsuarioRepository { }
```

#### **L - Liskov Substitution Principle (LSP)**
> Los objetos de una clase derivada deben poder reemplazar objetos de la clase base sin alterar el funcionamiento del programa.

```java
// ✅ BIEN: Cualquier implementación de IUsuarioRepository puede usarse
IUsuarioRepository repo = new UsuarioRepositoryMock();
// O
IUsuarioRepository repo = new UsuarioRepositoryJDBC();

// El servicio funciona igual con cualquier implementación
UsuarioService service = new UsuarioService(repo);
```

#### **I - Interface Segregation Principle (ISP)**
> Los clientes no deben depender de interfaces que no usan.

```java
// ❌ MAL: Interfaz muy grande
interface IUsuarioRepository {
    void guardar(Usuario u);
    void eliminar(int id);
    void exportarPDF();
    void enviarEmail();
    void generarReporte();
}

// ✅ BIEN: Interfaces segregadas
interface IUsuarioRepository {
    void guardar(Usuario u);
    void eliminar(int id);
}

interface IUsuarioExporter {
    void exportarPDF();
}

interface IUsuarioNotifier {
    void enviarEmail();
}
```

#### **D - Dependency Inversion Principle (DIP)**
> Depende de abstracciones, no de implementaciones concretas.

```java
// ❌ MAL: Dependencia de implementación concreta
class UsuarioService {
    private UsuarioRepositoryMock repository; // Acoplado a Mock
}

// ✅ BIEN: Dependencia de abstracción
class UsuarioService {
    private IUsuarioRepository repository; // Puede ser cualquier implementación
    
    public UsuarioService(IUsuarioRepository repository) {
        this.repository = repository;
    }
}
```

---

### 🔷 8. Interfaces como Contratos

**¿Por qué usar interfaces?**

1. **Contratos:** Definen QUÉ se debe hacer, no CÓMO
2. **Polimorfismo:** Múltiples implementaciones de un mismo contrato
3. **Testabilidad:** Fácil crear mocks
4. **Bajo acoplamiento:** Las capas se comunican vía interfaces

**Ejemplo en nuestro proyecto:**

```java
// Contrato: QUÉ operaciones están disponibles
public interface IUsuarioRepository {
    Usuario buscarPorId(int id);
    List<Usuario> listarTodos();
    void guardar(Usuario usuario);
    void actualizar(Usuario usuario);
    void eliminar(int id);
    boolean existeUsername(String username);
}

// Implementación 1: Mock (para desarrollo)
public class UsuarioRepositoryMock implements IUsuarioRepository {
    private List<Usuario> usuarios = new ArrayList<>();
    // Implementación en memoria...
}

// Implementación 2: JDBC (para producción)
public class UsuarioRepositoryJDBC implements IUsuarioRepository {
    private Connection connection;
    // Implementación con base de datos...
}

// Implementación 3: File (por si acaso)
public class UsuarioRepositoryFile implements IUsuarioRepository {
    private String filePath;
    // Implementación con archivos...
}

// El servicio NO conoce la implementación
public class UsuarioService {
    private final IUsuarioRepository repository; // Solo conoce la interfaz
    
    public UsuarioService(IUsuarioRepository repository) {
        this.repository = repository; // Puede ser cualquiera
    }
}
```

**Beneficios:**
- Cambiar de Mock a JDBC: ✅ Solo cambiar en ApplicationContext
- Crear tests: ✅ Fácil crear un Mock
- Agregar nueva fuente de datos: ✅ Solo crear nueva implementación

---

### 🔷 9. Anti-patrones a Evitar

#### 1. **God Class (Clase Dios)**
```java
// ❌ Una clase que hace todo
class SistemaCompleto {
    void login() { }
    void guardarUsuario() { }
    void generarReporte() { }
    void enviarEmail() { }
    void conectarBD() { }
    void validarFormulario() { }
    // 50 métodos más...
}
```

#### 2. **Lava Flow (Flujo de Lava)**
```java
// ❌ Código muerto que nadie se atreve a eliminar
class Usuario {
    // Estos métodos ya no se usan pero nadie los borra
    void metodoViejo1() { }
    void metodoQueNuncaFunciono() { }
    void experimentoFallido() { }
}
```

#### 3. **Spaghetti Code (Código Espagueti)**
```java
// ❌ Lógica entremezclada sin estructura
if (usuario != null) {
    if (validar()) {
        if (guardar()) {
            if (actualizar()) {
                if (mostrar()) {
                    // 10 niveles de anidación...
                }
            }
        }
    }
}
```

#### 4. **Magic Numbers (Números Mágicos)**
```java
// ❌ Valores hardcodeados sin contexto
if (usuario.getRol() == 1) { } // ¿Qué es 1?

// ✅ Usar constantes
public static final String ROL_ADMIN = "ADMIN";
if (usuario.getRol().equals(ROL_ADMIN)) { }
```

#### 5. **Tight Coupling (Acoplamiento Fuerte)**
```java
// ❌ Clases fuertemente acopladas
class UsuarioService {
    private UsuarioRepositoryMock repository = new UsuarioRepositoryMock();
    // No puedo cambiar la implementación
}

// ✅ Bajo acoplamiento con DI
class UsuarioService {
    private IUsuarioRepository repository;
    
    public UsuarioService(IUsuarioRepository repository) {
        this.repository = repository; // Puedo inyectar cualquier implementación
    }
}
```

---

### 🔷 10. MVC en Swing: Consideraciones Especiales

**Swing ya tiene su propio MVC:**
- `JTable` tiene un `TableModel` (Model)
- `JTable` es el componente visual (View)
- Listeners actúan como Controllers

**Nuestro MVC es a nivel de aplicación:**
- **Model:** Entidades de negocio (`Usuario`, `Producto`)
- **View:** Paneles completos (`UsuariosPanel`, `ProductosPanel`)
- **Controller:** Coordinan flujo (`UsuarioController`)

**Ambos MVC conviven:**
```
Aplicación MVC
├── View (UsuariosPanel)
│   ├── Swing MVC (JTable + TableModel)
│   └── Swing MVC (JComboBox + ComboBoxModel)
├── Controller (UsuarioController)
└── Model (Usuario)
```

**Importante:** No confundir el `TableModel` de Swing con nuestro Model de negocio.

---

## 🎯 Resumen Técnico

| Concepto | Definición | Beneficio clave |
|----------|-----------|-----------------|
| **MVC** | Separar UI, lógica y datos | Mantenibilidad |
| **SoC** | Cada clase una responsabilidad | Claridad |
| **IoC** | Framework controla el flujo | Flexibilidad |
| **DI** | Inyectar dependencias | Testabilidad |
| **Repository** | Abstrae acceso a datos | Independencia de BD |
| **Service** | Contiene lógica de negocio | Reutilización |
| **Interfaces** | Contratos entre capas | Bajo acoplamiento |
| **SOLID** | Principios de diseño OO | Calidad de código |

**Flujo completo:**
```
Usuario → View → Controller → Service → Repository → BD
                    ↓            ↓          ↓
                Coordina    Valida     Persiste
```

---

## 💡 Siguiente Paso

**Parte 2: Refactorización a Capas**

➡️ **[02-refactoring-layers.md](02-refactoring-layers.md)**

Ahora que comprendes los conceptos, es hora de aplicarlos. En la siguiente parte:
- Crearás la estructura de paquetes
- Implementarás interfaces de repositorios
- Crearás la capa de servicios
- Desarrollarás los controladores
- Separarás toda la lógica de las vistas

---

> 🧠 *"Comprender la teoría es el 50%. Aplicarla es el otro 90%."*
>
> 🏗️ *"Una buena arquitectura se nota cuando es fácil agregar nuevas funcionalidades."*

