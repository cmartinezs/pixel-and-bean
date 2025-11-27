# 🔧 Clase 5 – CRUD Completo + Operaciones Avanzadas

**Duración:** 2.5 horas pedagógicas (100 minutos)  
**Requisitos previos:** Clase 4 completada (conexión JDBC funcional)  
**Objetivo:** Implementar operaciones completas de Usuarios, Productos y Ventas con validaciones, seguridad y control de permisos.

---

## 📋 Resumen de la Clase

En esta clase completaremos la funcionalidad principal del sistema, implementando todas las operaciones CRUD necesarias para gestionar usuarios, productos y ventas. Nos enfocaremos en:

- **CRUD completo** de Usuarios y Productos
- **Validaciones** en la capa de servicio (defensa en profundidad)
- **Seguridad básica** con hash de contraseñas
- **Control de permisos** por roles
- **Módulo de Ventas** (versión básica)
- **Transacciones JDBC** para operaciones críticas

Esta es una de las clases más intensas del curso, donde todo lo aprendido anteriormente se pone en práctica.

---

## 🎯 Objetivos de Aprendizaje

Al finalizar esta clase, serás capaz de:

✅ Implementar operaciones CRUD completas con JDBC  
✅ Validar datos en múltiples capas (UI + Service)  
✅ Aplicar hash de contraseñas para seguridad básica  
✅ Controlar acceso según roles de usuario  
✅ Manejar transacciones JDBC manualmente  
✅ Registrar ventas con múltiples detalles  
✅ Refrescar vistas después de operaciones  
✅ Mostrar mensajes de error/éxito de forma amigable  

---

## 📚 Estructura de la Clase

La clase está dividida en 3 partes:

### **Parte 1: CRUD de Usuarios (30 minutos)**
[📄 01-usuarios-crud.md](01-usuarios-crud.md)
- Formulario de creación/edición
- Validaciones de usuario único
- Hash de contraseñas con SHA-256
- Activar/desactivar usuarios
- Control de acceso (solo ADMIN)

### **Parte 2: CRUD de Productos (30 minutos)**
[📄 02-productos-crud.md](02-productos-crud.md)
- Formulario de productos completo
- Validaciones de negocio
- Búsqueda y filtrado
- Activar/desactivar productos
- Restricciones según rol

### **Parte 3: Módulo de Ventas Básico (40 minutos)**
[📄 03-ventas-modulo.md](03-ventas-modulo.md)
- Registro de ventas con detalles
- Transacciones JDBC (venta + detalles)
- Listado de ventas del día
- Cálculo de totales
- Validación de productos activos

---

## ⏱️ Distribución del Tiempo

| Actividad                   | Tiempo       | Tipo     |
|-----------------------------|--------------|----------|
| **Introducción y revisión** | 5 min        | Teoría   |
| **Parte 1: CRUD Usuarios**  | 30 min       | Práctica |
| **Parte 2: CRUD Productos** | 30 min       | Práctica |
| **Break**                   | 5 min        | Descanso |
| **Parte 3: Módulo Ventas**  | 40 min       | Práctica |
| **Pruebas y validación**    | 10 min       | Testing  |
| **Cierre y tarea**          | 5 min        | Teoría   |
| **Total**                   | **~100 min** | -        |

---

## 🧱 Componentes a Implementar

### Capa de Servicio
- `UsuarioService` - Lógica de negocio de usuarios
- `ProductoService` - Lógica de negocio de productos
- `VentaService` - Lógica de negocio de ventas

### Capa de Repositorio
- `UsuarioRepositoryImpl` - CRUD completo
- `ProductoRepositoryImpl` - CRUD completo
- `VentaRepositoryImpl` - Operaciones con transacciones

### Capa de GUI
- `UsuarioDialog` - Formulario de usuario
- `ProductoDialog` - Formulario de producto
- `VentaPanel` - Panel de registro de ventas

### Utilidades
- `PasswordHasher` - Hash de contraseñas
- `ValidationUtils` - Validaciones comunes

---

## 🎓 Conceptos Clave

### 1. **Defensa en Profundidad**
Las validaciones deben hacerse en múltiples capas:
```
UI (campos requeridos) → Service (reglas de negocio) → Repository (constraints BD)
```

### 2. **Hash de Contraseñas**
Nunca almacenar contraseñas en texto plano:
```java
String hashedPassword = PasswordHasher.hashPassword(plainPassword);
```

### 3. **Transacciones JDBC**
Para operaciones que afectan múltiples tablas:
```java
conn.setAutoCommit(false);
try {
    // múltiples operaciones
    conn.commit();
} catch (SQLException e) {
    conn.rollback();
}
```

### 4. **Control de Permisos**
Validar roles antes de operaciones críticas:
```java
if (!currentUser.getRol().equals(Rol.ADMIN)) {
    throw new SecurityException("Acceso denegado");
}
```

---

## 📦 Entregables de la Clase

Al finalizar esta clase tendrás:

1. ✅ **CRUD de Usuarios** funcionando (solo ADMIN)
2. ✅ **CRUD de Productos** funcionando
3. ✅ **Módulo de Ventas** básico operativo
4. ✅ **Contraseñas hasheadas** en la base de datos
5. ✅ **Validaciones** en todas las capas
6. ✅ **Control de permisos** implementado
7. ✅ **Transacciones** para ventas

---

## 🔗 Navegación

- ⬅️ [Volver al índice principal](../../../README.md)
- ⬅️ [Clase 4 - Conexión JDBC](../04-database-jdbc/00-intro.md)
- ➡️ [Parte 1: CRUD de Usuarios](01-usuarios-crud.md)
- ➡️ [Clase 6 - Empaquetado y Cierre](../06-packaging/00-intro.md) *(próximamente)*

---

## 📝 Notas Importantes

### ⚠️ Sobre el Alcance
Esta clase tiene mucho contenido. Si el tiempo no alcanza:
- **Prioridad 1:** CRUD de Usuarios y Productos (obligatorio)
- **Prioridad 2:** Ventas básicas (1 producto por venta)
- **Prioridad 3:** Ventas con múltiples productos (trabajo autónomo)

### 💡 Consejos
1. Reutiliza código entre CRUD similares
2. Crea métodos auxiliares en `ValidationUtils`
3. Usa try-with-resources para manejar conexiones
4. Prueba cada funcionalidad antes de continuar
5. Commitea frecuentemente en Git

### 🎯 Trabajo Autónomo Sugerido
- Implementar anulación de ventas
- Agregar filtros avanzados en productos
- Mejorar la búsqueda incremental
- Implementar carrito de compras completo

---

> 💪 **"Esta clase es el corazón del sistema. Tómate tu tiempo y haz las cosas bien."**

**Creado:** 27 de noviembre de 2025  
**Autor:** Carlos Martínez

