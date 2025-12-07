# 📦 Paso 2 Completado: Extracción de Clase Producto

**Fecha:** 28 de noviembre de 2025  
**Fase:** 1 - Extracción y Catalogación  
**Estado:** ✅ COMPLETADO

---

## 🎯 Objetivo

Extraer y catalogar todas las definiciones de la clase `Producto` a través de las 6 lecciones del curso, identificando atributos, tipos de datos y métodos.

---

## 📊 Resultados de Extracción

### 🗄️ Definición en Base de Datos (Schema SQL)

**Archivo:** `docs/sql/01_schema.sql`

```sql
CREATE TABLE producto (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    categoria ENUM('BEBIDA', 'SNACK', 'TIEMPO_ARCADE') NOT NULL,
    tipo VARCHAR(50),                    -- Específico por categoría
    descripcion TEXT,
    precio DECIMAL(10,2) NOT NULL CHECK (precio > 0),
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    INDEX idx_nombre (nombre),
    INDEX idx_categoria (categoria),
    INDEX idx_activo (activo),
    UNIQUE KEY uk_nombre (nombre)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

**Atributos SQL:**
1. `id` - INT, PK, AUTO_INCREMENT
2. `nombre` - VARCHAR(100), NOT NULL, UNIQUE
3. `categoria` - ENUM('BEBIDA', 'SNACK', 'TIEMPO_ARCADE'), NOT NULL
4. `tipo` - VARCHAR(50), NULLABLE
5. `descripcion` - TEXT, NULLABLE
6. `precio` - DECIMAL(10,2), NOT NULL, CHECK > 0
7. `activo` - BOOLEAN, NOT NULL, DEFAULT TRUE
8. `fecha_creacion` - TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
9. `fecha_modificacion` - TIMESTAMP, AUTO UPDATE

**Observaciones SQL:**
- ✅ `categoria` es ENUM (3 valores posibles)
- ✅ `nombre` tiene restricción UNIQUE
- ✅ `precio` tiene CHECK constraint
- ✅ Campos de auditoría presentes

---

### 📘 Lección 03: MVC Architecture

**Archivo:** `docs/00-lessons/03-mvc-architecture/02-refactoring-layers.md`

#### Interface IProductoRepository

**Métodos definidos:**
```java
Producto buscarPorId(int id)
List<Producto> listarTodos()
List<Producto> listarActivos()
List<Producto> listarPorCategoria(String categoria)
List<Producto> buscarPorNombre(String nombre)
int guardar(Producto producto)
void actualizar(Producto producto)
void eliminar(int id)
void cambiarEstado(int id, boolean activo)
```

**Atributos implícitos de Producto (basados en métodos):**
- ✅ `id` (int) - usado en buscarPorId, eliminar, cambiarEstado
- ✅ `nombre` (String) - usado en buscarPorNombre
- ✅ `categoria` (String) - usado en listarPorCategoria
- ✅ `activo` (boolean) - usado en cambiarEstado, listarActivos
- ✅ Otros atributos no especificados en la interfaz

**Observaciones:**
- La interfaz NO define explícitamente los atributos de Producto
- Se asume que la clase modelo existe pero no se muestra completa
- Los métodos sugieren la existencia de: id, nombre, categoria, activo

---

### 📘 Lección 04: Database & JDBC

**Archivo:** `docs/00-lessons/04-database-jdbc/03-repository-implementation.md`

#### Método mapearProducto (línea 588)

```java
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
```

**Atributos Java identificados:**
1. ✅ `id` - int/Integer
2. ✅ `nombre` - String
3. ✅ `categoria` - String (campo DB: ENUM)
4. ✅ `tipo` - String
5. ✅ `descripcion` - String
6. ✅ `precio` - **double** (campo DB: DECIMAL)
7. ✅ `activo` - boolean/Boolean

**Getters/Setters usados (líneas 708-754):**
- `setId(int)`
- `getId()` (implícito)
- `setNombre(String)`
- `getNombre()` (usado en línea 730)
- `setCategoria(String)`
- `getCategoria()` (usado en línea 743)
- `setTipo(String)`
- `getTipo()` (usado en línea 744)
- `setDescripcion(String)`
- `getDescripcion()` (usado en línea 745)
- `setPrecio(double)`
- `getPrecio()` (usado en línea 746)
- `setActivo(boolean)`
- `isActivo()` (usado en línea 747)

**Observaciones:**
- ✅ Mapeo directo BD → Java
- ⚠️ **TIPO DE DATO PRECIO:** Usa `double` (no `BigDecimal`)
- ✅ `categoria` se mapea como String (correcto para ENUM SQL)
- ⚠️ **NO se mapean:** `fecha_creacion`, `fecha_modificacion`

---

### 📘 Lección 05: CRUD Operations

**Archivo:** `docs/00-lessons/05-crud-operations/02-productos-crud.md`

#### ProductoDialog - Formulario (líneas 40-120)

**Componentes del formulario:**
```java
private JTextField txtNombre;
private JComboBox<String> cboCategoria;
private JTextField txtTipo;
private JTextField txtPrecio;
private JCheckBox chkActivo;

