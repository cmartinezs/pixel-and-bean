# 🔄 Clase 4 (Parte 3) – Implementación de Repositorios con JDBC

**Objetivo:**  
Migrar los repositorios de datos mock a implementaciones reales con JDBC, conectando la aplicación a la base de datos MySQL y validando que todo funcione correctamente.

⏱️ **Duración estimada:** 30 minutos

**Distribución del tiempo:**
- Migrar UsuarioRepositoryImpl (10 min)
- Migrar ProductoRepositoryImpl (8 min)
- Implementar VentaRepositoryImpl básico (7 min)
- Pruebas y validación (5 min)

<!-- TOC -->
* [🔄 Clase 4 (Parte 3) – Implementación de Repositorios con JDBC](#-clase-4-parte-3--implementación-de-repositorios-con-jdbc)
  * [🎯 Objetivos de Esta Parte](#-objetivos-de-esta-parte)
  * [📋 Plan de Trabajo](#-plan-de-trabajo)
  * [👤 Paso 1: Migrar UsuarioRepositoryImpl (10 min)](#-paso-1-migrar-usuariorepositoryimpl-10-min)
    * [1.1 Revisar la Interfaz](#11-revisar-la-interfaz)
    * [1.2 Implementar con JDBC](#12-implementar-con-jdbc)
    * [1.3 Probar UsuarioRepository](#13-probar-usuariorepository)
  * [📦 Paso 2: Migrar ProductoRepositoryImpl (8 min)](#-paso-2-migrar-productorepositoryimpl-8-min)
    * [2.1 Revisar la Interfaz](#21-revisar-la-interfaz)
    * [2.2 Implementar con JDBC](#22-implementar-con-jdbc)
    * [2.3 Probar ProductoRepository](#23-probar-productorepository)
  * [💰 Paso 3: Implementar VentaRepositoryImpl Básico (7 min)](#-paso-3-implementar-ventarepositoryimpl-básico-7-min)
    * [3.1 Definir Interfaz](#31-definir-interfaz)
    * [3.2 Implementar con JDBC](#32-implementar-con-jdbc)
    * [3.3 Probar VentaRepository](#33-probar-ventarepository)
  * [🔒 Mejora Opcional: Hash de Contraseñas (Bonus)](#-mejora-opcional-hash-de-contraseñas-bonus)
    * [Clase PasswordHasher](#clase-passwordhasher)
    * [Actualizar Contraseñas en BD](#actualizar-contraseñas-en-bd)
    * [Actualizar UsuarioRepositoryImpl](#actualizar-usuariorepositoryimpl)
  * [🧪 Paso 4: Pruebas Integradas (5 min)](#-paso-4-pruebas-integradas-5-min)
    * [Test de Autenticación Real](#test-de-autenticación-real)
    * [Ejecutar y Probar la Aplicación](#ejecutar-y-probar-la-aplicación)
  * [🧹 Limpieza de Código Mock](#-limpieza-de-código-mock)
  * [✅ Verificación Final](#-verificación-final)
  * [🎯 Resumen de Cambios](#-resumen-de-cambios)
  * [🚀 Próximos Pasos](#-próximos-pasos)
  * [💡 Siguiente Clase](#-siguiente-clase)
<!-- TOC -->

---

## 🎯 Objetivos de Esta Parte

Al finalizar esta sección habrás:

1. ✅ Migrado `UsuarioRepositoryImpl` de mock a JDBC
2. ✅ Migrado `ProductoRepositoryImpl` de mock a JDBC
3. ✅ Implementado `VentaRepositoryImpl` básico con JDBC
4. ✅ Probado autenticación real contra base de datos
5. ✅ Validado listados de usuarios y productos desde BD
6. ✅ (Opcional) Implementado hash de contraseñas
7. ✅ Eliminado código mock obsoleto
8. ✅ Aplicación completamente funcional con persistencia real

---

## 📋 Plan de Trabajo

Vamos a migrar los repositorios uno por uno, manteniendo la misma interfaz pero cambiando la implementación interna.

**Ventaja de nuestra arquitectura:**  
Gracias al patrón Repository y la inyección de dependencias, las capas superiores (Service, Controller, View) **no necesitan cambiar en absoluto**. Solo cambiamos la implementación del repositorio.

```
┌──────────────┐
│     VIEW     │  ← Sin cambios
└──────┬───────┘
       │
┌──────────────┐
│  CONTROLLER  │  ← Sin cambios
└──────┬───────┘
       │
┌──────────────┐
│   SERVICE    │  ← Sin cambios
└──────┬───────┘
       │
┌──────────────┐
│  REPOSITORY  │  ← ✨ SOLO AQUÍ CAMBIAMOS ✨
│  (Mock→JDBC) │
└──────┬───────┘
       │
┌──────────────┐
│   MySQL DB   │  ← Nuevo
└──────────────┘
```

---

## 👤 Paso 1: Migrar UsuarioRepositoryImpl (10 min)

### 1.1 Revisar la Interfaz

La interfaz `UsuarioRepository` debería ser algo como:

```java
package cl.cmartinezs.pnb.repository;

import cl.cmartinezs.pnb.model.Usuario;
import java.util.List;
import java.util.Optional;

public interface UsuarioRepository {
    
    /**
     * Busca un usuario por su username.
     * @return Optional con el usuario, o vacío si no existe
     */
    Optional<Usuario> buscarPorUsername(String username);
    
    /**
     * Autentica un usuario por username y password.
     * @return Optional con el usuario si las credenciales son válidas
     */
    Optional<Usuario> autenticar(String username, String password);
    
    /**
     * Lista todos los usuarios activos.
     */
    List<Usuario> listarActivos();
    
    /**
     * Lista todos los usuarios (activos e inactivos).
     */
    List<Usuario> listarTodos();
    
    /**
     * Busca un usuario por ID.
     */
    Optional<Usuario> buscarPorId(int id);
    
    /**
     * Crea un nuevo usuario.
     * @return El usuario creado con su ID asignado
     */
    Usuario crear(Usuario usuario);
    
    /**
     * Actualiza un usuario existente.
     */
    void actualizar(Usuario usuario);
    
    /**
     * Elimina un usuario (físicamente).
     */
    void eliminar(int id);
    
    /**
     * Desactiva un usuario (baja lógica).
     */
    void desactivar(int id);
    
    /**
     * Activa un usuario previamente desactivado.
     */
    void activar(int id);
}
```

### 1.2 Implementar con JDBC

Ubicación: `cl.cmartinezs.pnb.repository.impl.UsuarioRepositoryImpl`

```java
package cl.cmartinezs.pnb.repository.impl;

import cl.cmartinezs.pnb.model.Usuario;
import cl.cmartinezs.pnb.repository.UsuarioRepository;
import cl.cmartinezs.pnb.util.DatabaseConnectionFactory;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

/**
 * Implementación de UsuarioRepository con JDBC.
 * 
 * @author Tu Nombre
 */
public class UsuarioRepositoryImpl implements UsuarioRepository {
    
    // Consultas SQL como constantes (evita typos y facilita mantenimiento)
    private static final String SQL_SELECT_ALL = 
        "SELECT id, username, password, nombre_completo, rol, activo FROM usuario";
    
    private static final String SQL_SELECT_BY_ID = 
        SQL_SELECT_ALL + " WHERE id = ?";
    
    private static final String SQL_SELECT_BY_USERNAME = 
        SQL_SELECT_ALL + " WHERE username = ?";
    
    private static final String SQL_SELECT_ACTIVOS = 
        SQL_SELECT_ALL + " WHERE activo = TRUE";
    
    private static final String SQL_AUTENTICAR = 
        SQL_SELECT_ALL + " WHERE username = ? AND password = ? AND activo = TRUE";
    
    private static final String SQL_INSERT = 
        "INSERT INTO usuario (username, password, nombre_completo, rol, activo) VALUES (?, ?, ?, ?, ?)";
    
    private static final String SQL_UPDATE = 
        "UPDATE usuario SET username = ?, password = ?, nombre_completo = ?, rol = ?, activo = ? WHERE id = ?";
    
    private static final String SQL_DELETE = 
        "DELETE FROM usuario WHERE id = ?";
    
    private static final String SQL_UPDATE_ESTADO = 
        "UPDATE usuario SET activo = ? WHERE id = ?";
    
    /**
     * Mapea un ResultSet a un objeto Usuario.
     */
    private Usuario mapearUsuario(ResultSet rs) throws SQLException {
        Usuario usuario = new Usuario();
        usuario.setId(rs.getInt("id"));
        usuario.setUsername(rs.getString("username"));
        usuario.setPassword(rs.getString("password"));
        usuario.setNombreCompleto(rs.getString("nombre_completo"));
        usuario.setRol(rs.getString("rol"));
        usuario.setActivo(rs.getBoolean("activo"));
        return usuario;
    }
    
    @Override
    public Optional<Usuario> buscarPorUsername(String username) {
        try (Connection conn = DatabaseConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_SELECT_BY_USERNAME)) {
            
            ps.setString(1, username);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(mapearUsuario(rs));
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Error al buscar usuario por username: " + username);
            e.printStackTrace();
        }
        
        return Optional.empty();
    }
    
    @Override
    public Optional<Usuario> autenticar(String username, String password) {
        try (Connection conn = DatabaseConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_AUTENTICAR)) {
            
            ps.setString(1, username);
            ps.setString(2, password); // TODO: En producción, hashear password
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(mapearUsuario(rs));
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Error al autenticar usuario: " + username);
            e.printStackTrace();
        }
        
        return Optional.empty();
    }
    
    @Override
    public List<Usuario> listarActivos() {
        List<Usuario> usuarios = new ArrayList<>();
        
        try (Connection conn = DatabaseConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_SELECT_ACTIVOS);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                usuarios.add(mapearUsuario(rs));
            }
            
        } catch (SQLException e) {
            System.err.println("Error al listar usuarios activos");
            e.printStackTrace();
        }
        
        return usuarios;
    }
    
    @Override
    public List<Usuario> listarTodos() {
        List<Usuario> usuarios = new ArrayList<>();
        
        try (Connection conn = DatabaseConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_SELECT_ALL);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                usuarios.add(mapearUsuario(rs));
            }
            
        } catch (SQLException e) {
            System.err.println("Error al listar todos los usuarios");
            e.printStackTrace();
        }
        
        return usuarios;
    }
    
    @Override
    public Optional<Usuario> buscarPorId(int id) {
        try (Connection conn = DatabaseConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_SELECT_BY_ID)) {
            
            ps.setInt(1, id);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(mapearUsuario(rs));
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Error al buscar usuario por ID: " + id);
            e.printStackTrace();
        }
        
        return Optional.empty();
    }
    
    @Override
    public Usuario crear(Usuario usuario) {
        try (Connection conn = DatabaseConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_INSERT, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setString(1, usuario.getUsername());
            ps.setString(2, usuario.getPassword()); // TODO: Hashear
            ps.setString(3, usuario.getNombreCompleto());
            ps.setString(4, usuario.getRol());
            ps.setBoolean(5, usuario.isActivo());
            
            int rowsAffected = ps.executeUpdate();
            
            if (rowsAffected > 0) {
                // Obtener el ID generado
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        usuario.setId(rs.getInt(1));
                    }
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Error al crear usuario: " + usuario.getUsername());
            e.printStackTrace();
            throw new RuntimeException("Error al crear usuario", e);
        }
        
        return usuario;
    }
    
    @Override
    public void actualizar(Usuario usuario) {
        try (Connection conn = DatabaseConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_UPDATE)) {
            
            ps.setString(1, usuario.getUsername());
            ps.setString(2, usuario.getPassword()); // TODO: Hashear si cambió
            ps.setString(3, usuario.getNombreCompleto());
            ps.setString(4, usuario.getRol());
            ps.setBoolean(5, usuario.isActivo());
            ps.setInt(6, usuario.getId());
            
            ps.executeUpdate();
            
        } catch (SQLException e) {
            System.err.println("Error al actualizar usuario ID: " + usuario.getId());
            e.printStackTrace();
            throw new RuntimeException("Error al actualizar usuario", e);
        }
    }
    
    @Override
    public void eliminar(int id) {
        try (Connection conn = DatabaseConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_DELETE)) {
            
            ps.setInt(1, id);
            ps.executeUpdate();
            
        } catch (SQLException e) {
            System.err.println("Error al eliminar usuario ID: " + id);
            e.printStackTrace();
            throw new RuntimeException("Error al eliminar usuario", e);
        }
    }
    
    @Override
    public void desactivar(int id) {
        try (Connection conn = DatabaseConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_UPDATE_ESTADO)) {
            
            ps.setBoolean(1, false);
            ps.setInt(2, id);
            ps.executeUpdate();
            
        } catch (SQLException e) {
            System.err.println("Error al desactivar usuario ID: " + id);
            e.printStackTrace();
            throw new RuntimeException("Error al desactivar usuario", e);
        }
    }
    
    @Override
    public void activar(int id) {
        try (Connection conn = DatabaseConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_UPDATE_ESTADO)) {
            
            ps.setBoolean(1, true);
            ps.setInt(2, id);
            ps.executeUpdate();
            
        } catch (SQLException e) {
            System.err.println("Error al activar usuario ID: " + id);
            e.printStackTrace();
            throw new RuntimeException("Error al activar usuario", e);
        }
    }
}
```

### 1.3 Probar UsuarioRepository

Crear clase de prueba: `TestUsuarioRepository.java`

```java
package cl.cmartinezs.pnb;

import cl.cmartinezs.pnb.model.Usuario;
import cl.cmartinezs.pnb.repository.UsuarioRepository;
import cl.cmartinezs.pnb.repository.impl.UsuarioRepositoryImpl;

import java.util.List;
import java.util.Optional;

public class TestUsuarioRepository {
    
    public static void main(String[] args) {
        System.out.println("===========================================");
        System.out.println("   TEST: UsuarioRepository (JDBC)         ");
        System.out.println("===========================================\n");
        
        UsuarioRepository repo = new UsuarioRepositoryImpl();
        
        // Test 1: Autenticar admin
        System.out.println("Test 1: Autenticar admin");
        Optional<Usuario> admin = repo.autenticar("admin", "admin123");
        
        if (admin.isPresent()) {
            Usuario u = admin.get();
            System.out.println("✅ Login exitoso:");
            System.out.println("   ID: " + u.getId());
            System.out.println("   Username: " + u.getUsername());
            System.out.println("   Nombre: " + u.getNombreCompleto());
            System.out.println("   Rol: " + u.getRol());
        } else {
            System.out.println("❌ Login falló");
        }
        
        System.out.println("\n-------------------------------------------\n");
        
        // Test 2: Listar todos los usuarios
        System.out.println("Test 2: Listar todos los usuarios");
        List<Usuario> todos = repo.listarTodos();
        System.out.println("Total de usuarios: " + todos.size());
        
        todos.forEach(u -> {
            String estado = u.isActivo() ? "✅" : "❌";
            System.out.printf("%s %d - %s (%s) - %s%n", 
                estado, u.getId(), u.getUsername(), u.getRol(), 
                u.isActivo() ? "Activo" : "Inactivo");
        });
        
        System.out.println("\n-------------------------------------------\n");
        
        // Test 3: Buscar por username
        System.out.println("Test 3: Buscar por username");
        Optional<Usuario> operador = repo.buscarPorUsername("operador");
        
        if (operador.isPresent()) {
            System.out.println("✅ Usuario encontrado:");
            System.out.println("   " + operador.get().getNombreCompleto());
        } else {
            System.out.println("❌ Usuario no encontrado");
        }
        
        System.out.println("\n===========================================");
        System.out.println("   TEST COMPLETADO                        ");
        System.out.println("===========================================");
    }
}
```

**Ejecutar y verificar:**
```
✅ Login exitoso: admin / Administrador del Sistema / ADMIN
✅ Total de usuarios: 5
✅ Usuario 'operador' encontrado
```

---

## 📦 Paso 2: Migrar ProductoRepositoryImpl (8 min)

### 2.1 Revisar la Interfaz

```java
package cl.cmartinezs.pnb.repository;

import cl.cmartinezs.pnb.model.Producto;
import java.util.List;
import java.util.Optional;

public interface ProductoRepository {
    
    List<Producto> listarTodos();
    List<Producto> listarActivos();
    List<Producto> buscarPorCategoria(String categoria);
    List<Producto> buscarPorNombre(String nombre);
    Optional<Producto> buscarPorId(int id);
    Producto crear(Producto producto);
    void actualizar(Producto producto);
    void eliminar(int id);
    void desactivar(int id);
    void activar(int id);
}
```

### 2.2 Implementar con JDBC

Ubicación: `cl.cmartinezs.pnb.repository.impl.ProductoRepositoryImpl`

```java
package cl.cmartinezs.pnb.repository.impl;

import cl.cmartinezs.pnb.model.Producto;
import cl.cmartinezs.pnb.repository.ProductoRepository;
import cl.cmartinezs.pnb.util.DatabaseConnectionFactory;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

/**
 * Implementación de ProductoRepository con JDBC.
 */
public class ProductoRepositoryImpl implements ProductoRepository {
    
    private static final String SQL_SELECT_ALL = 
        "SELECT id, nombre, categoria, tipo, descripcion, precio, activo FROM producto";
    
    private static final String SQL_SELECT_BY_ID = 
        SQL_SELECT_ALL + " WHERE id = ?";
    
    private static final String SQL_SELECT_ACTIVOS = 
        SQL_SELECT_ALL + " WHERE activo = TRUE ORDER BY categoria, nombre";
    
    private static final String SQL_SELECT_BY_CATEGORIA = 
        SQL_SELECT_ALL + " WHERE categoria = ? AND activo = TRUE ORDER BY nombre";
    
    private static final String SQL_SELECT_BY_NOMBRE = 
        SQL_SELECT_ALL + " WHERE nombre LIKE ? ORDER BY nombre";
    
    private static final String SQL_INSERT = 
        "INSERT INTO producto (nombre, categoria, tipo, descripcion, precio, activo) VALUES (?, ?, ?, ?, ?, ?)";
    
    private static final String SQL_UPDATE = 
        "UPDATE producto SET nombre = ?, categoria = ?, tipo = ?, descripcion = ?, precio = ?, activo = ? WHERE id = ?";
    
    private static final String SQL_DELETE = 
        "DELETE FROM producto WHERE id = ?";
    
    private static final String SQL_UPDATE_ESTADO = 
        "UPDATE producto SET activo = ? WHERE id = ?";
    
    private Producto mapearProducto(ResultSet rs) throws SQLException {
        Producto producto = new Producto();
        producto.setId(rs.getInt("id"));
        producto.setNombre(rs.getString("nombre"));
        producto.setCategoria(rs.getString("categoria"));
        producto.setTipo(rs.getString("tipo"));
        producto.setDescripcion(rs.getString("descripcion"));
        producto.setPrecio(rs.getDouble("precio"));
        producto.setActivo(rs.getBoolean("activo"));
        return producto;
    }
    
    @Override
    public List<Producto> listarTodos() {
        List<Producto> productos = new ArrayList<>();
        
        try (Connection conn = DatabaseConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_SELECT_ALL + " ORDER BY categoria, nombre");
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                productos.add(mapearProducto(rs));
            }
            
        } catch (SQLException e) {
            System.err.println("Error al listar todos los productos");
            e.printStackTrace();
        }
        
        return productos;
    }
    
    @Override
    public List<Producto> listarActivos() {
        List<Producto> productos = new ArrayList<>();
        
        try (Connection conn = DatabaseConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_SELECT_ACTIVOS);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                productos.add(mapearProducto(rs));
            }
            
        } catch (SQLException e) {
            System.err.println("Error al listar productos activos");
            e.printStackTrace();
        }
        
        return productos;
    }
    
    @Override
    public List<Producto> buscarPorCategoria(String categoria) {
        List<Producto> productos = new ArrayList<>();
        
        try (Connection conn = DatabaseConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_SELECT_BY_CATEGORIA)) {
            
            ps.setString(1, categoria);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    productos.add(mapearProducto(rs));
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Error al buscar productos por categoría: " + categoria);
            e.printStackTrace();
        }
        
        return productos;
    }
    
    @Override
    public List<Producto> buscarPorNombre(String nombre) {
        List<Producto> productos = new ArrayList<>();
        
        try (Connection conn = DatabaseConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_SELECT_BY_NOMBRE)) {
            
            ps.setString(1, "%" + nombre + "%"); // LIKE %nombre%
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    productos.add(mapearProducto(rs));
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Error al buscar productos por nombre: " + nombre);
            e.printStackTrace();
        }
        
        return productos;
    }
    
    @Override
    public Optional<Producto> buscarPorId(int id) {
        try (Connection conn = DatabaseConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_SELECT_BY_ID)) {
            
            ps.setInt(1, id);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(mapearProducto(rs));
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Error al buscar producto por ID: " + id);
            e.printStackTrace();
        }
        
        return Optional.empty();
    }
    
    @Override
    public Producto crear(Producto producto) {
        try (Connection conn = DatabaseConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_INSERT, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setString(1, producto.getNombre());
            ps.setString(2, producto.getCategoria());
            ps.setString(3, producto.getTipo());
            ps.setString(4, producto.getDescripcion());
            ps.setDouble(5, producto.getPrecio());
            ps.setBoolean(6, producto.isActivo());
            
            int rowsAffected = ps.executeUpdate();
            
            if (rowsAffected > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        producto.setId(rs.getInt(1));
                    }
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Error al crear producto: " + producto.getNombre());
            e.printStackTrace();
            throw new RuntimeException("Error al crear producto", e);
        }
        
        return producto;
    }
    
    @Override
    public void actualizar(Producto producto) {
        try (Connection conn = DatabaseConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_UPDATE)) {
            
            ps.setString(1, producto.getNombre());
            ps.setString(2, producto.getCategoria());
            ps.setString(3, producto.getTipo());
            ps.setString(4, producto.getDescripcion());
            ps.setDouble(5, producto.getPrecio());
            ps.setBoolean(6, producto.isActivo());
            ps.setInt(7, producto.getId());
            
            ps.executeUpdate();
            
        } catch (SQLException e) {
            System.err.println("Error al actualizar producto ID: " + producto.getId());
            e.printStackTrace();
            throw new RuntimeException("Error al actualizar producto", e);
        }
    }
    
    @Override
    public void eliminar(int id) {
        try (Connection conn = DatabaseConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_DELETE)) {
            
            ps.setInt(1, id);
            ps.executeUpdate();
            
        } catch (SQLException e) {
            System.err.println("Error al eliminar producto ID: " + id);
            e.printStackTrace();
            throw new RuntimeException("Error al eliminar producto", e);
        }
    }
    
    @Override
    public void desactivar(int id) {
        try (Connection conn = DatabaseConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_UPDATE_ESTADO)) {
            
            ps.setBoolean(1, false);
            ps.setInt(2, id);
            ps.executeUpdate();
            
        } catch (SQLException e) {
            System.err.println("Error al desactivar producto ID: " + id);
            e.printStackTrace();
            throw new RuntimeException("Error al desactivar producto", e);
        }
    }
    
    @Override
    public void activar(int id) {
        try (Connection conn = DatabaseConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_UPDATE_ESTADO)) {
            
            ps.setBoolean(1, true);
            ps.setInt(2, id);
            ps.executeUpdate();
            
        } catch (SQLException e) {
            System.err.println("Error al activar producto ID: " + id);
            e.printStackTrace();
            throw new RuntimeException("Error al activar producto", e);
        }
    }
}
```

### 2.3 Probar ProductoRepository

```java
package cl.cmartinezs.pnb;

import cl.cmartinezs.pnb.model.Producto;
import cl.cmartinezs.pnb.repository.ProductoRepository;
import cl.cmartinezs.pnb.repository.impl.ProductoRepositoryImpl;

import java.util.List;

public class TestProductoRepository {
    
    public static void main(String[] args) {
        System.out.println("===========================================");
        System.out.println("   TEST: ProductoRepository (JDBC)        ");
        System.out.println("===========================================\n");
        
        ProductoRepository repo = new ProductoRepositoryImpl();
        
        // Test 1: Listar productos activos
        System.out.println("Test 1: Listar productos activos");
        List<Producto> activos = repo.listarActivos();
        System.out.println("Total: " + activos.size() + " productos");
        
        // Agrupar por categoría
        String categoriaActual = "";
        for (Producto p : activos) {
            if (!p.getCategoria().equals(categoriaActual)) {
                categoriaActual = p.getCategoria();
                System.out.println("\n" + categoriaActual + ":");
            }
            System.out.printf("  - %s ($%.2f)%n", p.getNombre(), p.getPrecio());
        }
        
        System.out.println("\n-------------------------------------------\n");
        
        // Test 2: Buscar por nombre
        System.out.println("Test 2: Buscar productos con 'café'");
        List<Producto> cafes = repo.buscarPorNombre("café");
        System.out.println("Encontrados: " + cafes.size());
        cafes.forEach(p -> System.out.println("  - " + p.getNombre()));
        
        System.out.println("\n-------------------------------------------\n");
        
        // Test 3: Buscar por categoría
        System.out.println("Test 3: Productos de TIEMPO_ARCADE");
        List<Producto> arcade = repo.buscarPorCategoria("TIEMPO_ARCADE");
        arcade.forEach(p -> {
            System.out.printf("  - %s: $%.2f%n", p.getNombre(), p.getPrecio());
        });
        
        System.out.println("\n===========================================");
        System.out.println("   TEST COMPLETADO                        ");
        System.out.println("===========================================");
    }
}
```

---

## 💰 Paso 3: Implementar VentaRepositoryImpl Básico (7 min)

Para esta clase, implementaremos solo las operaciones básicas de Venta. En la Clase 5 completaremos el CRUD completo.

### 3.1 Definir Interfaz

```java
package cl.cmartinezs.pnb.repository;

import cl.cmartinezs.pnb.model.Venta;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

public interface VentaRepository {
    
    /**
     * Lista todas las ventas activas del día especificado.
     */
    List<Venta> listarPorFecha(LocalDate fecha);
    
    /**
     * Lista todas las ventas activas del día actual.
     */
    List<Venta> listarDelDia();
    
    /**
     * Busca una venta por ID.
     */
    Optional<Venta> buscarPorId(int id);
    
    /**
     * Crea una nueva venta (con detalles en una transacción).
     */
    Venta crear(Venta venta);
    
    /**
     * Calcula el total de ventas activas del día.
     */
    double calcularTotalDelDia();
}
```

### 3.2 Implementar con JDBC

```java
package cl.cmartinezs.pnb.repository.impl;

import cl.cmartinezs.pnb.model.Venta;
import cl.cmartinezs.pnb.repository.VentaRepository;
import cl.cmartinezs.pnb.util.DatabaseConnectionFactory;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

/**
 * Implementación básica de VentaRepository con JDBC.
 * Versión simplificada para Clase 4.
 */
public class VentaRepositoryImpl implements VentaRepository {
    
    private static final String SQL_SELECT_BASE = 
        "SELECT v.id, v.fecha_hora, v.usuario_id, v.total, v.estado, v.observaciones, u.username " +
        "FROM venta v " +
        "JOIN usuario u ON v.usuario_id = u.id";
    
    private static final String SQL_SELECT_BY_ID = 
        SQL_SELECT_BASE + " WHERE v.id = ?";
    
    private static final String SQL_SELECT_BY_FECHA = 
        SQL_SELECT_BASE + " WHERE DATE(v.fecha_hora) = ? AND v.estado = 'ACTIVA' ORDER BY v.fecha_hora DESC";
    
    private static final String SQL_SELECT_HOY = 
        SQL_SELECT_BASE + " WHERE DATE(v.fecha_hora) = CURDATE() AND v.estado = 'ACTIVA' ORDER BY v.fecha_hora DESC";
    
    private static final String SQL_TOTAL_DIA = 
        "SELECT COALESCE(SUM(total), 0) as total FROM venta WHERE DATE(fecha_hora) = CURDATE() AND estado = 'ACTIVA'";
    
    private Venta mapearVenta(ResultSet rs) throws SQLException {
        Venta venta = new Venta();
        venta.setId(rs.getInt("id"));
        venta.setFechaHora(rs.getTimestamp("fecha_hora").toLocalDateTime());
        venta.setUsuarioId(rs.getInt("usuario_id"));
        venta.setTotal(rs.getDouble("total"));
        venta.setEstado(rs.getString("estado"));
        venta.setObservaciones(rs.getString("observaciones"));
        // Campo adicional útil para mostrar
        venta.setUsuarioNombre(rs.getString("username"));
        return venta;
    }
    
    @Override
    public List<Venta> listarPorFecha(LocalDate fecha) {
        List<Venta> ventas = new ArrayList<>();
        
        try (Connection conn = DatabaseConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_SELECT_BY_FECHA)) {
            
            ps.setDate(1, Date.valueOf(fecha));
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ventas.add(mapearVenta(rs));
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Error al listar ventas por fecha: " + fecha);
            e.printStackTrace();
        }
        
        return ventas;
    }
    
    @Override
    public List<Venta> listarDelDia() {
        List<Venta> ventas = new ArrayList<>();
        
        try (Connection conn = DatabaseConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_SELECT_HOY);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                ventas.add(mapearVenta(rs));
            }
            
        } catch (SQLException e) {
            System.err.println("Error al listar ventas del día");
            e.printStackTrace();
        }
        
        return ventas;
    }
    
    @Override
    public Optional<Venta> buscarPorId(int id) {
        try (Connection conn = DatabaseConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_SELECT_BY_ID)) {
            
            ps.setInt(1, id);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(mapearVenta(rs));
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Error al buscar venta por ID: " + id);
            e.printStackTrace();
        }
        
        return Optional.empty();
    }
    
    @Override
    public Venta crear(Venta venta) {
        // TODO: Implementar en Clase 5 con transacciones
        throw new UnsupportedOperationException("Crear venta se implementará en Clase 5");
    }
    
    @Override
    public double calcularTotalDelDia() {
        try (Connection conn = DatabaseConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_TOTAL_DIA);
             ResultSet rs = ps.executeQuery()) {
            
            if (rs.next()) {
                return rs.getDouble("total");
            }
            
        } catch (SQLException e) {
            System.err.println("Error al calcular total del día");
            e.printStackTrace();
        }
        
        return 0.0;
    }
}
```

### 3.3 Probar VentaRepository

```java
package cl.cmartinezs.pnb;

import cl.cmartinezs.pnb.model.Venta;
import cl.cmartinezs.pnb.repository.VentaRepository;
import cl.cmartinezs.pnb.repository.impl.VentaRepositoryImpl;

import java.time.format.DateTimeFormatter;
import java.util.List;

public class TestVentaRepository {
    
    public static void main(String[] args) {
        System.out.println("===========================================");
        System.out.println("   TEST: VentaRepository (JDBC)           ");
        System.out.println("===========================================\n");
        
        VentaRepository repo = new VentaRepositoryImpl();
        DateTimeFormatter fmt = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        
        // Test 1: Ventas del día
        System.out.println("Test 1: Ventas del día (activas)");
        List<Venta> hoy = repo.listarDelDia();
        System.out.println("Total: " + hoy.size() + " ventas");
        
        hoy.forEach(v -> {
            System.out.printf("  #%d - %s - $%.2f - %s%n", 
                v.getId(),
                v.getFechaHora().format(fmt),
                v.getTotal(),
                v.getUsuarioNombre());
        });
        
        System.out.println("\n-------------------------------------------\n");
        
        // Test 2: Total del día
        System.out.println("Test 2: Total acumulado del día");
        double total = repo.calcularTotalDelDia();
        System.out.printf("Total: $%.2f%n", total);
        
        System.out.println("\n===========================================");
        System.out.println("   TEST COMPLETADO                        ");
        System.out.println("===========================================");
    }
}
```

---

## 🔒 Mejora Opcional: Hash de Contraseñas (Bonus)

Si tienes tiempo extra, puedes implementar hash de contraseñas para mayor seguridad.

### Clase PasswordHasher

```java
package cl.cmartinezs.pnb.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * Utilidad para hashear contraseñas con SHA-256.
 */
public class PasswordHasher {
    
    /**
     * Hashea una contraseña usando SHA-256.
     * 
     * @param password Contraseña en texto plano
     * @return Hash hexadecimal de la contraseña
     */
    public static String hash(String password) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hashBytes = digest.digest(password.getBytes());
            
            // Convertir bytes a hexadecimal
            StringBuilder hexString = new StringBuilder();
            for (byte b : hashBytes) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) {
                    hexString.append('0');
                }
                hexString.append(hex);
            }
            
            return hexString.toString();
            
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error al hashear contraseña", e);
        }
    }
    
    /**
     * Verifica si una contraseña coincide con un hash.
     */
    public static boolean verify(String password, String hash) {
        return hash(password).equals(hash);
    }
}
```

### Actualizar Contraseñas en BD

```sql
-- Script para hashear contraseñas existentes
USE pixelandbean;

UPDATE usuario SET password = SHA2('admin123', 256) WHERE username = 'admin';
UPDATE usuario SET password = SHA2('op123', 256) WHERE username = 'operador';
UPDATE usuario SET password = SHA2('juan123', 256) WHERE username = 'juan.perez';
UPDATE usuario SET password = SHA2('maria123', 256) WHERE username = 'maria.lopez';
UPDATE usuario SET password = SHA2('carlos123', 256) WHERE username = 'carlos.gomez';
```

### Actualizar UsuarioRepositoryImpl

```java
// En autenticar()
ps.setString(2, PasswordHasher.hash(password)); // Hash antes de comparar

// En crear() y actualizar()
ps.setString(2, PasswordHasher.hash(usuario.getPassword())); // Hash antes de guardar
```

---

## 🧪 Paso 4: Pruebas Integradas (5 min)

### Test de Autenticación Real

Ahora el login debe funcionar contra la base de datos.

1. Ejecutar la aplicación
2. Ingresar credenciales:
   - Usuario: `admin`
   - Contraseña: `admin123`
3. Verificar que ingresa correctamente
4. Ver que el rol y usuario se muestran en la barra de estado

### Ejecutar y Probar la Aplicación

```
✅ Login contra BD funciona
✅ Listado de usuarios carga desde BD
✅ Listado de productos carga desde BD
✅ Ventas del día se muestran correctamente
✅ Total del día se calcula desde BD
```

---

## 🧹 Limpieza de Código Mock

Una vez que todo funcione con JDBC, puedes eliminar:

- ❌ Clases `*RepositoryMock` (si las tenías separadas)
- ❌ Listas estáticas con datos hardcodeados
- ❌ Comentar o eliminar código de prueba temporal

**Nota:** Guarda una copia o haz commit en Git antes de eliminar, por si acaso.

---

## ✅ Verificación Final

Confirma que tienes:

1. ✅ `UsuarioRepositoryImpl` migrado a JDBC
2. ✅ `ProductoRepositoryImpl` migrado a JDBC
3. ✅ `VentaRepositoryImpl` implementado (básico)
4. ✅ Login funciona contra base de datos
5. ✅ Listados cargan desde base de datos
6. ✅ No hay datos mock en uso
7. ✅ Aplicación 100% funcional con persistencia real
8. ✅ (Opcional) Contraseñas hasheadas

---

## 🎯 Resumen de Cambios

### Antes (Clase 3):
```
Repository → List<Usuario> mock en memoria
```

### Ahora (Clase 4):
```
Repository → JDBC → MySQL Database
```

### Sin cambios:
- ✅ Interfaces de repositorio (mismo contrato)
- ✅ Capa de servicios
- ✅ Controladores
- ✅ Vistas

**Conclusión:** La arquitectura en capas nos permitió cambiar completamente la implementación de persistencia sin tocar el resto de la aplicación. ¡Ese es el poder de la separación de responsabilidades!

---

## 🚀 Próximos Pasos

En la **Clase 5** completaremos:
- CRUD completo de Usuarios
- CRUD completo de Productos
- Registro de ventas con múltiples productos (transacciones)
- Validaciones de negocio
- Anular ventas
- Reportes avanzados

---

## 💡 Siguiente Clase

**Clase 5 – CRUD Completo + Seguridad**

➡️ Implementación de todas las operaciones CRUD, validaciones completas, transacciones avanzadas y mejoras de seguridad.

---

> 🧠 *"La arquitectura en capas paga sus dividendos cuando necesitas hacer cambios profundos sin romper nada."*

