# 🔍 Plan de Revisión Transversal - Consistencia de Clases Modelo

**Proyecto:** Pixel & Bean  
**Fecha:** 28 de noviembre de 2025  
**Objetivo:** Verificar consistencia de atributos y tipos en clases modelo a través de las 6 lecciones

---

## 🎯 Objetivo

Realizar una auditoría transversal de las clases modelo (`Usuario`, `Producto`, `Venta`, `VentaDetalle`) para asegurar que:
- ✅ Los atributos no cambien de nombre sin justificación
- ✅ Los tipos de datos sean consistentes
- ✅ No se agreguen/eliminen atributos arbitrariamente
- ✅ La evolución de las clases sea lógica y documentada

---

## 📋 Plan de Ejecución - 10 Pasos

### **FASE 1: Extracción y Catalogación** (Pasos 1-3)

#### Paso 1: Extraer clase `Usuario`
**Objetivo:** Encontrar todas las definiciones de `Usuario` en las 6 lecciones  
**Acción:** 
- Buscar en lecciones 01-06
- Extraer atributos, tipos y métodos
- Documentar en qué lección aparece cada versión

**Salida esperada:** Tabla comparativa de `Usuario` por lección

---

#### Paso 2: Extraer clase `Producto`
**Objetivo:** Encontrar todas las definiciones de `Producto` en las 6 lecciones  
**Acción:**
- Buscar en lecciones 01-06
- Extraer atributos, tipos y métodos
- Documentar en qué lección aparece cada versión

**Salida esperada:** Tabla comparativa de `Producto` por lección

---

#### Paso 3: Extraer clases `Venta` y `VentaDetalle`
**Objetivo:** Encontrar todas las definiciones relacionadas con ventas  
**Acción:**
- Buscar `Venta`, `VentaDetalle`, `DetalleVenta` (posibles variaciones)
- Extraer atributos, tipos y métodos
- Documentar relaciones entre clases

**Salida esperada:** Tabla comparativa de clases de Venta por lección

---

### **FASE 2: Análisis de Consistencia** (Pasos 4-6)

#### Paso 4: Análisis de cambios de nombres
**Objetivo:** Identificar si un atributo cambia de nombre entre lecciones  
**Acción:**
- Comparar nombres de atributos lección por lección
- Identificar cambios (ej: `nombreCompleto` → `nombre_completo`)
- Clasificar como: inconsistencia, renombre justificado, o evolución lógica

**Salida esperada:** Lista de cambios de nombres con clasificación

---

#### Paso 5: Análisis de cambios de tipos
**Objetivo:** Identificar si un atributo cambia de tipo entre lecciones  
**Acción:**
- Comparar tipos de datos lección por lección
- Identificar cambios (ej: `String fecha` → `LocalDate fecha`)
- Clasificar como: inconsistencia, mejora técnica, o error

**Salida esperada:** Lista de cambios de tipos con clasificación

---

#### Paso 6: Análisis de atributos nuevos/eliminados
**Objetivo:** Identificar atributos que aparecen o desaparecen sin justificación  
**Acción:**
- Comparar conjunto de atributos entre lecciones consecutivas
- Identificar adiciones/eliminaciones
- Verificar si hay justificación pedagógica

**Salida esperada:** Lista de atributos agregados/eliminados con análisis

---

### **FASE 3: Validación y Corrección** (Pasos 7-9)

#### Paso 7: Crear matriz de consistencia
**Objetivo:** Visualizar la evolución completa de cada clase  
**Acción:**
- Crear tabla con: Clase | Atributo | L01 | L02 | L03 | L04 | L05 | L06
- Marcar inconsistencias con color/símbolo
- Identificar patrones de problemas

**Salida esperada:** Matriz visual de consistencia

---

#### Paso 8: Proponer correcciones
**Objetivo:** Definir la versión canónica de cada clase  
**Acción:**
- Establecer la versión "correcta" de cada clase
- Documentar cambios necesarios por lección
- Justificar decisiones de diseño

**Salida esperada:** Especificación canónica de cada clase modelo

---

#### Paso 9: Validar relaciones entre clases
**Objetivo:** Asegurar que las FK y relaciones sean consistentes  
**Acción:**
- Verificar que `Venta` → `Usuario` use el mismo campo
- Verificar que `VentaDetalle` → `Producto` use el mismo campo
- Confirmar tipos de datos en relaciones

**Salida esperada:** Diagrama de relaciones validado

---

### **FASE 4: Documentación** (Paso 10)

