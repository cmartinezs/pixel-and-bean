# 🛒 Parte 2: CRUD Completo de Productos (30 minutos)

En esta parte implementaremos el módulo completo de gestión de productos, con formularios, validaciones y búsqueda avanzada.

---

## 🎯 Objetivos

- Crear formulario de productos completo
- Implementar validaciones de negocio
- Agregar búsqueda y filtrado
- Permitir activar/desactivar productos
- Controlar acceso según rol

---

## 🎨 Paso 1: Formulario de Producto (10 min)

### Diseño del Formulario

Crear `ProductoDialog.java` en el paquete `gui`:

```java
package cl.tuusuario.pnb.gui;

import cl.tuusuario.pnb.model.Producto;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.math.BigDecimal;

/**
 * Diálogo para crear/editar productos
 */
public class ProductoDialog extends JDialog {
    
    // Componentes
    private JTextField txtNombre;
    private JComboBox<String> cboCategoria;
    private JTextField txtTipo;
    private JTextField txtPrecio;
    private JCheckBox chkActivo;
    
    private JButton btnGuardar;
    private JButton btnCancelar;
    
    // Estado
    private Producto producto;
    private boolean confirmado = false;
    
    // Categorías disponibles
    private static final String[] CATEGORIAS = {
        "BEBIDA", "SNACK", "TIEMPO_ARCADE"
    };
    
    /**
     * Constructor para crear nuevo producto
     */
    public ProductoDialog(Frame parent) {
        this(parent, null);
    }
    
    /**
     * Constructor para editar producto existente
     */
    public ProductoDialog(Frame parent, Producto producto) {
        super(parent, producto == null ? "Nuevo Producto" : "Editar Producto", true);
        this.producto = producto;
        
        initComponents();
        layoutComponents();
        setupListeners();
        
        if (producto != null) {
            cargarDatos();
        }
        
        pack();
        setLocationRelativeTo(parent);
        setResizable(false);
    }
    
    private void initComponents() {
        txtNombre = new JTextField(30);
        cboCategoria = new JComboBox<>(CATEGORIAS);
        txtTipo = new JTextField(20);
        txtPrecio = new JTextField(10);
        chkActivo = new JCheckBox("Activo");
        chkActivo.setSelected(true);
        
        btnGuardar = new JButton("Guardar");
        btnCancelar = new JButton("Cancelar");
    }
    
    private void layoutComponents() {
        JPanel panelCampos = new JPanel(new GridBagLayout());
        panelCampos.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));
        
        GridBagConstraints gbc = new GridBagConstraints();
        gbc.insets = new Insets(5, 5, 5, 5);
        gbc.anchor = GridBagConstraints.WEST;
        
        // Nombre
        gbc.gridx = 0; gbc.gridy = 0;
        panelCampos.add(new JLabel("Nombre:*"), gbc);
        gbc.gridx = 1; gbc.fill = GridBagConstraints.HORIZONTAL;
        panelCampos.add(txtNombre, gbc);
        
        // Categoría
        gbc.gridx = 0; gbc.gridy = 1; gbc.fill = GridBagConstraints.NONE;
        panelCampos.add(new JLabel("Categoría:*"), gbc);
        gbc.gridx = 1; gbc.fill = GridBagConstraints.HORIZONTAL;
        panelCampos.add(cboCategoria, gbc);
        
        // Tipo
        gbc.gridx = 0; gbc.gridy = 2; gbc.fill = GridBagConstraints.NONE;
        panelCampos.add(new JLabel("Tipo:"), gbc);
        gbc.gridx = 1; gbc.fill = GridBagConstraints.HORIZONTAL;
        panelCampos.add(txtTipo, gbc);
        
        // Precio
        gbc.gridx = 0; gbc.gridy = 3; gbc.fill = GridBagConstraints.NONE;
        panelCampos.add(new JLabel("Precio:*"), gbc);
        gbc.gridx = 1; gbc.fill = GridBagConstraints.HORIZONTAL;
        
        JPanel panelPrecio = new JPanel(new FlowLayout(FlowLayout.LEFT, 5, 0));
        panelPrecio.add(new JLabel("$"));
        panelPrecio.add(txtPrecio);
        panelCampos.add(panelPrecio, gbc);
        
        // Activo
        gbc.gridx = 1; gbc.gridy = 4;
        panelCampos.add(chkActivo, gbc);
        
        // Ayuda de categorías
        gbc.gridx = 0; gbc.gridy = 5; gbc.gridwidth = 2;
        JPanel panelAyuda = new JPanel(new BorderLayout());
        panelAyuda.setBorder(BorderFactory.createTitledBorder("Ejemplos por Categoría"));
        
        JTextArea txtAyuda = new JTextArea(
            "BEBIDA: Espresso, Cappuccino, Latte, etc.\n" +
            "SNACK: Brownie, Galletas, Sandwich, etc.\n" +
            "TIEMPO_ARCADE: 15 min, 30 min, 60 min, Pase Diario"
        );
        txtAyuda.setEditable(false);
        txtAyuda.setBackground(panelAyuda.getBackground());
        txtAyuda.setFont(txtAyuda.getFont().deriveFont(Font.PLAIN, 11f));
        panelAyuda.add(txtAyuda);
        panelCampos.add(panelAyuda, gbc);
        
        // Nota
        gbc.gridy = 6;
        JLabel lblNota = new JLabel("* Campos obligatorios");
        lblNota.setFont(lblNota.getFont().deriveFont(Font.ITALIC, 11f));
        panelCampos.add(lblNota, gbc);
        
        // Panel de botones
        JPanel panelBotones = new JPanel(new FlowLayout(FlowLayout.RIGHT));
        panelBotones.add(btnGuardar);
        panelBotones.add(btnCancelar);
        
        // Layout principal
        setLayout(new BorderLayout());
        add(panelCampos, BorderLayout.CENTER);
        add(panelBotones, BorderLayout.SOUTH);
    }
    
    private void setupListeners() {
        btnGuardar.addActionListener(e -> guardar());
        btnCancelar.addActionListener(e -> cancelar());
        
        // Enter en campos -> guardar
        KeyAdapter enterListener = new KeyAdapter() {
            @Override
            public void keyPressed(KeyEvent e) {
                if (e.getKeyCode() == KeyEvent.VK_ENTER) {
                    guardar();
                }
            }
        };
        
        txtNombre.addKeyListener(enterListener);
        txtTipo.addKeyListener(enterListener);
        txtPrecio.addKeyListener(enterListener);
        
        // ESC -> cancelar
        getRootPane().registerKeyboardAction(
            e -> cancelar(),
            KeyStroke.getKeyStroke(KeyEvent.VK_ESCAPE, 0),
            JComponent.WHEN_IN_FOCUSED_WINDOW
        );
    }
    
    private void cargarDatos() {
        txtNombre.setText(producto.getNombre());
        cboCategoria.setSelectedItem(producto.getCategoria());
        txtTipo.setText(producto.getTipo());
        txtPrecio.setText(producto.getPrecio().toString());
        chkActivo.setSelected(producto.isActivo());
    }
    
    private void guardar() {
        if (!validarCampos()) {
            return;
        }
        
        confirmado = true;
        dispose();
    }
    
    private void cancelar() {
        confirmado = false;
        dispose();
    }
    
    private boolean validarCampos() {
        String nombre = txtNombre.getText().trim();
        String tipo = txtTipo.getText().trim();
        String precioStr = txtPrecio.getText().trim();
        
        // Nombre obligatorio
        if (nombre.isEmpty()) {
            JOptionPane.showMessageDialog(this,
                "El nombre es obligatorio",
                "Error de Validación",
                JOptionPane.ERROR_MESSAGE);
            txtNombre.requestFocus();
            return false;
        }
        
        // Precio obligatorio
        if (precioStr.isEmpty()) {
            JOptionPane.showMessageDialog(this,
                "El precio es obligatorio",
                "Error de Validación",
                JOptionPane.ERROR_MESSAGE);
            txtPrecio.requestFocus();
            return false;
        }
        
        // Validar formato de precio
        try {
            BigDecimal precio = new BigDecimal(precioStr);
            if (precio.compareTo(BigDecimal.ZERO) <= 0) {
                JOptionPane.showMessageDialog(this,
                    "El precio debe ser mayor a 0",
                    "Error de Validación",
                    JOptionPane.ERROR_MESSAGE);
                txtPrecio.requestFocus();
                return false;
            }
        } catch (NumberFormatException e) {
            JOptionPane.showMessageDialog(this,
                "El precio debe ser un número válido",
                "Error de Validación",
                JOptionPane.ERROR_MESSAGE);
            txtPrecio.requestFocus();
            return false;
        }
        
        return true;
    }
    
    // Getters
    
    public boolean isConfirmado() {
        return confirmado;
    }
    
    public String getNombre() {
        return txtNombre.getText().trim();
    }
    
    public String getCategoria() {
        return (String) cboCategoria.getSelectedItem();
    }
    
    public String getTipo() {
        return txtTipo.getText().trim();
    }
    
    public BigDecimal getPrecio() {
        return new BigDecimal(txtPrecio.getText().trim());
    }
    
    public boolean isActivo() {
        return chkActivo.isSelected();
    }
    
    /**
     * Construye el objeto Producto con los datos del formulario
     */
    public Producto getProducto() {
        if (producto == null) {
            producto = new Producto();
        }
        
        producto.setNombre(getNombre());
        producto.setCategoria(getCategoria());
        producto.setTipo(getTipo());
        producto.setPrecio(getPrecio());
        producto.setActivo(isActivo());
        
        return producto;
    }
}
```

