# 📖 Parte 3: Documentación y Presentación Final (30 minutos)

En esta última parte crearemos toda la documentación necesaria para la entrega y prepararemos la presentación del proyecto.

---

## 🎯 Objetivos

- Crear README de instalación
- Escribir manual de usuario
- Documentar configuración
- Tomar capturas de pantalla
- Preparar video demostración (opcional)
- Organizar presentación final

---

## 📄 Paso 1: README de Instalación (10 min)

### Crear README.md en el directorio de distribución

```markdown
# ☕🎮 Pixel & Bean - Sistema de Gestión

Sistema de gestión para café-arcade desarrollado en Java con Swing y MySQL.

---

## 📋 Requisitos del Sistema

### Software Necesario

- **Java:** JDK 17 o superior ([Descargar aquí](https://www.oracle.com/java/technologies/downloads/))
- **XAMPP:** Versión 8.0+ con MySQL ([Descargar aquí](https://www.apachefriends.org/))
- **Sistema Operativo:** Windows 10/11, Linux, o macOS

### Verificar Java

```bash
java -version
```

Debe mostrar versión 17 o superior.

---

## 🚀 Instalación Rápida

### Paso 1: Descargar el Proyecto

Descomprimir el archivo `PixelAndBean-v1.0.0.zip` en una ubicación de tu elección.

### Paso 2: Instalar y Configurar XAMPP

1. **Instalar XAMPP**
   - Ejecutar el instalador descargado
   - Seleccionar componentes: Apache y MySQL

2. **Iniciar Servicios**
   - Abrir XAMPP Control Panel
   - Iniciar Apache y MySQL

3. **Verificar phpMyAdmin**
   - Abrir navegador: `http://localhost/phpmyadmin`
   - Debe cargar la interfaz de phpMyAdmin

### Paso 3: Crear Base de Datos

**Opción A: Desde phpMyAdmin (Recomendado)**

1. Abrir `http://localhost/phpmyadmin`
2. Clic en "Nuevo" en el panel izquierdo
3. Nombre de la base de datos: `pixelandbean`
4. Cotejamiento: `utf8mb4_unicode_ci`
5. Clic en "Crear"
6. Seleccionar la base de datos creada
7. Ir a la pestaña "Importar"
8. Seleccionar archivo: `docs/sql/01_schema.sql`
9. Clic en "Continuar"
10. Repetir con: `docs/sql/02_seed.sql`

**Opción B: Desde línea de comandos**

```bash
# Acceder a MySQL
mysql -u root -p

# Crear base de datos
CREATE DATABASE pixelandbean CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE pixelandbean;

# Importar scripts
SOURCE /ruta/completa/docs/sql/01_schema.sql;
SOURCE /ruta/completa/docs/sql/02_seed.sql;

# Verificar
SHOW TABLES;
SELECT * FROM usuario;
```

### Paso 4: Configurar Conexión

Editar el archivo `application.properties`:

```properties
# Configuración de Base de Datos
db.url=jdbc:mysql://localhost:3306/pixelandbean?useSSL=false&serverTimezone=UTC
db.username=root
db.password=
db.driver=com.mysql.cj.jdbc.Driver
```

**Nota:** Si configuraste contraseña en MySQL, actualiza `db.password`.

### Paso 5: Ejecutar la Aplicación

**Windows:**
```bash
run.bat
```

**Linux/Mac:**
```bash
./run.sh
```

**Manual:**
```bash
java -jar PixelAndBean.jar
```

---

## 🔐 Credenciales por Defecto

### Administrador
- **Usuario:** `admin`
- **Contraseña:** `admin123`

### Operador
- **Usuario:** `operador`
- **Contraseña:** `op123`

---

## 📁 Estructura de Archivos

```
PixelAndBean/
├── PixelAndBean.jar              # Aplicación ejecutable
├── application.properties         # Configuración
├── run.bat                        # Script Windows
├── run.sh                         # Script Linux/Mac
├── lib/                           # Dependencias
│   └── mysql-connector-j-*.jar
├── docs/                          # Documentación
│   ├── sql/
│   │   ├── 01_schema.sql          # Estructura BD
│   │   └── 02_seed.sql            # Datos iniciales
│   └── MANUAL_USUARIO.md          # Manual de usuario
└── README.md                      # Este archivo
```

---

## ❗ Solución de Problemas

### Error: "No se encuentra la clase principal"

**Causa:** El archivo JAR está corrupto o mal generado.

**Solución:**
```bash
# Verificar contenido del JAR
jar tf PixelAndBean.jar | grep MANIFEST

# Debe existir META-INF/MANIFEST.MF
```

### Error: "ClassNotFoundException: com.mysql.cj.jdbc.Driver"

