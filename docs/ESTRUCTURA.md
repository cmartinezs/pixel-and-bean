# 📁 Estructura Final de Documentación - Proyecto Pixel & Bean

**Fecha:** 10 de noviembre de 2025  
**Estado:** Reorganización completada con numeración correlativa

---

## 🎯 Estructura Completa

```
PixelAndBean/
├── README.md                           # Documento principal del proyecto
├── docs/
│   ├── 00-lessons/                     # Clases del curso (numeradas)
│   │   ├── 01-gui-components/          # Clase 1
│   │   │   ├── 00-intro.md             # Índice de la clase
│   │   │   ├── 01-technical-base.md    # Conceptos técnicos
│   │   │   └── 02-main-windows.md      # Práctica
│   │   │
│   │   └── 02-components-events/       # Clase 2
│   │       ├── 00-intro.md             # Índice de la clase
│   │       ├── 01-technical-concepts.md # Conceptos avanzados
│   │       ├── 02-layouts-views.md     # Creación de vistas
│   │       └── 03-navigation-stubs.md  # Navegación y stubs
│   │
│   ├── 01-extras/                      # Recursos adicionales
│   │   ├── 00-index.md                 # Índice de recursos
│   │   └── 01-git-basico.md            # Guía de Git
│   │
│   └── PROGRESS.md                     # Resumen de progreso
│
├── src/                                # Código fuente (Java)
├── build.xml                           # Configuración de Ant
└── private/                            # Archivos de trabajo interno
```

---

## 🔢 Sistema de Numeración

### Carpetas (prefijo numérico)
- `00-` → Contenido principal (lecciones)
- `01-` → Recursos adicionales (extras)
- `02-` → SQL y Base de Datos (futuro)
- `03-` → Assets (imágenes, iconos) (futuro)

### Archivos dentro de cada carpeta
- `00-` → Índice/Introducción
- `01-` → Primer contenido
- `02-` → Segundo contenido
- `03-` → Tercer contenido
- etc.

### Ejemplos:
```
00-lessons/01-gui-components/
├── 00-intro.md                 # Índice
├── 01-technical-base.md        # Primera parte
└── 02-main-windows.md          # Segunda parte

01-extras/
├── 00-index.md                 # Índice
├── 01-git-basico.md            # Primer extra
├── 02-netbeans-tips.md         # Segundo extra (futuro)
└── 03-jdbc-cheatsheet.md       # Tercer extra (futuro)
```

---

## 📚 Documentos Existentes

### Clases (00-lessons/)
| Archivo | Título | Duración | Estado |
|---------|--------|----------|--------|
| `01-gui-components/00-intro.md` | Índice Clase 1 | - | ✅ |
| `01-gui-components/01-technical-base.md` | Conceptos Técnicos | 40 min | ✅ |
| `01-gui-components/02-main-windows.md` | Ventanas Base | 60 min | ✅ |
| `02-components-events/00-intro.md` | Índice Clase 2 | - | ✅ |
| `02-components-events/01-technical-concepts.md` | Conceptos Avanzados | 30 min | ✅ |
| `02-components-events/02-layouts-views.md` | Creación de Vistas | 40 min | ✅ |
| `02-components-events/03-navigation-stubs.md` | Navegación y Stubs | 30 min | ✅ |

### Extras (01-extras/)
| Archivo | Título | Tipo | Estado |
|---------|--------|------|--------|
| `01-extras/00-index.md` | Índice de Recursos | Navegación | ✅ |
| `01-extras/01-git-basico.md` | Guía Básica de Git | Tutorial | ✅ |

### General
| Archivo | Descripción | Estado |
|---------|-------------|--------|
| `PROGRESS.md` | Resumen de progreso del proyecto | ✅ |
| `README.md` | Documento principal (raíz) | ✅ |

---

## 🎯 Ventajas del Sistema de Numeración