---

## 💼 Paso 2: Completar Repositorio de Productos (8 min)

### Métodos CRUD en `ProductoRepositoryImpl`

```java
@Override
public void save(Producto producto) throws SQLException {
    String sql = "INSERT INTO producto (nombre, categoria, tipo, precio, activo) " +
                 "VALUES (?, ?, ?, ?, ?)";
    
    try (Connection conn = connectionFactory.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
        
        stmt.setString(1, producto.getNombre());
        stmt.setString(2, producto.getCategoria());
        stmt.setString(3, producto.getTipo());
        stmt.setBigDecimal(4, producto.getPrecio());
        stmt.setBoolean(5, producto.isActivo());
        
        stmt.executeUpdate();
        
        // Obtener ID generado
        try (ResultSet rs = stmt.getGeneratedKeys()) {
            if (rs.next()) {
                producto.setId(rs.getInt(1));
            }
        }
    }
}

@Override
public void update(Producto producto) throws SQLException {
    String sql = "UPDATE producto SET nombre = ?, categoria = ?, tipo = ?, " +
                 "precio = ?, activo = ? WHERE id = ?";
    
    try (Connection conn = connectionFactory.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {
        
        stmt.setString(1, producto.getNombre());
        stmt.setString(2, producto.getCategoria());
        stmt.setString(3, producto.getTipo());
        stmt.setBigDecimal(4, producto.getPrecio());
        stmt.setBoolean(5, producto.isActivo());
        stmt.setInt(6, producto.getId());
        
        int rowsAffected = stmt.executeUpdate();
        if (rowsAffected == 0) {
            throw new SQLException("Producto no encontrado: ID " + producto.getId());
        }
    }
}

@Override
public void delete(int id) throws SQLException {
    String sql = "DELETE FROM producto WHERE id = ?";
    
    try (Connection conn = connectionFactory.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {
        
        stmt.setInt(1, id);
        
        int rowsAffected = stmt.executeUpdate();
        if (rowsAffected == 0) {
            throw new SQLException("Producto no encontrado: ID " + id);
        }
    }
}

@Override
public List<Producto> findByCategoria(String categoria) throws SQLException {
    String sql = "SELECT * FROM producto WHERE categoria = ? ORDER BY nombre";
    
    try (Connection conn = connectionFactory.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {
        
        stmt.setString(1, categoria);
        
        try (ResultSet rs = stmt.executeQuery()) {
            List<Producto> productos = new ArrayList<>();
            while (rs.next()) {
                productos.add(mapearProducto(rs));
            }
            return productos;
        }
    }
}

@Override
public List<Producto> findByNombreContaining(String nombre) throws SQLException {
    String sql = "SELECT * FROM producto WHERE nombre LIKE ? ORDER BY nombre";
    
    try (Connection conn = connectionFactory.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {
        
        stmt.setString(1, "%" + nombre + "%");
        
        try (ResultSet rs = stmt.executeQuery()) {
            List<Producto> productos = new ArrayList<>();
            while (rs.next()) {
                productos.add(mapearProducto(rs));
            }
            return productos;
        }
    }
}

@Override
public List<Producto> findActivos() throws SQLException {
    String sql = "SELECT * FROM producto WHERE activo = 1 ORDER BY categoria, nombre";
    
    try (Connection conn = connectionFactory.getConnection();
         Statement stmt = conn.createStatement();
         ResultSet rs = stmt.executeQuery(sql)) {
        
        List<Producto> productos = new ArrayList<>();
        while (rs.next()) {
            productos.add(mapearProducto(rs));
        }
        return productos;
    }
}

@Override
public boolean existsByNombre(String nombre) throws SQLException {
    String sql = "SELECT COUNT(*) FROM producto WHERE nombre = ?";
    
    try (Connection conn = connectionFactory.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {
        
        stmt.setString(1, nombre);
        
        try (ResultSet rs = stmt.executeQuery()) {
            return rs.next() && rs.getInt(1) > 0;
        }
    }
}
```

