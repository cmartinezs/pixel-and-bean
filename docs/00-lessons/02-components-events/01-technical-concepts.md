# 📖 Clase 2 (Parte 1) – Conceptos Técnicos de Componentes y Eventos

**Objetivo:**  
Comprender los conceptos avanzados de manejo de eventos en Swing, sistemas de navegación, modelos de tablas personalizados y preparación para arquitectura MVC.

⏱️ **Duración estimada:** 30 minutos

**Distribución del tiempo:**
- Presentación de objetivos y visión general (5 min)
- Tipos de listeners y eventos avanzados (10 min)
- Navegación y patrones de UI (8 min)
- Servicios stub y preparación para MVC (7 min)

<!-- TOC -->
* [📖 Clase 2 (Parte 1) – Conceptos Técnicos de Componentes y Eventos](#-clase-2-parte-1--conceptos-técnicos-de-componentes-y-eventos)
  * [🎯 Objetivos de la Clase 2](#-objetivos-de-la-clase-2)
  * [🗺️ Visión General del Proyecto](#-visión-general-del-proyecto)
    * [¿Dónde estamos?](#dónde-estamos)
    * [¿Qué construiremos hoy?](#qué-construiremos-hoy)
  * [📚 Apartado Técnico – Conceptos Avanzados](#-apartado-técnico--conceptos-avanzados)
    * [🔷 1. Tipos de Listeners en Swing](#-1-tipos-de-listeners-en-swing)
    * [🔷 2. DocumentListener – Validación en Tiempo Real](#-2-documentlistener--validación-en-tiempo-real)
    * [🔷 3. Selección y Eventos en JTable](#-3-selección-y-eventos-en-jtable)
    * [🔷 4. CardLayout – Sistema de Navegación](#-4-cardlayout--sistema-de-navegación)
    * [🔷 5. JDesktopPane y JInternalFrame](#-5-jdesktoppane-y-jinternalframe)
    * [🔷 6. AbstractTableModel Personalizado](#-6-abstracttablemodel-personalizado)
    * [🔷 7. Patrón Observer en Profundidad](#-7-patrón-observer-en-profundidad)
    * [🔷 8. Validaciones: UI vs Backend](#-8-validaciones-ui-vs-backend)
    * [🔷 9. Stub Services – Preparación para MVC](#-9-stub-services--preparación-para-mvc)
    * [🔷 10. KeyAdapter y Atajos de Teclado](#-10-keyadapter-y-atajos-de-teclado)
  * [🎯 Resumen Técnico](#-resumen-técnico)
  * [💡 Siguiente Paso](#-siguiente-paso)
<!-- TOC -->

---

## 🎯 Objetivos de la Clase 2

Al finalizar esta clase serás capaz de:

1. **Manejar eventos complejos** en componentes Swing más allá de ActionListener
2. **Implementar navegación** fluida entre múltiples pantallas
3. **Trabajar con JTable** de forma profesional usando modelos personalizados
4. **Validar formularios** en tiempo real mientras el usuario escribe
5. **Preparar el código** para una futura refactorización a MVC
6. **Crear interfaces de servicio** como contratos (stub services)
7. **Separar lógica de UI** de la lógica de negocio (aunque aún simulada)

---

## 🗺️ Visión General del Proyecto

### ¿Dónde estamos?

| Clase | Estado       | Entregable                           |
|-------|--------------|--------------------------------------|
| **1** | ✅ Completada | Login + MainFrame con menú           |
| **2** | 🔄 En curso  | **Alpha UI completa con navegación** |
| 3     | ⏳ Pendiente  | Refactorización a MVC + DI           |
| 4     | ⏳ Pendiente  | Conexión a BD (JDBC)                 |
| 5     | ⏳ Pendiente  | CRUD completo funcional              |
| 6     | ⏳ Pendiente  | Empaquetado y release                |

### ¿Qué construiremos hoy?

En esta clase crearemos **todas las vistas del sistema**:

```
MainFrame (ya existe)
├── 👥 Panel de Usuarios
│   ├── Formulario (crear/editar)
│   ├── Tabla de listado
│   └── Botones (Nuevo, Guardar, Eliminar, Cancelar)
├── 📦 Panel de Productos
│   ├── Búsqueda/filtro
│   ├── Formulario con categorías
│   ├── Tabla de listado
│   └── Botones de acción
├── 💰 Panel de Ventas
│   ├── Selección de productos
│   ├── Cantidad y precio
│   ├── Detalle de la venta
│   └── Confirmar venta
├── 📊 Panel de Reportes
│   ├── Filtros de fecha
│   ├── Tabla de ventas
│   └── Total del período
└── 🎮 Panel de Eventos
    └── Pantalla informativa (placeholder)
```

**Importante:** En esta clase NO conectaremos con base de datos. Usaremos **datos mock/hardcoded** y **servicios stub** que retornan datos de ejemplo.

---

## 📚 Apartado Técnico – Conceptos Avanzados

### 🔷 1. Tipos de Listeners en Swing

En la Clase 1 solo vimos `ActionListener`. Ahora ampliaremos nuestro arsenal:

| Listener                  | Interfaz                | Métodos principales                                                                      | Uso típico                                 |
|---------------------------|-------------------------|------------------------------------------------------------------------------------------|--------------------------------------------|
| **ActionListener**        | `ActionListener`        | `actionPerformed(ActionEvent)`                                                           | Botones, menús, Enter en campos            |
| **MouseListener**         | `MouseListener`         | `mouseClicked()`, `mousePressed()`, `mouseReleased()`, `mouseEntered()`, `mouseExited()` | Clics, hover, arrastrar                    |
| **MouseAdapter**          | `MouseAdapter`          | Igual que MouseListener                                                                  | Implementar solo los métodos que necesitas |
| **KeyListener**           | `KeyListener`           | `keyPressed()`, `keyReleased()`, `keyTyped()`                                            | Detectar teclas específicas                |
| **KeyAdapter**            | `KeyAdapter`            | Igual que KeyListener                                                                    | Implementar solo métodos necesarios        |
| **DocumentListener**      | `DocumentListener`      | `insertUpdate()`, `removeUpdate()`, `changedUpdate()`                                    | Validar mientras se escribe                |
| **ListSelectionListener** | `ListSelectionListener` | `valueChanged(ListSelectionEvent)`                                                       | Selección en JTable o JList                |
| **WindowListener**        | `WindowListener`        | `windowClosing()`, `windowOpened()`, etc.                                                | Eventos de ventanas                        |
| **FocusListener**         | `FocusListener`         | `focusGained()`, `focusLost()`                                                           | Entrada/salida de componentes              |

**¿Por qué existen los "Adapter"?**

Las interfaces como `KeyListener` tienen múltiples métodos abstractos. Si solo necesitas uno, debes implementar todos igual:

```java
// ❌ Tedioso - Implementar todos los métodos
textField.addKeyListener(new KeyListener() {
    @Override
    public void keyPressed(KeyEvent e) {
        if (e.getKeyCode() == KeyEvent.VK_ENTER) {
            buscar();
        }
    }
    
    @Override
    public void keyReleased(KeyEvent e) { } // Vacío pero obligatorio
    
    @Override
    public void keyTyped(KeyEvent e) { } // Vacío pero obligatorio
});

// ✅ Mejor - Solo implementar lo que necesitas
textField.addKeyListener(new KeyAdapter() {
    @Override
    public void keyPressed(KeyEvent e) {
        if (e.getKeyCode() == KeyEvent.VK_ENTER) {
            buscar();
        }
    }
});
```

---

### 🔷 2. DocumentListener – Validación en Tiempo Real

**¿Qué es un Document en Swing?**

Cada `JTextField` y `JTextArea` tiene un **Document** que representa el texto internamente. Podemos escuchar cambios en ese documento.

**Ejemplo práctico: Búsqueda incremental**

```java
// Campo de búsqueda que filtra mientras escribes
JTextField searchField = new JTextField();

searchField.getDocument().addDocumentListener(new DocumentListener() {
    @Override
    public void insertUpdate(DocumentEvent e) {
        filtrarTabla();
    }
    
    @Override
    public void removeUpdate(DocumentEvent e) {
        filtrarTabla();
    }
    
    @Override
    public void changedUpdate(DocumentEvent e) {
        // Generalmente no se usa (es para atributos, no contenido)
    }
    
    private void filtrarTabla() {
        String texto = searchField.getText();
        // Actualizar la tabla con los resultados filtrados
        tableModel.filtrar(texto);
    }
});
```

**Casos de uso:**
- ✅ Búsqueda incremental (Google-style)
- ✅ Validación en tiempo real (mostrar error mientras escribe)
- ✅ Autocompletado
- ✅ Contador de caracteres
- ✅ Formateo automático (RUT, teléfono, etc.)

**Versión simplificada con lambda:**

```java
searchField.getDocument().addDocumentListener(new DocumentListener() {
    public void insertUpdate(DocumentEvent e) { filtrar(); }
    public void removeUpdate(DocumentEvent e) { filtrar(); }
    public void changedUpdate(DocumentEvent e) { }
    
    private void filtrar() {
        tableModel.filter(searchField.getText());
    }
});
```

---

### 🔷 3. Selección y Eventos en JTable

**¿Cómo detectar cuándo el usuario selecciona una fila?**

```java
JTable table = new JTable(tableModel);

// Obtener el modelo de selección
ListSelectionModel selectionModel = table.getSelectionModel();

// Escuchar cambios de selección
selectionModel.addListSelectionListener(e -> {
    if (!e.getValueIsAdjusting()) { // Evita eventos duplicados
        int selectedRow = table.getSelectedRow();
        
        if (selectedRow >= 0) {
            // Obtener datos de la fila seleccionada
            Object id = table.getValueAt(selectedRow, 0);
            Object nombre = table.getValueAt(selectedRow, 1);
            
            System.out.println("Seleccionado: " + id + " - " + nombre);
            
            // Cargar datos en el formulario
            cargarEnFormulario(selectedRow);
        }
    }
});
```

**Modos de selección:**

```java
// Una sola fila
table.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);

// Múltiples filas
table.setSelectionMode(ListSelectionModel.MULTIPLE_INTERVAL_SELECTION);

// Rango continuo
table.setSelectionMode(ListSelectionModel.SINGLE_INTERVAL_SELECTION);
```

**Doble clic para editar:**

```java
table.addMouseListener(new MouseAdapter() {
    @Override
    public void mouseClicked(MouseEvent e) {
        if (e.getClickCount() == 2) { // Doble clic
            int row = table.getSelectedRow();
            if (row >= 0) {
                editarRegistro(row);
            }
        }
    }
});
```

---

### 🔷 4. CardLayout – Sistema de Navegación

**¿Qué es CardLayout?**

Es un gestor de diseño que muestra **un solo componente a la vez**, como un mazo de cartas donde solo ves la carta superior.

**Ventajas:**
- ✅ Todas las vistas están pre-cargadas en memoria
- ✅ Cambio instantáneo entre vistas
- ✅ Perfecto para aplicaciones con pocas vistas (< 10)
- ✅ Simple de implementar

**Implementación básica:**

```java
public class MainFrame extends JFrame {
    private JPanel contentPanel;  // Panel que contiene las vistas
    private CardLayout cardLayout; // Gestor de diseño
    
    public MainFrame() {
        initComponents();
        setupNavigation();
    }
    
    private void setupNavigation() {
        // Crear el CardLayout
        cardLayout = new CardLayout();
        contentPanel = new JPanel(cardLayout);
        
        // Agregar las vistas con nombres únicos
        contentPanel.add(new UsuariosPanel(), "USUARIOS");
        contentPanel.add(new ProductosPanel(), "PRODUCTOS");
        contentPanel.add(new VentasPanel(), "VENTAS");
        contentPanel.add(new ReportesPanel(), "REPORTES");
        contentPanel.add(new EventosPanel(), "EVENTOS");
        
        // Agregar el contentPanel al centro del MainFrame
        add(contentPanel, BorderLayout.CENTER);
        
        // Mostrar la vista inicial
        cardLayout.show(contentPanel, "PRODUCTOS");
    }
    
    // Método para cambiar de vista
    public void mostrarVista(String nombreVista) {
        cardLayout.show(contentPanel, nombreVista);
    }
}
```

**Conectar con el menú:**

```java
private void menuUsuariosActionPerformed(ActionEvent evt) {
    mostrarVista("USUARIOS");
}

private void menuProductosActionPerformed(ActionEvent evt) {
    mostrarVista("PRODUCTOS");
}
```

---

### 🔷 5. JDesktopPane y JInternalFrame

**Alternativa a CardLayout:** Ventanas internas estilo MDI (Multiple Document Interface)

**¿Cuándo usar JDesktopPane?**
- Cuando necesitas múltiples ventanas abiertas simultáneamente
- Estilo "oficina" con ventanas flotantes
- Aplicaciones complejas tipo IDE

**Implementación básica:**

```java
public class MainFrame extends JFrame {
    private JDesktopPane desktopPane;
    
    public MainFrame() {
        initComponents();
        
        desktopPane = new JDesktopPane();
        add(desktopPane, BorderLayout.CENTER);
    }
    
    private void abrirUsuarios() {
        UsuariosInternalFrame frame = new UsuariosInternalFrame();
        desktopPane.add(frame);
        frame.setVisible(true);
        
        // Centrar en el desktop
        try {
            frame.setSelected(true);
        } catch (PropertyVetoException e) {
            e.printStackTrace();
        }
    }
}

// Vista como JInternalFrame
public class UsuariosInternalFrame extends JInternalFrame {
    public UsuariosInternalFrame() {
        super("Gestión de Usuarios", true, true, true, true);
        // true = resizable, closable, maximizable, iconifiable
        
        setSize(800, 600);
        setLocation(30, 30);
        
        // Agregar componentes...
    }
}
```

**Comparación:**

| Característica | CardLayout | JDesktopPane |
|----------------|------------|--------------|
| Simplicidad | ✅ Muy simple | ⚠️ Más complejo |
| Múltiples vistas simultáneas | ❌ No | ✅ Sí |
| Uso de memoria | ⚠️ Todas en RAM | ✅ Solo abiertas |
| Look & Feel moderno | ✅ Limpio | ⚠️ Retro/corporativo |
| Recomendado para este proyecto | ✅ Sí | ⏸️ Opcional |

**Para este proyecto usaremos CardLayout** por simplicidad y porque se adapta mejor a aplicaciones modernas.

---

### 🔷 6. AbstractTableModel Personalizado

**¿Por qué no usar DefaultTableModel?**

`DefaultTableModel` es conveniente pero limitado:
- ❌ Todas las celdas son editables por defecto
- ❌ No tiene tipado (todo es Object)
- ❌ Difícil controlar qué columnas son editables
- ❌ No se integra bien con objetos de dominio

**Solución: Crear nuestro propio TableModel**

```java
public class ProductoTableModel extends AbstractTableModel {
    private List<Producto> productos;
    private String[] columnNames = {"ID", "Nombre", "Categoría", "Precio", "Activo"};
    
    public ProductoTableModel() {
        this.productos = new ArrayList<>();
    }
    
    public void setProductos(List<Producto> productos) {
        this.productos = productos;
        fireTableDataChanged(); // Notifica que los datos cambiaron
    }
    
    public void addProducto(Producto producto) {
        productos.add(producto);
        fireTableRowsInserted(productos.size() - 1, productos.size() - 1);
    }
    
    public void removeProducto(int row) {
        productos.remove(row);
        fireTableRowsDeleted(row, row);
    }
    
    public Producto getProductoAt(int row) {
        return productos.get(row);
    }
    
    @Override
    public int getRowCount() {
        return productos.size();
    }
    
    @Override
    public int getColumnCount() {
        return columnNames.length;
    }
    
    @Override
    public String getColumnName(int column) {
        return columnNames[column];
    }
    
    @Override
    public Object getValueAt(int row, int column) {
        Producto p = productos.get(row);
        switch (column) {
            case 0: return p.getId();
            case 1: return p.getNombre();
            case 2: return p.getCategoria();
            case 3: return String.format("$%,.0f", p.getPrecio());
            case 4: return p.isActivo() ? "Sí" : "No";
            default: return null;
        }
    }
    
    @Override
    public Class<?> getColumnClass(int column) {
        switch (column) {
            case 0: return Integer.class;
            case 1: return String.class;
            case 2: return String.class;
            case 3: return String.class;
            case 4: return String.class;
            default: return Object.class;
        }
    }
    
    @Override
    public boolean isCellEditable(int row, int column) {
        return false; // Ninguna celda editable directamente en la tabla
    }
}
```

**Uso:**

```java
ProductoTableModel tableModel = new ProductoTableModel();
JTable table = new JTable(tableModel);

// Cargar datos
List<Producto> productos = productoService.listarTodos();
tableModel.setProductos(productos);
```

**Ventajas:**
- ✅ Control total sobre qué mostrar y cómo
- ✅ Tipado fuerte
- ✅ Fácil mantener sincronizado con objetos de dominio
- ✅ Formateo personalizado (precios, fechas, etc.)

---

### 🔷 7. Patrón Observer en Profundidad

**Swing está construido sobre el patrón Observer**

```
┌─────────────────┐         ┌──────────────────┐
│   Observable    │ ──────> │    Observer      │
│   (Subject)     │         │   (Listener)     │
└─────────────────┘         └──────────────────┘
      │                              │
      │ notifyObservers()            │ update()
      │                              │
┌─────────────────┐         ┌──────────────────┐
│    JButton      │ ──────> │ ActionListener   │
│ (genera evento) │         │ (responde)       │
└─────────────────┘         └──────────────────┘
```

**Flujo completo:**

1. **Usuario hace clic** en un botón
2. **JButton genera** un `ActionEvent`
3. **Swing notifica** a todos los `ActionListener` registrados
4. **Cada listener** ejecuta su método `actionPerformed()`
5. **La UI se actualiza** basándose en las acciones realizadas

**Implementación del patrón en nuestro código:**

```java
// 1. El botón es el Subject (Observable)
JButton btnGuardar = new JButton("Guardar");

// 2. Registramos un Observer (Listener)
btnGuardar.addActionListener(new ActionListener() {
    @Override
    public void actionPerformed(ActionEvent e) {
        // 3. Este método se ejecuta cuando se dispara el evento
        guardarProducto();
    }
});

// Versión con lambda (más concisa)
btnGuardar.addActionListener(e -> guardarProducto());
```

**¿Por qué es importante entender esto?**

En la Clase 3, implementaremos nuestro propio Observer personalizado para comunicar cambios entre vistas y controladores.

---

### 🔷 8. Validaciones: UI vs Backend

**Defensa en profundidad: Validar en múltiples capas**

| Capa | Propósito | Ejemplo |
|------|-----------|---------|
| **UI (Vista)** | Feedback inmediato, experiencia de usuario | Campo vacío → borde rojo |
| **Controller** | Validaciones de negocio ligeras | Precio > 0 |
| **Service** | Reglas de negocio complejas | Usuario no duplicado |
| **Repository** | Restricciones de BD | UNIQUE constraints |

**Ejemplo práctico: Validar nombre de producto**

```java
// 1. Validación en UI (inmediata)
txtNombre.getDocument().addDocumentListener(new DocumentListener() {
    public void insertUpdate(DocumentEvent e) { validar(); }
    public void removeUpdate(DocumentEvent e) { validar(); }
    public void changedUpdate(DocumentEvent e) { }
    
    private void validar() {
        String nombre = txtNombre.getText().trim();
        if (nombre.isEmpty()) {
            txtNombre.setBorder(BorderFactory.createLineBorder(Color.RED));
            lblError.setText("El nombre es obligatorio");
        } else if (nombre.length() < 3) {
            txtNombre.setBorder(BorderFactory.createLineBorder(Color.ORANGE));
            lblError.setText("El nombre debe tener al menos 3 caracteres");
        } else {
            txtNombre.setBorder(BorderFactory.createLineBorder(Color.GREEN));
            lblError.setText("");
        }
    }
});

// 2. Validación antes de guardar (Controller/Service - Clase 3)
private boolean validarFormulario() {
    String nombre = txtNombre.getText().trim();
    String precioStr = txtPrecio.getText().trim();
    
    if (nombre.isEmpty()) {
        JOptionPane.showMessageDialog(this, "El nombre es obligatorio", 
            "Validación", JOptionPane.WARNING_MESSAGE);
        txtNombre.requestFocus();
        return false;
    }
    
    if (nombre.length() < 3) {
        JOptionPane.showMessageDialog(this, "El nombre debe tener al menos 3 caracteres", 
            "Validación", JOptionPane.WARNING_MESSAGE);
        txtNombre.requestFocus();
        return false;
    }
    
    try {
        double precio = Double.parseDouble(precioStr);
        if (precio <= 0) {
            throw new NumberFormatException();
        }
    } catch (NumberFormatException e) {
        JOptionPane.showMessageDialog(this, "El precio debe ser un número mayor a 0", 
            "Validación", JOptionPane.WARNING_MESSAGE);
        txtPrecio.requestFocus();
        return false;
    }
    
    return true;
}
```

**Regla de oro:**
- ✅ Validar en UI para UX (feedback rápido)
- ✅ Validar en backend para seguridad (nunca confiar en el cliente)

---

### 🔷 9. Stub Services – Preparación para MVC

**¿Qué es un stub?**

Un **stub** (boceto/simulador) es una implementación temporal que retorna datos hardcodeados sin lógica real.

**¿Por qué usar stubs?**

- ✅ Permite desarrollar la UI sin esperar la BD
- ✅ Facilita las pruebas
- ✅ Define el contrato (interfaz) que luego implementaremos
- ✅ Permite trabajar en paralelo (un dev hace UI, otro hace DAO)

**Ejemplo: Servicio de Productos**

**Paso 1: Definir la interfaz (contrato)**

```java
package cl.tuusuario.pnb.service;

import cl.tuusuario.pnb.model.Producto;
import java.util.List;

public interface ProductoService {
    List<Producto> listarTodos();
    Producto buscarPorId(int id);
    List<Producto> buscarPorNombre(String nombre);
    void guardar(Producto producto);
    void actualizar(Producto producto);
    void eliminar(int id);
    void cambiarEstado(int id, boolean activo);
}
```

**Paso 2: Implementación stub (simulada)**

```java
package cl.tuusuario.pnb.service.impl;

import cl.tuusuario.pnb.model.Producto;
import cl.tuusuario.pnb.service.ProductoService;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class ProductoServiceStub implements ProductoService {
    private List<Producto> productos;
    private int nextId;
    
    public ProductoServiceStub() {
        this.productos = new ArrayList<>();
        this.nextId = 1;
        cargarDatosIniciales();
    }
    
    private void cargarDatosIniciales() {
        productos.add(new Producto(nextId++, "Espresso", "BEBIDA", "CAFE", 2500.0, true));
        productos.add(new Producto(nextId++, "Cappuccino", "BEBIDA", "CAFE", 3000.0, true));
        productos.add(new Producto(nextId++, "Brownie", "SNACK", "POSTRE", 2000.0, true));
        productos.add(new Producto(nextId++, "15 minutos", "TIEMPO", "ARCADE", 1500.0, true));
        productos.add(new Producto(nextId++, "30 minutos", "TIEMPO", "ARCADE", 2500.0, true));
    }
    
    @Override
    public List<Producto> listarTodos() {
        return new ArrayList<>(productos);
    }
    
    @Override
    public Producto buscarPorId(int id) {
        return productos.stream()
            .filter(p -> p.getId() == id)
            .findFirst()
            .orElse(null);
    }
    
    @Override
    public List<Producto> buscarPorNombre(String nombre) {
        String nombreLower = nombre.toLowerCase();
        return productos.stream()
            .filter(p -> p.getNombre().toLowerCase().contains(nombreLower))
            .collect(Collectors.toList());
    }
    
    @Override
    public void guardar(Producto producto) {
        producto.setId(nextId++);
        productos.add(producto);
        System.out.println("[STUB] Producto guardado: " + producto);
    }
    
    @Override
    public void actualizar(Producto producto) {
        for (int i = 0; i < productos.size(); i++) {
            if (productos.get(i).getId() == producto.getId()) {
                productos.set(i, producto);
                System.out.println("[STUB] Producto actualizado: " + producto);
                return;
            }
        }
    }
    
    @Override
    public void eliminar(int id) {
        productos.removeIf(p -> p.getId() == id);
        System.out.println("[STUB] Producto eliminado: " + id);
    }
    
    @Override
    public void cambiarEstado(int id, boolean activo) {
        Producto producto = buscarPorId(id);
        if (producto != null) {
            producto.setActivo(activo);
            System.out.println("[STUB] Estado cambiado: " + id + " -> " + activo);
        }
    }
}
```

**Paso 3: Usar en la vista**

```java
public class ProductosPanel extends JPanel {
    private ProductoService productoService;
    private ProductoTableModel tableModel;
    
    public ProductosPanel() {
        // Por ahora, crear el stub directamente
        // En Clase 3, lo inyectaremos desde AppContext
        this.productoService = new ProductoServiceStub();
        
        initComponents();
        cargarProductos();
    }
    
    private void cargarProductos() {
        List<Producto> productos = productoService.listarTodos();
        tableModel.setProductos(productos);
    }
    
    private void btnGuardarActionPerformed(ActionEvent evt) {
        if (!validarFormulario()) {
            return;
        }
        
        Producto producto = construirProductoDesdeFormulario();
        
        if (producto.getId() == 0) {
            // Nuevo
            productoService.guardar(producto);
        } else {
            // Actualizar
            productoService.actualizar(producto);
        }
        
        cargarProductos();
        limpiarFormulario();
        JOptionPane.showMessageDialog(this, "Producto guardado exitosamente");
    }
}
```

**Ventajas del enfoque:**
- ✅ La vista no sabe si los datos vienen de memoria o BD
- ✅ En Clase 4, solo cambiamos la implementación
- ✅ Código testeable desde ahora
- ✅ Interfaz clara del API

---

### 🔷 10. KeyAdapter y Atajos de Teclado

**Mejorar la productividad con shortcuts**

```java
// Enter en un campo de texto ejecuta búsqueda
txtBuscar.addKeyListener(new KeyAdapter() {
    @Override
    public void keyPressed(KeyEvent e) {
        if (e.getKeyCode() == KeyEvent.VK_ENTER) {
            buscar();
        }
    }
});

// Escape cierra el diálogo
dialog.addKeyListener(new KeyAdapter() {
    @Override
    public void keyPressed(KeyEvent e) {
        if (e.getKeyCode() == KeyEvent.VK_ESCAPE) {
            dialog.dispose();
        }
    }
});

// Ctrl+S guarda
panel.getInputMap(JComponent.WHEN_IN_FOCUSED_WINDOW)
    .put(KeyStroke.getKeyStroke(KeyEvent.VK_S, KeyEvent.CTRL_DOWN_MASK), "guardar");
panel.getActionMap().put("guardar", new AbstractAction() {
    @Override
    public void actionPerformed(ActionEvent e) {
        guardar();
    }
});
```

---

## 🎯 Resumen Técnico

| Concepto | Uso en el proyecto | Importancia |
|----------|-------------------|-------------|
| **ActionListener** | Botones y menús | ⭐⭐⭐⭐⭐ |
| **DocumentListener** | Búsqueda incremental, validación en tiempo real | ⭐⭐⭐⭐ |
| **ListSelectionListener** | Detectar selección en JTable | ⭐⭐⭐⭐⭐ |
| **CardLayout** | Navegación entre vistas | ⭐⭐⭐⭐⭐ |
| **AbstractTableModel** | Modelos personalizados de tablas | ⭐⭐⭐⭐⭐ |
| **MouseAdapter** | Doble clic para editar | ⭐⭐⭐ |
| **KeyAdapter** | Atajos de teclado | ⭐⭐⭐ |
| **Stub Services** | Desarrollo sin BD, contratos claros | ⭐⭐⭐⭐⭐ |
| **Validaciones UI** | Feedback inmediato al usuario | ⭐⭐⭐⭐ |

---

## 💡 Siguiente Paso

Ahora que comprendes los conceptos técnicos, estás listo para la parte práctica:

➡️ **[02-layouts-views.md](02-layouts-views.md)** – Creación de todas las vistas del sistema (40 min)

---

> 🧠 *"El código que nunca se ejecuta es código que no funciona. Empieza simple, itera rápido."*

