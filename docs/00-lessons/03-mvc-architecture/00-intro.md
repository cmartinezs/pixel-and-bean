# 🏗️ Clase 3 – Patrones y Arquitectura MVC

> ⚠️ **NOTA:** Este archivo ha sido dividido en tres partes para una mejor organización:
>
> 1. **[01-technical-patterns.md](01-technical-patterns.md)** – Patrones de diseño, MVC, IoC y arquitectura en capas (30 min)
> 2. **[02-refactoring-layers.md](02-refactoring-layers.md)** – Refactorización a capas: Controller, Service, Repository (40 min)
> 3. **[03-dependency-injection.md](03-dependency-injection.md)** – Inyección de dependencias manual y integración completa (30 min)
>
> Se recomienda seguir el orden indicado para un mejor aprovechamiento de la clase.

---

## 📚 Contenido de la Clase 3

### Parte 1: Patrones y Arquitectura (30 min)
➡️ **[01-technical-patterns.md](01-technical-patterns.md)**

**Temas cubiertos:**
- 🎯 Objetivo de la clase y entregables
- 🗺️ Visión general: de código monolítico a arquitectura en capas
- 📚 Apartado técnico:
  - Patrón MVC (Model-View-Controller)
  - Separación de responsabilidades (SoC)
  - Inversión de Control (IoC)
  - Inyección de Dependencias (DI) manual
  - Patrón Repository (DAO)
  - Patrón Service Layer
  - SOLID aplicado a Swing
  - Interfaces como contratos
  - Anti-patrones a evitar

### Parte 2: Refactorización a Capas (40 min)
➡️ **[02-refactoring-layers.md](02-refactoring-layers.md)**

**Actividades prácticas:**
- 🏗️ Crear estructura de paquetes (controller, service, repository)
- 📝 Implementar interfaces de repositorios
- 🔧 Crear implementaciones mock de repositorios
- 💼 Implementar capa de servicios
- 🎮 Crear controladores para cada vista
- 🔄 Separar lógica de UI de lógica de negocio

### Parte 3: Inyección de Dependencias e Integración (30 min)
➡️ **[03-dependency-injection.md](03-dependency-injection.md)**

**Actividades prácticas:**
- 🔌 Implementar contenedor IoC manual (ApplicationContext)
- 🔗 Conectar Controllers con Services y Repositories
- 🧪 Refactorizar vistas para usar Controllers
- ✅ Validar arquitectura completa
- 🧹 Limpieza de código y versionamiento

---

## ⏱️ Duración Total

**2.5 horas pedagógicas (100 minutos)**

**Distribución del tiempo:**
- **Parte 1 - Teoría:** 30 minutos
  - Presentación de MVC y patrones (10 min)
  - Inversión de Control e Inyección de Dependencias (8 min)
  - Repository y Service Layer (7 min)
  - SOLID en la práctica (5 min)

- **Parte 2 - Refactorización:** 40 minutos
  - Estructura de paquetes (5 min)
  - Interfaces de repositorios (8 min)
  - Capa de servicios (10 min)
  - Controladores (12 min)
  - Validación intermedia (5 min)

- **Parte 3 - Integración:** 30 minutos
  - ApplicationContext (IoC manual) (10 min)
  - Conectar capas (10 min)
  - Refactorizar vistas (8 min)
  - Pruebas y limpieza (2 min)

---

## ✅ Resultado de la Clase 3

Al finalizar esta sesión completa (las tres partes) tendrás:

### Conocimientos adquiridos:
- ✅ Comprensión profunda del patrón MVC aplicado a Swing
- ✅ Dominio de separación de responsabilidades (SoC)
- ✅ Implementación de Inversión de Control (IoC) manual
- ✅ Diseño con interfaces como contratos
- ✅ Aplicación práctica de principios SOLID
- ✅ Arquitectura escalable y mantenible

### Entregables funcionales:
- ✅ Código refactorizado con arquitectura en capas
- ✅ Separación clara: GUI → Controller → Service → Repository
- ✅ Interfaces de repositorio definidas (contratos)
- ✅ Capa de servicios con lógica de negocio
- ✅ Contenedor IoC manual funcional
- ✅ Aplicación funcionando igual que antes pero con mejor arquitectura
- ✅ Preparación completa para integración con BD en Clase 4

### Estructura de paquetes resultante:
```
cl.tuusuario.pnb/
├── app/
│   └── ApplicationContext.java    # Contenedor IoC manual
├── gui/
│   ├── LoginForm.java
│   ├── MainFrame.java
│   ├── UsuariosPanel.java
│   ├── ProductosPanel.java
│   ├── VentasPanel.java
│   └── ReportesPanel.java
├── controller/
│   ├── LoginController.java
│   ├── UsuarioController.java
│   ├── ProductoController.java
│   ├── VentaController.java
│   └── ReporteController.java
├── service/
│   ├── UsuarioService.java
│   ├── ProductoService.java
│   ├── VentaService.java
│   └── ReporteService.java
├── repository/
│   ├── IUsuarioRepository.java
│   ├── IProductoRepository.java
│   ├── IVentaRepository.java
│   ├── UsuarioRepositoryMock.java
│   ├── ProductoRepositoryMock.java
│   └── VentaRepositoryMock.java
├── model/
│   ├── Usuario.java
│   ├── Producto.java
│   ├── Venta.java
│   └── VentaDetalle.java
└── util/
    └── ValidationUtil.java
```

