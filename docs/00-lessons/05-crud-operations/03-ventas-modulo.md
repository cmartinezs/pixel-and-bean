# 💰 Parte 3: Módulo de Ventas Básico (40 minutos)

En esta parte implementaremos el módulo de ventas, que incluye transacciones JDBC para asegurar la integridad de datos entre la cabecera de venta y sus detalles.

---

## 🎯 Objetivos

- Diseñar modelo de Venta y VentaDetalle
- Implementar transacciones JDBC
- Crear formulario de registro de venta
- Calcular totales automáticamente
- Validar productos activos
- Mostrar listado de ventas del día

---

## 📊 Paso 1: Modelos de Dominio (5 min)

### Clase `Venta`

Crear `Venta.java` en el paquete `model`:

```java
package cl.tuusuario.pnb.model;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * Representa una venta (cabecera)
 */
public class Venta {
    
    private Integer id;
    private LocalDateTime fechaHora;
    private Integer usuarioId;  // ID del usuario que registró la venta (FK a usuario.id)
    private BigDecimal total;
    private String estado;  // ACTIVA, ANULADA
    private String observaciones;  // Observaciones de la venta
    
    // Relación con detalles
    private List<VentaDetalle> detalles;
    
    // Constructor
    public Venta() {
        this.fechaHora = LocalDateTime.now();
        this.total = BigDecimal.ZERO;
        this.estado = "ACTIVA";
        this.detalles = new ArrayList<>();
    }
    
    // Getters y Setters
    
    public Integer getId() {
        return id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    
    public LocalDateTime getFechaHora() {
        return fechaHora;
    }
    
    public void setFechaHora(LocalDateTime fechaHora) {
        this.fechaHora = fechaHora;
    }
    
    public Integer getUsuarioId() {
        return usuarioId;
    }
    
    public void setUsuarioId(Integer usuarioId) {
        this.usuarioId = usuarioId;
    }
    
    public BigDecimal getTotal() {
        return total;
    }
    
    public void setTotal(BigDecimal total) {
        this.total = total;
    }
    
    public String getEstado() {
        return estado;
    }
    
    public void setEstado(String estado) {
        this.estado = estado;
    }
    
    public String getObservaciones() {
        return observaciones;
    }
    
    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }
    
    public List<VentaDetalle> getDetalles() {
        return detalles;
    }
    
    public void setDetalles(List<VentaDetalle> detalles) {
        this.detalles = detalles;
    }
    
    // Métodos de negocio
    
    public void agregarDetalle(VentaDetalle detalle) {
        this.detalles.add(detalle);
        recalcularTotal();
    }
    
    public void removerDetalle(VentaDetalle detalle) {
        this.detalles.remove(detalle);
        recalcularTotal();
    }
    
    public void recalcularTotal() {
        this.total = detalles.stream()
            .map(VentaDetalle::getSubtotal)
            .reduce(BigDecimal.ZERO, BigDecimal::add);
    }
    
    public boolean isActiva() {
        return "ACTIVA".equals(estado);
    }
    
    public boolean isAnulada() {
        return "ANULADA".equals(estado);
    }
}
```

### Clase `VentaDetalle`

Crear `VentaDetalle.java` en el paquete `model`:

