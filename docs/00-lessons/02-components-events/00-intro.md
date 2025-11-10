# 🎨 Clase 2 – Componentes y Eventos (Pre-MVC)

> ⚠️ **NOTA:** Este archivo ha sido dividido en tres partes para una mejor organización:
>
> 1. **[01-technical-concepts.md](01-technical-concepts.md)** – Conceptos técnicos sobre eventos, navegación y componentes avanzados (30 min)
> 2. **[02-layouts-views.md](02-layouts-views.md)** – Creación de todas las vistas del sistema (40 min)
> 3. **[03-navigation-stubs.md](03-navigation-stubs.md)** – Navegación entre vistas y servicios stub (30 min)
>
> Se recomienda seguir el orden indicado para un mejor aprovechamiento de la clase.

---

## 📚 Contenido de la Clase 2

### Parte 1: Conceptos Técnicos (30 min)
➡️ **[01-technical-concepts.md](01-technical-concepts.md)**

**Temas cubiertos:**
- 🎯 Objetivo de la clase y entregables
- 🗺️ Visión general del proyecto
- 📚 Apartado técnico:
  - Tipos de Listeners en Swing
  - DocumentListener para validación en tiempo real
  - Selección y eventos en JTable
  - CardLayout vs JDesktopPane
  - AbstractTableModel personalizado
  - Patrón Observer en profundidad
  - Validaciones en UI vs Backend
  - Stub Services (preparación para MVC)

### Parte 2: Creación de Layouts y Vistas (40 min)
➡️ **[02-layouts-views.md](02-layouts-views.md)**

**Actividades prácticas:**
- 🏗️ Implementar sistema de navegación (CardLayout)
- 🪟 Crear vista de Gestión de Usuarios
  - Formulario de datos
  - Tabla de listado
  - Botones de acción
- 📦 Crear vista de Gestión de Productos
  - Formulario con categorías
  - Búsqueda y filtros
  - Tabla con datos
- 💰 Crear vista de Ventas
  - Selección de productos
  - Detalle de venta
  - Total y confirmación
- 📊 Crear vista de Reportes
  - Ventas del día
  - Filtros de fecha
- 🎮 Crear vista de Eventos (placeholder)

### Parte 3: Navegación y Servicios Stub (30 min)
➡️ **[03-navigation-stubs.md](03-navigation-stubs.md)**

**Actividades prácticas:**
- 🔗 Conectar menús con vistas usando CardLayout
- 🎯 Implementar ActionListeners en todos los botones
- 📝 Crear interfaces de servicios stub
- ✅ Validaciones de formularios
- 🧪 Pruebas de navegación completa
- 🧹 Limpieza y versionamiento

---

## ⏱️ Duración Total

**2.5 horas pedagógicas (100 minutos)**

**Distribución del tiempo:**
- **Parte 1 - Teoría:** 30 minutos
  - Presentación de conceptos avanzados (15 min)
  - Eventos y listeners en profundidad (10 min)
  - Preparación para MVC (5 min)

- **Parte 2 - Vistas:** 40 minutos
  - Sistema de navegación (5 min)
  - Vista de Usuarios (8 min)
  - Vista de Productos (8 min)
  - Vista de Ventas (10 min)
  - Vista de Reportes (6 min)
  - Vista de Eventos (3 min)

- **Parte 3 - Integración:** 30 minutos
  - Conectar navegación (8 min)
  - Implementar eventos (10 min)
  - Crear stubs (7 min)
  - Validaciones (3 min)
  - Pruebas (2 min)

---

## ✅ Resultado de la Clase 2

Al finalizar esta sesión completa (las tres partes) tendrás:

### Conocimientos adquiridos:
- ✅ Dominio completo de listeners en Swing
- ✅ Comprensión de navegación entre vistas
- ✅ Uso profesional de JTable con modelos personalizados
- ✅ Validaciones de formularios en tiempo real
- ✅ Preparación para arquitectura MVC
- ✅ Creación de interfaces de servicios (contratos)

### Entregables funcionales:
- ✅ **Alpha UI completa:** Todas las vistas del sistema implementadas
- ✅ **Navegación funcional:** Menú completamente operativo
- ✅ **Eventos conectados:** Todos los botones y acciones implementadas
- ✅ **Servicios stub:** Interfaces y simulaciones de datos
- ✅ **Validaciones básicas:** Campos requeridos y formatos
- ✅ **Código organizado:** Preparado para refactorización a MVC

### Resumen de vistas creadas:

| Vista              | Componentes principales               | Estado       |
|--------------------|---------------------------------------|--------------|
| 🏠 MainFrame       | CardLayout, navegación                | ✅ Funcional  |
| 👥 Usuarios        | JTable, formulario CRUD               | ✅ Funcional  |
| 📦 Productos       | JTable, búsqueda, formulario          | ✅ Funcional  |
| 💰 Ventas          | Selección, detalle, total             | ✅ Funcional  |
| 📊 Reportes        | Tabla de ventas, filtros              | ✅ Funcional  |
| 🎮 Eventos         | Pantalla informativa                  | ✅ Funcional  |

---

## 🎯 Pre-requisitos

**Antes de comenzar esta clase, debes haber completado:**
- ✅ Clase 1 completada (Login y MainFrame básico)
- ✅ Comprensión de componentes Swing básicos
- ✅ Conocimiento de eventos ActionListener
- ✅ Proyecto versionado en Git

**Conocimientos recomendados:**
- 📚 Interfaces en Java
- 📚 Colecciones (List, ArrayList)
- 📚 Concepto básico de MVC (lo profundizaremos en Clase 3)

---

## 💡 Próxima Clase

**Clase 3 – Patrones de Diseño (MVC + IoC/DI manual)**

➡️ Refactorización completa a arquitectura MVC con inyección de dependencias manual, separación de capas y preparación para conexión a base de datos.

**Lo que haremos:**
- 🏗️ Separar completamente View, Controller y Service
- 🔧 Implementar IoC/DI manual (AppContext)
- 📋 Crear interfaces de repositorio
- 🎯 Controladores por pantalla
- ✅ Validaciones en capa de servicio
- 🔄 Refactorizar código existente

---

## 📋 Checklist de Avance

Antes de pasar a la Clase 3, asegúrate de que tu proyecto cumple con:

**Funcionalidad:**
- [ ] Todas las vistas están creadas y son visibles
- [ ] El menú navega correctamente a cada vista
- [ ] Los botones tienen eventos asignados
- [ ] Las tablas muestran datos de ejemplo (hardcoded o stub)
- [ ] Los formularios tienen validaciones básicas
- [ ] Los mensajes de éxito/error se muestran correctamente

**Código:**
- [ ] Código comentado en secciones clave
- [ ] Nombres de variables descriptivos
- [ ] No hay código duplicado obvio
- [ ] Servicios stub implementados como interfaces
- [ ] Estructura de paquetes ordenada

**Versionamiento:**
- [ ] Commit realizado con mensaje descriptivo
- [ ] Código subido a repositorio remoto
- [ ] README actualizado con progreso

---

> 🧠 *"Una buena interfaz es invisible. El usuario no piensa en cómo usarla, simplemente la usa."*