---

## 🔧 Paso 3: Lógica de Negocio en Servicio (7 min)

### Completar `ProductoServiceImpl`

```java
package cl.tuusuario.pnb.service.impl;

import cl.tuusuario.pnb.model.Producto;
import cl.tuusuario.pnb.repository.ProductoRepository;
import cl.tuusuario.pnb.service.ProductoService;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;

public class ProductoServiceImpl implements ProductoService {
    
    private final ProductoRepository productoRepository;
    
    public ProductoServiceImpl(ProductoRepository productoRepository) {
        this.productoRepository = productoRepository;
    }
    
    @Override
    public void crear(Producto producto) throws SQLException {
        // Validaciones
        validarProducto(producto);
        
        // Verificar que no exista
        if (productoRepository.existsByNombre(producto.getNombre())) {
            throw new IllegalArgumentException("Ya existe un producto con ese nombre");
        }
        
        // Crear
        productoRepository.save(producto);
    }
    
    @Override
    public void actualizar(Producto producto) throws SQLException {
        // Validaciones
        validarProducto(producto);
        
        // Verificar que existe
        Producto actual = productoRepository.findById(producto.getId());
        if (actual == null) {
            throw new IllegalArgumentException("Producto no encontrado");
        }
        
        // Verificar nombre único (excepto el mismo)
        if (!actual.getNombre().equals(producto.getNombre())) {
            if (productoRepository.existsByNombre(producto.getNombre())) {
                throw new IllegalArgumentException("Ya existe un producto con ese nombre");
            }
        }
        
        // Actualizar
        productoRepository.update(producto);
    }
    
    @Override
    public void eliminar(int id) throws SQLException {
        // Verificar que existe
        Producto producto = productoRepository.findById(id);
        if (producto == null) {
            throw new IllegalArgumentException("Producto no encontrado");
        }
        
        // TODO: Verificar que no tenga ventas asociadas
        // (implementar en trabajo autónomo)
        
        productoRepository.delete(id);
    }
    
    @Override
    public List<Producto> listarTodos() throws SQLException {
        return productoRepository.findAll();
    }
    
    @Override
    public List<Producto> listarActivos() throws SQLException {
        return productoRepository.findActivos();
    }
    
    @Override
    public List<Producto> buscarPorNombre(String nombre) throws SQLException {
        if (nombre == null || nombre.trim().isEmpty()) {
            return listarTodos();
        }
        return productoRepository.findByNombreContaining(nombre);
    }
    
    @Override
    public List<Producto> buscarPorCategoria(String categoria) throws SQLException {
        return productoRepository.findByCategoria(categoria);
    }
    
    @Override
    public Producto buscarPorId(int id) throws SQLException {
        return productoRepository.findById(id);
    }
    
    /**
     * Validaciones comunes para crear/editar
     */
    private void validarProducto(Producto producto) {
        if (producto.getNombre() == null || producto.getNombre().trim().isEmpty()) {
            throw new IllegalArgumentException("El nombre es obligatorio");
        }
        
        if (producto.getCategoria() == null || producto.getCategoria().trim().isEmpty()) {
            throw new IllegalArgumentException("La categoría es obligatoria");
        }
        
        if (producto.getPrecio() == null || producto.getPrecio().compareTo(BigDecimal.ZERO) <= 0) {
            throw new IllegalArgumentException("El precio debe ser mayor a 0");
        }
        
        // Validar categoría válida
        String cat = producto.getCategoria();
        if (!cat.equals("BEBIDA") && !cat.equals("SNACK") && !cat.equals("TIEMPO_ARCADE")) {
            throw new IllegalArgumentException("Categoría inválida: " + cat);
        }
    }
}
```