```java
package cl.tuusuario.pnb.model;

import java.math.BigDecimal;

/**
 * Representa una línea de detalle de una venta
 */
public class VentaDetalle {
    
    private Integer id;
    private Integer ventaId;
    private Integer productoId;
    private String productoNombre;  // Desnormalizado para historial
    private int cantidad;
    private BigDecimal precioUnitario;
    private BigDecimal subtotal;
    
    // Constructor vacío
    public VentaDetalle() {
    }
    
    // Constructor completo
    public VentaDetalle(Integer productoId, String productoNombre, 
                       int cantidad, BigDecimal precioUnitario) {
        this.productoId = productoId;
        this.productoNombre = productoNombre;
        this.cantidad = cantidad;
        this.precioUnitario = precioUnitario;
        calcularSubtotal();
    }
    
    // Getters y Setters
    
    public Integer getId() {
        return id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    
    public Integer getVentaId() {
        return ventaId;
    }
    
    public void setVentaId(Integer ventaId) {
        this.ventaId = ventaId;
    }
    
    public Integer getProductoId() {
        return productoId;
    }
    
    public void setProductoId(Integer productoId) {
        this.productoId = productoId;
    }
    
    public String getProductoNombre() {
        return productoNombre;
    }
    
    public void setProductoNombre(String productoNombre) {
        this.productoNombre = productoNombre;
    }
    
    public int getCantidad() {
        return cantidad;
    }
    
    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
        calcularSubtotal();
    }
    
    public BigDecimal getPrecioUnitario() {
        return precioUnitario;
    }
    
    public void setPrecioUnitario(BigDecimal precioUnitario) {
        this.precioUnitario = precioUnitario;
        calcularSubtotal();
    }
    
    public BigDecimal getSubtotal() {
        return subtotal;
    }
    
    public void setSubtotal(BigDecimal subtotal) {
        this.subtotal = subtotal;
    }
    
    // Métodos de negocio
    
    public void calcularSubtotal() {
        if (precioUnitario != null) {
            this.subtotal = precioUnitario.multiply(new BigDecimal(cantidad));
        }
    }
}
```

---

## 🗄️ Paso 2: Repositorio con Transacciones (12 min)

### Interface `VentaRepository`

```java
package cl.tuusuario.pnb.repository;

import cl.tuusuario.pnb.model.Venta;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

public interface VentaRepository {
    
    /**
     * Guarda una venta con sus detalles en una transacción
     */
    void guardar(Venta venta) throws SQLException;
    
    /**
     * Busca una venta por ID con sus detalles
     */
    Venta buscarPorId(int id) throws SQLException;
    
    /**
     * Lista todas las ventas (sin detalles)
     */
    List<Venta> buscarTodas() throws SQLException;
    
    /**
     * Lista ventas de una fecha específica
     */
    List<Venta> buscarPorFecha(LocalDate fecha) throws SQLException;
    
    /**
     * Lista ventas del día actual
     */
    List<Venta> buscarDelDia() throws SQLException;
    
    /**
     * Anula una venta (cambia estado)
     */
    void anular(int id) throws SQLException;
}
```

### Implementación `VentaRepositoryImpl`

