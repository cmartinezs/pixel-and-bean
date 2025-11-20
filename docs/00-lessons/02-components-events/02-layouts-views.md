# 🎨 Clase 2 (Parte 2) – Creación de Layouts y Vistas

**Objetivo:**  
Crear todas las vistas del sistema con sus componentes, formularios y tablas, implementando el sistema de navegación con CardLayout.

⏱️ **Duración estimada:** 40 minutos

**Distribución del tiempo:**
- Sistema de navegación en MainFrame (5 min)
- Vista de Gestión de Usuarios (8 min)
- Vista de Gestión de Productos (8 min)
- Vista de Ventas (10 min)
- Vista de Reportes (6 min)
- Vista de Eventos (3 min)

> 📌 **Pre-requisito:**  
> Antes de comenzar esta parte práctica, asegúrate de haber leído y comprendido los conceptos técnicos en **[01-technical-concepts.md](01-technical-concepts.md)**.

<!-- TOC -->
* [🎨 Clase 2 (Parte 2) – Creación de Layouts y Vistas](#-clase-2-parte-2--creación-de-layouts-y-vistas)
  * [🗂️ Estructura de esta sesión](#-estructura-de-esta-sesión)
  * [📦 Paso 0 – Preparación: Crear el modelo de datos](#-paso-0--preparación-crear-el-modelo-de-datos)
  * [🔄 Paso 1 – Implementar sistema de navegación en MainFrame](#-paso-1--implementar-sistema-de-navegación-en-mainframe)
  * [👥 Paso 2 – Crear vista de Gestión de Usuarios](#-paso-2--crear-vista-de-gestión-de-usuarios)
  * [📦 Paso 3 – Crear vista de Gestión de Productos](#-paso-3--crear-vista-de-gestión-de-productos)
  * [💰 Paso 4 – Crear vista de Ventas](#-paso-4--crear-vista-de-ventas)
  * [📊 Paso 5 – Crear vista de Reportes](#-paso-5--crear-vista-de-reportes)
  * [🎮 Paso 6 – Crear vista de Eventos (Placeholder)](#-paso-6--crear-vista-de-eventos-placeholder)
  * [✅ Resultado de esta parte](#-resultado-de-esta-parte)
  * [💡 Siguiente Paso](#-siguiente-paso)
<!-- TOC -->

---

## 🗂️ Estructura de esta sesión

| Vista | Componentes principales | Tiempo | Complejidad |
|-------|------------------------|--------|-------------|
| MainFrame | CardLayout, navegación | 5 min | ⭐ |
| Usuarios | Formulario + JTable + CRUD | 8 min | ⭐⭐⭐ |
| Productos | Búsqueda + Formulario + JTable | 8 min | ⭐⭐⭐⭐ |
| Ventas | Selección + Detalle + Total | 10 min | ⭐⭐⭐⭐⭐ |
| Reportes | Filtros + JTable + Totales | 6 min | ⭐⭐⭐ |
| Eventos | Panel informativo | 3 min | ⭐ |

---

## 📦 Paso 0 – Preparación: Crear el modelo de datos

Antes de crear las vistas, necesitamos las clases de modelo (POJOs).

### Crear el paquete `model`:

```
Source Packages/
└── cl.tuusuario.pnb/
    ├── model/              ← Nuevo paquete
    ├── gui/
    └── PixelAndBean.java
```

### Clase: Usuario.java

```java
package cl.tuusuario.pnb.model;

public class Usuario {
    private int id;
    private String username;
    private String password;
    private String nombreCompleto;
    private String rol; // "ADMIN" o "OPERADOR"
    private boolean activo;
    
    // Constructor vacío
    public Usuario() {
    }
    
    // Constructor completo
    public Usuario(int id, String username, String password, String nombreCompleto, 
                   String rol, boolean activo) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.nombreCompleto = nombreCompleto;
        this.rol = rol;
        this.activo = activo;
    }
    
    // Getters y Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    
    public String getNombreCompleto() { return nombreCompleto; }
    public void setNombreCompleto(String nombreCompleto) { this.nombreCompleto = nombreCompleto; }
    
    public String getRol() { return rol; }
    public void setRol(String rol) { this.rol = rol; }
    
    public boolean isActivo() { return activo; }
    public void setActivo(boolean activo) { this.activo = activo; }
    
    @Override
    public String toString() {
        return "Usuario{id=" + id + ", username='" + username + "', rol='" + rol + "'}";
    }
}
```

### Clase: Producto.java

```java
package cl.tuusuario.pnb.model;

public class Producto {
    private int id;
    private String nombre;
    private String categoria; // BEBIDA, SNACK, TIEMPO
    private String tipo; // Específico de cada categoría
    private double precio;
    private boolean activo;
    
    // Constructor vacío
    public Producto() {
    }
    
    // Constructor completo
    public Producto(int id, String nombre, String categoria, String tipo, 
                    double precio, boolean activo) {
        this.id = id;
        this.nombre = nombre;
        this.categoria = categoria;
        this.tipo = tipo;
        this.precio = precio;
        this.activo = activo;
    }
    
    // Getters y Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    
    public String getCategoria() { return categoria; }
    public void setCategoria(String categoria) { this.categoria = categoria; }
    
    public String getTipo() { return tipo; }
    public void setTipo(String tipo) { this.tipo = tipo; }
    
    public double getPrecio() { return precio; }
    public void setPrecio(double precio) { this.precio = precio; }
    
    public boolean isActivo() { return activo; }
    public void setActivo(boolean activo) { this.activo = activo; }
    
    @Override
    public String toString() {
        return nombre + " - $" + String.format("%,.0f", precio);
    }
}
```

### Clase: Venta.java (simplificada para esta clase)

```java
package cl.tuusuario.pnb.model;

import java.time.LocalDateTime;

public class Venta {
    private int id;
    private LocalDateTime fechaHora;
    private int usuarioId;
    private String usuarioNombre;
    private double total;
    private String estado; // "ACTIVA" o "ANULADA"
    
    // Constructor vacío
    public Venta() {
    }
    
    // Constructor completo
    public Venta(int id, LocalDateTime fechaHora, int usuarioId, String usuarioNombre,
                 double total, String estado) {
        this.id = id;
        this.fechaHora = fechaHora;
        this.usuarioId = usuarioId;
        this.usuarioNombre = usuarioNombre;
        this.total = total;
        this.estado = estado;
    }
    
    // Getters y Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public LocalDateTime getFechaHora() { return fechaHora; }
    public void setFechaHora(LocalDateTime fechaHora) { this.fechaHora = fechaHora; }
    
    public int getUsuarioId() { return usuarioId; }
    public void setUsuarioId(int usuarioId) { this.usuarioId = usuarioId; }
    
    public String getUsuarioNombre() { return usuarioNombre; }
    public void setUsuarioNombre(String usuarioNombre) { this.usuarioNombre = usuarioNombre; }
    
    public double getTotal() { return total; }
    public void setTotal(double total) { this.total = total; }
    
    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }
    
    @Override
    public String toString() {
        return "Venta #" + id + " - $" + String.format("%,.0f", total);
    }
}
```

---

## 🔄 Paso 1 – Implementar sistema de navegación en MainFrame

Vamos a modificar el `MainFrame` que creamos en la Clase 1 para agregar el sistema de navegación con CardLayout.

### Modificar MainFrame.java:

**En el editor visual de NetBeans:**

1. Abre `MainFrame.java` en modo **Design**.
2. **Elimina** cualquier panel central que pueda existir.
3. Arrastra un **JPanel** al centro (BorderLayout.CENTER).
4. Cambia el nombre de la variable a `contentPanel`.

**En el código (pestaña Source):**

```java
package cl.tuusuario.pnb.gui;

import javax.swing.*;
import java.awt.*;

public class MainFrame extends JFrame {
    private JPanel contentPanel;
    private CardLayout cardLayout;
    
    public MainFrame() {
        initComponents(); // Generado por NetBeans
        setupNavigation();
        setLocationRelativeTo(null);
    }
    
    private void setupNavigation() {
        // Inicializar CardLayout
        cardLayout = new CardLayout();
        contentPanel.setLayout(cardLayout);
        
        // Crear y agregar las vistas
        contentPanel.add(createHomePanel(), "HOME");
        contentPanel.add(new UsuariosPanel(), "USUARIOS");
        contentPanel.add(new ProductosPanel(), "PRODUCTOS");
        contentPanel.add(new VentasPanel(), "VENTAS");
        contentPanel.add(new ReportesPanel(), "REPORTES");
        contentPanel.add(new EventosPanel(), "EVENTOS");
        
        // Mostrar pantalla inicial
        mostrarVista("HOME");
    }
    
    private JPanel createHomePanel() {
        JPanel panel = new JPanel(new GridBagLayout());
        JLabel label = new JLabel("<html><center>" +
            "<h1>☕🎮 Pixel & Bean</h1>" +
            "<p>Sistema de Gestión para Café-Arcade</p>" +
            "<p style='margin-top: 20px;'>Selecciona una opción del menú superior para comenzar</p>" +
            "</center></html>");
        label.setHorizontalAlignment(SwingConstants.CENTER);
        panel.add(label);
        return panel;
    }
    
    public void mostrarVista(String nombreVista) {
        cardLayout.show(contentPanel, nombreVista);
    }
    
    // Métodos generados por NetBeans para los menús
    private void menuUsuariosActionPerformed(java.awt.event.ActionEvent evt) {
        mostrarVista("USUARIOS");
    }
    
    private void menuProductosActionPerformed(java.awt.event.ActionEvent evt) {
        mostrarVista("PRODUCTOS");
    }
    
    private void menuVentasActionPerformed(java.awt.event.ActionEvent evt) {
        mostrarVista("VENTAS");
    }
    
    private void menuVentasDelDiaActionPerformed(java.awt.event.ActionEvent evt) {
        mostrarVista("REPORTES");
    }
    
    private void menuTorneosActionPerformed(java.awt.event.ActionEvent evt) {
        mostrarVista("EVENTOS");
    }
    
    private void menuCerrarSesionActionPerformed(java.awt.event.ActionEvent evt) {
        int respuesta = JOptionPane.showConfirmDialog(this,
            "¿Estás seguro de que deseas cerrar sesión?",
            "Confirmar",
            JOptionPane.YES_NO_OPTION);
        
        if (respuesta == JOptionPane.YES_OPTION) {
            this.dispose();
            // Aquí abriremos el Login nuevamente en clases futuras
            new cl.tuusuario.pnb.gui.LoginFrame().setVisible(true);
        }
    }
    
    private void menuSalirActionPerformed(java.awt.event.ActionEvent evt) {
        int respuesta = JOptionPane.showConfirmDialog(this,
            "¿Estás seguro de que deseas salir?",
            "Confirmar salida",
            JOptionPane.YES_NO_OPTION);
        
        if (respuesta == JOptionPane.YES_OPTION) {
            System.exit(0);
        }
    }
    
    private void menuAcercaDeActionPerformed(java.awt.event.ActionEvent evt) {
        JOptionPane.showMessageDialog(this,
            "<html><center>" +
            "<h2>Pixel & Bean</h2>" +
            "<p>Sistema de Gestión para Café-Arcade</p>" +
            "<p>Versión 1.0.0</p>" +
            "<p style='margin-top: 10px;'>Desarrollado por: Tu Nombre</p>" +
            "<p>Asignatura: Programación Orientada a Objetos</p>" +
            "<p>Año: 2025</p>" +
            "</center></html>",
            "Acerca de",
            JOptionPane.INFORMATION_MESSAGE);
    }
}
```

**Conectar los menús con los eventos:**

En el editor visual de NetBeans:
1. Selecciona cada ítem del menú
2. Pestaña **Events** → **Action → actionPerformed**
3. Asigna el método correspondiente

---

## 👥 Paso 2 – Crear vista de Gestión de Usuarios

### Crear UsuariosPanel.java:

1. **Clic derecho** sobre `cl.tuusuario.pnb.gui` → **New → JPanel Form**
2. **Class Name:** `UsuariosPanel`
3. **Finish**

### Diseño de la interfaz:

El panel se dividirá en tres secciones usando BorderLayout:

```
┌─────────────────────────────────────────────┐
│  NORTH: Panel de búsqueda y botón Nuevo     │
├─────────────────────────────────────────────┤
│                                             │
│  CENTER: JScrollPane con JTable             │
│  (Listado de usuarios)                      │
│                                             │
├─────────────────────────────────────────────┤
│  SOUTH: Panel de formulario                 │
│  [Username] [Password] [Nombre] [Rol]       │
│  [Guardar] [Cancelar] [Eliminar]            │
└─────────────────────────────────────────────┘
```

### En el editor visual:

1. Cambia el Layout del panel principal a **BorderLayout**

2. **Panel Norte** (búsqueda):
   - Arrastra un JPanel → BorderLayout.NORTH
   - Layout: FlowLayout (izquierda)
   - Componentes:
     - JLabel: "Buscar:"
     - JTextField: `txtBuscar` (ancho: 200px)
     - JButton: `btnNuevo` ("Nuevo Usuario")

3. **Panel Centro** (tabla):
   - Arrastra un JScrollPane → BorderLayout.CENTER
   - Dentro arrastra una JTable → `tblUsuarios`

4. **Panel Sur** (formulario):
   - Arrastra un JPanel → BorderLayout.SOUTH
   - Layout: GridBagLayout o GroupLayout
   - Componentes:
     - JLabel: "Username:" + JTextField: `txtUsername`
     - JLabel: "Password:" + JPasswordField: `txtPassword`
     - JLabel: "Nombre Completo:" + JTextField: `txtNombreCompleto`
     - JLabel: "Rol:" + JComboBox: `cmbRol` (items: ADMIN, OPERADOR)
     - JCheckBox: `chkActivo` ("Usuario Activo")
     - JButton: `btnGuardar` ("Guardar")
     - JButton: `btnCancelar` ("Cancelar")
     - JButton: `btnEliminar` ("Eliminar")

### Código en UsuariosPanel.java:

```java
package cl.tuusuario.pnb.gui;

import cl.tuusuario.pnb.model.Usuario;
import javax.swing.*;
import javax.swing.table.AbstractTableModel;
import java.awt.*;
import java.util.ArrayList;
import java.util.List;

public class UsuariosPanel extends JPanel {
    // Componentes (generados por NetBeans)
    // ...
    
    private UsuarioTableModel tableModel;
    private Usuario usuarioSeleccionado;
    
    public UsuariosPanel() {
        initComponents(); // Generado por NetBeans
        setupTable();
        setupListeners();
        cargarUsuarios();
        limpiarFormulario();
    }
    
    private void setupTable() {
        tableModel = new UsuarioTableModel();
        tblUsuarios.setModel(tableModel);
        tblUsuarios.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
        
        // Configurar anchos de columnas
        tblUsuarios.getColumnModel().getColumn(0).setPreferredWidth(50);  // ID
        tblUsuarios.getColumnModel().getColumn(1).setPreferredWidth(100); // Username
        tblUsuarios.getColumnModel().getColumn(2).setPreferredWidth(200); // Nombre
        tblUsuarios.getColumnModel().getColumn(3).setPreferredWidth(80);  // Rol
        tblUsuarios.getColumnModel().getColumn(4).setPreferredWidth(60);  // Activo
    }
    
    private void setupListeners() {
        // Selección en tabla
        tblUsuarios.getSelectionModel().addListSelectionListener(e -> {
            if (!e.getValueIsAdjusting()) {
                int selectedRow = tblUsuarios.getSelectedRow();
                if (selectedRow >= 0) {
                    usuarioSeleccionado = tableModel.getUsuarioAt(selectedRow);
                    cargarEnFormulario(usuarioSeleccionado);
                }
            }
        });
        
        // Doble clic para editar
        tblUsuarios.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                if (evt.getClickCount() == 2) {
                    int row = tblUsuarios.getSelectedRow();
                    if (row >= 0) {
                        usuarioSeleccionado = tableModel.getUsuarioAt(row);
                        cargarEnFormulario(usuarioSeleccionado);
                        txtUsername.requestFocus();
                    }
                }
            }
        });
        
        // Búsqueda en tiempo real
        txtBuscar.getDocument().addDocumentListener(new javax.swing.event.DocumentListener() {
            public void insertUpdate(javax.swing.event.DocumentEvent e) { filtrar(); }
            public void removeUpdate(javax.swing.event.DocumentEvent e) { filtrar(); }
            public void changedUpdate(javax.swing.event.DocumentEvent e) { }
            
            private void filtrar() {
                String texto = txtBuscar.getText();
                // TODO: Implementar filtro en próxima parte
            }
        });
    }
    
    private void cargarUsuarios() {
        // Datos de ejemplo (stub)
        List<Usuario> usuarios = new ArrayList<>();
        usuarios.add(new Usuario(1, "admin", "admin123", "Administrador del Sistema", "ADMIN", true));
        usuarios.add(new Usuario(2, "operador", "op123", "Juan Pérez", "OPERADOR", true));
        usuarios.add(new Usuario(3, "cajero", "caj123", "María González", "OPERADOR", true));
        
        tableModel.setUsuarios(usuarios);
    }
    
    private void cargarEnFormulario(Usuario usuario) {
        txtUsername.setText(usuario.getUsername());
        txtPassword.setText(usuario.getPassword());
        txtNombreCompleto.setText(usuario.getNombreCompleto());
        cmbRol.setSelectedItem(usuario.getRol());
        chkActivo.setSelected(usuario.isActivo());
        
        btnEliminar.setEnabled(true);
    }
    
    private void limpiarFormulario() {
        usuarioSeleccionado = null;
        txtUsername.setText("");
        txtPassword.setText("");
        txtNombreCompleto.setText("");
        cmbRol.setSelectedIndex(0);
        chkActivo.setSelected(true);
        btnEliminar.setEnabled(false);
        txtUsername.requestFocus();
    }
    
    // Eventos de botones (conectar en NetBeans)
    private void btnNuevoActionPerformed(java.awt.event.ActionEvent evt) {
        limpiarFormulario();
    }
    
    private void btnGuardarActionPerformed(java.awt.event.ActionEvent evt) {
        if (!validarFormulario()) {
            return;
        }
        
        String username = txtUsername.getText().trim();
        String password = new String(txtPassword.getPassword());
        String nombreCompleto = txtNombreCompleto.getText().trim();
        String rol = (String) cmbRol.getSelectedItem();
        boolean activo = chkActivo.isSelected();
        
        if (usuarioSeleccionado == null) {
            // Nuevo usuario
            Usuario nuevo = new Usuario(0, username, password, nombreCompleto, rol, activo);
            // TODO: Guardar en servicio
            System.out.println("[STUB] Guardando usuario: " + nuevo);
            JOptionPane.showMessageDialog(this, "Usuario guardado exitosamente");
        } else {
            // Actualizar
            usuarioSeleccionado.setUsername(username);
            usuarioSeleccionado.setPassword(password);
            usuarioSeleccionado.setNombreCompleto(nombreCompleto);
            usuarioSeleccionado.setRol(rol);
            usuarioSeleccionado.setActivo(activo);
            // TODO: Actualizar en servicio
            System.out.println("[STUB] Actualizando usuario: " + usuarioSeleccionado);
            JOptionPane.showMessageDialog(this, "Usuario actualizado exitosamente");
        }
        
        limpiarFormulario();
        cargarUsuarios();
    }
    
    private void btnCancelarActionPerformed(java.awt.event.ActionEvent evt) {
        limpiarFormulario();
    }
    
    private void btnEliminarActionPerformed(java.awt.event.ActionEvent evt) {
        if (usuarioSeleccionado == null) {
            return;
        }
        
        int respuesta = JOptionPane.showConfirmDialog(this,
            "¿Estás seguro de eliminar el usuario '" + usuarioSeleccionado.getUsername() + "'?",
            "Confirmar eliminación",
            JOptionPane.YES_NO_OPTION);
        
        if (respuesta == JOptionPane.YES_OPTION) {
            // TODO: Eliminar en servicio
            System.out.println("[STUB] Eliminando usuario: " + usuarioSeleccionado);
            JOptionPane.showMessageDialog(this, "Usuario eliminado exitosamente");
            limpiarFormulario();
            cargarUsuarios();
        }
    }
    
    private boolean validarFormulario() {
        if (txtUsername.getText().trim().isEmpty()) {
            JOptionPane.showMessageDialog(this, "El username es obligatorio", 
                "Validación", JOptionPane.WARNING_MESSAGE);
            txtUsername.requestFocus();
            return false;
        }
        
        if (txtPassword.getPassword().length == 0) {
            JOptionPane.showMessageDialog(this, "La contraseña es obligatoria", 
                "Validación", JOptionPane.WARNING_MESSAGE);
            txtPassword.requestFocus();
            return false;
        }
        
        if (txtNombreCompleto.getText().trim().isEmpty()) {
            JOptionPane.showMessageDialog(this, "El nombre completo es obligatorio", 
                "Validación", JOptionPane.WARNING_MESSAGE);
            txtNombreCompleto.requestFocus();
            return false;
        }
        
        return true;
    }
    
    // Modelo de tabla personalizado
    private class UsuarioTableModel extends AbstractTableModel {
        private List<Usuario> usuarios = new ArrayList<>();
        private String[] columnNames = {"ID", "Username", "Nombre Completo", "Rol", "Activo"};
        
        public void setUsuarios(List<Usuario> usuarios) {
            this.usuarios = usuarios;
            fireTableDataChanged();
        }
        
        public Usuario getUsuarioAt(int row) {
            return usuarios.get(row);
        }
        
        @Override
        public int getRowCount() {
            return usuarios.size();
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
            Usuario u = usuarios.get(row);
            switch (column) {
                case 0: return u.getId();
                case 1: return u.getUsername();
                case 2: return u.getNombreCompleto();
                case 3: return u.getRol();
                case 4: return u.isActivo() ? "Sí" : "No";
                default: return null;
            }
        }
        
        @Override
        public boolean isCellEditable(int row, int column) {
            return false;
        }
    }
}
```

---

## 📦 Paso 3 – Crear vista de Gestión de Productos

Esta vista será similar a Usuarios pero con búsqueda más destacada y campos diferentes.

### Crear ProductosPanel.java:

1. **Clic derecho** sobre `cl.tuusuario.pnb.gui` → **New → JPanel Form**
2. **Class Name:** `ProductosPanel`
3. **Finish**

### Diseño de la interfaz:

```
┌────────────────────────────────────────────────────────────┐
│  NORTH: [Buscar: ______] [🔍] [Filtro Categoría ▼] [Nuevo]│
├────────────────────────────────────────────────────────────┤
│  CENTER:                                                   │
│  ┌────────────────────┬─────────────────────────────────┐ │
│  │  Tabla (60%)       │  Formulario (40%)               │ │
│  │  ID | Nombre       │  Nombre: ___________            │ │
│  │  Categoría | Pre   │  Categoría: [▼]                 │ │
│  │  Tipo | Activo     │  Tipo: [▼]                      │ │
│  │                    │  Precio: ___________            │ │
│  │                    │  □ Activo                       │ │
│  │                    │  [Guardar] [Cancelar]           │ │
│  │                    │  [Eliminar] [Cambiar Estado]    │ │
│  └────────────────────┴─────────────────────────────────┘ │
└────────────────────────────────────────────────────────────┘
```

### Implementación simplificada (estructura similar a Usuarios):

El código seguirá el mismo patrón que `UsuariosPanel`, pero con los campos de Producto. Puedes usar como referencia el código de Usuarios y adaptar los campos.

**Puntos clave:**
- Campo de búsqueda con DocumentListener
- JComboBox para categoría (BEBIDA, SNACK, TIEMPO)
- JComboBox para tipo (dinámico según categoría)
- Campo de precio con validación numérica
- Botón "Cambiar Estado" adicional

> 💡 **Nota:**  El código completo sigue el mismo patrón que `UsuariosPanel`. Los estudiantes deben adaptar:
> - Cambiar `Usuario` por `Producto`
> - Ajustar columnas de la tabla
> - Modificar campos del formulario
> - Implementar validación de precio numérico

---

## 💰 Paso 4 – Crear vista de Ventas

Esta es la vista más compleja. Incluye selección de productos, manejo de cantidad y cálculo de totales.

### Crear VentasPanel.java:

1. **Clic derecho** sobre `cl.tuusuario.pnb.gui` → **New → JPanel Form**
2. **Class Name:** `VentasPanel`
3. **Finish**

### Diseño de la interfaz:

```
┌─────────────────────────────────────────────────────────────┐
│  NORTH: Registro de Nueva Venta                            │
├─────────────────────────────────────────────────────────────┤
│  LEFT (30%): Selección de Producto                         │
│  ┌─────────────────────────────────┐                       │
│  │ Buscar: [_________] [🔍]         │                       │
│  │ ┌───────────────────────────┐   │                       │
│  │ │ Espresso        $2,500    │   │                       │
│  │ │ Cappuccino      $3,000    │   │                       │
│  │ │ Brownie         $2,000    │   │                       │
│  │ │ 15 min Arcade   $1,500    │   │                       │
│  │ └───────────────────────────┘   │                       │
│  │ Cantidad: [___]  [Agregar]      │                       │
│  └─────────────────────────────────┘                       │
├─────────────────────────────────────────────────────────────┤
│  CENTER-RIGHT (70%): Detalle de la Venta                   │
│  ┌──────────────────────────────────────────────────────┐  │
│  │ Producto      │ Cantidad │ Precio Unit │ Subtotal    │  │
│  │───────────────┼──────────┼─────────────┼─────────────│  │
│  │ Espresso      │    2     │   $2,500    │   $5,000    │  │
│  │ Brownie       │    1     │   $2,000    │   $2,000    │  │
│  └──────────────────────────────────────────────────────┘  │
│  [Quitar Seleccionado]                                     │
│  ┌─────────────────────────────────────────────────────┐   │
│  │              TOTAL: $7,000                          │   │
│  └─────────────────────────────────────────────────────┘   │
│  [Confirmar Venta] [Cancelar]                              │
├─────────────────────────────────────────────────────────────┤
│  SOUTH: Ventas del Día                                     │
│  ┌──────────────────────────────────────────────────────┐  │
│  │ #  │ Fecha/Hora       │ Usuario │ Total   │ Estado  │  │
│  │────┼──────────────────┼─────────┼─────────┼─────────│  │
│  │ 1  │ 10/11/25 10:30  │ admin   │ $5,000  │ ACTIVA  │  │
│  │ 2  │ 10/11/25 11:15  │ operador│ $7,500  │ ACTIVA  │  │
│  └──────────────────────────────────────────────────────┘  │
│  Total del día: $12,500                                    │
└─────────────────────────────────────────────────────────────┘
```

### Implementación esquemática:

```java
package cl.tuusuario.pnb.gui;

import cl.tuusuario.pnb.model.Producto;
import cl.tuusuario.pnb.model.Venta;
import javax.swing.*;
import javax.swing.table.AbstractTableModel;
import java.awt.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class VentasPanel extends JPanel {
    // Componentes (generados por NetBeans)
    private JTextField txtBuscarProducto;
    private JList<Producto> lstProductos;
    private DefaultListModel<Producto> listModel;
    private JSpinner spnCantidad;
    private JTable tblDetalle;
    private DetalleVentaTableModel detalleTableModel;
    private JLabel lblTotal;
    private JTable tblVentasDelDia;
    private VentaTableModel ventasTableModel;
    private JLabel lblTotalDia;
    
    private List<ItemVenta> itemsVenta;
    
    public VentasPanel() {
        initComponents();
        setupComponents();
        cargarProductos();
        cargarVentasDelDia();
    }
    
    private void setupComponents() {
        // Lista de productos
        listModel = new DefaultListModel<>();
        lstProductos.setModel(listModel);
        lstProductos.setCellRenderer(new ProductoListCellRenderer());
        
        // Spinner de cantidad
        spnCantidad.setModel(new SpinnerNumberModel(1, 1, 99, 1));
        
        // Tabla de detalle
        itemsVenta = new ArrayList<>();
        detalleTableModel = new DetalleVentaTableModel();
        tblDetalle.setModel(detalleTableModel);
        
        // Tabla de ventas del día
        ventasTableModel = new VentaTableModel();
        tblVentasDelDia.setModel(ventasTableModel);
        
        actualizarTotal();
    }
    
    private void cargarProductos() {
        // Datos de ejemplo (stub)
        listModel.clear();
        listModel.addElement(new Producto(1, "Espresso", "BEBIDA", "CAFE", 2500, true));
        listModel.addElement(new Producto(2, "Cappuccino", "BEBIDA", "CAFE", 3000, true));
        listModel.addElement(new Producto(3, "Brownie", "SNACK", "POSTRE", 2000, true));
        listModel.addElement(new Producto(4, "15 minutos", "TIEMPO", "ARCADE", 1500, true));
        listModel.addElement(new Producto(5, "30 minutos", "TIEMPO", "ARCADE", 2500, true));
    }
    
    private void btnAgregarActionPerformed(java.awt.event.ActionEvent evt) {
        Producto seleccionado = lstProductos.getSelectedValue();
        if (seleccionado == null) {
            JOptionPane.showMessageDialog(this, "Selecciona un producto", 
                "Validación", JOptionPane.WARNING_MESSAGE);
            return;
        }
        
        int cantidad = (Integer) spnCantidad.getValue();
        
        // Verificar si ya existe en el detalle
        boolean encontrado = false;
        for (ItemVenta item : itemsVenta) {
            if (item.getProducto().getId() == seleccionado.getId()) {
                item.setCantidad(item.getCantidad() + cantidad);
                encontrado = true;
                break;
            }
        }
        
        if (!encontrado) {
            itemsVenta.add(new ItemVenta(seleccionado, cantidad));
        }
        
        detalleTableModel.fireTableDataChanged();
        actualizarTotal();
        spnCantidad.setValue(1);
    }
    
    private void btnQuitarActionPerformed(java.awt.event.ActionEvent evt) {
        int selectedRow = tblDetalle.getSelectedRow();
        if (selectedRow >= 0) {
            itemsVenta.remove(selectedRow);
            detalleTableModel.fireTableDataChanged();
            actualizarTotal();
        }
    }
    
    private void btnConfirmarVentaActionPerformed(java.awt.event.ActionEvent evt) {
        if (itemsVenta.isEmpty()) {
            JOptionPane.showMessageDialog(this, "Agrega al menos un producto", 
                "Validación", JOptionPane.WARNING_MESSAGE);
            return;
        }
        
        double total = calcularTotal();
        
        int respuesta = JOptionPane.showConfirmDialog(this,
            String.format("¿Confirmar venta por $%,.0f?", total),
            "Confirmar Venta",
            JOptionPane.YES_NO_OPTION);
        
        if (respuesta == JOptionPane.YES_OPTION) {
            // TODO: Guardar en servicio
            System.out.println("[STUB] Guardando venta. Total: $" + String.format("%,.0f", total));
            JOptionPane.showMessageDialog(this, "Venta registrada exitosamente");
            
            limpiarVenta();
            cargarVentasDelDia();
        }
    }
    
    private void btnCancelarActionPerformed(java.awt.event.ActionEvent evt) {
        if (!itemsVenta.isEmpty()) {
            int respuesta = JOptionPane.showConfirmDialog(this,
                "¿Cancelar la venta actual?",
                "Confirmar",
                JOptionPane.YES_NO_OPTION);
            
            if (respuesta == JOptionPane.YES_OPTION) {
                limpiarVenta();
            }
        }
    }
    
    private void limpiarVenta() {
        itemsVenta.clear();
        detalleTableModel.fireTableDataChanged();
        actualizarTotal();
        lstProductos.clearSelection();
        spnCantidad.setValue(1);
    }
    
    private double calcularTotal() {
        return itemsVenta.stream()
            .mapToDouble(ItemVenta::getSubtotal)
            .sum();
    }
    
    private void actualizarTotal() {
        double total = calcularTotal();
        lblTotal.setText(String.format("TOTAL: $%,.0f", total));
    }
    
    private void cargarVentasDelDia() {
        // Datos de ejemplo (stub)
        List<Venta> ventas = new ArrayList<>();
        ventas.add(new Venta(1, LocalDateTime.now().minusHours(2), 1, "admin", 5000, "ACTIVA"));
        ventas.add(new Venta(2, LocalDateTime.now().minusHours(1), 2, "operador", 7500, "ACTIVA"));
        ventas.add(new Venta(3, LocalDateTime.now().minusMinutes(30), 1, "admin", 3000, "ACTIVA"));
        
        ventasTableModel.setVentas(ventas);
        
        double totalDia = ventas.stream()
            .filter(v -> "ACTIVA".equals(v.getEstado()))
            .mapToDouble(Venta::getTotal)
            .sum();
        
        lblTotalDia.setText(String.format("Total del día: $%,.0f", totalDia));
    }
    
    // Clases internas
    private class ItemVenta {
        private Producto producto;
        private int cantidad;
        
        public ItemVenta(Producto producto, int cantidad) {
            this.producto = producto;
            this.cantidad = cantidad;
        }
        
        public Producto getProducto() { return producto; }
        public int getCantidad() { return cantidad; }
        public void setCantidad(int cantidad) { this.cantidad = cantidad; }
        public double getSubtotal() { return producto.getPrecio() * cantidad; }
    }
    
    private class DetalleVentaTableModel extends AbstractTableModel {
        private String[] columnNames = {"Producto", "Cantidad", "Precio Unit.", "Subtotal"};
        
        @Override
        public int getRowCount() { return itemsVenta.size(); }
        
        @Override
        public int getColumnCount() { return columnNames.length; }
        
        @Override
        public String getColumnName(int column) { return columnNames[column]; }
        
        @Override
        public Object getValueAt(int row, int column) {
            ItemVenta item = itemsVenta.get(row);
            switch (column) {
                case 0: return item.getProducto().getNombre();
                case 1: return item.getCantidad();
                case 2: return String.format("$%,.0f", item.getProducto().getPrecio());
                case 3: return String.format("$%,.0f", item.getSubtotal());
                default: return null;
            }
        }
        
        @Override
        public boolean isCellEditable(int row, int column) { return false; }
    }
    
    private class VentaTableModel extends AbstractTableModel {
        private List<Venta> ventas = new ArrayList<>();
        private String[] columnNames = {"#", "Fecha/Hora", "Usuario", "Total", "Estado"};
        
        public void setVentas(List<Venta> ventas) {
            this.ventas = ventas;
            fireTableDataChanged();
        }
        
        @Override
        public int getRowCount() { return ventas.size(); }
        
        @Override
        public int getColumnCount() { return columnNames.length; }
        
        @Override
        public String getColumnName(int column) { return columnNames[column]; }
        
        @Override
        public Object getValueAt(int row, int column) {
            Venta v = ventas.get(row);
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yy HH:mm");
            switch (column) {
                case 0: return v.getId();
                case 1: return v.getFechaHora().format(formatter);
                case 2: return v.getUsuarioNombre();
                case 3: return String.format("$%,.0f", v.getTotal());
                case 4: return v.getEstado();
                default: return null;
            }
        }
        
        @Override
        public boolean isCellEditable(int row, int column) { return false; }
    }
    
    // Renderer personalizado para la lista de productos
    private class ProductoListCellRenderer extends DefaultListCellRenderer {
        @Override
        public Component getListCellRendererComponent(JList<?> list, Object value, 
                int index, boolean isSelected, boolean cellHasFocus) {
            super.getListCellRendererComponent(list, value, index, isSelected, cellHasFocus);
            
            if (value instanceof Producto) {
                Producto p = (Producto) value;
                setText(String.format("<html><b>%s</b><br><small>$%,.0f</small></html>", 
                    p.getNombre(), p.getPrecio()));
            }
            
            return this;
        }
    }
}
```

---

## 📊 Paso 5 – Crear vista de Reportes

Vista simple con filtros y tabla de resultados.

### Crear ReportesPanel.java:

```java
package cl.tuusuario.pnb.gui;

import cl.tuusuario.pnb.model.Venta;
import javax.swing.*;
import javax.swing.table.AbstractTableModel;
import java.awt.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class ReportesPanel extends JPanel {
    // Componentes
    private JComboBox<String> cmbFiltro;
    private JButton btnGenerar;
    private JTable tblReporte;
    private ReporteTableModel tableModel;
    private JLabel lblTotal;
    
    public ReportesPanel() {
        initComponents();
        setupComponents();
    }
    
    private void setupComponents() {
        tableModel = new ReporteTableModel();
        tblReporte.setModel(tableModel);
        
        cmbFiltro.addItem("Hoy");
        cmbFiltro.addItem("Ayer");
        cmbFiltro.addItem("Última semana");
        cmbFiltro.addItem("Último mes");
        
        generarReporte();
    }
    
    private void btnGenerarActionPerformed(java.awt.event.ActionEvent evt) {
        generarReporte();
    }
    
    private void generarReporte() {
        String filtro = (String) cmbFiltro.getSelectedItem();
        
        // Datos de ejemplo (stub)
        List<Venta> ventas = obtenerVentas(filtro);
        tableModel.setVentas(ventas);
        
        double total = ventas.stream()
            .filter(v -> "ACTIVA".equals(v.getEstado()))
            .mapToDouble(Venta::getTotal)
            .sum();
        
        lblTotal.setText(String.format("Total: $%,.0f", total));
    }
    
    private List<Venta> obtenerVentas(String filtro) {
        // Stub con datos de ejemplo
        List<Venta> ventas = new ArrayList<>();
        LocalDateTime ahora = LocalDateTime.now();
        
        ventas.add(new Venta(1, ahora.minusHours(3), 1, "admin", 5000, "ACTIVA"));
        ventas.add(new Venta(2, ahora.minusHours(2), 2, "operador", 7500, "ACTIVA"));
        ventas.add(new Venta(3, ahora.minusHours(1), 1, "admin", 3000, "ACTIVA"));
        ventas.add(new Venta(4, ahora.minusMinutes(30), 2, "operador", 4500, "ACTIVA"));
        
        System.out.println("[STUB] Generando reporte: " + filtro);
        return ventas;
    }
    
    private class ReporteTableModel extends AbstractTableModel {
        private List<Venta> ventas = new ArrayList<>();
        private String[] columnNames = {"ID", "Fecha/Hora", "Usuario", "Total", "Estado"};
        
        public void setVentas(List<Venta> ventas) {
            this.ventas = ventas;
            fireTableDataChanged();
        }
        
        @Override
        public int getRowCount() { return ventas.size(); }
        
        @Override
        public int getColumnCount() { return columnNames.length; }
        
        @Override
        public String getColumnName(int column) { return columnNames[column]; }
        
        @Override
        public Object getValueAt(int row, int column) {
            Venta v = ventas.get(row);
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
            switch (column) {
                case 0: return v.getId();
                case 1: return v.getFechaHora().format(formatter);
                case 2: return v.getUsuarioNombre();
                case 3: return String.format("$%,.0f", v.getTotal());
                case 4: return v.getEstado();
                default: return null;
            }
        }
        
        @Override
        public boolean isCellEditable(int row, int column) { return false; }
    }
}
```

---

## 🎮 Paso 6 – Crear vista de Eventos (Placeholder)

Vista simple informativa sin funcionalidad real.

### Crear EventosPanel.java:

```java
package cl.tuusuario.pnb.gui;

import javax.swing.*;
import java.awt.*;

public class EventosPanel extends JPanel {
    
    public EventosPanel() {
        initComponents();
    }
    
    private void initComponents() {
        setLayout(new GridBagLayout());
        
        JLabel lblTitulo = new JLabel("<html><center>" +
            "<h1 style='color: #FF6B35;'>🎮 Eventos y Torneos</h1>" +
            "<p style='margin-top: 20px; font-size: 14px;'>" +
            "Este módulo está en desarrollo y estará disponible próximamente." +
            "</p>" +
            "<p style='margin-top: 30px; font-size: 12px; color: #666;'>" +
            "Funcionalidades planificadas:" +
            "</p>" +
            "<ul style='text-align: left; font-size: 12px; color: #666;'>" +
            "<li>Gestión de torneos semanales</li>" +
            "<li>Inscripción de participantes</li>" +
            "<li>Registro de resultados</li>" +
            "<li>Rankings y estadísticas</li>" +
            "</ul>" +
            "</center></html>");
        
        lblTitulo.setHorizontalAlignment(SwingConstants.CENTER);
        add(lblTitulo);
    }
}
```

---

## ✅ Resultado de esta parte

Al finalizar esta sección tendrás:

### Vistas creadas:
- ✅ **UsuariosPanel** - Formulario + Tabla + CRUD completo
- ✅ **ProductosPanel** - Búsqueda + Formulario + Tabla
- ✅ **VentasPanel** - Registro de ventas con detalle
- ✅ **ReportesPanel** - Ventas del día con filtros
- ✅ **EventosPanel** - Placeholder informativo

### Funcionalidad implementada:
- ✅ Navegación con CardLayout en MainFrame
- ✅ Tablas personalizadas con AbstractTableModel
- ✅ Formularios con validaciones básicas
- ✅ Selección en tablas
- ✅ Doble clic para editar
- ✅ Datos de ejemplo (stub)

### Estructura de paquetes:

```
cl.tuusuario.pnb/
├── model/
│   ├── Usuario.java
│   ├── Producto.java
│   └── Venta.java
├── gui/
│   ├── LoginFrame.java
│   ├── MainFrame.java
│   ├── UsuariosPanel.java
│   ├── ProductosPanel.java
│   ├── VentasPanel.java
│   ├── ReportesPanel.java
│   └── EventosPanel.java
└── PixelAndBean.java
```

---

## 💡 Siguiente Paso

Ahora que todas las vistas están creadas, pasamos a conectar la navegación y crear los servicios stub:

➡️ **[03-navigation-stubs.md](03-navigation-stubs.md)** – Navegación completa y servicios stub (30 min)

---

> 🧠 *"La interfaz es donde el usuario y el programa se encuentran. Haz que ese encuentro sea agradable."*