### ✅ Orden Garantizado
- Los archivos siempre aparecen en el orden correcto en cualquier explorador
- No depende del orden alfabético de los títulos

### ✅ Fácil Navegación
- Los números indican la secuencia natural de lectura
- `00-` siempre es el punto de entrada (índice)

### ✅ Escalabilidad
- Fácil agregar nuevos archivos manteniendo el orden
- Se pueden insertar archivos entre existentes (ej: 01, 02, 02b, 03)

### ✅ Claridad
- Un vistazo rápido muestra la estructura completa
- Los estudiantes saben qué leer primero

### ✅ Compatibilidad
- Funciona en Windows, macOS y Linux
- Compatible con Git y GitHub
- No depende de metadatos especiales

---

## 🔗 Enlaces de Navegación Rápida

### Para Estudiantes
- **Empezar aquí:** [README.md](../README.md)
- **Clase 1:** [01-gui-components/00-intro.md](00-lessons/01-gui-components/00-intro.md)
- **Clase 2:** [02-components-events/00-intro.md](00-lessons/02-components-events/00-intro.md)
- **Recursos extras:** [01-extras/00-index.md](01-extras/00-index.md)
- **Progreso:** [PROGRESS.md](PROGRESS.md)

### Para Profesores
- **Planificación:** [private/clases.txt](../private/clases.txt)
- **Revisión:** [private/revisar.txt](../private/revisar.txt)
- **Ajustes:** [private/REVISION_CLASE_1.md](../private/REVISION_CLASE_1.md)

---

## 📝 Convenciones de Nombres

### Archivos Markdown
- Usar minúsculas
- Separar palabras con guiones (`-`)
- Prefijo numérico con dos dígitos (`01-`, `02-`, etc.)
- Nombres descriptivos pero concisos

**Buenos nombres:**
```
✅ 01-git-basico.md
✅ 02-netbeans-tips.md
✅ 03-jdbc-cheatsheet.md
```

**Malos nombres:**
```
❌ git.md                    (sin número, poco descriptivo)
❌ 1-Git_Basico.md           (un solo dígito, mayúsculas, guión bajo)
❌ conceptos-tecnicos.md     (sin número cuando debería tenerlo)
```

### Carpetas
- Usar minúsculas
- Separar palabras con guiones (`-`)
- Prefijo numérico con dos dígitos
- Nombres que describen el contenido general

**Ejemplos:**
```
✅ 00-lessons/
✅ 01-extras/
✅ 02-sql/
✅ 03-assets/
```

---

## 🚀 Próximos Pasos

### Documentación Pendiente (Futuro)
- [ ] Clase 3 - MVC + DI
- [ ] Clase 4 - Conexión BD (JDBC)
- [ ] Clase 5 - CRUD Completo
- [ ] Clase 6 - Empaquetado

### Extras Planificados
- [ ] `02-netbeans-tips.md` - Atajos y trucos de NetBeans
- [ ] `03-jdbc-cheatsheet.md` - Referencia rápida de JDBC
- [ ] `04-mysql-basico.md` - Comandos básicos de MySQL
- [ ] `05-patrones-diseno.md` - Patrones usados en el proyecto

### Mejoras Continuas
- [ ] Screenshots de las interfaces
- [ ] Diagramas de arquitectura
- [ ] Videos tutoriales cortos
- [ ] Ejercicios adicionales

---

## 📊 Estadísticas

- **Clases completadas:** 2 de 6 (33%)
- **Archivos de documentación:** 10
- **Páginas totales (estimado):** ~150
- **Tiempo de lectura total:** ~4 horas
- **Ejemplos de código:** 50+
- **Commits realizados:** 10+

---

> 💡 **Nota:** Esta estructura es flexible y puede adaptarse según las necesidades del curso. La numeración correlativa facilita la reorganización sin romper enlaces.

---

**Última actualización:** 10 de noviembre de 2025  
**Mantenido por:** Carlos Martínez

