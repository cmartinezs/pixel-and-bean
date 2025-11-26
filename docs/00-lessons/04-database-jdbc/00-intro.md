# 🗄️ Clase 4 – Conexión a Base de Datos (JDBC + MySQL)

> ⚠️ **NOTA:** Este archivo ha sido dividido en tres partes para una mejor organización:
>
> 1. **[01-technical-jdbc.md](01-technical-jdbc.md)** – Fundamentos de JDBC, SQL y conexión a MySQL (30 min)
> 2. **[02-database-setup.md](02-database-setup.md)** – Instalación XAMPP, creación BD y primeros repositorios (40 min)
> 3. **[03-repository-implementation.md](03-repository-implementation.md)** – Implementación completa de repositorios y migración de datos mock (30 min)
>
> Se recomienda seguir el orden indicado para un mejor aprovechamiento de la clase.

---

## 📚 Contenido de la Clase 4

### Parte 1: Fundamentos de JDBC (30 min)
➡️ **[01-technical-jdbc.md](01-technical-jdbc.md)**

**Temas cubiertos:**
- 🎯 Objetivo de la clase y entregables
- 🗺️ Visión general: de datos mock a base de datos real
- 📚 Apartado técnico:
  - JDBC (Java Database Connectivity)
  - Driver JDBC de MySQL
  - Connection, Statement y PreparedStatement
  - ResultSet y navegación de datos
  - Transacciones en JDBC
  - Connection Pool (introducción)
  - SQL Injection y seguridad
  - Try-with-resources
  - Patrón Factory para conexiones
  - Manejo de excepciones SQLException

### Parte 2: Instalación y Configuración (40 min)
➡️ **[02-database-setup.md](02-database-setup.md)**

**Actividades prácticas:**
- 🔧 Instalar y configurar XAMPP
- 🗃️ Crear base de datos `pixelandbean`
- 📝 Crear esquema de tablas (usuarios, productos, ventas)
- 🌱 Insertar datos iniciales (seed)
- ⚙️ Configurar archivo `application.properties`
- 🔌 Agregar MySQL Connector/J al proyecto
- 🏭 Implementar clase `DatabaseConnectionFactory`
- ✅ Probar conexión desde Java

### Parte 3: Implementación de Repositorios (30 min)
➡️ **[03-repository-implementation.md](03-repository-implementation.md)**

**Actividades prácticas:**
- 🔄 Migrar `UsuarioRepositoryImpl` de mock a JDBC
- 🔄 Migrar `ProductoRepositoryImpl` de mock a JDBC
- 🔄 Implementar `VentaRepositoryImpl` con JDBC
- 🧪 Probar autenticación real desde BD
- 🧪 Probar listados de usuarios y productos
- 🔒 Implementar hash de contraseñas (opcional)
- 🧹 Eliminar código mock obsoleto
- ✅ Validar integración completa

---

## ⏱️ Duración Total

**2.5 horas pedagógicas (100 minutos)**

**Distribución del tiempo:**
- **Parte 1 - Teoría:** 30 minutos
  - Presentación de JDBC y arquitectura (8 min)
  - Connection, PreparedStatement y ResultSet (12 min)
  - Seguridad y buenas prácticas (10 min)

- **Parte 2 - Setup:** 40 minutos
  - Instalación XAMPP (5 min)
  - Creación de base de datos (10 min)
  - Scripts SQL de tablas y datos (10 min)
  - Configuración en Java (8 min)
  - Prueba de conexión (7 min)

- **Parte 3 - Repositorios:** 30 minutos
  - UsuarioRepositoryImpl (10 min)
  - ProductoRepositoryImpl (8 min)
  - VentaRepositoryImpl (7 min)
  - Pruebas y validación (5 min)

---

## ✅ Resultado de la Clase 4

Al finalizar esta sesión completa (las tres partes) tendrás:

