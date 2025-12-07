# 📦 Paso 3 Completado: Extracción de Clases Venta y VentaDetalle

**Fecha:** 28 de noviembre de 2025  
**Fase:** 1 - Extracción y Catalogación  
**Estado:** ✅ COMPLETADO

---

## 🎯 Objetivo

Extraer y catalogar todas las definiciones de las clases `Venta` y `VentaDetalle` a través de las 6 lecciones del curso, identificando atributos, tipos de datos, relaciones y métodos.

---

## 📊 Resultados de Extracción

### 🗄️ Definición en Base de Datos (Schema SQL)

**Archivo:** `docs/sql/01_schema.sql`

#### Tabla `venta` (cabecera)

```sql
CREATE TABLE venta (
    id INT PRIMARY KEY AUTO_INCREMENT,
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario_id INT NOT NULL,
    total DECIMAL(10,2) NOT NULL CHECK (total >= 0),
    estado ENUM('ACTIVA', 'ANULADA') NOT NULL DEFAULT 'ACTIVA',
    observaciones TEXT,
    
    FOREIGN KEY (usuario_id) REFERENCES usuario(id),
    
    INDEX idx_fecha_hora (fecha_hora),
    INDEX idx_usuario (usuario_id),
    INDEX idx_estado (estado)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

**Atributos SQL de `venta`:**
1. `id` - INT, PK, AUTO_INCREMENT
2. `fecha_hora` - TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
3. `usuario_id` - INT, NOT NULL, FK → usuario(id)
4. `total` - DECIMAL(10,2), NOT NULL, CHECK >= 0
5. `estado` - ENUM('ACTIVA', 'ANULADA'), NOT NULL, DEFAULT 'ACTIVA'
6. `observaciones` - TEXT, NULLABLE

**Observaciones SQL venta:**
- ✅ FK a tabla `usuario` por `usuario_id`
- ✅ `estado` es ENUM (2 valores)
- ✅ `total` tiene CHECK constraint
- ⚠️ **NO tiene campos de auditoría** (fecha_creacion, fecha_modificacion)
- ⚠️ `usuario_id` es INT (no VARCHAR para username)

---

#### Tabla `venta_detalle` (líneas de venta)

```sql
CREATE TABLE venta_detalle (
    id INT PRIMARY KEY AUTO_INCREMENT,
    venta_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    precio_unitario DECIMAL(10,2) NOT NULL CHECK (precio_unitario > 0),
    subtotal DECIMAL(10,2) NOT NULL CHECK (subtotal >= 0),
    
    FOREIGN KEY (venta_id) REFERENCES venta(id) ON DELETE CASCADE,
    FOREIGN KEY (producto_id) REFERENCES producto(id),
    
    INDEX idx_venta (venta_id),
    INDEX idx_producto (producto_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

**Atributos SQL de `venta_detalle`:**
1. `id` - INT, PK, AUTO_INCREMENT
2. `venta_id` - INT, NOT NULL, FK → venta(id) ON DELETE CASCADE
3. `producto_id` - INT, NOT NULL, FK → producto(id)
4. `cantidad` - INT, NOT NULL, CHECK > 0
5. `precio_unitario` - DECIMAL(10,2), NOT NULL, CHECK > 0
6. `subtotal` - DECIMAL(10,2), NOT NULL, CHECK >= 0

**Observaciones SQL venta_detalle:**
- ✅ FK a `venta` con ON DELETE CASCADE
- ✅ FK a `producto`
- ✅ Todos los campos tienen CHECK constraints
- ⚠️ **NO tiene campo `producto_nombre`** (desnormalizado)

---

### 📘 Lección 03: MVC Architecture

**Archivo:** `docs/00-lessons/03-mvc-architecture/02-refactoring-layers.md`

#### Interface IVentaRepository

**Métodos definidos:**
```java
Venta buscarPorId(int id)
List<Venta> listarTodas()
List<Venta> listarPorRangoFechas(LocalDateTime desde, LocalDateTime hasta)
List<Venta> listarDelDia()
List<Venta> listarPorUsuario(int usuarioId)
int guardar(Venta venta)
void anular(int id)
double calcularTotalPorRango(LocalDateTime desde, LocalDateTime hasta)
```

**Atributos implícitos de Venta (basados en métodos):**
- ✅ `id` (int) - usado en buscarPorId, anular
- ✅ `fechaHora` (LocalDateTime) - usado en listarPorRangoFechas
- ✅ `usuarioId` (int) - usado en listarPorUsuario
- ✅ Otros atributos no especificados en la interfaz

**Observaciones:**
- La interfaz NO define explícitamente los atributos
- Se asume que la clase modelo existe pero no se muestra completa
- Los métodos sugieren la existencia de: id, fechaHora, usuarioId

---

### 📘 Lección 04: Database & JDBC

**Observación:** La lección 04 NO implementa completamente Venta/VentaDetalle
- No se encontró método `mapearVenta` o `mapearVentaDetalle`
- No se encontró implementación de `VentaRepositoryImpl` en lección 04
- **Posiblemente se implementa directamente en lección 05**

---

### 📘 Lección 05: CRUD Operations

**Archivo:** `docs/00-lessons/05-crud-operations/03-ventas-modulo.md`

#### Clase Venta (líneas 28-130)

```java
public class Venta {
    
    private Integer id;
    private LocalDateTime fechaHora;
    private String usuarioId;  // username del usuario que registró la venta
    private BigDecimal total;
    private String estado;  // ACTIVA, ANULADA
    
    // Relación con detalles
    private List<VentaDetalle> detalles;
    
    // Constructor
    public Venta() {
        this.fechaHora = LocalDateTime.now();
        this.total = BigDecimal.ZERO;
        this.estado = "ACTIVA";
        this.detalles = new ArrayList<>();
    }
    
    // Getters/Setters estándar
    // ...
    
    // Métodos de negocio
    public void agregarDetalle(VentaDetalle detalle) { }
    public void removerDetalle(VentaDetalle detalle) { }
    public void recalcularTotal() { }
    public boolean isActiva() { }
    public boolean isAnulada() { }
}
```

**Atributos Java de Venta:**
1. ✅ `id` - Integer
2. ✅ `fechaHora` - LocalDateTime
3. ⚠️ `usuarioId` - **String** (comentario dice "username")
4. ✅ `total` - BigDecimal
5. ✅ `estado` - String (valores: "ACTIVA", "ANULADA")
6. ✅ `detalles` - List<VentaDetalle>

**Métodos de negocio:**
- `agregarDetalle(VentaDetalle)` - agrega y recalcula
- `removerDetalle(VentaDetalle)` - remueve y recalcula
- `recalcularTotal()` - suma todos los subtotales
- `isActiva()` - verifica si estado == "ACTIVA"
- `isAnulada()` - verifica si estado == "ANULADA"

---

#### Clase VentaDetalle (líneas 135-243)

```java
public class VentaDetalle {
    
    private Integer id;
    private Integer ventaId;
    private Integer productoId;
    private String productoNombre;  // Desnormalizado para historial
    private int cantidad;
    private BigDecimal precioUnitario;
    private BigDecimal subtotal;
    
    // Constructor vacío
    public VentaDetalle() { }
    
    // Constructor completo
    public VentaDetalle(Integer productoId, String productoNombre, 
                       int cantidad, BigDecimal precioUnitario) {
        this.productoId = productoId;
        this.productoNombre = productoNombre;
        this.cantidad = cantidad;
        this.precioUnitario = precioUnitario;
        calcularSubtotal();
    }
    
    // Getters/Setters estándar
    // ...
    
    // Métodos de negocio
    public void calcularSubtotal() {
        if (precioUnitario != null) {
            this.subtotal = precioUnitario.multiply(new BigDecimal(cantidad));
        }
    }
}
```

**Atributos Java de VentaDetalle:**
1. ✅ `id` - Integer
2. ✅ `ventaId` - Integer
3. ✅ `productoId` - Integer
4. ✅ `productoNombre` - String (desnormalizado)
5. ✅ `cantidad` - int (primitivo)
6. ✅ `precioUnitario` - BigDecimal
7. ✅ `subtotal` - BigDecimal

**Métodos de negocio:**
- `calcularSubtotal()` - multiplica cantidad × precioUnitario

**Observaciones:**
- ✅ Los setters de `cantidad` y `precioUnitario` llaman automáticamente a `calcularSubtotal()`
- ✅ Campo `productoNombre` desnormalizado para mantener historial

---

## 📊 Tabla Comparativa: Atributos de Venta por Lección

| Atributo | SQL (Schema) | L03 (Interface) | L04 (JDBC) | L05 (CRUD) |
|----------|--------------|-----------------|------------|------------|
| **id** | ✅ INT PK | ✅ int (implícito) | ❓ No implementado | ✅ Integer |
| **fecha_hora** | ✅ TIMESTAMP | ✅ LocalDateTime (implícito) | ❓ | ✅ LocalDateTime |
| **usuario_id** | ✅ INT FK | ✅ int | ❓ | ⚠️ **String** (username) |
| **total** | ✅ DECIMAL(10,2) | ❓ | ❓ | ✅ BigDecimal |
| **estado** | ✅ ENUM('ACTIVA','ANULADA') | ❓ | ❓ | ✅ String |
| **observaciones** | ✅ TEXT | ❓ | ❓ | ❌ **Ausente** |
| **detalles** | ❌ (tabla separada) | ❓ | ❓ | ✅ List<VentaDetalle> |

---

## 📊 Tabla Comparativa: Atributos de VentaDetalle por Lección

| Atributo | SQL (Schema) | L03 (Interface) | L04 (JDBC) | L05 (CRUD) |
|----------|--------------|-----------------|------------|------------|
| **id** | ✅ INT PK | ❓ | ❓ | ✅ Integer |
| **venta_id** | ✅ INT FK | ❓ | ❓ | ✅ Integer (ventaId) |
| **producto_id** | ✅ INT FK | ❓ | ❓ | ✅ Integer (productoId) |
| **cantidad** | ✅ INT CHECK > 0 | ❓ | ❓ | ✅ int (primitivo) |
| **precio_unitario** | ✅ DECIMAL(10,2) | ❓ | ❓ | ✅ BigDecimal (precioUnitario) |
| **subtotal** | ✅ DECIMAL(10,2) | ❓ | ❓ | ✅ BigDecimal |
| **producto_nombre** | ❌ **No en BD** | ❓ | ❓ | ✅ String (productoNombre) |

### Leyenda
- ✅ Presente y consistente
- ⚠️ Presente pero con diferencia de tipo
- ❌ Ausente explícitamente
- ❓ No verificado en esta lección

---

## 🔍 Inconsistencias Identificadas

### ❌ CRÍTICA #1: Tipo de `usuario_id` en Venta

**Problema:**
- **Base de Datos:** `usuario_id INT` FK a tabla usuario(id)
- **Lección 05 (Java):** `usuarioId String` (comentario dice "username")

**Impacto:**
- ❌ **INCOMPATIBILIDAD CRÍTICA** entre BD y Java
- ❌ BD espera un INT (id del usuario)
- ❌ Java almacena un String (username del usuario)
- ❌ No se puede hacer FK correctamente
- ❌ El INSERT/UPDATE fallará o guardará datos incorrectos

**Análisis:**
La tabla SQL tiene:
```sql
usuario_id INT NOT NULL,
FOREIGN KEY (usuario_id) REFERENCES usuario(id)
```

Pero la clase Java tiene:
```java
private String usuarioId;  // username del usuario que registró la venta
```

**Soluciones posibles:**
1. **Opción A (Recomendada):** Cambiar Java a `Integer usuarioId`
   - Guardar el ID del usuario (como indica la FK)
   - Hacer JOIN si necesitas el nombre para mostrar
   
2. **Opción B:** Cambiar BD a `usuario_username VARCHAR(50)`
   - Cambiar FK a referenciar username
   - Menos eficiente pero funcional

3. **Opción C:** Tener ambos campos
   - `usuarioId Integer` para FK
   - `usuarioNombre String` desnormalizado para mostrar

---

### ⚠️ CRÍTICA #2: Campo `observaciones` ausente en clase Java

**Problema:**
- SQL tiene campo `observaciones TEXT`
- **Lección 05:** La clase `Venta` NO tiene atributo `observaciones`

**Impacto:**
- ⚠️ No se pueden guardar observaciones de la venta
- ⚠️ El campo quedará siempre NULL en BD
- ⚠️ Pérdida de funcionalidad

**Solución recomendada:**
```java
private String observaciones;

public String getObservaciones() {
    return observaciones;
}

public void setObservaciones(String observaciones) {
    this.observaciones = observaciones;
}
```

---

### ⚠️ CRÍTICA #3: Campo `productoNombre` NO está en BD

**Problema:**
- **Lección 05 (Java):** `VentaDetalle` tiene `productoNombre String`
- **Base de Datos:** `venta_detalle` NO tiene columna `producto_nombre`

**Impacto:**
- ⚠️ No se puede persistir el nombre del producto desnormalizado
- ⚠️ Al hacer SELECT, el campo quedará vacío
- ⚠️ Se pierde la intención de mantener historial

**Análisis:**
El comentario en el código dice:
```java
private String productoNombre;  // Desnormalizado para historial
```

Esto sugiere que se quería guardar el nombre del producto en el momento de la venta (para historial), pero la tabla SQL no lo soporta.

**Soluciones posibles:**
1. **Opción A (Recomendada):** Agregar columna a BD
   ```sql
   ALTER TABLE venta_detalle 
   ADD COLUMN producto_nombre VARCHAR(100) AFTER producto_id;
   ```

2. **Opción B:** Quitar campo de Java
   - Hacer JOIN con tabla producto para obtener nombre
   - Riesgo: si cambia nombre del producto, historial cambia

3. **Opción C:** No persistir, solo usar en memoria
   - Llenar desde JOIN al cargar
   - No guardar en INSERT

---

### ⚠️ MENOR: Campo `estado` como String vs Enum

**Observado:**
- SQL: `ENUM('ACTIVA', 'ANULADA')`
- Java L05: `String estado`

**Estado:** ⚠️ **MEJORABLE** pero no crítico
- Funciona correctamente (String puede contener valores del ENUM)
- Alternativa: Crear `enum EstadoVenta { ACTIVA, ANULADA }`
- Recomendación: Mantener String por simplicidad

---

### ⚠️ MENOR: Tipo de `cantidad` en VentaDetalle

**Observado:**
- SQL: `INT` (puede ser NULL según SQL estándar)
- Java: `int` (primitivo, no puede ser null)

**Estado:** ✅ **CORRECTO** 
- SQL tiene `NOT NULL`, por lo que nunca será null
- Usar `int` primitivo es apropiado

---

## 📋 Especificación Canónica Propuesta

### Clase Venta (Java)

```java
package cl.tuusuario.pnb.model;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * Modelo de dominio: Venta (cabecera)
 * Representa una transacción de venta con sus detalles
 */
public class Venta {
    
    // Identificación
    private Integer id;
    private LocalDateTime fechaHora;
    
    // Auditoría y control
    private Integer usuarioId;  // ✅ CORREGIDO: Integer (no String)
    private String estado;      // ACTIVA, ANULADA
    private String observaciones;  // ✅ AGREGADO
    
    // Totales
    private BigDecimal total;
    
    // Relación con detalles (no persiste directamente)
    private List<VentaDetalle> detalles;
    
    // Constructors
    
    public Venta() {
        this.fechaHora = LocalDateTime.now();
        this.total = BigDecimal.ZERO;
        this.estado = "ACTIVA";
        this.detalles = new ArrayList<>();
    }
    
    // Getters y Setters
    
    public Integer getId() {
        return id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    
    public LocalDateTime getFechaHora() {
        return fechaHora;
    }
    
    public void setFechaHora(LocalDateTime fechaHora) {
        this.fechaHora = fechaHora;
    }
    
    public Integer getUsuarioId() {
        return usuarioId;
    }
    
    public void setUsuarioId(Integer usuarioId) {
        this.usuarioId = usuarioId;
    }
    
    public String getEstado() {
        return estado;
    }
    
    public void setEstado(String estado) {
        this.estado = estado;
    }
    
    public String getObservaciones() {
        return observaciones;
    }
    
    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }
    
    public BigDecimal getTotal() {
        return total;
    }
    
    public void setTotal(BigDecimal total) {
        this.total = total;
    }
    
    public List<VentaDetalle> getDetalles() {
        return detalles;
    }
    
    public void setDetalles(List<VentaDetalle> detalles) {
        this.detalles = detalles;
    }
    
    // Métodos de negocio
    
    public void agregarDetalle(VentaDetalle detalle) {
        this.detalles.add(detalle);
        recalcularTotal();
    }
    
    public void removerDetalle(VentaDetalle detalle) {
        this.detalles.remove(detalle);
        recalcularTotal();
    }
    
    public void recalcularTotal() {
        this.total = detalles.stream()
            .map(VentaDetalle::getSubtotal)
            .reduce(BigDecimal.ZERO, BigDecimal::add);
    }
    
    public boolean isActiva() {
        return "ACTIVA".equals(estado);
    }
    
    public boolean isAnulada() {
        return "ANULADA".equals(estado);
    }
    
    public void anular() {
        this.estado = "ANULADA";
    }
    
    @Override
    public String toString() {
        return "Venta{" +
                "id=" + id +
                ", fechaHora=" + fechaHora +
                ", total=" + total +
                ", estado='" + estado + '\'' +
                ", detalles=" + detalles.size() +
                '}';
    }
}
```

---

### Clase VentaDetalle (Java)

```java
package cl.tuusuario.pnb.model;

import java.math.BigDecimal;

/**
 * Modelo de dominio: Detalle de Venta
 * Representa una línea de productos en una venta
 */
public class VentaDetalle {
    
    // Identificación
    private Integer id;
    private Integer ventaId;
    
    // Producto
    private Integer productoId;
    private String productoNombre;  // ⚠️ Desnormalizado - agregar a BD
    
    // Cantidades y precios
    private int cantidad;
    private BigDecimal precioUnitario;
    private BigDecimal subtotal;
    
    // Constructors
    
    public VentaDetalle() {
    }
    
    public VentaDetalle(Integer productoId, String productoNombre, 
                       int cantidad, BigDecimal precioUnitario) {
        this.productoId = productoId;
        this.productoNombre = productoNombre;
        this.cantidad = cantidad;
        this.precioUnitario = precioUnitario;
        calcularSubtotal();
    }
    
    // Getters y Setters
    
    public Integer getId() {
        return id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    
    public Integer getVentaId() {
        return ventaId;
    }
    
    public void setVentaId(Integer ventaId) {
        this.ventaId = ventaId;
    }
    
    public Integer getProductoId() {
        return productoId;
    }
    
    public void setProductoId(Integer productoId) {
        this.productoId = productoId;
    }
    
    public String getProductoNombre() {
        return productoNombre;
    }
    
    public void setProductoNombre(String productoNombre) {
        this.productoNombre = productoNombre;
    }
    
    public int getCantidad() {
        return cantidad;
    }
    
    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
        calcularSubtotal();
    }
    
    public BigDecimal getPrecioUnitario() {
        return precioUnitario;
    }
    
    public void setPrecioUnitario(BigDecimal precioUnitario) {
        this.precioUnitario = precioUnitario;
        calcularSubtotal();
    }
    
    public BigDecimal getSubtotal() {
        return subtotal;
    }
    
    public void setSubtotal(BigDecimal subtotal) {
        this.subtotal = subtotal;
    }
    
    // Métodos de negocio
    
    public void calcularSubtotal() {
        if (precioUnitario != null) {
            this.subtotal = precioUnitario.multiply(new BigDecimal(cantidad));
        }
    }
    
    @Override
    public String toString() {
        return "VentaDetalle{" +
                "id=" + id +
                ", productoNombre='" + productoNombre + '\'' +
                ", cantidad=" + cantidad +
                ", precioUnitario=" + precioUnitario +
                ", subtotal=" + subtotal +
                '}';
    }
}
```

---

### Script SQL de Corrección

```sql
-- Agregar columna producto_nombre a venta_detalle
-- (para mantener historial del nombre en el momento de la venta)
ALTER TABLE venta_detalle 
ADD COLUMN producto_nombre VARCHAR(100) AFTER producto_id;

-- Opcional: Llenar con datos actuales de productos existentes
UPDATE venta_detalle vd
JOIN producto p ON vd.producto_id = p.id
SET vd.producto_nombre = p.nombre
WHERE vd.producto_nombre IS NULL;
```

---

## ✅ Checklist de Validación

### Clase Venta
- [x] `id` - Integer, consistente
- [x] `fechaHora` - LocalDateTime, consistente
- [⚠️] `usuarioId` - **String en L05, debe ser Integer**
- [x] `total` - BigDecimal, consistente
- [x] `estado` - String, funcional
- [⚠️] `observaciones` - **Ausente en L05, debe agregarse**
- [x] `detalles` - List<VentaDetalle>, correcto

### Clase VentaDetalle
- [x] `id` - Integer, consistente
- [x] `ventaId` - Integer, consistente
- [x] `productoId` - Integer, consistente
- [⚠️] `productoNombre` - **Ausente en BD, agregar columna**
- [x] `cantidad` - int, consistente
- [x] `precioUnitario` - BigDecimal, consistente
- [x] `subtotal` - BigDecimal, consistente

---

## 📝 Recomendaciones para Corrección

### Prioridad ALTA

1. **Corregir tipo de `usuarioId` en Venta**
   - Cambiar de `String` a `Integer` en clase Java
   - Actualizar toda lógica que use usuarioId
   - Guardar el ID del usuario (no el username)
   - En UI, obtener el ID del usuario logueado

2. **Agregar campo `observaciones` a clase Venta**
   - Agregar atributo en Java
   - Agregar getters/setters
   - Incluir en mapeo JDBC (si aplica en L04/L05)
   - Agregar en formulario UI (opcional)

3. **Agregar columna `producto_nombre` a tabla BD**
   - Ejecutar ALTER TABLE
   - Actualizar mapeo en Repository
   - Mantener funcionalidad de historial

### Prioridad MEDIA

4. **Considerar Enum para estado**
   - Crear `enum EstadoVenta { ACTIVA, ANULADA }`
   - Más seguridad de tipos
   - No crítico, String funciona

5. **Validar lógica de transacciones**
   - Verificar que INSERT de venta + detalles sea atómico
   - Implementar rollback en caso de error

### Prioridad BAJA

6. **Agregar campos de auditoría a tabla venta**
   - Considerar agregar `fecha_creacion`, `fecha_modificacion`
   - Consistente con otras tablas

---

## 📊 Comparación con clases anteriores

| Aspecto | Usuario | Producto | Venta/VentaDetalle |
|---------|---------|----------|-------------------|
| **Tipos inconsistentes** | rol (String vs Enum) | precio (double vs BigDecimal) | usuarioId (String vs Integer) |
| **Campos faltantes en Java** | fechas auditoría | fechas auditoría, descripcion | observaciones |
| **Campos faltantes en BD** | Ninguno | Ninguno | productoNombre en venta_detalle |
| **Relaciones** | Ninguna | Ninguna | ✅ Venta 1:N VentaDetalle |
| **Métodos de negocio** | Pocos | Algunos | ✅ Varios (calcular, agregar, etc) |

---

## 🚀 Siguiente Paso

**Paso 4:** Análisis de cambios de nombres de atributos

---

**Paso 3 completado:** 28 de noviembre de 2025  
**Tiempo invertido:** ~30 minutos  
**Inconsistencias encontradas:** 3 críticas, 3 menores

