# 📦 Paso 1 Completado: Extracción de Clase Usuario

**Fecha:** 28 de noviembre de 2025  
**Fase:** 1 - Extracción y Catalogación  
**Estado:** ✅ COMPLETADO

---

## 🎯 Objetivo

Extraer y catalogar todas las definiciones de la clase `Usuario` a través de las 6 lecciones del curso, identificando atributos, tipos de datos y métodos.

---

## 📊 Resultados de Extracción

### 🗄️ Definición en Base de Datos (Schema SQL)

**Archivo:** `docs/sql/01_schema.sql`

```sql
CREATE TABLE usuario (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,              -- Para hash SHA-256/bcrypt
    nombre_completo VARCHAR(100),
    rol ENUM('ADMIN', 'OPERADOR') NOT NULL DEFAULT 'OPERADOR',
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    INDEX idx_username (username),
    INDEX idx_rol (rol),
    INDEX idx_activo (activo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

**Atributos SQL:**
1. `id` - INT, PK, AUTO_INCREMENT
2. `username` - VARCHAR(50), UNIQUE, NOT NULL
3. `password` - VARCHAR(255), NOT NULL
4. `nombre_completo` - VARCHAR(100), NULLABLE
5. `rol` - ENUM('ADMIN', 'OPERADOR'), NOT NULL, DEFAULT 'OPERADOR'
6. `activo` - BOOLEAN, NOT NULL, DEFAULT TRUE
7. `fecha_creacion` - TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
8. `fecha_modificacion` - TIMESTAMP, AUTO UPDATE

---

### 📘 Lección 03: MVC Architecture

**Archivo:** `docs/00-lessons/03-mvc-architecture/02-refactoring-layers.md`

#### Interface IUsuarioRepository

**Métodos definidos:**
```java
Usuario buscarPorId(int id)
Usuario buscarPorUsername(String username)
List<Usuario> listarTodos()
List<Usuario> listarPorRol(String rol)
int guardar(Usuario usuario)
void actualizar(Usuario usuario)
void eliminar(int id)
boolean existeUsername(String username)
```

**Atributos implícitos de Usuario (basados en métodos):**
- ✅ `id` (int) - usado en buscarPorId, eliminar
- ✅ `username` (String) - usado en buscarPorUsername, existeUsername
- ✅ `rol` (String) - usado en listarPorRol
- ✅ Otros atributos no especificados en la interfaz

**Observaciones:**
- La interfaz NO define explícitamente los atributos de Usuario
- Se asume que la clase modelo existe pero no se muestra completa
- Los métodos sugieren la existencia de: id, username, rol

---

### 📘 Lección 04: Database & JDBC

**Archivo:** `docs/00-lessons/04-database-jdbc/03-repository-implementation.md`

#### Método mapearUsuario (línea 217)

```java
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
```

**Atributos Java identificados:**
1. ✅ `id` - int/Integer
2. ✅ `username` - String
3. ✅ `password` - String
4. ✅ `nombreCompleto` - String (campo DB: nombre_completo)
5. ✅ `rol` - String (campo DB: rol)
6. ✅ `activo` - boolean/Boolean

**Getters/Setters usados:**
- `setId(int)`
- `getId()` (implícito)
- `setUsername(String)`
- `getUsername()` (usado en línea 355)
- `setPassword(String)`
- `getPassword()` (usado en líneas 342, 374)
- `setNombreCompleto(String)`
- `getNombreCompleto()` (usado en línea 343)
- `setRol(String)`
- `getRol()` (usado en línea 344)
- `setActivo(boolean)`
- `isActivo()` (usado en línea 345)

**Observaciones:**
- ✅ Mapeo directo BD → Java
- ✅ Nomenclatura Java: `nombreCompleto` (camelCase)
- ✅ Nomenclatura SQL: `nombre_completo` (snake_case)
- ⚠️ **NO se mapean:** `fecha_creacion`, `fecha_modificacion`

---

### 📘 Lección 05: CRUD Operations

**Archivo:** `docs/00-lessons/05-crud-operations/01-usuarios-crud.md`

#### UsuarioDialog - Formulario

**Componentes del formulario (línea ~160):**
```java
private JTextField txtUsername;
private JPasswordField txtPassword;
private JPasswordField txtPasswordConfirm;
private JTextField txtNombreCompleto;
private JComboBox<Rol> cboRol;
private JCheckBox chkActivo;
```

**Atributos implícitos:**
1. ✅ `username` - String
2. ✅ `password` - String
3. ✅ `nombreCompleto` - String
4. ✅ `rol` - Rol (tipo Enum, no String)
5. ✅ `activo` - boolean

**Método getUsuario() - línea ~432:**
```java
public Usuario getUsuario() {
    if (usuario == null) {
        usuario = new Usuario();
    }
    
    usuario.setUsername(getUsername());
    usuario.setNombreCompleto(getNombreCompleto());
    usuario.setRol(getRol());
    usuario.setActivo(isActivo());
    
    // Password solo si se ingresó
    String pwd = getPassword();
    if (pwd != null) {
        usuario.setPassword(pwd);  // Se hasheará en el servicio
    }
    
    return usuario;
}
```

**Observaciones:**
- ✅ Usa `Rol` como tipo Enum (no String como en lección 04)
- ✅ Confirma atributos: username, password, nombreCompleto, rol, activo
- ⚠️ **INCONSISTENCIA POTENCIAL:** Lección 04 usa `String rol`, Lección 05 usa `Rol rol`

---

## 📊 Tabla Comparativa: Atributos de Usuario por Lección

| Atributo | SQL (Schema) | L03 (Interface) | L04 (JDBC) | L05 (CRUD) | L06 |
|----------|--------------|-----------------|------------|------------|-----|
| **id** | ✅ INT PK | ✅ int (implícito) | ✅ int/Integer | ❓ (no visible) | ❓ |
| **username** | ✅ VARCHAR(50) UNIQUE | ✅ String | ✅ String | ✅ String | ❓ |
| **password** | ✅ VARCHAR(255) | ❓ (no visible) | ✅ String | ✅ String | ❓ |
| **nombreCompleto** | ✅ nombre_completo VARCHAR(100) | ❓ (no visible) | ✅ String | ✅ String | ❓ |
| **rol** | ✅ ENUM('ADMIN','OPERADOR') | ✅ String (implícito) | ✅ **String** | ⚠️ **Rol (Enum)** | ❓ |
| **activo** | ✅ BOOLEAN DEFAULT TRUE | ❓ (no visible) | ✅ boolean | ✅ boolean | ❓ |
| **fecha_creacion** | ✅ TIMESTAMP | ❌ No | ❌ **No mapeado** | ❓ | ❓ |
| **fecha_modificacion** | ✅ TIMESTAMP | ❌ No | ❌ **No mapeado** | ❓ | ❓ |

### Leyenda
- ✅ Presente y consistente
- ⚠️ Presente pero con diferencia de tipo
- ❌ Ausente explícitamente
- ❓ No verificado en esta lección

---

## 🔍 Inconsistencias Identificadas

### ❌ CRÍTICA: Tipo de dato `rol`

**Problema:**
- **Lección 04 (JDBC):** `usuario.setRol(rs.getString("rol"))` → String
- **Lección 05 (CRUD):** `usuario.setRol(getRol())` donde `getRol()` retorna `Rol` (Enum)

**Impacto:**
- ❌ Incompatibilidad de tipos
- ❌ El código de L04 y L05 no es compatible
- ❌ Requiere conversión String ↔ Enum

**Soluciones posibles:**
1. **Opción A:** Usar `Rol` (Enum) consistentemente
   - Cambiar L04: `usuario.setRol(Rol.valueOf(rs.getString("rol")))`
2. **Opción B:** Usar `String` consistentemente
   - Cambiar L05: `usuario.setRol(getRol().name())`
3. **Opción C:** Sobrecargar setter para aceptar ambos

---

### ⚠️ MENOR: Campos de auditoría no mapeados

**Problema:**
- La tabla SQL tiene `fecha_creacion` y `fecha_modificacion`
- Ninguna lección mapea estos campos a la clase Java

**Impacto:**
- ⚠️ Pérdida de información de auditoría
- ⚠️ No se puede consultar cuándo se creó/modificó un usuario desde Java

**Solución recomendada:**
- Agregar atributos en clase Usuario:
  ```java
  private LocalDateTime fechaCreacion;
  private LocalDateTime fechaModificacion;
  ```

---

### ⚠️ MENOR: Nomenclatura BD vs Java

**Observado:**
- SQL: `nombre_completo` (snake_case)
- Java: `nombreCompleto` (camelCase)

**Estado:** ✅ CORRECTO - Es la convención estándar

---

## 📋 Especificación Canónica Propuesta

### Clase Usuario (Java)

```java
package cl.tuusuario.pnb.model;