**Causa:** No se encuentra el driver de MySQL.

**Solución:**
- Verificar que existe `lib/mysql-connector-j-*.jar`
- Ejecutar desde el directorio que contiene `lib/`

### Error: "No se puede conectar a la base de datos"

**Causa:** XAMPP no está corriendo o configuración incorrecta.

**Solución:**
1. Verificar que MySQL esté iniciado en XAMPP
2. Verificar `application.properties`
3. Verificar que la BD `pixelandbean` exista
4. Probar conexión manual desde línea de comandos

### Error: "Communications link failure"

**Causa:** MySQL no está escuchando en el puerto 3306.

**Solución:**
```bash
# Verificar puerto de MySQL
netstat -an | grep 3306   # Linux/Mac
netstat -an | findstr 3306   # Windows

# Si no aparece, verificar configuración de XAMPP
```

---

## 🆘 Soporte

Si tienes problemas con la instalación:

1. Verificar que cumples todos los requisitos
2. Revisar la sección de solución de problemas
3. Consultar el manual de usuario: `docs/MANUAL_USUARIO.md`
4. Contactar al equipo de desarrollo

---

## 📝 Notas de Versión

### Versión 1.0.0 (Noviembre 2025)

**Características implementadas:**
- ✅ Login con autenticación y roles
- ✅ Gestión de usuarios (ADMIN)
- ✅ Gestión de productos
- ✅ Registro de ventas
- ✅ Reportes básicos
- ✅ Top 5 productos más vendidos
- ✅ Exportación a CSV
- ✅ Hash de contraseñas (SHA-256)

**Características futuras (próximas versiones):**
- Control de stock
- Gestión de clientes
- Descuentos y promociones
- Impresión de tickets
- Dashboard con gráficos

---

## 👥 Créditos

**Desarrollado por:**
- [Tu Nombre / Equipo]

**Asignatura:** Programación Orientada a Objetos  
**Institución:** Duoc UC  
**Fecha:** Noviembre 2025

---

## 📄 Licencia

Proyecto educativo desarrollado para la asignatura de POO.

---

> 💡 **¿Primera vez usando el sistema?** Consulta el [Manual de Usuario](docs/MANUAL_USUARIO.md)
```

---

## 📘 Paso 2: Manual de Usuario (10 min)

### Crear MANUAL_USUARIO.md

```markdown
# 📘 Manual de Usuario - Pixel & Bean

Guía completa para usar el sistema de gestión del café-arcade Pixel & Bean.

---

## 📑 Índice