### Conocimientos adquiridos:
- ✅ Comprensión profunda de JDBC y sus componentes
- ✅ Dominio de PreparedStatement y prevención de SQL Injection
- ✅ Manejo de transacciones en JDBC
- ✅ Gestión de conexiones con Factory Pattern
- ✅ Conocimiento de XAMPP y MySQL
- ✅ Diseño y creación de esquemas de base de datos
- ✅ Implementación de repositorios con persistencia real

### Entregables funcionales:
- ✅ XAMPP instalado y MySQL funcionando
- ✅ Base de datos `pixelandbean` creada con todas las tablas
- ✅ Datos iniciales cargados (usuarios, productos)
- ✅ MySQL Connector/J agregado al proyecto
- ✅ `DatabaseConnectionFactory` implementado
- ✅ `application.properties` configurado
- ✅ Repositorios migrando de mock a JDBC
- ✅ Login funcionando contra base de datos real
- ✅ Listados de usuarios y productos desde BD
- ✅ Aplicación completamente funcional con persistencia real

### Arquitectura actualizada:
```
┌──────────────┐
│  VIEW (GUI)  │  ← Sin cambios
└──────┬───────┘
       │
       ↓
┌──────────────┐
│ CONTROLLER   │  ← Sin cambios
└──────┬───────┘
       │
       ↓
┌──────────────┐
│  SERVICE     │  ← Sin cambios
└──────┬───────┘
       │
       ↓
┌──────────────┐
│ REPOSITORY   │  ← ✨ AHORA CON JDBC ✨
│  (+ JDBC)    │
└──────┬───────┘
       │
       ↓
┌──────────────┐
│   MySQL DB   │  ← ✨ NUEVO ✨
└──────────────┘
```

---

## 🎓 Ventajas de esta arquitectura

### ✅ Separación de capas mantenida
- Solo cambiamos la implementación de repositorios
- Las vistas, controladores y servicios no se tocan
- Esto demuestra el poder de la arquitectura en capas

### ✅ Datos persistentes
- Ya no se pierden al cerrar la aplicación
- Múltiples instancias pueden compartir datos
- Preparado para entorno multi-usuario

### ✅ Flexibilidad
- Fácil cambiar de MySQL a PostgreSQL u otra BD
- Solo modificamos `DatabaseConnectionFactory` y queries
- El resto de la aplicación no se entera

### ✅ Seguridad mejorada
- PreparedStatement previene SQL Injection
- Contraseñas hasheadas (si implementas la mejora)
- Conexiones manejadas de forma segura

---

## 💡 Próxima Clase

**Clase 5 – CRUD Completo + Seguridad**

➡️ Implementación de todas las operaciones CRUD (Crear, Leer, Actualizar, Eliminar) en Usuarios, Productos y Ventas. Hash de contraseñas y validaciones completas.

---

## 🔗 Enlaces Relacionados

### Documentación anterior:
- [Clase 1 - GUI y Componentes](../01-gui-components/00-intro.md)
- [Clase 2 - Componentes y Eventos](../02-components-events/00-intro.md)
- [Clase 3 - MVC y Arquitectura](../03-mvc-architecture/00-intro.md)

### Recursos externos:
- [JDBC Tutorial - Oracle](https://docs.oracle.com/javase/tutorial/jdbc/)
- [MySQL Documentation](https://dev.mysql.com/doc/)
- [XAMPP Download](https://www.apachefriends.org)
- [MySQL Connector/J](https://dev.mysql.com/downloads/connector/j/)

---

## ⚠️ Requisitos Previos

Antes de comenzar esta clase, asegúrate de:

1. ✅ Tener completadas las Clases 1, 2 y 3
2. ✅ Tener la arquitectura MVC implementada
3. ✅ Tener las interfaces de repositorios definidas
4. ✅ Contar con conexión a internet para descargar XAMPP y MySQL Connector
5. ✅ Tener permisos de administrador en tu computadora (para instalar XAMPP)

---

> 🧠 *"Los datos son el corazón de cualquier aplicación. JDBC es el puente entre tu código y ese corazón."*