---

## 💡 Próxima Clase

**Clase 4 – Conexión a Base de Datos (JDBC + XAMPP)**

➡️ Reemplazar los repositorios mock por implementaciones reales que se conectan a MySQL usando JDBC.

**Preparación para la Clase 4:**
- Instalar XAMPP y MySQL
- Revisar conceptos de SQL y JDBC
- Tener listo el archivo `application.properties`

---

## 🎯 ¿Por qué esta clase es crítica?

Esta es probablemente la **clase más importante** del curso porque:

1. **Transforma código "estudiantil" en código "profesional"**
   - De todo-en-uno a arquitectura modular
   - De acoplamiento alto a bajo acoplamiento
   
2. **Prepara para el mundo real**
   - Así se estructuran aplicaciones empresariales
   - Facilita trabajo en equipo
   
3. **Hace el código testeable**
   - Puedes probar cada capa independientemente
   - Permite crear tests unitarios
   
4. **Facilita mantenimiento futuro**
   - Cambios en una capa no afectan otras
   - Código más legible y organizado
   
5. **Permite escalabilidad**
   - Fácil agregar nuevas funcionalidades
   - Preparado para crecer

---

## 📊 Comparación: Antes vs Después

### ❌ ANTES (Clase 2):
```java
// TODO en la vista - código monolítico
class UsuariosPanel {
    private void btnGuardarActionPerformed() {
        // Validar en la vista
        if (txtUsername.getText().isEmpty()) {
            JOptionPane.showMessageDialog(this, "Campo requerido");
            return;
        }
        
        // Lógica de negocio en la vista
        Usuario u = new Usuario();
        u.setUsername(txtUsername.getText());
        
        // "Persistencia" hardcodeada en la vista
        listaUsuarios.add(u);
        
        // Actualizar tabla desde la vista
        cargarTabla();
    }
}
```

**Problemas:**
- 😵 Vista, validación, lógica y datos todo mezclado
- 🔒 Imposible reutilizar lógica en otra vista
- 🧪 Imposible probar sin abrir la interfaz
- 🔄 Cambiar de ArrayList a BD requiere modificar la vista

---

### ✅ DESPUÉS (Clase 3):
```java
// Vista limpia - solo UI
class UsuariosPanel {
    private UsuarioController controller;
    
    private void btnGuardarActionPerformed() {
        try {
            controller.guardarUsuario(
                txtUsername.getText(),
                txtPassword.getText(),
                txtNombreCompleto.getText(),
                comboRol.getSelectedItem().toString()
            );
            limpiarFormulario();
            cargarTabla();
        } catch (ValidationException e) {
            mostrarError(e.getMessage());
        }
    }
}

// Controlador - coordina
class UsuarioController {
    private UsuarioService service;
    
    public void guardarUsuario(String username, String password, 
                               String nombre, String rol) {
        service.crear(username, password, nombre, rol);
    }
}

// Servicio - lógica de negocio
class UsuarioService {
    private IUsuarioRepository repository;
    
    public void crear(String username, String password, 
                     String nombre, String rol) {
        // Validaciones de negocio
        ValidationUtil.requireNonEmpty(username, "Username");
        ValidationUtil.requireNonEmpty(password, "Password");
        
        if (repository.existeUsername(username)) {
            throw new BusinessException("Username ya existe");
        }
        
        // Hash de password (futuro)
        
        // Crear entidad
        Usuario usuario = new Usuario();
        usuario.setUsername(username);
        usuario.setPassword(password);
        usuario.setNombreCompleto(nombre);
        usuario.setRol(rol);
        usuario.setActivo(true);
        
        // Persistir
        repository.guardar(usuario);
    }
}

// Repositorio - acceso a datos
interface IUsuarioRepository {
    void guardar(Usuario usuario);
    boolean existeUsername(String username);
    List<Usuario> listarTodos();
}
```

**Beneficios:**
- ✅ Cada clase tiene una única responsabilidad
- ✅ Lógica de negocio reutilizable
- ✅ Testeable sin interfaz gráfica
- ✅ Cambiar de Mock a JDBC: solo cambiar implementación de repository

---

## 🚦 Prerrequisitos para esta clase

Antes de comenzar, asegúrate de haber completado:

- ✅ **Clase 1:** Login y MainFrame funcionando
- ✅ **Clase 2:** Todas las vistas creadas con navegación
- ✅ **Entender POO:** Clases, interfaces, herencia, polimorfismo
- ✅ **Conocer interfaces Java:** cómo declararlas e implementarlas

---

## 💪 Preparación mental

Esta clase requiere **cambio de mentalidad**:

- 🧠 De "hacer que funcione" a "hacer que sea mantenible"
- 🎯 De pensar en pantallas a pensar en responsabilidades
- 🔄 De código lineal a flujo entre capas
- 📦 De clases grandes a muchas clases pequeñas

**Es normal que al principio parezca "más complicado".**  
Pero una vez que veas los beneficios, no querrás volver atrás.

---

> 🧠 *"La arquitectura no es sobre el presente, es sobre el futuro del código."*
>
> 🏗️ *"Primero hazlo funcionar. Luego hazlo bien. Ahora es el momento de hacerlo bien."*