```java
package cl.tuusuario.pnb.repository.impl;

import cl.tuusuario.pnb.model.Venta;
import cl.tuusuario.pnb.model.VentaDetalle;
import cl.tuusuario.pnb.repository.VentaRepository;
import cl.tuusuario.pnb.util.DatabaseConnectionFactory;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class VentaRepositoryImpl implements VentaRepository {
    
    private final DatabaseConnectionFactory connectionFactory;
    
    public VentaRepositoryImpl(DatabaseConnectionFactory connectionFactory) {
        this.connectionFactory = connectionFactory;
    }
    
    @Override
    public void guardar(Venta venta) throws SQLException {
        Connection conn = null;
        
        try {
            conn = connectionFactory.getConnection();
            
            // Iniciar transacción
            conn.setAutoCommit(false);
            
            // 1. Insertar cabecera
            String sqlVenta = "INSERT INTO venta (fecha_hora, usuario_id, total, estado) " +
                            "VALUES (?, ?, ?, ?)";
            
            int ventaId;
            try (PreparedStatement stmtVenta = conn.prepareStatement(sqlVenta, 
                                                    Statement.RETURN_GENERATED_KEYS)) {
                
                stmtVenta.setTimestamp(1, Timestamp.valueOf(venta.getFechaHora()));
                stmtVenta.setString(2, venta.getUsuarioId());
                stmtVenta.setBigDecimal(3, venta.getTotal());
                stmtVenta.setString(4, venta.getEstado());
                
                stmtVenta.executeUpdate();
                
                // Obtener ID generado
                try (ResultSet rs = stmtVenta.getGeneratedKeys()) {
                    if (rs.next()) {
                        ventaId = rs.getInt(1);
                        venta.setId(ventaId);
                    } else {
                        throw new SQLException("Error al obtener ID de venta");
                    }
                }
            }
            
            // 2. Insertar detalles
            String sqlDetalle = "INSERT INTO venta_detalle " +
                              "(venta_id, producto_id, producto_nombre, cantidad, precio_unitario, subtotal) " +
                              "VALUES (?, ?, ?, ?, ?, ?)";
            
            try (PreparedStatement stmtDetalle = conn.prepareStatement(sqlDetalle)) {
                for (VentaDetalle detalle : venta.getDetalles()) {
                    stmtDetalle.setInt(1, ventaId);
                    stmtDetalle.setInt(2, detalle.getProductoId());
                    stmtDetalle.setString(3, detalle.getProductoNombre());
                    stmtDetalle.setInt(4, detalle.getCantidad());
                    stmtDetalle.setBigDecimal(5, detalle.getPrecioUnitario());
                    stmtDetalle.setBigDecimal(6, detalle.getSubtotal());
                    
                    stmtDetalle.addBatch();
                }
                
                stmtDetalle.executeBatch();
            }
            
            // Confirmar transacción
            conn.commit();
            
        } catch (SQLException e) {
            // Revertir transacción
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            throw e;
        } finally {
            // Restaurar auto-commit
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
    
    @Override
    public Venta buscarPorId(int id) throws SQLException {
        String sql = "SELECT * FROM venta WHERE id = ?";
        
        try (Connection conn = connectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Venta venta = mapearVenta(rs);
                    
                    // Cargar detalles
                    venta.setDetalles(findDetallesByVentaId(conn, id));
                    
                    return venta;
                }
                return null;
            }
        }
    }
    
    @Override
    public List<Venta> buscarTodas() throws SQLException {
        String sql = "SELECT * FROM venta ORDER BY fecha_hora DESC";
        
        try (Connection conn = connectionFactory.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            List<Venta> ventas = new ArrayList<>();
            while (rs.next()) {
                ventas.add(mapearVenta(rs));
            }
            return ventas;
        }
    }
    
    @Override
    public List<Venta> buscarPorFecha(LocalDate fecha) throws SQLException {
        String sql = "SELECT * FROM venta WHERE DATE(fecha_hora) = ? ORDER BY fecha_hora DESC";
        
        try (Connection conn = connectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setDate(1, Date.valueOf(fecha));
            
            try (ResultSet rs = stmt.executeQuery()) {
                List<Venta> ventas = new ArrayList<>();
                while (rs.next()) {
                    ventas.add(mapearVenta(rs));
                }
                return ventas;
            }
        }
    }
    
    @Override
    public List<Venta> findDelDia() throws SQLException {
        return buscarPorFecha(LocalDate.now());
    }
    
    @Override
    public void anular(int id) throws SQLException {
        String sql = "UPDATE venta SET estado = 'ANULADA' WHERE id = ?";
        
        try (Connection conn = connectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected == 0) {
                throw new SQLException("Venta no encontrada: ID " + id);
            }
        }
    }
    
    // Métodos auxiliares
    
    private List<VentaDetalle> findDetallesByVentaId(Connection conn, int ventaId) throws SQLException {
        String sql = "SELECT * FROM venta_detalle WHERE venta_id = ?";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, ventaId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                List<VentaDetalle> detalles = new ArrayList<>();
                while (rs.next()) {
                    detalles.add(mapearDetalle(rs));
                }
                return detalles;
            }
        }
    }
    
    private Venta mapearVenta(ResultSet rs) throws SQLException {
        Venta venta = new Venta();
        venta.setId(rs.getInt("id"));
        venta.setFechaHora(rs.getTimestamp("fecha_hora").toLocalDateTime());
        venta.setUsuarioId(rs.getString("usuario_id"));
        venta.setTotal(rs.getBigDecimal("total"));
        venta.setEstado(rs.getString("estado"));
        return venta;
    }
    
    private VentaDetalle mapearDetalle(ResultSet rs) throws SQLException {
        VentaDetalle detalle = new VentaDetalle();
        detalle.setId(rs.getInt("id"));
        detalle.setVentaId(rs.getInt("venta_id"));
        detalle.setProductoId(rs.getInt("producto_id"));
        detalle.setProductoNombre(rs.getString("producto_nombre"));
        detalle.setCantidad(rs.getInt("cantidad"));
        detalle.setPrecioUnitario(rs.getBigDecimal("precio_unitario"));
        detalle.setSubtotal(rs.getBigDecimal("subtotal"));
        return detalle;
    }
}
```

