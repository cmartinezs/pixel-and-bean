# 🏗️ Clase 3 (Parte 2) – Refactorización a Capas

**Objetivo:**  
Crear la estructura de paquetes completa, implementar interfaces de repositorios, desarrollar la capa de servicios y crear controladores para cada módulo, separando completamente la lógica de negocio de la interfaz gráfica.

⏱️ **Duración estimada:** 40 minutos

**Distribución del tiempo:**
- Crear estructura de paquetes (5 min)
- Interfaces de repositorios (8 min)
- Implementar repositorios Mock (10 min)
- Crear capa de servicios (10 min)
- Implementar controladores (7 min)

> 📌 **Pre-requisito:**  
> Antes de comenzar esta parte práctica, asegúrate de haber leído y comprendido los conceptos técnicos en **[01-technical-patterns.md](01-technical-patterns.md)**.

<!-- TOC -->
* [🏗️ Clase 3 (Parte 2) – Refactorización a Capas](#-clase-3-parte-2--refactorización-a-capas)
  * [🗂️ Estructura de esta sesión](#-estructura-de-esta-sesión)
  * [📦 Paso 1 – Crear estructura de paquetes](#-paso-1--crear-estructura-de-paquetes)
  * [📋 Paso 2 – Crear interfaces de repositorios](#-paso-2--crear-interfaces-de-repositorios)
  * [🔧 Paso 3 – Implementar repositorios Mock](#-paso-3--implementar-repositorios-mock)
  * [💼 Paso 4 – Crear capa de servicios](#-paso-4--crear-capa-de-servicios)
  * [🎮 Paso 5 – Crear controladores](#-paso-5--crear-controladores)
  * [✅ Resultado de esta parte](#-resultado-de-esta-parte)
  * [💡 Siguiente Paso](#-siguiente-paso)
<!-- TOC -->

---

## 🗂️ Estructura de esta sesión

| Tarea | Archivos a crear | Tiempo | Complejidad |
|-------|------------------|--------|-------------|
| Estructura de paquetes | 6 paquetes | 5 min | ⭐ |
| Interfaces Repository | 3 interfaces | 8 min | ⭐⭐⭐ |
| Repositorios Mock | 3 clases | 10 min | ⭐⭐⭐⭐ |
| Servicios | 3 clases | 10 min | ⭐⭐⭐⭐ |
| Controladores | 4 clases | 7 min | ⭐⭐⭐ |

---

## 📦 Paso 1 – Crear estructura de paquetes

Vamos a crear una arquitectura en capas bien organizada.

### Estructura final:

```
cl.tuusuario.pnb/
├── app/                    ← Nuevo: Configuración de aplicación
├── controller/             ← Nuevo: Controladores
├── service/                ← Nuevo: Lógica de negocio
├── repository/             ← Nuevo: Acceso a datos
│   └── mock/              ← Nuevo: Implementaciones Mock
├── model/                  ← Ya existe desde Clase 2
├── gui/                    ← Ya existe desde Clase 1
└── PixelAndBean.java       ← Ya existe
```

### En NetBeans/IntelliJ:

1. Clic derecho sobre `cl.tuusuario.pnb` → **New → Java Package**
2. Crear los siguientes paquetes:
   - `cl.tuusuario.pnb.app`
   - `cl.tuusuario.pnb.controller`
   - `cl.tuusuario.pnb.service`
   - `cl.tuusuario.pnb.repository`
   - `cl.tuusuario.pnb.repository.mock`

> 💡 **Nota:** El paquete `model` y `gui` ya existen de clases anteriores.

### Agregar .gitkeep (opcional):

Para que Git reconozca los paquetes vacíos, crea archivos `.gitkeep` en cada uno.

---

## 📋 Paso 2 – Crear interfaces de repositorios

Las interfaces definen el **contrato** de operaciones de acceso a datos.

### Interface: IUsuarioRepository.java

**Ubicación:** `cl.tuusuario.pnb.repository`

```java
package cl.tuusuario.pnb.repository;

import cl.tuusuario.pnb.model.Usuario;
import java.util.List;

/**
 * Contrato de operaciones para acceso a datos de Usuario
 */
public interface IUsuarioRepository {
    
    /**
     * Busca un usuario por su ID
     * @param id ID del usuario
     * @return Usuario encontrado o null
     */
    Usuario buscarPorId(int id);
    
    /**
     * Busca un usuario por su username
     * @param username Username a buscar
     * @return Usuario encontrado o null
     */
    Usuario buscarPorUsername(String username);
    
    /**
     * Lista todos los usuarios
     * @return Lista de todos los usuarios
     */
    List<Usuario> listarTodos();
    
    /**
     * Lista usuarios por rol
     * @param rol Rol a filtrar (ADMIN, OPERADOR)
     * @return Lista de usuarios con ese rol
     */
    List<Usuario> listarPorRol(String rol);
    
    /**
     * Guarda un nuevo usuario
     * @param usuario Usuario a guardar
     * @return ID generado
     */
    int guardar(Usuario usuario);
    
    /**
     * Actualiza un usuario existente
     * @param usuario Usuario con datos actualizados
     */
    void actualizar(Usuario usuario);
    
    /**
     * Elimina un usuario por ID
     * @param id ID del usuario a eliminar
     */
    void eliminar(int id);
    
    /**
     * Verifica si existe un username
     * @param username Username a verificar
     * @return true si existe, false si no
     */
    boolean existeUsername(String username);
    
    /**
     * Cuenta usuarios activos por rol
     * @param rol Rol a contar
     * @return Cantidad de usuarios activos con ese rol
     */
    int contarActivosPorRol(String rol);
}
```

### Interface: IProductoRepository.java

**Ubicación:** `cl.tuusuario.pnb.repository`

```java
package cl.tuusuario.pnb.repository;

import cl.tuusuario.pnb.model.Producto;
import java.util.List;

/**
 * Contrato de operaciones para acceso a datos de Producto
 */
public interface IProductoRepository {
    
    /**
     * Busca un producto por su ID
     */
    Producto buscarPorId(int id);
    
    /**
     * Lista todos los productos
     */
    List<Producto> listarTodos();
    
    /**
     * Lista productos activos solamente
     */
    List<Producto> listarActivos();
    
    /**
     * Lista productos por categoría
     * @param categoria BEBIDA, SNACK, TIEMPO
     */
    List<Producto> listarPorCategoria(String categoria);
    
    /**
     * Busca productos por nombre (búsqueda parcial)
     */
    List<Producto> buscarPorNombre(String nombre);
    
    /**
     * Guarda un nuevo producto
     */
    int guardar(Producto producto);
    
    /**
     * Actualiza un producto existente
     */
    void actualizar(Producto producto);
    
    /**
     * Elimina un producto por ID
     */
    void eliminar(int id);
    
    /**
     * Cambia el estado activo/inactivo de un producto
     */
    void cambiarEstado(int id, boolean activo);
}
```

### Interface: IVentaRepository.java

**Ubicación:** `cl.tuusuario.pnb.repository`

```java
package cl.tuusuario.pnb.repository;

import cl.tuusuario.pnb.model.Venta;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

/**
 * Contrato de operaciones para acceso a datos de Venta
 */
public interface IVentaRepository {
    
    /**
     * Busca una venta por su ID
     */
    Venta buscarPorId(int id);
    
    /**
     * Lista todas las ventas
     */
    List<Venta> listarTodas();
    
    /**
     * Lista ventas por rango de fechas
     */
    List<Venta> listarPorRangoFechas(LocalDateTime desde, LocalDateTime hasta);
    
    /**
     * Lista ventas del día actual
     */
    List<Venta> listarDelDia();
    
    /**
     * Lista ventas por usuario
     */
    List<Venta> listarPorUsuario(int usuarioId);
    
    /**
     * Guarda una nueva venta
     */
    int guardar(Venta venta);
    
    /**
     * Anula una venta
     */
    void anular(int id);
    
    /**
     * Calcula total de ventas por rango de fechas
     */
    double calcularTotalPorRango(LocalDateTime desde, LocalDateTime hasta);
    
    /**
     * Calcula total de ventas del día
     */
    double calcularTotalDelDia();
}
```

---

## 🔧 Paso 3 – Implementar repositorios Mock

Ahora implementaremos las interfaces con datos en memoria (Mock).

### Clase: UsuarioRepositoryMock.java

**Ubicación:** `cl.tuusuario.pnb.repository.mock`

```java
package cl.tuusuario.pnb.repository.mock;

import cl.tuusuario.pnb.model.Usuario;
import cl.tuusuario.pnb.repository.IUsuarioRepository;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Implementación Mock (en memoria) del repositorio de Usuario
 * Usaremos esto hasta tener la base de datos en Clase 4
 */
public class UsuarioRepositoryMock implements IUsuarioRepository {
    
    private List<Usuario> usuarios;
    private int nextId;
    
    public UsuarioRepositoryMock() {
        usuarios = new ArrayList<>();
        nextId = 1;
        cargarDatosIniciales();
    }
    
    private void cargarDatosIniciales() {
        // Usuarios de ejemplo
        usuarios.add(new Usuario(nextId++, "admin", "admin123", 
                                 "Administrador del Sistema", "ADMIN", true));
        usuarios.add(new Usuario(nextId++, "operador1", "op123", 
                                 "Juan Pérez", "OPERADOR", true));
        usuarios.add(new Usuario(nextId++, "operador2", "op456", 
                                 "María González", "OPERADOR", true));
        usuarios.add(new Usuario(nextId++, "cajero", "caj123", 
                                 "Pedro Ramírez", "OPERADOR", false));
    }
    
    @Override
    public Usuario buscarPorId(int id) {
        return usuarios.stream()
                .filter(u -> u.getId() == id)
                .findFirst()
                .orElse(null);
    }
    
    @Override
    public Usuario buscarPorUsername(String username) {
        return usuarios.stream()
                .filter(u -> u.getUsername().equalsIgnoreCase(username))
                .findFirst()
                .orElse(null);
    }
    
    @Override
    public List<Usuario> listarTodos() {
        return new ArrayList<>(usuarios); // Copia defensiva
    }
    
    @Override
    public List<Usuario> listarPorRol(String rol) {
        return usuarios.stream()
                .filter(u -> u.getRol().equalsIgnoreCase(rol))
                .collect(Collectors.toList());
    }
    
    @Override
    public int guardar(Usuario usuario) {
        usuario.setId(nextId++);
        usuarios.add(usuario);
        return usuario.getId();
    }
    
    @Override
    public void actualizar(Usuario usuario) {
        Usuario existente = buscarPorId(usuario.getId());
        if (existente != null) {
            int index = usuarios.indexOf(existente);
            usuarios.set(index, usuario);
        }
    }
    
    @Override
    public void eliminar(int id) {
        usuarios.removeIf(u -> u.getId() == id);
    }
    
    @Override
    public boolean existeUsername(String username) {
        return usuarios.stream()
                .anyMatch(u -> u.getUsername().equalsIgnoreCase(username));
    }
    
    @Override
    public int contarActivosPorRol(String rol) {
        return (int) usuarios.stream()
                .filter(u -> u.getRol().equalsIgnoreCase(rol))
                .filter(Usuario::isActivo)
                .count();
    }
}
```

### Clase: ProductoRepositoryMock.java

**Ubicación:** `cl.tuusuario.pnb.repository.mock`

```java
package cl.tuusuario.pnb.repository.mock;

import cl.tuusuario.pnb.model.Producto;
import cl.tuusuario.pnb.repository.IProductoRepository;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Implementación Mock (en memoria) del repositorio de Producto
 */
public class ProductoRepositoryMock implements IProductoRepository {
    
    private List<Producto> productos;
    private int nextId;
    
    public ProductoRepositoryMock() {
        productos = new ArrayList<>();
        nextId = 1;
        cargarDatosIniciales();
    }
    
    private void cargarDatosIniciales() {
        // Bebidas
        productos.add(new Producto(nextId++, "Espresso", "BEBIDA", "CAFE", 2500, true));
        productos.add(new Producto(nextId++, "Cappuccino", "BEBIDA", "CAFE", 3000, true));
        productos.add(new Producto(nextId++, "Latte", "BEBIDA", "CAFE", 3200, true));
        productos.add(new Producto(nextId++, "Americano", "BEBIDA", "CAFE", 2800, true));
        productos.add(new Producto(nextId++, "Coca-Cola", "BEBIDA", "GASEOSA", 1500, true));
        productos.add(new Producto(nextId++, "Sprite", "BEBIDA", "GASEOSA", 1500, true));
        
        // Snacks
        productos.add(new Producto(nextId++, "Brownie", "SNACK", "POSTRE", 2000, true));
        productos.add(new Producto(nextId++, "Cheesecake", "SNACK", "POSTRE", 2500, true));
        productos.add(new Producto(nextId++, "Papas Fritas", "SNACK", "SALADO", 1800, true));
        productos.add(new Producto(nextId++, "Nachos", "SNACK", "SALADO", 2200, true));
        
        // Tiempo de Arcade
        productos.add(new Producto(nextId++, "15 minutos", "TIEMPO", "ARCADE", 1500, true));
        productos.add(new Producto(nextId++, "30 minutos", "TIEMPO", "ARCADE", 2500, true));
        productos.add(new Producto(nextId++, "1 hora", "TIEMPO", "ARCADE", 4000, true));
        productos.add(new Producto(nextId++, "2 horas", "TIEMPO", "ARCADE", 7000, true));
    }
    
    @Override
    public Producto buscarPorId(int id) {
        return productos.stream()
                .filter(p -> p.getId() == id)
                .findFirst()
                .orElse(null);
    }
    
    @Override
    public List<Producto> listarTodos() {
        return new ArrayList<>(productos);
    }
    
    @Override
    public List<Producto> listarActivos() {
        return productos.stream()
                .filter(Producto::isActivo)
                .collect(Collectors.toList());
    }
    
    @Override
    public List<Producto> listarPorCategoria(String categoria) {
        return productos.stream()
                .filter(p -> p.getCategoria().equalsIgnoreCase(categoria))
                .collect(Collectors.toList());
    }
    
    @Override
    public List<Producto> buscarPorNombre(String nombre) {
        String nombreLower = nombre.toLowerCase();
        return productos.stream()
                .filter(p -> p.getNombre().toLowerCase().contains(nombreLower))
                .collect(Collectors.toList());
    }
    
    @Override
    public int guardar(Producto producto) {
        producto.setId(nextId++);
        productos.add(producto);
        return producto.getId();
    }
    
    @Override
    public void actualizar(Producto producto) {
        Producto existente = buscarPorId(producto.getId());
        if (existente != null) {
            int index = productos.indexOf(existente);
            productos.set(index, producto);
        }
    }
    
    @Override
    public void eliminar(int id) {
        productos.removeIf(p -> p.getId() == id);
    }
    
    @Override
    public void cambiarEstado(int id, boolean activo) {
        Producto producto = buscarPorId(id);
        if (producto != null) {
            producto.setActivo(activo);
        }
    }
}
```

### Clase: VentaRepositoryMock.java

**Ubicación:** `cl.tuusuario.pnb.repository.mock`

```java
package cl.tuusuario.pnb.repository.mock;

import cl.tuusuario.pnb.model.Venta;
import cl.tuusuario.pnb.repository.IVentaRepository;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Implementación Mock (en memoria) del repositorio de Venta
 */
public class VentaRepositoryMock implements IVentaRepository {
    
    private List<Venta> ventas;
    private int nextId;
    
    public VentaRepositoryMock() {
        ventas = new ArrayList<>();
        nextId = 1;
        cargarDatosIniciales();
    }
    
    private void cargarDatosIniciales() {
        // Ventas de ejemplo del día actual
        LocalDateTime ahora = LocalDateTime.now();
        
        ventas.add(new Venta(nextId++, ahora.minusHours(5), 1, "admin", 7500, "ACTIVA"));
        ventas.add(new Venta(nextId++, ahora.minusHours(4), 2, "operador1", 5000, "ACTIVA"));
        ventas.add(new Venta(nextId++, ahora.minusHours(3), 1, "admin", 12000, "ACTIVA"));
        ventas.add(new Venta(nextId++, ahora.minusHours(2), 3, "operador2", 3500, "ACTIVA"));
        ventas.add(new Venta(nextId++, ahora.minusHours(1), 2, "operador1", 8500, "ANULADA"));
        ventas.add(new Venta(nextId++, ahora.minusMinutes(30), 1, "admin", 6000, "ACTIVA"));
    }
    
    @Override
    public Venta buscarPorId(int id) {
        return ventas.stream()
                .filter(v -> v.getId() == id)
                .findFirst()
                .orElse(null);
    }
    
    @Override
    public List<Venta> listarTodas() {
        return new ArrayList<>(ventas);
    }
    
    @Override
    public List<Venta> listarPorRangoFechas(LocalDateTime desde, LocalDateTime hasta) {
        return ventas.stream()
                .filter(v -> !v.getFechaHora().isBefore(desde) && 
                            !v.getFechaHora().isAfter(hasta))
                .collect(Collectors.toList());
    }
    
    @Override
    public List<Venta> listarDelDia() {
        LocalDateTime inicioDia = LocalDate.now().atStartOfDay();
        LocalDateTime finDia = inicioDia.plusDays(1).minusSeconds(1);
        return listarPorRangoFechas(inicioDia, finDia);
    }
    
    @Override
    public List<Venta> listarPorUsuario(int usuarioId) {
        return ventas.stream()
                .filter(v -> v.getUsuarioId() == usuarioId)
                .collect(Collectors.toList());
    }
    
    @Override
    public int guardar(Venta venta) {
        venta.setId(nextId++);
        venta.setFechaHora(LocalDateTime.now());
        venta.setEstado("ACTIVA");
        ventas.add(venta);
        return venta.getId();
    }
    
    @Override
    public void anular(int id) {
        Venta venta = buscarPorId(id);
        if (venta != null) {
            venta.setEstado("ANULADA");
        }
    }
    
    @Override
    public double calcularTotalPorRango(LocalDateTime desde, LocalDateTime hasta) {
        return listarPorRangoFechas(desde, hasta).stream()
                .filter(v -> "ACTIVA".equals(v.getEstado()))
                .mapToDouble(Venta::getTotal)
                .sum();
    }
    
    @Override
    public double calcularTotalDelDia() {
        return listarDelDia().stream()
                .filter(v -> "ACTIVA".equals(v.getEstado()))
                .mapToDouble(Venta::getTotal)
                .sum();
    }
}
```

---

## 💼 Paso 4 – Crear capa de servicios

La capa de servicios contiene toda la **lógica de negocio** y validaciones.

### Clase: UsuarioService.java

**Ubicación:** `cl.tuusuario.pnb.service`

```java
package cl.tuusuario.pnb.service;

import cl.tuusuario.pnb.model.Usuario;
import cl.tuusuario.pnb.repository.IUsuarioRepository;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Servicio de lógica de negocio para Usuario
 * Contiene validaciones y reglas de negocio
 */
public class UsuarioService {
    
    private final IUsuarioRepository repository;
    
    /**
     * Constructor con inyección de dependencias
     */
    public UsuarioService(IUsuarioRepository repository) {
        this.repository = repository;
    }
    
    /**
     * Autentica un usuario
     * @throws RuntimeException si las credenciales son inválidas
     */
    public Usuario autenticar(String username, String password) {
        // Validaciones básicas
        if (username == null || username.trim().isEmpty()) {
            throw new IllegalArgumentException("El username es obligatorio");
        }
        if (password == null || password.trim().isEmpty()) {
            throw new IllegalArgumentException("La contraseña es obligatoria");
        }
        
        // Buscar usuario
        Usuario usuario = repository.buscarPorUsername(username.trim());
        
        if (usuario == null) {
            throw new RuntimeException("Credenciales inválidas");
        }
        
        if (!usuario.isActivo()) {
            throw new RuntimeException("Usuario inactivo. Contacta al administrador");
        }
        
        // Verificar contraseña (por ahora sin hash)
        if (!usuario.getPassword().equals(password)) {
            throw new RuntimeException("Credenciales inválidas");
        }
        
        return usuario;
    }
    
    /**
     * Crea un nuevo usuario
     */
    public void crear(String username, String password, String nombreCompleto, String rol) {
        // Validaciones
        validarDatosUsuario(username, password, nombreCompleto, rol);
        
        // Verificar que no exista el username
        if (repository.existeUsername(username)) {
            throw new RuntimeException("El username '" + username + "' ya existe");
        }
        
        // Crear usuario
        Usuario usuario = new Usuario();
        usuario.setUsername(username.trim().toLowerCase());
        usuario.setPassword(password); // TODO: Hash en Clase 5
        usuario.setNombreCompleto(nombreCompleto.trim());
        usuario.setRol(rol);
        usuario.setActivo(true);
        
        repository.guardar(usuario);
    }
    
    /**
     * Actualiza un usuario existente
     */
    public void actualizar(int id, String username, String password, 
                           String nombreCompleto, String rol, boolean activo) {
        // Validaciones
        validarDatosUsuario(username, password, nombreCompleto, rol);
        
        // Buscar usuario existente
        Usuario usuario = repository.buscarPorId(id);
        if (usuario == null) {
            throw new RuntimeException("Usuario no encontrado");
        }
        
        // Verificar username único (si cambió)
        if (!usuario.getUsername().equals(username) && 
            repository.existeUsername(username)) {
            throw new RuntimeException("El username '" + username + "' ya existe");
        }
        
        // Actualizar datos
        usuario.setUsername(username.trim().toLowerCase());
        if (password != null && !password.trim().isEmpty()) {
            usuario.setPassword(password);
        }
        usuario.setNombreCompleto(nombreCompleto.trim());
        usuario.setRol(rol);
        usuario.setActivo(activo);
        
        repository.actualizar(usuario);
    }
    
    /**
     * Elimina un usuario
     * Regla de negocio: No se puede eliminar el último ADMIN activo
     */
    public void eliminar(int id) {
        Usuario usuario = repository.buscarPorId(id);
        if (usuario == null) {
            throw new RuntimeException("Usuario no encontrado");
        }
        
        // Validar que no sea el último admin activo
        if (usuario.getRol().equals("ADMIN") && usuario.isActivo()) {
            int adminsActivos = repository.contarActivosPorRol("ADMIN");
            if (adminsActivos <= 1) {
                throw new RuntimeException(
                    "No se puede eliminar el último administrador activo");
            }
        }
        
        repository.eliminar(id);
    }
    
    /**
     * Lista todos los usuarios
     */
    public List<Usuario> listarTodos() {
        return repository.listarTodos();
    }
    
    /**
     * Lista usuarios activos
     */
    public List<Usuario> listarActivos() {
        return repository.listarTodos().stream()
                .filter(Usuario::isActivo)
                .collect(Collectors.toList());
    }
    
    /**
     * Busca usuarios por texto (username o nombre)
     */
    public List<Usuario> buscar(String texto) {
        if (texto == null || texto.trim().isEmpty()) {
            return listarTodos();
        }
        
        String textoLower = texto.toLowerCase();
        return repository.listarTodos().stream()
                .filter(u -> u.getUsername().toLowerCase().contains(textoLower) ||
                            u.getNombreCompleto().toLowerCase().contains(textoLower))
                .collect(Collectors.toList());
    }
    
    /**
     * Validaciones comunes de usuario
     */
    private void validarDatosUsuario(String username, String password, 
                                     String nombreCompleto, String rol) {
        if (username == null || username.trim().isEmpty()) {
            throw new IllegalArgumentException("El username es obligatorio");
        }
        if (username.trim().length() < 4) {
            throw new IllegalArgumentException(
                "El username debe tener al menos 4 caracteres");
        }
        
        if (password == null || password.trim().isEmpty()) {
            throw new IllegalArgumentException("La contraseña es obligatoria");
        }
        if (password.length() < 6) {
            throw new IllegalArgumentException(
                "La contraseña debe tener al menos 6 caracteres");
        }
        
        if (nombreCompleto == null || nombreCompleto.trim().isEmpty()) {
            throw new IllegalArgumentException("El nombre completo es obligatorio");
        }
        
        if (rol == null || rol.trim().isEmpty()) {
            throw new IllegalArgumentException("El rol es obligatorio");
        }
        if (!rol.equals("ADMIN") && !rol.equals("OPERADOR")) {
            throw new IllegalArgumentException(
                "El rol debe ser ADMIN u OPERADOR");
        }
    }
}
```

### Clase: ProductoService.java

**Ubicación:** `cl.tuusuario.pnb.service`

```java
package cl.tuusuario.pnb.service;

import cl.tuusuario.pnb.model.Producto;
import cl.tuusuario.pnb.repository.IProductoRepository;
import java.util.List;

/**
 * Servicio de lógica de negocio para Producto
 */
public class ProductoService {
    
    private final IProductoRepository repository;
    
    public ProductoService(IProductoRepository repository) {
        this.repository = repository;
    }
    
    /**
     * Crea un nuevo producto
     */
    public void crear(String nombre, String categoria, String tipo, double precio) {
        // Validaciones
        validarDatosProducto(nombre, categoria, tipo, precio);
        
        // Crear producto
        Producto producto = new Producto();
        producto.setNombre(nombre.trim());
        producto.setCategoria(categoria);
        producto.setTipo(tipo);
        producto.setPrecio(precio);
        producto.setActivo(true);
        
        repository.guardar(producto);
    }
    
    /**
     * Actualiza un producto existente
     */
    public void actualizar(int id, String nombre, String categoria, 
                          String tipo, double precio, boolean activo) {
        // Validaciones
        validarDatosProducto(nombre, categoria, tipo, precio);
        
        // Buscar producto
        Producto producto = repository.buscarPorId(id);
        if (producto == null) {
            throw new RuntimeException("Producto no encontrado");
        }
        
        // Actualizar
        producto.setNombre(nombre.trim());
        producto.setCategoria(categoria);
        producto.setTipo(tipo);
        producto.setPrecio(precio);
        producto.setActivo(activo);
        
        repository.actualizar(producto);
    }
    
    /**
     * Elimina un producto
     */
    public void eliminar(int id) {
        Producto producto = repository.buscarPorId(id);
        if (producto == null) {
            throw new RuntimeException("Producto no encontrado");
        }
        
        repository.eliminar(id);
    }
    
    /**
     * Cambia el estado de un producto
     */
    public void cambiarEstado(int id) {
        Producto producto = repository.buscarPorId(id);
        if (producto == null) {
            throw new RuntimeException("Producto no encontrado");
        }
        
        repository.cambiarEstado(id, !producto.isActivo());
    }
    
    /**
     * Lista todos los productos
     */
    public List<Producto> listarTodos() {
        return repository.listarTodos();
    }
    
    /**
     * Lista productos activos
     */
    public List<Producto> listarActivos() {
        return repository.listarActivos();
    }
    
    /**
     * Lista productos por categoría
     */
    public List<Producto> listarPorCategoria(String categoria) {
        return repository.listarPorCategoria(categoria);
    }
    
    /**
     * Busca productos por nombre
     */
    public List<Producto> buscarPorNombre(String nombre) {
        return repository.buscarPorNombre(nombre);
    }
    
    /**
     * Validaciones de producto
     */
    private void validarDatosProducto(String nombre, String categoria, 
                                      String tipo, double precio) {
        if (nombre == null || nombre.trim().isEmpty()) {
            throw new IllegalArgumentException("El nombre es obligatorio");
        }
        
        if (categoria == null || categoria.trim().isEmpty()) {
            throw new IllegalArgumentException("La categoría es obligatoria");
        }
        if (!categoria.equals("BEBIDA") && !categoria.equals("SNACK") && 
            !categoria.equals("TIEMPO")) {
            throw new IllegalArgumentException(
                "Categoría inválida. Debe ser BEBIDA, SNACK o TIEMPO");
        }
        
        if (tipo == null || tipo.trim().isEmpty()) {
            throw new IllegalArgumentException("El tipo es obligatorio");
        }
        
        if (precio <= 0) {
            throw new IllegalArgumentException("El precio debe ser mayor a 0");
        }
    }
}
```

### Clase: VentaService.java

**Ubicación:** `cl.tuusuario.pnb.service`

```java
package cl.tuusuario.pnb.service;

import cl.tuusuario.pnb.model.Venta;
import cl.tuusuario.pnb.repository.IVentaRepository;
import java.time.LocalDateTime;
import java.util.List;

/**
 * Servicio de lógica de negocio para Venta
 */
public class VentaService {
    
    private final IVentaRepository repository;
    
    public VentaService(IVentaRepository repository) {
        this.repository = repository;
    }
    
    /**
     * Registra una nueva venta
     */
    public int registrarVenta(int usuarioId, String usuarioNombre, double total) {
        // Validaciones
        if (usuarioId <= 0) {
            throw new IllegalArgumentException("Usuario inválido");
        }
        if (total <= 0) {
            throw new IllegalArgumentException("El total debe ser mayor a 0");
        }
        
        // Crear venta
        Venta venta = new Venta();
        venta.setFechaHora(LocalDateTime.now());
        venta.setUsuarioId(usuarioId);
        venta.setUsuarioNombre(usuarioNombre);
        venta.setTotal(total);
        venta.setEstado("ACTIVA");
        
        return repository.guardar(venta);
    }
    
    /**
     * Anula una venta
     */
    public void anular(int id) {
        Venta venta = repository.buscarPorId(id);
        if (venta == null) {
            throw new RuntimeException("Venta no encontrada");
        }
        
        if ("ANULADA".equals(venta.getEstado())) {
            throw new RuntimeException("La venta ya está anulada");
        }
        
        repository.anular(id);
    }
    
    /**
     * Lista todas las ventas
     */
    public List<Venta> listarTodas() {
        return repository.listarTodas();
    }
    
    /**
     * Lista ventas del día
     */
    public List<Venta> listarDelDia() {
        return repository.listarDelDia();
    }
    
    /**
     * Lista ventas por rango de fechas
     */
    public List<Venta> listarPorRango(LocalDateTime desde, LocalDateTime hasta) {
        return repository.listarPorRangoFechas(desde, hasta);
    }
    
    /**
     * Calcula total del día
     */
    public double calcularTotalDelDia() {
        return repository.calcularTotalDelDia();
    }
    
    /**
     * Calcula total por rango
     */
    public double calcularTotalPorRango(LocalDateTime desde, LocalDateTime hasta) {
        return repository.calcularTotalPorRango(desde, hasta);
    }
}
```

---

## 🎮 Paso 5 – Crear controladores

Los controladores **coordinan** el flujo entre las vistas y los servicios.

### Clase: LoginController.java

**Ubicación:** `cl.tuusuario.pnb.controller`

```java
package cl.tuusuario.pnb.controller;

import cl.tuusuario.pnb.model.Usuario;
import cl.tuusuario.pnb.service.UsuarioService;

/**
 * Controlador para operaciones de autenticación
 */
public class LoginController {
    
    private final UsuarioService usuarioService;
    
    public LoginController(UsuarioService usuarioService) {
        this.usuarioService = usuarioService;
    }
    
    /**
     * Intenta autenticar un usuario
     * @return Usuario autenticado
     * @throws RuntimeException si las credenciales son inválidas
     */
    public Usuario autenticar(String username, String password) {
        return usuarioService.autenticar(username, password);
    }
}
```

### Clase: UsuarioController.java

**Ubicación:** `cl.tuusuario.pnb.controller`

```java
package cl.tuusuario.pnb.controller;

import cl.tuusuario.pnb.model.Usuario;
import cl.tuusuario.pnb.service.UsuarioService;
import java.util.List;

/**
 * Controlador para operaciones de Usuario
 */
public class UsuarioController {
    
    private final UsuarioService service;
    
    public UsuarioController(UsuarioService service) {
        this.service = service;
    }
    
    public void crear(String username, String password, 
                     String nombreCompleto, String rol) {
        service.crear(username, password, nombreCompleto, rol);
    }
    
    public void actualizar(int id, String username, String password,
                          String nombreCompleto, String rol, boolean activo) {
        service.actualizar(id, username, password, nombreCompleto, rol, activo);
    }
    
    public void eliminar(int id) {
        service.eliminar(id);
    }
    
    public List<Usuario> listarTodos() {
        return service.listarTodos();
    }
    
    public List<Usuario> listarActivos() {
        return service.listarActivos();
    }
    
    public List<Usuario> buscar(String texto) {
        return service.buscar(texto);
    }
}
```

### Clase: ProductoController.java

**Ubicación:** `cl.tuusuario.pnb.controller`

```java
package cl.tuusuario.pnb.controller;

import cl.tuusuario.pnb.model.Producto;
import cl.tuusuario.pnb.service.ProductoService;
import java.util.List;

/**
 * Controlador para operaciones de Producto
 */
public class ProductoController {
    
    private final ProductoService service;
    
    public ProductoController(ProductoService service) {
        this.service = service;
    }
    
    public void crear(String nombre, String categoria, String tipo, double precio) {
        service.crear(nombre, categoria, tipo, precio);
    }
    
    public void actualizar(int id, String nombre, String categoria,
                          String tipo, double precio, boolean activo) {
        service.actualizar(id, nombre, categoria, tipo, precio, activo);
    }
    
    public void eliminar(int id) {
        service.eliminar(id);
    }
    
    public void cambiarEstado(int id) {
        service.cambiarEstado(id);
    }
    
    public List<Producto> listarTodos() {
        return service.listarTodos();
    }
    
    public List<Producto> listarActivos() {
        return service.listarActivos();
    }
    
    public List<Producto> listarPorCategoria(String categoria) {
        return service.listarPorCategoria(categoria);
    }
    
    public List<Producto> buscarPorNombre(String nombre) {
        return service.buscarPorNombre(nombre);
    }
}
```

### Clase: VentaController.java

**Ubicación:** `cl.tuusuario.pnb.controller`

```java
package cl.tuusuario.pnb.controller;

import cl.tuusuario.pnb.model.Venta;
import cl.tuusuario.pnb.service.VentaService;
import java.time.LocalDateTime;
import java.util.List;

/**
 * Controlador para operaciones de Venta
 */
public class VentaController {
    
    private final VentaService service;
    
    public VentaController(VentaService service) {
        this.service = service;
    }
    
    public int registrarVenta(int usuarioId, String usuarioNombre, double total) {
        return service.registrarVenta(usuarioId, usuarioNombre, total);
    }
    
    public void anular(int id) {
        service.anular(id);
    }
    
    public List<Venta> listarTodas() {
        return service.listarTodas();
    }
    
    public List<Venta> listarDelDia() {
        return service.listarDelDia();
    }
    
    public List<Venta> listarPorRango(LocalDateTime desde, LocalDateTime hasta) {
        return service.listarPorRango(desde, hasta);
    }
    
    public double calcularTotalDelDia() {
        return service.calcularTotalDelDia();
    }
    
    public double calcularTotalPorRango(LocalDateTime desde, LocalDateTime hasta) {
        return service.calcularTotalPorRango(desde, hasta);
    }
}
```

---

## ✅ Resultado de esta parte

Al finalizar esta sección has creado:

### Estructura completa de paquetes:
```
cl.tuusuario.pnb/
├── app/                    ✅ Creado (vacío por ahora)
├── controller/             ✅ 4 controladores
│   ├── LoginController.java
│   ├── UsuarioController.java
│   ├── ProductoController.java
│   └── VentaController.java
├── service/                ✅ 3 servicios
│   ├── UsuarioService.java
│   ├── ProductoService.java
│   └── VentaService.java
├── repository/             ✅ 3 interfaces
│   ├── IUsuarioRepository.java
│   ├── IProductoRepository.java
│   ├── IVentaRepository.java
│   └── mock/              ✅ 3 implementaciones Mock
│       ├── UsuarioRepositoryMock.java
│       ├── ProductoRepositoryMock.java
│       └── VentaRepositoryMock.java
├── model/                  ✅ Ya existía (Clase 2)
├── gui/                    ✅ Ya existía (Clase 1 y 2)
└── PixelAndBean.java       ✅ Ya existía
```

### Conteo de archivos:
- **3 interfaces de repositorio**
- **3 implementaciones Mock**
- **3 servicios con lógica de negocio**
- **4 controladores**
- **Total: 13 archivos nuevos**

### Arquitectura en capas completada:
- ✅ Capa de Repositorio (Repository Pattern)
- ✅ Capa de Servicio (Business Logic)
- ✅ Capa de Control (Controller)
- ✅ Separación de responsabilidades (SoC)
- ✅ Bajo acoplamiento mediante interfaces
- ✅ Preparado para Inyección de Dependencias

---

## 💡 Siguiente Paso

**Parte 3: Inyección de Dependencias e Integración**

➡️ **[03-dependency-injection.md](03-dependency-injection.md)**

Ahora que tenemos todas las capas implementadas, es momento de:
- Crear el ApplicationContext (contenedor IoC)
- Conectar todas las capas mediante DI
- Refactorizar las vistas para usar controladores
- Probar la aplicación completa

---

> 🏗️ *"La arquitectura no se trata de hacer las cosas más complicadas, sino de hacerlas más mantenibles."*
>
> 🧩 *"Cada pieza en su lugar, cada responsabilidad clara."*

