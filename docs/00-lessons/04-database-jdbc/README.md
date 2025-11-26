# 🗄️ Clase 4 – Conexión a Base de Datos (JDBC + MySQL)

Esta carpeta contiene toda la documentación para la **Clase 4** del proyecto Pixel & Bean, donde se implementa la conexión a base de datos MySQL usando JDBC.

---

## 📚 Contenido

### Documentos principales:

1. **[00-intro.md](00-intro.md)** - Índice general de la clase
   - Objetivos de aprendizaje
   - Estructura de la clase (3 partes)
   - Duración: 2.5 horas pedagógicas (100 min)

2. **[01-technical-jdbc.md](01-technical-jdbc.md)** - Fundamentos técnicos (30 min)
   - ¿Qué es JDBC?
   - Arquitectura JDBC
   - Driver MySQL Connector/J
   - Connection, PreparedStatement, ResultSet
   - SQL Injection y seguridad
   - Try-with-resources
   - Connection Pool
   - Patrón Factory para conexiones
   - Manejo de SQLException

3. **[02-database-setup.md](02-database-setup.md)** - Instalación y configuración (40 min)
   - Instalación de XAMPP
   - Creación de base de datos `pixelandbean`
   - Esquema de tablas (usuario, producto, venta, venta_detalle)
   - Datos iniciales (seed)
   - Configuración de `application.properties`
   - Agregando MySQL Connector/J al proyecto
   - Implementación de `DatabaseConnectionFactory`
   - Prueba de conexión

4. **[03-repository-implementation.md](03-repository-implementation.md)** - Implementación de repositorios (30 min)
   - Migración de `UsuarioRepositoryImpl` a JDBC
   - Migración de `ProductoRepositoryImpl` a JDBC
   - Implementación básica de `VentaRepositoryImpl`
   - Hash de contraseñas (opcional)
   - Pruebas integradas
   - Limpieza de código mock

---

## 🎯 Objetivos de Aprendizaje

Al completar esta clase, los estudiantes serán capaces de:

✅ Comprender los fundamentos de JDBC y su arquitectura  
✅ Instalar y configurar XAMPP con MySQL  
✅ Diseñar y crear esquemas de base de datos  
✅ Conectar aplicaciones Java con MySQL usando JDBC  
✅ Ejecutar consultas SQL de forma segura con PreparedStatement  
✅ Prevenir SQL Injection  
✅ Implementar el patrón Repository con persistencia real  
✅ Gestionar conexiones de base de datos eficientemente  
✅ Migrar de datos mock a base de datos real sin romper la arquitectura  

---

## 🗃️ Scripts SQL

Los scripts SQL necesarios están en `/docs/sql/`:

- **01_schema.sql** - Esquema completo de la base de datos
  - Tabla `usuario`
  - Tabla `producto`
  - Tabla `venta`
  - Tabla `venta_detalle`

- **02_seed.sql** - Datos iniciales para pruebas
  - 5 usuarios (admin, operadores)
  - 22 productos (bebidas, snacks, tiempo arcade)
  - 5 ventas de ejemplo

---

## 🏗️ Arquitectura

### Antes de esta clase:
```
Repository (Mock) → List<T> en memoria
```

### Después de esta clase:
```
Repository (JDBC) → MySQL Database
```

### Sin cambios:
- ✅ Interfaces de repositorio
- ✅ Capa de servicios
- ✅ Controladores
- ✅ Vistas

**Ventaja:** La arquitectura en capas permite cambiar completamente la persistencia sin tocar el resto de la aplicación.

---

## 📋 Requisitos Previos

Antes de esta clase, debes tener:

1. ✅ Clases 1, 2 y 3 completadas
2. ✅ Arquitectura MVC implementada
3. ✅ Interfaces de repositorio definidas
4. ✅ Conexión a internet (para descargar XAMPP y drivers)
5. ✅ Permisos de administrador (para instalar XAMPP)

---

## 🛠️ Software Necesario

- **XAMPP** 8.0+ (incluye MySQL)
- **MySQL Connector/J** 8.2.0+ (driver JDBC)
- **Java JDK** 17+
- **NetBeans** o **IntelliJ IDEA**

---

## 🎓 Entregables

Al finalizar esta clase tendrás:

1. ✅ XAMPP instalado y MySQL funcionando
2. ✅ Base de datos `pixelandbean` creada
3. ✅ Todas las tablas creadas y pobladas
4. ✅ `DatabaseConnectionFactory` implementado
5. ✅ Repositorios funcionando con JDBC
6. ✅ Login real contra base de datos
7. ✅ Aplicación 100% funcional con persistencia real

---

## 💡 Próxima Clase

**Clase 5 – CRUD Completo + Seguridad**

En la siguiente clase implementaremos:
- CRUD completo de Usuarios y Productos
- Registro de ventas con transacciones
- Validaciones de negocio
- Anular ventas
- Reportes avanzados
- Hash de contraseñas (si no lo hiciste en esta clase)

---

## 📖 Recursos Adicionales

### Documentación oficial:
- [JDBC Tutorial - Oracle](https://docs.oracle.com/javase/tutorial/jdbc/)
- [MySQL Documentation](https://dev.mysql.com/doc/)
- [XAMPP Documentation](https://www.apachefriends.org/docs/)

### Enlaces internos:
- [README principal](../../../README.md)
- [Clase 3 - MVC](../03-mvc-architecture/00-intro.md)
- [Recursos extras](../../01-extras/00-index.md)

---

> 🧠 *"Una base de datos bien diseñada es la columna vertebral de cualquier sistema empresarial."*

**Creado:** 25 de noviembre de 2025  
**Autor:** Carlos Martínez