---

## 🔧 Paso 3: Servicio de Ventas (8 min)

### Interface `VentaService`

```java
package cl.tuusuario.pnb.service;

import cl.tuusuario.pnb.model.Venta;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

public interface VentaService {
    
    /**
     * Registra una nueva venta
     */
    void registrar(Venta venta) throws SQLException;
    
    /**
     * Lista ventas de una fecha
     */
    List<Venta> listarPorFecha(LocalDate fecha) throws SQLException;
    
    /**
     * Lista ventas del día actual
     */
    List<Venta> listarDelDia() throws SQLException;
    
    /**
     * Anula una venta
     */
    void anular(int id) throws SQLException;
    
    /**
     * Busca una venta por ID
     */
    Venta buscarPorId(int id) throws SQLException;
}
```

### Implementación `VentaServiceImpl`

```java
package cl.tuusuario.pnb.service.impl;

import cl.tuusuario.pnb.model.Venta;
import cl.tuusuario.pnb.model.VentaDetalle;
import cl.tuusuario.pnb.repository.VentaRepository;
import cl.tuusuario.pnb.service.VentaService;

import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

public class VentaServiceImpl implements VentaService {
    
    private final VentaRepository ventaRepository;
    
    public VentaServiceImpl(VentaRepository ventaRepository) {
        this.ventaRepository = ventaRepository;
    }
    
    @Override
    public void registrar(Venta venta) throws SQLException {
        // Validaciones
        if (venta.getUsuarioId() == null || venta.getUsuarioId().isEmpty()) {
            throw new IllegalArgumentException("Usuario es obligatorio");
        }
        
        if (venta.getDetalles() == null || venta.getDetalles().isEmpty()) {
            throw new IllegalArgumentException("La venta debe tener al menos un producto");
        }
        
        // Validar cantidades
        for (VentaDetalle detalle : venta.getDetalles()) {
            if (detalle.getCantidad() <= 0) {
                throw new IllegalArgumentException("La cantidad debe ser mayor a 0");
            }
        }
        
        // Recalcular total (por seguridad)
        venta.recalcularTotal();
        
        // Guardar
        ventaRepository.guardar(venta);
    }
    
    @Override
    public List<Venta> listarPorFecha(LocalDate fecha) throws SQLException {
        return ventaRepository.buscarPorFecha(fecha);
    }
    
    @Override
    public List<Venta> listarDelDia() throws SQLException {
        return ventaRepository.findDelDia();
    }
    
    @Override
    public void anular(int id) throws SQLException {
        // Verificar que existe
        Venta venta = ventaRepository.buscarPorId(id);
        if (venta == null) {
            throw new IllegalArgumentException("Venta no encontrada");
        }
        
        // Verificar que no esté ya anulada
        if (venta.isAnulada()) {
            throw new IllegalArgumentException("La venta ya está anulada");
        }
        
        // Anular
        ventaRepository.anular(id);
    }
    
    @Override
    public Venta buscarPorId(int id) throws SQLException {
        return ventaRepository.buscarPorId(id);
    }
}
```