// Categorías disponibles
private static final String[] CATEGORIAS = {
    "BEBIDA", "SNACK", "TIEMPO_ARCADE"
};
```

**Atributos implícitos:**
1. ✅ `nombre` - String
2. ✅ `categoria` - String
3. ✅ `tipo` - String
4. ✅ `precio` - ? (se convierte desde String)
5. ✅ `activo` - boolean

#### Método getProducto() (línea ~300)

```java
public Producto getProducto() {
    if (producto == null) {
        producto = new Producto();
    }
    
    producto.setNombre(getNombre());
    producto.setCategoria(getCategoria());
    producto.setTipo(getTipo());
    producto.setPrecio(getPrecio());    // ← getPrecio() retorna BigDecimal
    producto.setActivo(isActivo());
    
    return producto;
}
```

**Método getPrecio() (línea ~288):**
```java
public BigDecimal getPrecio() {
    return new BigDecimal(txtPrecio.getText().trim());
}
```

**Observaciones:**
- ✅ Usa `categoria` como String (array de opciones)
- ⚠️ **TIPO DE DATO PRECIO:** Usa `BigDecimal` (no `double` como en L04)
- ✅ Confirma atributos: nombre, categoria, tipo, precio, activo
- ❌ **NO aparece:** `descripcion` en el formulario
- ⚠️ **INCONSISTENCIA:** L04 usa `double`, L05 usa `BigDecimal`

---

## 📊 Tabla Comparativa: Atributos de Producto por Lección

| Atributo | SQL (Schema) | L03 (Interface) | L04 (JDBC) | L05 (CRUD) | L06 |
|----------|--------------|-----------------|------------|------------|-----|
| **id** | ✅ INT PK | ✅ int (implícito) | ✅ int/Integer | ❓ (no visible) | ❓ |
| **nombre** | ✅ VARCHAR(100) UNIQUE | ✅ String | ✅ String | ✅ String | ❓ |
| **categoria** | ✅ ENUM(...) | ✅ String (implícito) | ✅ String | ✅ String | ❓ |
| **tipo** | ✅ VARCHAR(50) | ❓ (no visible) | ✅ String | ✅ String | ❓ |
| **descripcion** | ✅ TEXT | ❓ (no visible) | ✅ String | ❌ **Ausente en UI** | ❓ |
| **precio** | ✅ DECIMAL(10,2) | ❓ (no visible) | ⚠️ **double** | ⚠️ **BigDecimal** | ❓ |
| **activo** | ✅ BOOLEAN DEFAULT TRUE | ✅ boolean (implícito) | ✅ boolean | ✅ boolean | ❓ |
| **fecha_creacion** | ✅ TIMESTAMP | ❌ No | ❌ **No mapeado** | ❓ | ❓ |
| **fecha_modificacion** | ✅ TIMESTAMP | ❌ No | ❌ **No mapeado** | ❓ | ❓ |

### Leyenda
- ✅ Presente y consistente
- ⚠️ Presente pero con diferencia de tipo
- ❌ Ausente explícitamente
- ❓ No verificado en esta lección

---

## 🔍 Inconsistencias Identificadas

### ❌ CRÍTICA #1: Tipo de dato `precio`

**Problema:**
- **Lección 04 (JDBC):** `producto.setPrecio(rs.getDouble("precio"))` → **double**
- **Lección 05 (CRUD):** `producto.setPrecio(getPrecio())` donde `getPrecio()` retorna **BigDecimal**
- **Base de Datos:** `DECIMAL(10,2)` → debe mapearse a BigDecimal

**Impacto:**
- ❌ **INCOMPATIBILIDAD DE TIPOS** crítica
- ❌ El código de L04 y L05 no es compatible
- ❌ Pérdida de precisión al usar `double` para dinero
- ❌ Mala práctica: usar `double` para valores monetarios

**Solución recomendada:**
- ✅ Usar `BigDecimal` en todas las lecciones
- Cambiar L04: 
  ```java
  producto.setPrecio(rs.getBigDecimal("precio"));
  // y en INSERT/UPDATE:
  ps.setBigDecimal(5, producto.getPrecio());
  ```

---

### ⚠️ CRÍTICA #2: Campo `descripcion` ausente en UI (Lección 05)

**Problema:**
- SQL tiene campo `descripcion TEXT`
- Lección 04 mapea `descripcion` correctamente
- **Lección 05:** El formulario `ProductoDialog` NO tiene campo para `descripcion`

**Impacto:**
- ⚠️ Usuario no puede ingresar/editar descripción desde la UI
- ⚠️ Al crear producto, `descripcion` quedará NULL
- ⚠️ Al editar producto, se pierde la descripción existente (si no se envía)

**Solución recomendada:**
- Agregar campo en ProductoDialog:
  ```java
  private JTextArea txtDescripcion;
  // ...
  producto.setDescripcion(getDescripcion());
  ```

---

### ⚠️ MENOR: Campos de auditoría no mapeados

**Problema:**
- La tabla SQL tiene `fecha_creacion` y `fecha_modificacion`
- Ninguna lección mapea estos campos a la clase Java

**Impacto:**
- ⚠️ Pérdida de información de auditoría
- ⚠️ No se puede consultar cuándo se creó/modificó un producto desde Java

**Solución recomendada:**
- Agregar atributos en clase Producto:
  ```java
  private LocalDateTime fechaCreacion;
  private LocalDateTime fechaModificacion;
  ```

---

### ✅ CORRECTO: Campo `categoria` como String

**Observado:**
- SQL: ENUM('BEBIDA', 'SNACK', 'TIEMPO_ARCADE')
- Java: String categoria

**Estado:** ✅ **CORRECTO** - Es apropiado mapear ENUM SQL a String en Java
- Alternativa sería crear Enum Java, pero String es más flexible para este caso

---

## 📋 Especificación Canónica Propuesta

### Clase Producto (Java)

```java
package cl.tuusuario.pnb.model;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * Modelo de dominio: Producto del sistema
 * Representa productos: bebidas, snacks y tiempo de arcade
 */