import java.time.LocalDateTime;

/**
 * Modelo de dominio: Usuario del sistema
 * Representa un usuario con credenciales y permisos
 */
public class Usuario {
    
    // Identificación
    private Integer id;
    private String username;
    private String password;
    
    // Información personal
    private String nombreCompleto;
    
    // Autorización
    private Rol rol;  // ✅ Usar Enum, no String
    
    // Estado
    private boolean activo;
    
    // Auditoría (opcional pero recomendado)
    private LocalDateTime fechaCreacion;
    private LocalDateTime fechaModificacion;
    
    // Constructors
    public Usuario() {
    }
    
    public Usuario(String username, String password, Rol rol) {
        this.username = username;
        this.password = password;
        this.rol = rol;
        this.activo = true;
    }
    
    // Getters y Setters
    
    public Integer getId() {
        return id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    
    public String getUsername() {
        return username;
    }
    
    public void setUsername(String username) {
        this.username = username;
    }
    
    public String getPassword() {
        return password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    
    public String getNombreCompleto() {
        return nombreCompleto;
    }
    
    public void setNombreCompleto(String nombreCompleto) {
        this.nombreCompleto = nombreCompleto;
    }
    
    public Rol getRol() {
        return rol;
    }
    
    public void setRol(Rol rol) {
        this.rol = rol;
    }
    
    // ⚠️ Sobrecarga para compatibilidad con String (si es necesario)
    public void setRol(String rol) {
        this.rol = Rol.valueOf(rol);
    }
    
    public boolean isActivo() {
        return activo;
    }
    
    public void setActivo(boolean activo) {
        this.activo = activo;
    }
    
    public LocalDateTime getFechaCreacion() {
        return fechaCreacion;
    }
    
    public void setFechaCreacion(LocalDateTime fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }
    
    public LocalDateTime getFechaModificacion() {
        return fechaModificacion;
    }
    
    public void setFechaModificacion(LocalDateTime fechaModificacion) {
        this.fechaModificacion = fechaModificacion;
    }
    
    // Métodos de negocio
    
    public boolean esAdmin() {
        return this.rol == Rol.ADMIN;
    }
    
    public boolean esOperador() {
        return this.rol == Rol.OPERADOR;
    }
    
    // toString, equals, hashCode (recomendado)
    
    @Override
    public String toString() {
        return "Usuario{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", rol=" + rol +
                ", activo=" + activo +
                '}';
    }
}
```

### Enum Rol

```java
package cl.tuusuario.pnb.model;

/**
 * Roles disponibles en el sistema
 */
public enum Rol {
    ADMIN("Administrador"),
    OPERADOR("Operador");
    
    private final String descripcion;
    
    Rol(String descripcion) {
        this.descripcion = descripcion;
    }
    
    public String getDescripcion() {
        return descripcion;
    }
}
```

---

## ✅ Checklist de Validación

### Atributos Principales
- [x] `id` - Identificado en todas las lecciones relevantes
- [x] `username` - Consistente en todas las lecciones
- [x] `password` - Presente y consistente
- [x] `nombreCompleto` - Nomenclatura consistente (camelCase)
- [⚠️] `rol` - **INCONSISTENCIA:** String vs Enum
- [x] `activo` - Consistente en todas las lecciones

### Campos Opcionales
- [⚠️] `fechaCreacion` - En BD pero no mapeado en Java
- [⚠️] `fechaModificacion` - En BD pero no mapeado en Java

### Nomenclatura
- [x] Java usa camelCase
- [x] SQL usa snake_case
- [x] Getters/Setters siguen convención JavaBeans

---

## 📝 Recomendaciones para Corrección

### Prioridad ALTA
1. **Resolver inconsistencia de tipo `rol`**
   - Actualizar Lección 04 para usar `Rol.valueOf()`
   - O documentar la sobrecarga de setRol()
   - Asegurar que todas las lecciones usen Enum

### Prioridad MEDIA
2. **Agregar campos de auditoría**
   - Incluir `fechaCreacion` y `fechaModificacion` en clase Java
   - Actualizar mapeo en lección 04
   - Documentar su uso (o no uso) en lecciones

### Prioridad BAJA
3. **Documentar clase Usuario completa**
   - Crear ejemplo completo de la clase en lección 03 o 04
   - Mostrar todos los atributos claramente
   - Incluir constructores y métodos auxiliares

---

## 🚀 Siguiente Paso

**Paso 2:** Extraer clase `Producto`

---

**Paso 1 completado:** 28 de noviembre de 2025  
**Tiempo invertido:** ~30 minutos  
**Inconsistencias encontradas:** 1 crítica, 2 menores

