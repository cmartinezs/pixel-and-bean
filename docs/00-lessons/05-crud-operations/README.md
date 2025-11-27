# 🔧 Clase 5 – CRUD Completo + Operaciones Avanzadas

Esta carpeta contiene toda la documentación para la **Clase 5** del proyecto Pixel & Bean, donde se implementan las operaciones CRUD completas para Usuarios, Productos y Ventas.

---

## 📚 Contenido

### Documentos principales:

1. **[00-intro.md](00-intro.md)** - Índice general de la clase
   - Objetivos de aprendizaje
   - Estructura de la clase (3 partes)
   - Duración: 2.5 horas pedagógicas (100 min)

2. **[01-usuarios-crud.md](01-usuarios-crud.md)** - CRUD de Usuarios (30 min)
   - Utilidad para hash de contraseñas (SHA-256)
   - Formulario de usuario (crear/editar)
   - Operaciones CRUD en repositorio
   - Validaciones en capa de servicio
   - Control de acceso (solo ADMIN)

3. **[02-productos-crud.md](02-productos-crud.md)** - CRUD de Productos (30 min)
   - Formulario de productos completo
   - Validaciones de negocio
   - Búsqueda incremental
   - Filtrado por categoría
   - Activar/desactivar productos

4. **[03-ventas-modulo.md](03-ventas-modulo.md)** - Módulo de Ventas Básico (40 min)
   - Modelos de dominio (Venta y VentaDetalle)
   - Transacciones JDBC
   - Registro de ventas con detalles
   - Listado de ventas del día
   - Cálculo de totales

---

## 🎯 Objetivos de Aprendizaje

Al completar esta clase, los estudiantes serán capaces de:

✅ Implementar operaciones CRUD completas con JDBC  
✅ Validar datos en múltiples capas (UI + Service)  
✅ Aplicar hash de contraseñas para seguridad básica  
✅ Controlar acceso según roles de usuario  
✅ Manejar transacciones JDBC manualmente  
✅ Registrar ventas con múltiples detalles  
✅ Refrescar vistas después de operaciones  
✅ Mostrar mensajes de error/éxito de forma amigable  

---

## 🧱 Componentes Implementados

### Utilidades
- `PasswordHasher` - Hash de contraseñas con SHA-256

### Capa de GUI
- `UsuarioDialog` - Formulario para crear/editar usuarios
- `ProductoDialog` - Formulario para crear/editar productos
- `VentaPanel` - Panel de registro y visualización de ventas

### Capa de Servicio
- `UsuarioServiceImpl` - Lógica de negocio de usuarios
- `ProductoServiceImpl` - Lógica de negocio de productos
- `VentaServiceImpl` - Lógica de negocio de ventas

### Capa de Repositorio
- `UsuarioRepositoryImpl` - CRUD completo de usuarios
- `ProductoRepositoryImpl` - CRUD completo de productos
- `VentaRepositoryImpl` - Operaciones con transacciones

### Modelos
- `Venta` - Cabecera de venta
- `VentaDetalle` - Línea de detalle de venta

---

## ⏱️ Distribución del Tiempo

| Actividad | Tiempo | Tipo |
|-----------|--------|------|
| **Introducción y revisión** | 5 min | Teoría |
| **Parte 1: CRUD Usuarios** | 30 min | Práctica |
| **Parte 2: CRUD Productos** | 30 min | Práctica |
| **Break** | 5 min | Descanso |
| **Parte 3: Módulo Ventas** | 40 min | Práctica |
| **Pruebas y validación** | 10 min | Testing |
| **Cierre y tarea** | 5 min | Teoría |
| **Total** | **~100 min** | - |

---

## 🔐 Características de Seguridad

### Hash de Contraseñas
- **Algoritmo:** SHA-256
- **Implementación:** Clase `PasswordHasher`
- **Uso:** Automático al crear/actualizar usuarios

### Control de Acceso
- **ADMIN:** Acceso completo a usuarios y productos
- **OPERADOR:** Acceso limitado (solo lectura de productos, registro de ventas)
- **Validación:** En UI y en capa de servicio

### Validaciones
- **UI:** Campos obligatorios, formatos, longitudes
- **Service:** Reglas de negocio, unicidad, consistencia
- **Repository:** Constraints de base de datos

---

## 🔄 Transacciones JDBC

### ¿Cuándo usar transacciones?

Las transacciones son esenciales cuando una operación afecta múltiples tablas:

```java
conn.setAutoCommit(false);
try {
    // 1. Insertar cabecera de venta
    // 2. Insertar detalles de venta
    conn.commit();
} catch (SQLException e) {
    conn.rollback();
    throw e;
}
```

### Ejemplo del Proyecto

**Registro de Venta:**
1. Insertar en tabla `venta` → obtener ID
2. Insertar múltiples filas en `venta_detalle` con ese ID
3. Si alguna falla → revertir todo (rollback)

---

## 📋 Requisitos Previos

Antes de esta clase, debes tener:

1. ✅ Clase 4 completada (conexión JDBC funcional)
2. ✅ Base de datos `pixelandbean` operativa
3. ✅ Login funcionando contra BD
4. ✅ Arquitectura MVC implementada
5. ✅ Interfaces de repositorio y servicio definidas

---

## 🎓 Entregables

Al finalizar esta clase tendrás:

1. ✅ **CRUD de Usuarios** funcionando (solo ADMIN)
2. ✅ **CRUD de Productos** funcionando
3. ✅ **Módulo de Ventas** básico operativo
4. ✅ **Contraseñas hasheadas** en la base de datos
5. ✅ **Validaciones** en todas las capas
6. ✅ **Control de permisos** implementado
7. ✅ **Transacciones** para ventas

---

## 💡 Próxima Clase

**Clase 6 – Empaquetado y Cierre**

En la siguiente clase:
- Puliremos la interfaz de usuario
- Implementaremos reportes avanzados
- Empaquetar la aplicación como `.jar` ejecutable
- Preparar documentación final
- Presentación del proyecto

---

## 📖 Recursos Adicionales

### Documentación oficial:
- [Java Security - MessageDigest](https://docs.oracle.com/javase/8/docs/api/java/security/MessageDigest.html)
- [JDBC Transactions](https://docs.oracle.com/javase/tutorial/jdbc/basics/transactions.html)
- [PreparedStatement Best Practices](https://docs.oracle.com/javase/tutorial/jdbc/basics/prepared.html)

### Patrones aplicados:
- **DAO (Data Access Object):** Capa de repositorio
- **Service Layer:** Lógica de negocio centralizada
- **DTO (Data Transfer Object):** Modelos de dominio
- **Factory:** Para creación de conexiones

### Enlaces internos:
- [README principal](../../../README.md)
- [Clase 4 - Conexión JDBC](../04-database-jdbc/00-intro.md)
- [Recursos extras](../../01-extras/00-index.md)

---

## 🚧 Trabajo Autónomo Sugerido

### Prioridad Alta (Recomendado)
- [ ] Implementar carrito de compras completo
- [ ] Agregar funcionalidad de anular ventas
- [ ] Mejorar búsqueda de productos (más filtros)
- [ ] Validar que no se eliminen productos con ventas

### Prioridad Media (Mejoras)
- [ ] Cambiar a BCrypt para hash de contraseñas
- [ ] Agregar campo de descripción en productos
- [ ] Implementar historial de cambios (auditoría)
- [ ] Export de reportes a CSV

### Prioridad Baja (Extras)
- [ ] Control de stock de productos
- [ ] Descuentos y promociones
- [ ] Impresión de tickets
- [ ] Dashboard con métricas

---

## 📊 Estadísticas

- **Clases completadas:** 5 de 6 (83%)
- **Archivos creados:** ~10 nuevos archivos
- **Líneas de código:** ~2000 líneas (aprox.)
- **Operaciones CRUD:** 3 módulos completos

---

## ⚠️ Notas Importantes

### Sobre Hash de Contraseñas
El uso de SHA-256 sin "sal" (salt) es suficiente para fines educativos, pero **NO es recomendado para producción**. En aplicaciones reales, usar:
- **BCrypt** (recomendado)
- **Argon2** (más moderno)
- **PBKDF2** (estándar NIST)

### Sobre Transacciones
- Siempre usar transacciones para operaciones multi-tabla
- No olvidar restaurar `autoCommit(true)` en el `finally`
- Capturar y manejar errores de rollback

### Sobre Validaciones
- **Nunca confiar solo en validaciones de UI**
- Siempre validar en capa de servicio
- La base de datos es la última línea de defensa

---

> 💪 **"Esta es la clase más importante del curso. Si dominas esto, dominas CRUD en Java."**

**Creado:** 27 de noviembre de 2025  
**Autor:** Carlos Martínez