1. [Inicio de Sesión](#inicio-de-sesión)
2. [Navegación Principal](#navegación-principal)
3. [Gestión de Usuarios](#gestión-de-usuarios)
4. [Gestión de Productos](#gestión-de-productos)
5. [Registro de Ventas](#registro-de-ventas)
6. [Reportes](#reportes)
7. [Consejos y Buenas Prácticas](#consejos-y-buenas-prácticas)

---

## 🔐 Inicio de Sesión

### Acceder al Sistema

1. Ejecutar la aplicación (doble clic en `run.bat` o `run.sh`)
2. Se mostrará la ventana de login
3. Ingresar credenciales:
   - **Usuario:** tu nombre de usuario
   - **Contraseña:** tu contraseña
4. Clic en "Iniciar Sesión"

### Usuarios por Defecto

| Usuario | Contraseña | Rol | Permisos |
|---------|-----------|-----|----------|
| admin | admin123 | ADMIN | Acceso completo |
| operador | op123 | OPERADOR | Ventas y reportes |

### Roles y Permisos

**ADMIN (Administrador)**
- ✅ Gestión de usuarios (crear, editar, eliminar)
- ✅ Gestión de productos (crear, editar, eliminar)
- ✅ Registro de ventas
- ✅ Todos los reportes
- ✅ Configuración del sistema

**OPERADOR**
- ❌ No puede gestionar usuarios
- ✅ Puede ver productos (solo lectura)
- ✅ Registro de ventas
- ✅ Reportes básicos

---

## 🗺️ Navegación Principal

### Menú Superior

La barra de menú contiene las siguientes opciones:

**Archivo**
- Cerrar Sesión: Cierra la sesión actual
- Salir: Cierra la aplicación

**Gestión**
- Usuarios: Administrar usuarios (solo ADMIN)
- Productos: Administrar productos

**Operación**
- Ventas: Registrar nuevas ventas

**Reportes**
- Ventas del día: Ver ventas de hoy
- Top Productos: Productos más vendidos

**Ayuda**
- Acerca de...: Información del sistema

### Barra de Estado (Inferior)

Muestra:
- **Izquierda:** Mensajes del sistema
- **Centro:** Usuario y rol actual
- **Derecha:** Fecha y hora actual

---

## 👥 Gestión de Usuarios

**Requisito:** Solo disponible para ADMIN

### Ver Listado de Usuarios

1. Menú → Gestión → Usuarios
2. Se muestra tabla con todos los usuarios
3. Columnas: Username, Nombre Completo, Rol, Estado

### Crear Nuevo Usuario

1. En el módulo de usuarios, clic en "Nuevo"
2. Completar formulario:
   - **Username:** nombre de usuario (único)
   - **Contraseña:** al menos 4 caracteres
   - **Confirmar contraseña:** debe coincidir
   - **Nombre completo:** nombre del usuario
   - **Rol:** ADMIN o OPERADOR
   - **Activo:** marcar si estará activo
3. Clic en "Guardar"

### Editar Usuario

1. Seleccionar usuario en la tabla
2. Clic en "Editar" (o doble clic)
3. Modificar campos necesarios
4. Para cambiar contraseña: ingresar nueva contraseña
5. Para mantener contraseña: dejar campos en blanco
6. Clic en "Guardar"

### Desactivar Usuario

1. Seleccionar usuario en la tabla
2. Clic en "Editar"
3. Desmarcar "Activo"
4. Clic en "Guardar"

**Nota:** No se puede eliminar el usuario `admin`.

---

## 🛒 Gestión de Productos

### Ver Listado de Productos

1. Menú → Gestión → Productos
2. Se muestra tabla con todos los productos

### Buscar Productos

**Por nombre:**
- Escribir en el campo "Buscar"
- La tabla se filtra automáticamente

**Por categoría:**
- Seleccionar categoría en el combo
- Se muestran solo productos de esa categoría

### Crear Nuevo Producto

1. En el módulo de productos, clic en "Nuevo"
2. Completar formulario:
   - **Nombre:** nombre del producto (único)
   - **Categoría:** BEBIDA, SNACK o TIEMPO_ARCADE
   - **Tipo:** descripción específica (ej: "Caliente")
   - **Precio:** mayor a 0
   - **Activo:** marcar si estará disponible
3. Clic en "Guardar"

### Editar Producto

1. Seleccionar producto en la tabla
2. Clic en "Editar" (o doble clic)
3. Modificar campos necesarios
4. Clic en "Guardar"

### Desactivar Producto

Para que un producto no aparezca en ventas:
1. Editar el producto
2. Desmarcar "Activo"
3. Guardar

---

## 💰 Registro de Ventas

### Realizar Nueva Venta

1. Menú → Operación → Ventas
2. En el panel superior "Nueva Venta":
   - Seleccionar producto del combo
   - Indicar cantidad
   - Clic en "Agregar"
3. Repetir para agregar más productos
4. Revisar el total calculado
5. Clic en "Confirmar Venta"

### Ver Historial de Ventas

En el panel inferior se muestra:
- Todas las ventas registradas
- Filtro por fecha (Hoy, Ayer, Última semana)
- Total del día (ventas activas)

### Cancelar Venta en Proceso

Si te equivocaste al agregar productos:
- Clic en "Cancelar"
- El carrito se limpiará

---

## 📊 Reportes

### Ventas del Día

1. Menú → Reportes → Ventas del día
2. Se muestra listado de ventas
3. Total general al final
4. Filtros disponibles: Hoy, Ayer, Última semana

**Exportar a CSV:**
1. Con el reporte visible
2. Clic en "Exportar a CSV"
3. Seleccionar ubicación y nombre
4. Clic en "Guardar"

### Top 5 Productos Más Vendidos

1. Menú → Reportes → Top Productos
2. Seleccionar rango de fecha:
   - Hoy
   - Última semana
   - Último mes
   - Último año
3. Clic en "Generar Reporte"
4. Se muestra ranking de productos:
   - Posición
   - Nombre del producto
   - Cantidad vendida
   - Total generado

**Exportar:**
- Clic en "Exportar a CSV" para guardar

---

## 💡 Consejos y Buenas Prácticas

### Para Administradores

1. **Contraseñas seguras:** Usar contraseñas de al menos 8 caracteres
2. **Usuarios activos:** Desactivar usuarios que ya no trabajen
3. **Productos:** Mantener actualizado el catálogo
4. **Respaldo:** Hacer backup de la BD regularmente

### Para Operadores

1. **Cerrar sesión:** Al terminar turno, siempre cerrar sesión
2. **Verificar totales:** Revisar el total antes de confirmar venta
3. **Productos correctos:** Verificar que sean los productos solicitados
4. **Reportes diarios:** Revisar el total del día al cerrar

### Seguridad

1. **No compartir contraseñas:** Cada usuario debe tener su propia cuenta
2. **Cambiar contraseñas:** Cambiar periódicamente las contraseñas
3. **Cerrar sesión:** No dejar la aplicación abierta sin supervisión

### Resolución de Problemas

**"No puedo ver el módulo de Usuarios"**
- Verificar que hayas iniciado sesión como ADMIN

**"Un producto no aparece en ventas"**
- Verificar que el producto esté marcado como "Activo"

**"Error al guardar"**
- Verificar que todos los campos obligatorios estén llenos
- Verificar conexión a la base de datos (XAMPP corriendo)

**"No puedo exportar a CSV"**
- Verificar permisos de escritura en la carpeta destino
- Cerrar el archivo CSV si estaba abierto

---

## ❓ Preguntas Frecuentes

**P: ¿Puedo cambiar mi propia contraseña?**  
R: Actualmente no, debe hacerlo un administrador.

**P: ¿Puedo eliminar una venta por error?**  
R: No se puede eliminar, pero un administrador puede anularla.

**P: ¿Los precios incluyen IVA?**  
R: Depende de cómo los configure el administrador.

**P: ¿Qué significa "producto desnormalizado"?**  
R: El nombre del producto se guarda en la venta para historial.

**P: ¿Puedo usar el sistema sin internet?**  
R: Sí, es completamente offline (solo necesita BD local).

---

## 📞 Soporte Técnico

Si tienes problemas técnicos:
1. Consultar sección "Solución de Problemas" en README.md
2. Verificar que XAMPP esté corriendo
3. Contactar al administrador del sistema

---

**Versión del Manual:** 1.0.0  
**Fecha:** Noviembre 2025  
**Contacto:** [Tu correo o equipo]
```

---

## 📸 Paso 3: Capturas de Pantalla (5 min)

### Capturas Necesarias

Tomar screenshots de:

1. **Login**
   - Ventana de inicio de sesión

2. **Ventana Principal**
   - Vista general con menú y barra de estado

3. **Módulo de Usuarios**
   - Listado de usuarios
   - Formulario de crear/editar usuario

4. **Módulo de Productos**
   - Listado de productos
   - Formulario de producto
   - Búsqueda en acción

5. **Módulo de Ventas**
   - Registro de venta con carrito
   - Historial de ventas

6. **Reportes**
   - Reporte de ventas del día
   - Top 5 productos

7. **Dialogo Acerca de**
   - Ventana "Acerca de..."

### Organizar Capturas

```
screenshots/
├── 01-login.png
├── 02-ventana-principal.png
├── 03-usuarios-listado.png
├── 04-usuarios-formulario.png
├── 05-productos-listado.png
├── 06-productos-formulario.png
├── 07-ventas-registro.png
├── 08-ventas-historial.png
├── 09-reporte-ventas.png
├── 10-reporte-top-productos.png
└── 11-acerca-de.png
```

---

## 🎥 Paso 4: Video Demostración (Opcional, 5 min)

### Script de Video (3-5 minutos)

1. **Introducción (30 seg)**
   - Presentar el proyecto
   - Mencionar tecnologías usadas

2. **Login (20 seg)**
   - Mostrar pantalla de login
   - Iniciar sesión como admin

3. **Gestión de Productos (60 seg)**
   - Mostrar listado
   - Crear producto nuevo
   - Buscar producto

4. **Registro de Venta (60 seg)**
   - Agregar productos al carrito
   - Confirmar venta
   - Ver en historial

5. **Reportes (45 seg)**
   - Mostrar ventas del día
   - Generar top productos
   - Exportar a CSV

6. **Cierre (15 seg)**
   - Recapitular funcionalidades
   - Agradecimientos

### Herramientas Recomendadas

- **Windows:** OBS Studio, Xbox Game Bar
- **Mac:** QuickTime, ScreenFlow
- **Linux:** SimpleScreenRecorder, OBS Studio

---

## ✅ Checklist de Documentación

- [ ] README.md completo con instalación
- [ ] MANUAL_USUARIO.md detallado
- [ ] Capturas de pantalla tomadas y organizadas
- [ ] Video demo grabado (opcional)
- [ ] Scripts SQL documentados
- [ ] application.properties con comentarios
- [ ] Notas de versión incluidas

---

## 🔗 Navegación

- ⬅️ [Anterior: Empaquetado](02-empaquetado.md)
- ⬅️ [Volver al índice de la clase](00-intro.md)

---

**Tiempo estimado:** 30 minutos  
**Dificultad:** Baja-Media

---

> 🎉 **¡Felicitaciones!** Has completado el proyecto Pixel & Bean. Tu aplicación está lista para ser presentada y entregada.

