# ☕🎮 Proyecto: Pixel & Bean – Sistema de Gestión para un Café-Arcade

**Asignatura:** Programación Orientada a Objetos  
**Profesor:** Carlos Martínez  
**Lenguaje:** Java 17 + Swing  
**Base de Datos:** MySQL (XAMPP)  
**Duración:** 6 clases (15 horas pedagógicas = 600 minutos = 10 horas reales)  
**Modalidad:** Desarrollo guiado paso a paso (de GUI simple a arquitectura MVC con BD)

> ⏱️ **Nota sobre horas pedagógicas:** Cada hora pedagógica = 40 minutos. El proyecto completo son 6 clases de 2.5 hrs pedagógicas cada una.

---

## 🎯 Contexto del Proyecto

El emprendimiento local **Pixel & Bean** acaba de abrir sus puertas. Es un **Café-Arcade retro**, donde los clientes pueden:
- Disfrutar de **café de especialidad** y **snacks**
- Arrendar **cabinas arcade por tiempo** (15/30/60 minutos)
- Participar en **torneos semanales**
- Asistir a **"noches retro"** mensuales con premios

El equipo necesita una **aplicación de escritorio offline** que permita gestionar las operaciones diarias desde la caja del local.  
Tu misión será desarrollar esta aplicación paso a paso en **Java Swing**, evolucionando desde una interfaz básica hasta una arquitectura **MVC con inyección de dependencias (IoC "manual")** y conexión a **MySQL mediante JDBC**.

---

## 🧭 Objetivo General

Construir una aplicación **usable, modular y mantenible**, que permita:
1. Autenticar usuarios con roles (`ADMIN`, `OPERADOR`).
2. Centralizar las operaciones desde una **ventana maestra** con menú.
3. Administrar **usuarios, productos y ventas**.
4. Generar **reportes básicos** de ventas y productos más vendidos.
5. Conectarse a una **base de datos MySQL** mediante **JDBC**.