---

## 🎨 Paso 4: Panel de Ventas Básico (15 min)

### Estructura del Panel

Crear `VentaPanel.java` en el paquete `gui`:

```java
package cl.tuusuario.pnb.gui;

import cl.tuusuario.pnb.model.*;
import cl.tuusuario.pnb.service.ProductoService;
import cl.tuusuario.pnb.service.VentaService;

import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

/**
 * Panel de registro y visualización de ventas
 */
public class VentaPanel extends JPanel {
    
    // Servicios
    private final VentaService ventaService;
    private final ProductoService productoService;
    private final Usuario usuarioActual;
    
    // Componentes de registro
    private JComboBox<Producto> cboProducto;
    private JSpinner spnCantidad;
    private JButton btnAgregar;
    private JTable tblCarrito;
    private DefaultTableModel modeloCarrito;
    private JLabel lblTotal;
    private JButton btnConfirmar;
    private JButton btnCancelar;
    
    // Componentes de historial
    private JTable tblVentas;
    private DefaultTableModel modeloVentas;
    private JComboBox<String> cboFiltroFecha;
    private JLabel lblTotalDia;
    
    public VentaPanel(VentaService ventaService, ProductoService productoService, Usuario usuarioActual) {
        this.ventaService = ventaService;
        this.productoService = productoService;
        this.usuarioActual = usuarioActual;
        
        initComponents();
        layoutComponents();
        cargarProductos();
        cargarVentas();
    }
    
    private void initComponents() {
        // Registro de venta
        cboProducto = new JComboBox<>();
        spnCantidad = new JSpinner(new SpinnerNumberModel(1, 1, 99, 1));
        btnAgregar = new JButton("Agregar");
        
        // Carrito
        String[] columnasCarrito = {"Producto", "Cantidad", "Precio Unit.", "Subtotal"};
        modeloCarrito = new DefaultTableModel(columnasCarrito, 0) {
            @Override
            public boolean isCellEditable(int row, int column) {
                return false;
            }
        };
        tblCarrito = new JTable(modeloCarrito);
        
        lblTotal = new JLabel("Total: $0");
        lblTotal.setFont(lblTotal.getFont().deriveFont(Font.BOLD, 16f));
        
        btnConfirmar = new JButton("Confirmar Venta");
        btnCancelar = new JButton("Cancelar");
        
        // Historial
        String[] columnasVentas = {"ID", "Fecha/Hora", "Usuario", "Total", "Estado"};
        modeloVentas = new DefaultTableModel(columnasVentas, 0) {
            @Override
            public boolean isCellEditable(int row, int column) {
                return false;
            }
        };
        tblVentas = new JTable(modeloVentas);
        
        cboFiltroFecha = new JComboBox<>(new String[]{"Hoy", "Ayer", "Última semana"});
        lblTotalDia = new JLabel("Total del día: $0");
        
        // Listeners
        btnAgregar.addActionListener(e -> agregarAlCarrito());
        btnConfirmar.addActionListener(e -> confirmarVenta());
        btnCancelar.addActionListener(e -> limpiarCarrito());
        cboFiltroFecha.addActionListener(e -> cargarVentas());
    }
    
    private void layoutComponents() {
        setLayout(new BorderLayout(10, 10));
        setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));
        
        // Panel superior: Registro de venta
        JPanel panelRegistro = crearPanelRegistro();
        
        // Panel inferior: Historial
        JPanel panelHistorial = crearPanelHistorial();
        
        // Dividir en dos
        JSplitPane splitPane = new JSplitPane(JSplitPane.VERTICAL_SPLIT, panelRegistro, panelHistorial);
        splitPane.setDividerLocation(300);
        splitPane.setResizeWeight(0.5);
        
        add(splitPane, BorderLayout.CENTER);
    }
    
    private JPanel crearPanelRegistro() {
        JPanel panel = new JPanel(new BorderLayout(5, 5));
        panel.setBorder(BorderFactory.createTitledBorder("Nueva Venta"));
        
        // Panel de selección
        JPanel panelSeleccion = new JPanel(new FlowLayout(FlowLayout.LEFT));
        panelSeleccion.add(new JLabel("Producto:"));
        panelSeleccion.add(cboProducto);
        panelSeleccion.add(new JLabel("Cantidad:"));
        panelSeleccion.add(spnCantidad);
        panelSeleccion.add(btnAgregar);
        
        // Tabla de carrito
        JScrollPane scrollCarrito = new JScrollPane(tblCarrito);
        
        // Panel inferior con total y botones
        JPanel panelInferior = new JPanel(new BorderLayout());
        panelInferior.add(lblTotal, BorderLayout.WEST);
        
        JPanel panelBotones = new JPanel(new FlowLayout(FlowLayout.RIGHT));
        panelBotones.add(btnConfirmar);
        panelBotones.add(btnCancelar);
        panelInferior.add(panelBotones, BorderLayout.EAST);
        
        panel.add(panelSeleccion, BorderLayout.NORTH);
        panel.add(scrollCarrito, BorderLayout.CENTER);
        panel.add(panelInferior, BorderLayout.SOUTH);
        
        return panel;
    }
    
    private JPanel crearPanelHistorial() {
        JPanel panel = new JPanel(new BorderLayout(5, 5));
        panel.setBorder(BorderFactory.createTitledBorder("Historial de Ventas"));
        
        // Panel de filtros
        JPanel panelFiltros = new JPanel(new FlowLayout(FlowLayout.LEFT));
        panelFiltros.add(new JLabel("Filtro:"));
        panelFiltros.add(cboFiltroFecha);
        panelFiltros.add(lblTotalDia);
        
        // Tabla de ventas
        JScrollPane scrollVentas = new JScrollPane(tblVentas);
        
        panel.add(panelFiltros, BorderLayout.NORTH);
        panel.add(scrollVentas, BorderLayout.CENTER);
        
        return panel;
    }
    
    private void cargarProductos() {
        try {
            List<Producto> productos = productoService.listarActivos();
            
            DefaultComboBoxModel<Producto> modelo = new DefaultComboBoxModel<>();
            for (Producto p : productos) {
                modelo.addElement(p);
            }
            
            cboProducto.setModel(modelo);
            cboProducto.setRenderer(new DefaultListCellRenderer() {
                @Override
                public Component getListCellRendererComponent(JList<?> list, Object value,
                                                             int index, boolean isSelected, boolean cellHasFocus) {
                    super.getListCellRendererComponent(list, value, index, isSelected, cellHasFocus);
                    if (value instanceof Producto) {
                        Producto p = (Producto) value;
                        setText(p.getNombre() + " - $" + p.getPrecio());
                    }
                    return this;
                }
            });
            
        } catch (Exception e) {
            JOptionPane.showMessageDialog(this,
                "Error al cargar productos: " + e.getMessage(),
                "Error",
                JOptionPane.ERROR_MESSAGE);
        }
    }
    
    private void agregarAlCarrito() {
        Producto producto = (Producto) cboProducto.getSelectedItem();
        if (producto == null) {
            JOptionPane.showMessageDialog(this, "Seleccione un producto");
            return;
        }
        
        int cantidad = (Integer) spnCantidad.getValue();
        BigDecimal subtotal = producto.getPrecio().multiply(new BigDecimal(cantidad));
        
        modeloCarrito.addRow(new Object[]{
            producto.getNombre(),
            cantidad,
            "$" + producto.getPrecio(),
            "$" + subtotal
        });
        
        actualizarTotal();
    }
    
    private void actualizarTotal() {
        BigDecimal total = BigDecimal.ZERO;
        
        for (int i = 0; i < modeloCarrito.getRowCount(); i++) {
            String subtotalStr = modeloCarrito.getValueAt(i, 3).toString();
            subtotalStr = subtotalStr.replace("$", "");
            total = total.add(new BigDecimal(subtotalStr));
        }
        
        lblTotal.setText("Total: $" + total);
    }
    
    private void confirmarVenta() {
        if (modeloCarrito.getRowCount() == 0) {
            JOptionPane.showMessageDialog(this, "Agregue al menos un producto");
            return;
        }
        
        try {
            // Construir venta
            Venta venta = new Venta();
            venta.setUsuarioId(usuarioActual.getUsername());
            
            // Agregar detalles (simplificado - requiere guardar referencia al producto)
            // En implementación real, deberías mantener una lista de VentaDetalle
            
            // Por ahora, mostrar mensaje de éxito
            ventaService.registrar(venta);
            
            JOptionPane.showMessageDialog(this,
                "Venta registrada exitosamente",
                "Éxito",
                JOptionPane.INFORMATION_MESSAGE);
            
            limpiarCarrito();
            cargarVentas();
            
        } catch (Exception e) {
            JOptionPane.showMessageDialog(this,
                "Error al registrar venta: " + e.getMessage(),
                "Error",
                JOptionPane.ERROR_MESSAGE);
        }
    }
    
    private void limpiarCarrito() {
        modeloCarrito.setRowCount(0);
        actualizarTotal();
    }
    
    private void cargarVentas() {
        try {
            String filtro = (String) cboFiltroFecha.getSelectedItem();
            LocalDate fecha = calcularFecha(filtro);
            
            List<Venta> ventas = ventaService.listarPorFecha(fecha);
            
            modeloVentas.setRowCount(0);
            BigDecimal totalDia = BigDecimal.ZERO;
            
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
            
            for (Venta v : ventas) {
                modeloVentas.addRow(new Object[]{
                    v.getId(),
                    v.getFechaHora().format(formatter),
                    v.getUsuarioId(),
                    "$" + v.getTotal(),
                    v.getEstado()
                });
                
                if (v.isActiva()) {
                    totalDia = totalDia.add(v.getTotal());
                }
            }
            
            lblTotalDia.setText("Total del día: $" + totalDia);
            
        } catch (Exception e) {
            JOptionPane.showMessageDialog(this,
                "Error al cargar ventas: " + e.getMessage(),
                "Error",
                JOptionPane.ERROR_MESSAGE);
        }
    }
    
    private LocalDate calcularFecha(String filtro) {
        switch (filtro) {
            case "Ayer":
                return LocalDate.now().minusDays(1);
            case "Última semana":
                return LocalDate.now().minusWeeks(1);
            default:
                return LocalDate.now();
        }
    }
}
```

---

## ✅ Checklist de Progreso

- [ ] Modelos `Venta` y `VentaDetalle` creados
- [ ] `VentaRepository` con transacciones implementado
- [ ] `VentaService` con validaciones funcionando
- [ ] `VentaPanel` con registro básico operativo
- [ ] Historial de ventas mostrándose correctamente
- [ ] Cálculo de totales funcionando
- [ ] Transacciones JDBC probadas

---

## 💡 Mejoras para Trabajo Autónomo

- Implementar carrito completo con agregar/quitar
- Permitir editar cantidades en el carrito
- Agregar botón de anular venta
- Mostrar detalles de una venta al hacer doble clic
- Implementar impresión de ticket
- Agregar observaciones a la venta

---

## 🔗 Navegación

- ⬅️ [Anterior: CRUD de Productos](02-productos-crud.md)
- ⬅️ [Volver al índice de la clase](00-intro.md)
- ➡️ [Clase 6 - Empaquetado](../06-packaging/00-intro.md) *(próximamente)*

---

**Tiempo estimado:** 40 minutos  
**Dificultad:** Alta

---

> 🎉 **¡Felicitaciones!** Has completado el núcleo funcional del sistema. Ahora tienes un sistema de gestión completo con CRUD, seguridad y transacciones.