#### Paso 10: Generar reporte de consistencia transversal
**Objetivo:** Documentar hallazgos y correcciones  
**Acción:**
- Consolidar todos los análisis
- Generar reporte ejecutivo
- Crear checklist de correcciones
- Actualizar INDICE_DOCUMENTACION.md

**Salida esperada:** 
- `ANALISIS_TRANSVERSAL_CLASES_MODELO.md`
- `CORRECCIONES_CLASES_MODELO.md`

---

## 📊 Metodología de Búsqueda

Para cada paso usaremos:

### Búsqueda de definiciones de clase
```bash
grep -rn "class Usuario\|public class Usuario" docs/00-lessons/
grep -rn "private.*id\|private.*username" docs/00-lessons/
```

### Búsqueda de atributos específicos
```bash
grep -A20 "class Usuario" docs/00-lessons/ | grep "private\|protected"
```

### Búsqueda de constructores
```bash
grep -A10 "public Usuario(" docs/00-lessons/
```

### Búsqueda de getters/setters
```bash
grep "get.*\|set.*" docs/00-lessons/ | grep Usuario
```

---

## 📈 Criterios de Evaluación

Para cada cambio encontrado, evaluar:

### ✅ Cambio Aceptable
- Evolución lógica pedagógica (ej: agregar atributo en lección de BD)
- Mejora técnica justificada (ej: String → LocalDate)
- Refactorización explícita con documentación

### ⚠️ Cambio Cuestionable
- Renombre sin justificación clara
- Cambio de tipo sin explicación
- Atributo que aparece y desaparece

### ❌ Inconsistencia Crítica
- Mismo atributo con diferentes nombres en misma lección
- Cambio de tipo incompatible (ej: int → String)
- Atributo requerido que falta en implementaciones

---

## 🎯 Entregables Esperados

Al completar los 10 pasos tendremos:

1. **Tablas comparativas** de cada clase por lección
2. **Lista de inconsistencias** clasificadas por severidad
3. **Matriz de consistencia** visual
4. **Especificación canónica** de cada clase
5. **Diagrama de relaciones** validado
6. **Reporte ejecutivo** con hallazgos y correcciones
7. **Checklist de correcciones** a aplicar

---

## ⏱️ Estimación de Tiempo

| Fase | Pasos | Tiempo Estimado |
|------|-------|----------------|
| **FASE 1: Extracción** | 1-3 | 30 minutos |
| **FASE 2: Análisis** | 4-6 | 45 minutos |
| **FASE 3: Validación** | 7-9 | 30 minutos |
| **FASE 4: Documentación** | 10 | 20 minutos |
| **TOTAL** | 10 pasos | **~2 horas** |

---

## 🚀 Estado del Plan

```
[ ] Paso 1: Extraer clase Usuario
[ ] Paso 2: Extraer clase Producto
[ ] Paso 3: Extraer clase Venta/VentaDetalle
[ ] Paso 4: Análisis cambios de nombres
[ ] Paso 5: Análisis cambios de tipos
[ ] Paso 6: Análisis atributos nuevos/eliminados
[ ] Paso 7: Crear matriz de consistencia
[ ] Paso 8: Proponer correcciones
[ ] Paso 9: Validar relaciones
[ ] Paso 10: Generar reporte final
```

---

## 📝 Notas Importantes

### Clases a Analizar (prioritarias)
1. **Usuario** - Aparece desde lección 01
2. **Producto** - Aparece desde lección 02
3. **Venta** - Aparece desde lección 02/03
4. **VentaDetalle** - Aparece desde lección 03/04

### Clases secundarias (si aplica)
- `Rol` (enum)
- `Categoria` (enum o clase)
- Otras clases auxiliares

### Consideraciones Especiales
- En lecciones tempranas puede haber versiones "simplificadas"
- En lección 04 (JDBC) deben aparecer todos los campos de BD
- En lección 05 (CRUD) puede haber campos adicionales de validación
- Verificar que SQL schemas coincidan con clases Java

---

**Plan creado el:** 28 de noviembre de 2025  
**Listo para ejecutar:** ✅ SÍ  
**Siguiente paso:** Ejecutar Paso 1 - Extraer clase Usuario

---

## 🤝 Confirmación para Comenzar

¿Estás listo para comenzar con el **Paso 1**?

Responde:
- **"Sí"** o **"Adelante"** → Comenzamos con Paso 1
- **"Modifica X"** → Ajustamos el plan antes de empezar
- **"Salta al paso Y"** → Comenzamos desde un paso específico