---

## 🔍 Paso 4: Búsqueda Incremental (5 min)

### Agregar búsqueda en tiempo real en `ProductosPanel`

Modificar el panel de productos para agregar búsqueda:

```java
// Agregar campo de búsqueda en el panel
private JTextField txtBuscar;
private JComboBox<String> cboFiltroCat;

private void initSearchComponents() {
    txtBuscar = new JTextField(20);
    cboFiltroCat = new JComboBox<>(new String[]{"TODAS", "BEBIDA", "SNACK", "TIEMPO_ARCADE"});
    
    // Listener para búsqueda incremental
    txtBuscar.getDocument().addDocumentListener(new DocumentListener() {
        @Override
        public void insertUpdate(DocumentEvent e) {
            buscar();
        }
        
        @Override
        public void removeUpdate(DocumentEvent e) {
            buscar();
        }
        
        @Override
        public void changedUpdate(DocumentEvent e) {
            buscar();
        }
    });
    
    // Listener para filtro de categoría
    cboFiltroCat.addActionListener(e -> buscar());
}

private void buscar() {
    String texto = txtBuscar.getText().trim();
    String categoria = (String) cboFiltroCat.getSelectedItem();
    
    try {
        List<Producto> productos;
        
        if ("TODAS".equals(categoria)) {
            if (texto.isEmpty()) {
                productos = productoService.listarTodos();
            } else {
                productos = productoService.buscarPorNombre(texto);
            }
        } else {
            productos = productoService.buscarPorCategoria(categoria);
            if (!texto.isEmpty()) {
                // Filtrar adicionalmente por nombre
                productos = productos.stream()
                    .filter(p -> p.getNombre().toLowerCase().contains(texto.toLowerCase()))
                    .collect(Collectors.toList());
            }
        }
        
        actualizarTabla(productos);
        
    } catch (SQLException e) {
        JOptionPane.showMessageDialog(this,
            "Error al buscar productos: " + e.getMessage(),
            "Error",
            JOptionPane.ERROR_MESSAGE);
    }
}
```

---

## 🎮 Paso 5: Integración Completa (Continuará)

La integración completa con el panel se realizará en clase, conectando:
- Botones de crear/editar/eliminar
- Doble clic en tabla para editar
- Confirmaciones de eliminación
- Actualización automática de tabla

---

## ✅ Checklist de Progreso

- [ ] `ProductoDialog` implementado
- [ ] Métodos CRUD completados en repositorio
- [ ] Validaciones en servicio implementadas
- [ ] Búsqueda incremental funcionando
- [ ] Filtro por categoría operativo
- [ ] Integración con panel completa
- [ ] Restricciones de rol aplicadas

---

## 💡 Mejoras Opcionales

### Para Trabajo Autónomo
- Evitar eliminar productos con ventas asociadas
- Agregar campo de descripción larga
- Permitir agregar imagen al producto
- Implementar importación masiva desde CSV
- Agregar control de stock

---

## 🔗 Navegación

- ⬅️ [Anterior: CRUD de Usuarios](01-usuarios-crud.md)
- ⬅️ [Volver al índice de la clase](00-intro.md)
- ➡️ [Siguiente: Módulo de Ventas](03-ventas-modulo.md)

---

**Tiempo estimado:** 30 minutos  
**Dificultad:** Media