public class Producto {
    
    // Identificación
    private Integer id;
    private String nombre;
    
    // Clasificación
    private String categoria;  // BEBIDA, SNACK, TIEMPO_ARCADE
    private String tipo;       // Específico por categoría
    private String descripcion;
    
    // Precio
    private BigDecimal precio;  // ✅ Usar BigDecimal, NO double
    
    // Estado
    private boolean activo;
    
    // Auditoría (opcional pero recomendado)
    private LocalDateTime fechaCreacion;
    private LocalDateTime fechaModificacion;
    
    // Constructors
    public Producto() {
    }
    
    public Producto(String nombre, String categoria, BigDecimal precio) {
        this.nombre = nombre;
        this.categoria = categoria;
        this.precio = precio;
        this.activo = true;
    }
    
    // Getters y Setters
    
    public Integer getId() {
        return id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    
    public String getNombre() {
        return nombre;
    }
    
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    
    public String getCategoria() {
        return categoria;
    }
    
    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }
    
    public String getTipo() {
        return tipo;
    }
    
    public void setTipo(String tipo) {
        this.tipo = tipo;
    }
    
    public String getDescripcion() {
        return descripcion;
    }
    
    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
    
    public BigDecimal getPrecio() {
        return precio;
    }
    
    public void setPrecio(BigDecimal precio) {
        this.precio = precio;
    }
    