> **📌 Nota Importante sobre Alcance:**
> Este proyecto está diseñado para completarse en **6 clases de 2.5 horas pedagógicas cada una** (15 hrs pedagógicas = **600 minutos = 10 horas reales**). El alcance se divide en:
> - **Core (obligatorio en clases):** Login, CRUD de Usuarios y Productos, Ventas básicas, Reporte de ventas del día
> - **Trabajo autónomo (recomendado):** Ventas complejas (múltiples productos), anular ventas, Top productos
> - **Opcional avanzado (para mejorar nota):** Export CSV, hash de contraseñas, filtros avanzados
> 
> Consulta la sección [🎮 Flujo Principal de Uso](#-flujo-principal-de-uso-escenario-demostración) para ver qué demostrar según lo que implementes.

---

## 🧱 Alcance Funcional (Mínimo Obligatorio)

### 1️⃣ Autenticación y Roles
- **Login** contra base de datos con `usuario` y `password`
- **Hash de contraseñas** (recomendado como mejora opcional)
- **Roles definidos:**
  - **ADMIN:** Acceso total (Usuarios, Productos, Ventas, Reportes, Configuración)
  - **OPERADOR:** Acceso limitado (Ventas, Reportes básicos, lectura de Productos)
- **Barra de estado:** Mostrar usuario activo, rol y hora en tiempo real

---

### 2️⃣ Ventana Maestra (UI)
- `JFrame` principal con:
  - **JMenuBar:** Menú superior con opciones jerárquicas
  - **Área central:** CardLayout o JDesktopPane para cambiar entre vistas
  - **Barra de estado inferior:** Mensajes del sistema, usuario, reloj
- **Estructura de Menús:**
  ```
  Archivo
    ├── Cerrar sesión
    └── Salir
  Gestión
    ├── Usuarios* (solo ADMIN)
    └── Productos
  Operación
    └── Ventas
  Reportes
    ├── Ventas del día
    └── Top productos
  Eventos
    └── Torneos (placeholder)
  Ayuda
    └── Acerca de...
  ```
- **Atajos de teclado:** Alt+A (Archivo), Alt+G (Gestión), etc.
- **"Acerca de...":** Nombre del equipo, versión, fecha

---

### 3️⃣ Módulo de Productos
- **Listado:** JTable con datos desde BD
- **Búsqueda:** Por nombre o categoría (filtro en tiempo real)
- **CRUD completo:**
  - ✅ Crear producto
  - ✅ Editar producto
  - ✅ Eliminar producto (confirmación)
  - ✅ Desactivar/Activar producto
- **Campos:**
  - `nombre` (obligatorio, único)
  - `categoría` (bebida, snack, tiempo-arcade)
  - `tipo` (específico de cada categoría)
  - `precio` (obligatorio, > 0)
  - `activo` (sí/no)
- **Validaciones:**
  - Campos obligatorios no vacíos
  - Precio mayor a 0
  - Categoría válida
- **Restricción:** Solo ADMIN puede crear/editar/eliminar

---

### 4️⃣ Módulo de Usuarios *(solo ADMIN)*
- **Listado:** JTable con todos los usuarios
- **CRUD completo:**
  - ✅ Crear usuario
  - ✅ Editar usuario
  - ✅ Eliminar usuario (confirmación)
  - ✅ Desactivar/Activar usuario
- **Campos:**
  - `username` (obligatorio, único)
  - `password` (obligatorio, hash recomendado)
  - `nombre completo`
  - `rol` (ADMIN, OPERADOR)
  - `estado` (activo/inactivo)
- **Validaciones:**
  - Username único
  - Rol válido
  - Password con mínimo de caracteres (opcional)
- **Restricción:** Solo visible para ADMIN

---

### 5️⃣ Módulo de Ventas (Caja) - Versión Simplificada
- **Listado de ventas:**
  - Mostrar todas las ventas en JTable (fecha, usuario, total, estado)
  - Filtro por fecha (día actual por defecto)
  - Total acumulado del día
- **Registro básico de venta:**
  1. Seleccionar 1-2 productos desde combo o lista
  2. Indicar cantidad
  3. Calcular total automáticamente
  4. Confirmar y guardar
- **Persistencia:** 
  - Tabla `Venta` (cabecera con total)
  - Tabla `VentaDetalle` (líneas de productos)
- **Validaciones:**
  - Al menos un producto en la venta
  - Productos activos solamente
  - Total = Σ(cantidad × precio)
- **Acceso:** ADMIN y OPERADOR

> **📚 Trabajo Autónomo Sugerido:**
> - Carrito de compras con múltiples productos
> - Agregar/quitar productos dinámicamente
> - Notas u observaciones en venta
> - Anular venta (cambiar estado)
> 
> **🌟 Opcional Avanzado:**
> - Descuentos y promociones
> - Impresión de ticket
> - Búsqueda avanzada de productos

---

### 6️⃣ Reportes - Versión Básica
- **Ventas del día:**
  - Query simple: `SELECT * FROM venta WHERE DATE(fechaHora) = CURDATE()`
  - Mostrar en JTable con columnas: ID, Fecha/Hora, Usuario, Total, Estado
  - Total general del día (excluir anuladas si implementaste esa funcionalidad)
  - Filtro por fecha (combo: Hoy, Ayer, Última semana)
- **Acceso:** ADMIN y OPERADOR (lectura)

> **📚 Trabajo Autónomo Sugerido:**
> - **Top 5 productos más vendidos:**
>   - Query con GROUP BY y ORDER BY
>   - Rango de fechas configurable
>   - Mostrar cantidad vendida y total generado
> - **Reporte de productos sin movimiento**
> - **Historial de un cliente específico**
> 
> **🌟 Opcional Avanzado:**
> - Export a CSV con Apache Commons CSV
> - Export a PDF con iText o JasperReports
> - Gráficos con JFreeChart
> - Dashboard con totales del mes

---

### 7️⃣ Eventos y Torneos *(Placeholder)*
- Pantalla informativa con diseño atractivo
- Texto estático: "Módulo en desarrollo - Próximamente"
- No requiere implementación funcional, solo navegación y diseño de la vista

---

## 🗃️ Entidades Base (Mínimo)

| Entidad          | Campos principales                                          |
|------------------|-------------------------------------------------------------|
| **Usuario**      | id, username, password, rol, activo                         |
| **Producto**     | id, nombre, categoría, tipo, precio, activo                 |
| **Venta**        | id, fechaHora, usuarioId, total, estado                     |
| **VentaDetalle** | id, ventaId, productoId, cantidad, precioUnitario, subtotal |

> ⚙️ Puedes extender con nuevas tablas (por ejemplo, `Cliente` o `Categoria` como tablas separadas).

---

## ⚖️ Reglas de Negocio Clave

1. Solo `ADMIN` puede crear, editar o eliminar usuarios y productos.  
2. Una venta debe tener **al menos un detalle**; total = Σ(subtotales).  
3. **Anular una venta** cambia su estado y excluye del total diario (no se elimina físicamente).  
4. Los **productos inactivos** no pueden venderse (no deben aparecer en búsqueda de caja).  
5. Todas las validaciones deben avisar claramente mediante **diálogos** y **mensajes en barra de estado**.

---

## ⚙️ Requisitos Técnicos

### Software Requerido
- **Java:** JDK 17 o superior
- **IDE:** NetBeans 26 (para diseño GUI visual) o IntelliJ IDEA Community Edition (para lógica)
- **Base de Datos:** MySQL 8.0+ (mediante XAMPP)
- **XAMPP:** Versión 8.0+ (incluye MySQL y phpMyAdmin)
- **Conexión BD:** JDBC (MySQL Connector/J 8.0+)
- **Build Tool:** Apache Ant (NetBeans) o Maven/Gradle
- **Control de versiones:** Git/GitHub

### Configuración Inicial

#### 1. Instalación de XAMPP
1. Descargar XAMPP desde [apachefriends.org](https://www.apachefriends.org)
2. Instalar en:
   - **Windows:** `C:\xampp`
   - **Linux:** `/opt/lampp`
   - **macOS:** `/Applications/XAMPP`
3. Iniciar los servicios **Apache** y **MySQL** desde el panel de control de XAMPP
4. Verificar acceso a phpMyAdmin en `http://localhost/phpmyadmin`

#### 2. Creación de la Base de Datos
**Opción 1: Desde phpMyAdmin (recomendado para principiantes)**
```
1. Abrir http://localhost/phpmyadmin
2. Crear nueva base de datos: "pixelandbean"
3. Seleccionar cotejamiento: utf8mb4_unicode_ci
4. Importar archivo: /docs/sql/01_schema.sql
5. Importar archivo: /docs/sql/02_seed.sql
```

**Opción 2: Desde línea de comandos**
```bash
# Acceder a MySQL
mysql -u root -p

# Crear base de datos
CREATE DATABASE pixelandbean CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE pixelandbean;

# Importar scripts
SOURCE C:/Users/TuUsuario/Documents/ProyectosPOO/PixelAndBean/docs/sql/01_schema.sql;
SOURCE C:/Users/TuUsuario/Documents/ProyectosPOO/PixelAndBean/docs/sql/02_seed.sql;
```

#### 3. Configuración de Conexión
Crear archivo `application.properties` en la raíz del proyecto:
```properties
# Configuración de Base de Datos
db.url=jdbc:mysql://localhost:3306/pixelandbean?useSSL=false&serverTimezone=UTC
db.username=root
db.password=
db.driver=com.mysql.cj.jdbc.Driver

# Configuración de Aplicación
app.name=Pixel & Bean
app.version=1.0.0
app.author=Tu Nombre o Equipo
```

#### 4. Agregar MySQL Connector/J al proyecto
**NetBeans:**
1. Clic derecho en **Libraries** → **Add JAR/Folder**
2. Seleccionar `mysql-connector-j-8.x.x.jar`

**IntelliJ IDEA:**
1. File → Project Structure → Libraries
2. Add → Java → Seleccionar el JAR de MySQL Connector

**Maven (alternativa):**
```xml
<dependency>
    <groupId>com.mysql</groupId>
    <artifactId>mysql-connector-j</artifactId>
    <version>8.2.0</version>
</dependency>
```

---

## 🧩 Arquitectura del Proyecto

El proyecto evolucionará progresivamente a través de 6 clases:

| Clase | Contenido                                    | Resultado                             |
|-------|----------------------------------------------|---------------------------------------|
| 1     | Introducción a GUI y componentes Swing       | Login mock y ventana principal        |
| 2     | Manejo de eventos y navegación (Pre-MVC)     | Menú funcional con vistas básicas     |
| 3     | Patrones y MVC con inyección de dependencias | Separación de capas (GUI/Controller)  |
| 4     | Conexión a base de datos (JDBC + XAMPP)      | Login real y lectura de datos         |
| 5     | CRUD completo + seguridad básica             | Operaciones reales sobre BD           |
| 6     | Empaquetado y despliegue final               | `.jar` ejecutable y presentación      |

### Estructura de Paquetes (Objetivo Final)
```
cl.tuusuario.pnb/
├── app/              # Inicio y contexto de aplicación
├── gui/              # Vistas Swing (JFrame, JDialog, JPanel)
├── controller/       # Controladores (lógica de eventos)
├── model/            # Entidades de dominio (POJOs)
├── service/          # Lógica de negocio
├── repository/       # Acceso a datos (DAO con JDBC)
├── util/             # Utilidades (validaciones, formateo, etc.)
└── exception/        # Excepciones personalizadas
```

---

## 🧠 Requisitos No Funcionales

### Usabilidad
- Formularios claros con labels descriptivos
- Mensajes comprensibles (sin trazas técnicas al usuario)
- Foco inicial en el primer campo editable
- Botones con texto y mnemonics (Alt+letra)
- Shortcuts: Enter para aceptar, Escape para cancelar

### Arquitectura Evolutiva
- Partir simple (Clase 1-2: GUI directa)
- Refactorizar a MVC + DI manual (Clase 3-4)
- Mantener separación de responsabilidades

### Configuración Externa
- Archivo `application.properties` con credenciales y URL de BD
- No hardcodear conexiones en el código

### Manejo de Errores
- No lanzar trazas crudas al usuario
- Registrar errores en consola o log
- Mostrar mensajes amigables en JOptionPane o barra de estado

### Despliegue
- Generar archivo `.jar` ejecutable
- Incluir scripts SQL y README
- Instrucciones claras de instalación

### Rendimiento
- Abrir listados en **< 1 segundo** con 500 filas locales
- Uso de `PreparedStatement` para consultas eficientes

---

## 🎨 UX Mínima Exigida

- ✅ **Consistencia visual:** mismos iconos, márgenes y tamaños en toda la aplicación
- ✅ **Estado en barra inferior:** mostrar éxitos y errores temporalmente
- ✅ **Confirmaciones:** al eliminar o anular (JOptionPane.showConfirmDialog)
- ✅ **Shortcuts:** en menús y botones (Enter/Escape cuando corresponda)
- ✅ **Feedback inmediato:** loading, cambio de cursor, mensajes de progreso

---

## 🔒 Seguridad Básica (Mínimo)

1. **Password no en texto plano en BD** (hash recomendado como mejora de la Clase 5)
   - Usar `MessageDigest` con SHA-256 o BCrypt
2. **Validación de inputs** en UI y capa de servicio (defensa en profundidad)
3. **Evitar SQL injection** usando `PreparedStatement` exclusivamente
4. **Roles y permisos:** validar rol antes de permitir operaciones críticas

---

## 🌱 Datos de Arranque (Seed)

El archivo `02_seed.sql` debe incluir:

### Usuarios
```sql
-- Password en texto plano para desarrollo (en producción usar hash)
INSERT INTO usuario (username, password, rol, activo) VALUES
('admin', 'admin123', 'ADMIN', 1),
('operador', 'op123', 'OPERADOR', 1);
```

### Productos (8-10 variados)
```sql
-- 3 bebidas
Espresso, Café con Leche, Cappuccino
-- 3 snacks
Brownie, Galletas, Sandwich
-- 2-4 tiempo-arcade
15 minutos, 30 minutos, 60 minutos, Pase Diario
```

### Ventas de Ejemplo (3-5)
- Para pruebas de reportes
- Con diferentes productos y cantidades
- Algunas anuladas, otras activas

---

## 🧮 Criterios de Evaluación (Resumen)

| Criterio                                        | Ponderación | Detalle |
|-------------------------------------------------|-------------|---------|
| **Funcional:** Login/roles, Productos, Usuarios*, Ventas básicas, Reportes básicos | **40%** | CRUD completo de Usuarios y Productos. Ventas y Reportes en versión simplificada |
| **Calidad de UI/UX:** Consistencia, validaciones, estados y accesos rápidos | **20%** | Interfaz coherente, mensajes claros, validaciones en UI |
| **Arquitectura:** Separación por capas, MVC + DI, repositorios JDBC | **25%** | Código organizado, patrones aplicados correctamente |
| **Despliegue y docs:** .jar, scripts SQL, README claro | **15%** | Empaquetado funcional, documentación completa |

> **Notas:**
> - *Usuarios es exclusivo de ADMIN
> - **Ventas básicas:** Registro simple (1-2 productos), listado y total del día
> - **Reportes básicos:** Solo "Ventas del día" con filtro de fecha
> - **Funcionalidades opcionales** (anular ventas, top productos, CSV) pueden sumar **puntos adicionales** o servir como trabajo autónomo

---

## 🚀 Entregables y Evidencia

### Código y Scripts
- `/docs/sql/01_schema.sql` - Estructura de tablas
- `/docs/sql/02_seed.sql` - Datos iniciales
- `application.properties` - Configuración
- `PixelAndBean.jar` - Aplicación ejecutable

### Documentación
- `README.md` - Requisitos, instalación, ejecución
- Capturas de pantalla:
  - Login
  - Ventana Maestra
  - Módulo Productos
  - Módulo Usuarios
  - Módulo Ventas
  - Reportes
- Video breve (≤3 min) del flujo principal *(opcional recomendado)*

---

## 🎮 Flujo Principal de Uso (Escenario Demostración)

### ✅ Demostración Mínima Viable (Core - Alcanzable en 6 clases)

1. **Login como operador**
   - Usuario: `operador` / Contraseña: `op123`
   - Verificar que rol y usuario aparecen en barra de estado

2. **Ver listado de productos**
   - Navegar a Gestión → Productos
   - Buscar un producto por nombre

3. **Registrar una venta simple** *(si implementaste el módulo básico)*
   - Navegar a Operación → Ventas
   - Seleccionar 1-2 productos
   - Indicar cantidad
   - Confirmar venta
   - Verificar que aparece en el listado del día

4. **Ver reporte de ventas del día**
   - Navegar a Reportes → Ventas del día
   - Verificar que la venta registrada aparece
   - Ver total acumulado

5. **Cerrar sesión**
   - Archivo → Cerrar sesión

6. **Ingresar como admin**
   - Usuario: `admin` / Contraseña: `admin123`

7. **Crear un usuario nuevo**
   - Navegar a Gestión → Usuarios
   - Crear usuario: `cajero` / rol: OPERADOR

8. **Editar un precio de producto**
   - Navegar a Gestión → Productos
   - Seleccionar un producto
   - Cambiar su precio
   - Guardar cambios

9. **Desactivar un producto**
   - Seleccionar un producto
   - Marcarlo como inactivo
   - Guardar

10. **Verificar restricciones y permisos**
    - Cerrar sesión e ingresar como `operador`
    - Verificar que menú Usuarios está deshabilitado
    - *(Opcional)* Verificar que producto inactivo no aparece al registrar ventas

---

### 🌟 Demostración Extendida (Con trabajo autónomo)

Si implementaste las funcionalidades opcionales, también puedes demostrar:

11. **Agregar múltiples productos a una venta**
    - Usar carrito de compras dinámico
    - Agregar/quitar productos
    - Ver subtotales

12. **Anular una venta**
    - Seleccionar una venta del listado
    - Cambiar su estado a "Anulada"
    - Verificar que se excluye del total del día

13. **Top 5 productos más vendidos**
    - Navegar a Reportes → Top Productos
    - Seleccionar rango de fechas
    - Ver ranking ordenado

14. **Export a CSV**
    - Desde cualquier reporte
    - Guardar archivo
    - Abrir en Excel/Calc

---

## 🎁 Restricciones y Libertades

### Obligatorio
- ✅ Swing puro (no JavaFX ni web)
- ✅ JDBC directo (no JPA/Hibernate en esta etapa)
- ✅ MySQL en XAMPP

### Permitido
- ✅ `AbstractTableModel` personalizado
- ✅ Íconos y recursos visuales
- ✅ Renderers y editores personalizados para JTable
- ✅ Diálogos modales (JDialog)
- ✅ CardLayout o JDesktopPane (a elección)

### Opcionales (para mejorar nota)

#### 🔵 Prioridad Alta (Trabajo Autónomo Recomendado)
Estas funcionalidades complementan el proyecto base y son alcanzables:
- 🔵 **Carrito de ventas con múltiples productos** (agregar/quitar dinámicamente)
- 🔵 **Anular venta** (cambiar estado, excluir de reportes)
- 🔵 **Top 5 productos más vendidos** (query con GROUP BY)
- 🔵 **Búsqueda incremental** en productos (filtro mientras escribe)

#### 🟢 Prioridad Media (Mejoras de calidad)
- 🟢 **Hash de contraseñas** (SHA-256 o BCrypt)
- 🟢 **Export a CSV** desde reportes
- 🟢 **Filtros por categoría** en productos
- 🟢 **Validación de roles en backend** (no solo UI)

#### 🟡 Prioridad Baja (Extras avanzados)
- 🟡 Preferencias de tema claro/oscuro
- 🟡 Gráficos con JFreeChart
- 🟡 Impresión de tickets
- 🟡 Dashboard con métricas

---

## 💡 Ideas de Mejora Adicionales

### Funcionales (Expandir el negocio)
- Control de stock de productos
- Categorías dinámicas desde BD
- Historial de cambios (auditoría)
- Descuentos y promociones
- Gestión de clientes frecuentes
- Reservas de cabinas arcade

### Técnicas (Profesionalizar el código)
- Logging con Log4j o SLF4J
- Connection pool (HikariCP)
- Migraciones con Flyway
- Tests unitarios con JUnit
- CI/CD con GitHub Actions
- Profiles de configuración (dev, prod)

### UX (Mejorar experiencia)
- Modo oscuro completo
- Temas personalizables
- Notificaciones tipo toast
- Drag & drop en tablas
- Auto-guardado de preferencias
- Atajos de teclado personalizables

---

## 📖 Recursos de Apoyo

### Documentación del Proyecto
- **[Guía Básica de Git](docs/01-extras/01-git-basico.md)** - Comandos esenciales de Git para el curso
- [Clase 1 - Introducción a GUI](docs/00-lessons/01-gui-components/00-intro.md)
- [Clase 2 - Componentes y Eventos](docs/00-lessons/02-components-events/00-intro.md)
- [Progreso del Proyecto](docs/PROGRESS.md)

### Documentación Oficial
- [Java SE 17 Documentation](https://docs.oracle.com/en/java/javase/17/)
- [Swing Tutorial](https://docs.oracle.com/javase/tutorial/uiswing/)
- [MySQL Documentation](https://dev.mysql.com/doc/)
- [JDBC Tutorial](https://docs.oracle.com/javase/tutorial/jdbc/)
- [Git Documentation](https://git-scm.com/doc)

### Tutoriales Recomendados
- NetBeans GUI Builder (Matisse)
- Patrón MVC en Java Swing
- JDBC Best Practices
- PreparedStatement vs Statement
- [Learn Git Branching](https://learngitbranching.js.org/) - Tutorial interactivo de Git

---

## 👨‍💻 Créditos y Autoría

Proyecto educativo desarrollado en el marco de la asignatura **Programación Orientada a Objetos**,  
por los estudiantes de **Duoc UC**, bajo la guía del profesor **Carlos Martínez**.

**Equipo de desarrollo:**
- [Nombre del estudiante 1]
- [Nombre del estudiante 2]
- [Nombre del estudiante 3]

**Versión:** 1.0.0  
**Fecha:** Noviembre 2025  
**Licencia:** Proyecto Educativo

---

> _"No solo escribas código: construye experiencias."_ ☕🎮
>
> _"Primero haz que funcione. Luego hazlo elegante."_

---

## 📞 Soporte y Consultas

Para dudas o consultas sobre el proyecto:
- **Profesor:** Carlos Martínez
- **Email:** c.martinez @ profesor.duoc.cl
- **Horario de consultas:** [definir horario]

---

**¡Manos a la obra! 🚀**