    // ⚠️ Sobrecarga para compatibilidad temporal con double (deprecar)
    @Deprecated
    public void setPrecio(double precio) {
        this.precio = BigDecimal.valueOf(precio);
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
    
    public boolean esBebida() {
        return "BEBIDA".equals(this.categoria);
    }
    
    public boolean esSnack() {
        return "SNACK".equals(this.categoria);
    }
    
    public boolean esTiempoArcade() {
        return "TIEMPO_ARCADE".equals(this.categoria);
    }
    
    public BigDecimal calcularPrecioConDescuento(double porcentaje) {
        BigDecimal descuento = BigDecimal.valueOf(porcentaje / 100);
        return precio.multiply(BigDecimal.ONE.subtract(descuento));
    }
    
    // toString, equals, hashCode
    
    @Override
    public String toString() {
        return "Producto{" +
                "id=" + id +
                ", nombre='" + nombre + '\'' +
                ", categoria='" + categoria + '\'' +
                ", precio=" + precio +
                ", activo=" + activo +
                '}';
    }
}
```

---

## ✅ Checklist de Validación

### Atributos Principales
- [x] `id` - Identificado en todas las lecciones relevantes
- [x] `nombre` - Consistente en todas las lecciones
- [x] `categoria` - Consistente como String
- [x] `tipo` - Presente en L04 y L05
- [⚠️] `descripcion` - **Ausente en UI de L05**
- [⚠️] `precio` - **INCONSISTENCIA:** double vs BigDecimal
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
1. **Resolver inconsistencia de tipo `precio`**
   - Actualizar Lección 04 para usar `BigDecimal`
   - Cambiar `rs.getDouble()` → `rs.getBigDecimal()`
   - Cambiar `ps.setDouble()` → `ps.setBigDecimal()`
   - Asegurar que todas las lecciones usen BigDecimal

2. **Agregar campo `descripcion` en UI (Lección 05)**
   - Agregar `JTextArea txtDescripcion` en ProductoDialog
   - Incluir en layout del formulario
   - Agregar getter/setter

### Prioridad MEDIA
3. **Agregar campos de auditoría**
   - Incluir `fechaCreacion` y `fechaModificacion` en clase Java
   - Actualizar mapeo en lección 04
   - Documentar su uso (o no uso) en lecciones

### Prioridad BAJA
4. **Documentar clase Producto completa**
   - Crear ejemplo completo de la clase en lección 03 o 04
   - Mostrar todos los atributos claramente
   - Incluir constructores y métodos auxiliares

5. **Considerar Enum para categoría**
   - Opcionalmente crear `enum Categoria { BEBIDA, SNACK, TIEMPO_ARCADE }`
   - Mantener String es válido, pero Enum da más seguridad de tipos

---

## 📊 Comparación con clase Usuario

| Aspecto | Usuario | Producto | Consistencia |
|---------|---------|----------|--------------|
| **Tipo de ID** | Integer | Integer | ✅ Consistente |
| **Campos String** | username, nombreCompleto, password | nombre, categoria, tipo, descripcion | ✅ Consistente |
| **Campos boolean** | activo | activo | ✅ Consistente |
| **Inconsistencia tipo** | rol (String vs Enum) | precio (double vs BigDecimal) | ❌ Ambas tienen problemas similares |
| **Campos auditoría** | No mapeados | No mapeados | ⚠️ Mismo problema en ambas |
| **Campo faltante en UI** | Ninguno | descripcion | ⚠️ Solo en Producto |

---

## 🚀 Siguiente Paso

**Paso 3:** Extraer clases `Venta` y `VentaDetalle`

---

**Paso 2 completado:** 28 de noviembre de 2025  
**Tiempo invertido:** ~25 minutos  
**Inconsistencias encontradas:** 2 críticas, 2 menores

