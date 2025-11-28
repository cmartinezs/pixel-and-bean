# 🎨 Parte 1: Mejoras de UI y Reportes Avanzados (35 minutos)

En esta parte puliremos la interfaz de usuario y agregaremos reportes avanzados con consultas SQL complejas y exportación a CSV.

---

## 🎯 Objetivos

- Agregar iconos a la aplicación
- Implementar barra de estado funcional con reloj
- Crear ventana "Acerca de..."
- Implementar reporte Top 5 Productos
- Agregar exportación a CSV

---

## 🖼️ Paso 1: Iconos y Recursos Visuales (8 min)

### Estructura de Recursos

Crear carpeta de recursos:
```
src/
└── resources/
    └── icons/
        ├── app-icon.png      (icono de la aplicación)
        ├── user.png          (usuarios)
        ├── product.png       (productos)
        ├── sale.png          (ventas)
        ├── report.png        (reportes)
        └── exit.png          (salir)
```

### Cargar Iconos en la Aplicación

Crear clase `CargadorIconos` en el paquete `util`:

```java
package cl.cmartinezs.pnb.util;

import javax.swing.*;
import java.net.URL;

/**
 * Utilidad para cargar iconos de recursos
 */
public class CargadorIconos {
    
    private static final String RUTA_ICONOS = "/icons/";
    
    /**
     * Carga un icono desde los recursos
     * 
     * @param nombre nombre del archivo (ej: "user.png")
     * @return ImageIcon o null si no se encuentra
     */
    public static ImageIcon cargar(String nombre) {
        try {
            URL url = CargadorIconos.class.getResource(RUTA_ICONOS + nombre);
            if (url != null) {
                return new ImageIcon(url);
            }
        } catch (Exception e) {
            System.err.println("Error al cargar icono: " + nombre);
        }
        return null;
    }
    
    /**
     * Carga un icono escalado
     * 
     * @param nombre nombre del archivo
     * @param ancho ancho deseado
     * @param alto alto deseado
     * @return ImageIcon escalado o null
     */
    public static ImageIcon cargarEscalado(String nombre, int ancho, int alto) {
        ImageIcon icono = cargar(nombre);
        if (icono != null) {
            java.awt.Image img = icono.getImage();
            java.awt.Image imgEscalada = img.getScaledInstance(ancho, alto, java.awt.Image.SCALE_SMOOTH);
            return new ImageIcon(imgEscalada);
        }
        return null;
    }
}
```

### Aplicar Iconos al Menú

En `VentanaPrincipal`:

```java
// En el método que crea el menú
private void crearMenu() {
    JMenuBar menuBar = new JMenuBar();
    
    // Menú Archivo
    JMenu menuArchivo = new JMenu("Archivo");
    menuArchivo.setMnemonic('A');
    
    JMenuItem itemCerrarSesion = new JMenuItem("Cerrar Sesión");
    itemCerrarSesion.setIcon(CargadorIconos.cargarEscalado("exit.png", 16, 16));
    itemCerrarSesion.addActionListener(e -> cerrarSesion());
    
    JMenuItem itemSalir = new JMenuItem("Salir");
    itemSalir.setIcon(CargadorIconos.cargarEscalado("exit.png", 16, 16));
    itemSalir.addActionListener(e -> salir());
    
    menuArchivo.add(itemCerrarSesion);
    menuArchivo.addSeparator();
    menuArchivo.add(itemSalir);
    
    // Menú Gestión
    JMenu menuGestion = new JMenu("Gestión");
    menuGestion.setMnemonic('G');
    
    JMenuItem itemUsuarios = new JMenuItem("Usuarios");
    itemUsuarios.setIcon(CargadorIconos.cargarEscalado("user.png", 16, 16));
    itemUsuarios.addActionListener(e -> mostrarUsuarios());
    
    JMenuItem itemProductos = new JMenuItem("Productos");
    itemProductos.setIcon(CargadorIconos.cargarEscalado("product.png", 16, 16));
    itemProductos.addActionListener(e -> mostrarProductos());
    
    menuGestion.add(itemUsuarios);
    menuGestion.add(itemProductos);
    
    // Agregar al menuBar
    menuBar.add(menuArchivo);
    menuBar.add(menuGestion);
    // ... más menús
    
    setJMenuBar(menuBar);
}

// Establecer icono de la aplicación
private void configurarIconoAplicacion() {
    ImageIcon icono = CargadorIconos.cargar("app-icon.png");
    if (icono != null) {
        setIconImage(icono.getImage());
    }
}
```

---

## 📊 Paso 2: Barra de Estado Funcional (7 min)

### Crear Panel de Barra de Estado

```java
package cl.cmartinezs.pnb.gui;

import cl.cmartinezs.pnb.model.Usuario;

import javax.swing.*;
import java.awt.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * Barra de estado inferior de la ventana principal
 */
public class BarraEstado extends JPanel {
    
    private JLabel lblMensaje;
    private JLabel lblUsuario;
    private JLabel lblReloj;
    
    private Timer timer;
    
    public BarraEstado(Usuario usuario) {
        setLayout(new BorderLayout());
        setBorder(BorderFactory.createCompoundBorder(
            BorderFactory.createMatteBorder(1, 0, 0, 0, Color.GRAY),
            BorderFactory.createEmptyBorder(2, 5, 2, 5)
        ));
        
        // Mensaje del sistema (izquierda)
        lblMensaje = new JLabel("Listo");
        lblMensaje.setFont(lblMensaje.getFont().deriveFont(Font.PLAIN, 11f));
        
        // Usuario actual (centro)
        lblUsuario = new JLabel();
        lblUsuario.setFont(lblUsuario.getFont().deriveFont(Font.BOLD, 11f));
        lblUsuario.setHorizontalAlignment(SwingConstants.CENTER);
        actualizarUsuario(usuario);
        
        // Reloj (derecha)
        lblReloj = new JLabel();
        lblReloj.setFont(lblReloj.getFont().deriveFont(Font.PLAIN, 11f));
        lblReloj.setHorizontalAlignment(SwingConstants.RIGHT);
        
        // Layout
        add(lblMensaje, BorderLayout.WEST);
        add(lblUsuario, BorderLayout.CENTER);
        add(lblReloj, BorderLayout.EAST);
        
        // Iniciar reloj
        iniciarReloj();
    }
    
    /**
     * Muestra un mensaje en la barra de estado
     */
    public void mostrarMensaje(String mensaje) {
        lblMensaje.setText(mensaje);
        
        // Limpiar mensaje después de 5 segundos
        Timer timer = new Timer(5000, e -> lblMensaje.setText("Listo"));
        timer.setRepeats(false);
        timer.start();
    }
    
    /**
     * Muestra un mensaje de éxito
     */
    public void mostrarExito(String mensaje) {
        lblMensaje.setForeground(new Color(0, 128, 0));
        mostrarMensaje("✓ " + mensaje);
        Timer timer = new Timer(5000, e -> lblMensaje.setForeground(Color.BLACK));
        timer.setRepeats(false);
        timer.start();
    }
    
    /**
     * Muestra un mensaje de error
     */
    public void mostrarError(String mensaje) {
        lblMensaje.setForeground(Color.RED);
        mostrarMensaje("✗ " + mensaje);
        Timer timer = new Timer(5000, e -> lblMensaje.setForeground(Color.BLACK));
        timer.setRepeats(false);
        timer.start();
    }
    
    /**
     * Actualiza la información del usuario
     */
    public void actualizarUsuario(Usuario usuario) {
        if (usuario != null) {
            String texto = String.format("Usuario: %s | Rol: %s", 
                usuario.getUsername(), 
                usuario.getRol());
            lblUsuario.setText(texto);
        }
    }
    
    /**
     * Inicia el reloj en tiempo real
     */
    private void iniciarReloj() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");
        
        timer = new Timer(1000, e -> {
            String horaActual = LocalDateTime.now().format(formatter);
            lblReloj.setText(horaActual);
        });
        
        timer.start();
        
        // Actualizar inmediatamente
        lblReloj.setText(LocalDateTime.now().format(formatter));
    }
    
    /**
     * Detiene el reloj
     */
    public void detener() {
        if (timer != null) {
            timer.stop();
        }
    }
}
```

### Integrar en VentanaPrincipal

```java
public class VentanaPrincipal extends JFrame {
    
    private BarraEstado barraEstado;
    
    // ...existing code...
    
    private void initComponents() {
        // ...existing code...
        
        // Crear barra de estado
        barraEstado = new BarraEstado(usuarioActual);
        add(barraEstado, BorderLayout.SOUTH);
    }
    
    // Métodos para usar la barra de estado
    
    private void mostrarUsuarios() {
        // ...existing code...
        barraEstado.mostrarMensaje("Mostrando módulo de usuarios");
    }
    
    private void guardarExitoso() {
        barraEstado.mostrarExito("Registro guardado correctamente");
    }
    
    private void errorGuardar(String error) {
        barraEstado.mostrarError("Error al guardar: " + error);
    }
}
```

---

## ℹ️ Paso 3: Ventana "Acerca de..." (5 min)

```java
package cl.cmartinezs.pnb.gui;

import cl.cmartinezs.pnb.util.CargadorIconos;

import javax.swing.*;
import java.awt.*;

/**
 * Diálogo "Acerca de" con información del proyecto
 */
public class AcercaDeDialog extends JDialog {
    
    public AcercaDeDialog(Frame parent) {
        super(parent, "Acerca de Pixel & Bean", true);
        
        initComponents();
        
        pack();
        setLocationRelativeTo(parent);
        setResizable(false);
    }
    
    private void initComponents() {
        setLayout(new BorderLayout(10, 10));
        
        // Panel superior con icono
        JPanel panelSuperior = new JPanel(new FlowLayout(FlowLayout.CENTER));
        panelSuperior.setBackground(Color.WHITE);
        
        ImageIcon icono = CargadorIconos.cargarEscalado("app-icon.png", 64, 64);
        if (icono != null) {
            panelSuperior.add(new JLabel(icono));
        }
        
        // Panel central con información
        JPanel panelInfo = new JPanel();
        panelInfo.setLayout(new BoxLayout(panelInfo, BoxLayout.Y_AXIS));
        panelInfo.setBorder(BorderFactory.createEmptyBorder(10, 20, 10, 20));
        panelInfo.setBackground(Color.WHITE);
        
        JLabel lblNombre = new JLabel("Pixel & Bean");
        lblNombre.setFont(lblNombre.getFont().deriveFont(Font.BOLD, 18f));
        lblNombre.setAlignmentX(Component.CENTER_ALIGNMENT);
        
        JLabel lblSubtitulo = new JLabel("Sistema de Gestión para Café-Arcade");
        lblSubtitulo.setFont(lblSubtitulo.getFont().deriveFont(Font.PLAIN, 12f));
        lblSubtitulo.setAlignmentX(Component.CENTER_ALIGNMENT);
        
        JLabel lblVersion = new JLabel("Versión 1.0.0");
        lblVersion.setFont(lblVersion.getFont().deriveFont(Font.PLAIN, 11f));
        lblVersion.setAlignmentX(Component.CENTER_ALIGNMENT);
        
        JLabel lblFecha = new JLabel("Noviembre 2025");
        lblFecha.setFont(lblFecha.getFont().deriveFont(Font.PLAIN, 11f));
        lblFecha.setAlignmentX(Component.CENTER_ALIGNMENT);
        
        panelInfo.add(lblNombre);
        panelInfo.add(Box.createVerticalStrut(5));
        panelInfo.add(lblSubtitulo);
        panelInfo.add(Box.createVerticalStrut(10));
        panelInfo.add(lblVersion);
        panelInfo.add(lblFecha);
        panelInfo.add(Box.createVerticalStrut(15));
        
        // Separador
        panelInfo.add(new JSeparator());
        panelInfo.add(Box.createVerticalStrut(10));
        
        // Equipo
        JLabel lblEquipo = new JLabel("Desarrollado por:");
        lblEquipo.setFont(lblEquipo.getFont().deriveFont(Font.BOLD, 11f));
        lblEquipo.setAlignmentX(Component.CENTER_ALIGNMENT);
        
        JLabel lblNombres = new JLabel("[Tu Nombre / Equipo]");
        lblNombres.setFont(lblNombres.getFont().deriveFont(Font.PLAIN, 11f));
        lblNombres.setAlignmentX(Component.CENTER_ALIGNMENT);
        
        JLabel lblCurso = new JLabel("Programación Orientada a Objetos");
        lblCurso.setFont(lblCurso.getFont().deriveFont(Font.ITALIC, 10f));
        lblCurso.setAlignmentX(Component.CENTER_ALIGNMENT);
        
        JLabel lblInstitucion = new JLabel("Duoc UC");
        lblInstitucion.setFont(lblInstitucion.getFont().deriveFont(Font.PLAIN, 10f));
        lblInstitucion.setAlignmentX(Component.CENTER_ALIGNMENT);
        
        panelInfo.add(lblEquipo);
        panelInfo.add(Box.createVerticalStrut(5));
        panelInfo.add(lblNombres);
        panelInfo.add(Box.createVerticalStrut(5));
        panelInfo.add(lblCurso);
        panelInfo.add(lblInstitucion);
        
        // Panel inferior con botón
        JPanel panelBotones = new JPanel(new FlowLayout(FlowLayout.CENTER));
        panelBotones.setBackground(Color.WHITE);
        
        JButton btnCerrar = new JButton("Cerrar");
        btnCerrar.addActionListener(e -> dispose());
        panelBotones.add(btnCerrar);
        
        // Agregar todo
        add(panelSuperior, BorderLayout.NORTH);
        add(panelInfo, BorderLayout.CENTER);
        add(panelBotones, BorderLayout.SOUTH);
        
        // Fondo blanco
        getContentPane().setBackground(Color.WHITE);
    }
    
    public static void mostrar(Frame parent) {
        AcercaDeDialog dialogo = new AcercaDeDialog(parent);
        dialogo.setVisible(true);
    }
}
```

---

## 📈 Paso 4: Reporte Top 5 Productos (10 min)

### Modelo de Datos para el Reporte

```java
package cl.cmartinezs.pnb.model;

import java.math.BigDecimal;

/**
 * DTO para el reporte de productos más vendidos
 */
public class ProductoVendido {
    
    private String nombre;
    private int cantidadVendida;
    private BigDecimal totalGenerado;
    
    public ProductoVendido() {
    }
    
    public ProductoVendido(String nombre, int cantidadVendida, BigDecimal totalGenerado) {
        this.nombre = nombre;
        this.cantidadVendida = cantidadVendida;
        this.totalGenerado = totalGenerado;
    }
    
    // Getters y Setters
    
    public String getNombre() {
        return nombre;
    }
    
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    
    public int getCantidadVendida() {
        return cantidadVendida;
    }
    
    public void setCantidadVendida(int cantidadVendida) {
        this.cantidadVendida = cantidadVendida;
    }
    
    public BigDecimal getTotalGenerado() {
        return totalGenerado;
    }
    
    public void setTotalGenerado(BigDecimal totalGenerado) {
        this.totalGenerado = totalGenerado;
    }
}
```

### Consulta SQL en Repositorio

Agregar a `VentaRepository`:

```java
/**
 * Obtiene los productos más vendidos en un rango de fechas
 */
List<ProductoVendido> buscarTopProductos(LocalDate fechaInicio, LocalDate fechaFin, int limite) throws SQLException;
```

Implementar en `VentaRepositoryImpl`:

```java
@Override
public List<ProductoVendido> buscarTopProductos(LocalDate fechaInicio, LocalDate fechaFin, int limite) throws SQLException {
    String sql = "SELECT p.nombre, " +
                 "       SUM(vd.cantidad) as cantidad_vendida, " +
                 "       SUM(vd.subtotal) as total_generado " +
                 "FROM venta_detalle vd " +
                 "JOIN producto p ON vd.producto_id = p.id " +
                 "JOIN venta v ON vd.venta_id = v.id " +
                 "WHERE v.estado = 'ACTIVA' " +
                 "  AND DATE(v.fecha_hora) BETWEEN ? AND ? " +
                 "GROUP BY p.id, p.nombre " +
                 "ORDER BY cantidad_vendida DESC " +
                 "LIMIT ?";
    
    try (Connection conn = connectionFactory.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {
        
        stmt.setDate(1, Date.valueOf(fechaInicio));
        stmt.setDate(2, Date.valueOf(fechaFin));
        stmt.setInt(3, limite);
        
        try (ResultSet rs = stmt.executeQuery()) {
            List<ProductoVendido> productos = new ArrayList<>();
            while (rs.next()) {
                ProductoVendido pv = new ProductoVendido();
                pv.setNombre(rs.getString("nombre"));
                pv.setCantidadVendida(rs.getInt("cantidad_vendida"));
                pv.setTotalGenerado(rs.getBigDecimal("total_generado"));
                productos.add(pv);
            }
            return productos;
        }
    }
}
```

### Panel de Reporte

```java
package cl.cmartinezs.pnb.gui;

import cl.cmartinezs.pnb.model.ProductoVendido;
import cl.cmartinezs.pnb.service.VentaService;

import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.time.LocalDate;
import java.util.List;

/**
 * Panel de reporte Top 5 Productos
 */
public class TopProductosPanel extends JPanel {
    
    private final VentaService ventaService;
    
    private JComboBox<String> cboRango;
    private JButton btnGenerar;
    private JTable tblProductos;
    private DefaultTableModel modelo;
    private JLabel lblTotalGeneral;
    
    public TopProductosPanel(VentaService ventaService) {
        this.ventaService = ventaService;
        
        initComponents();
        layoutComponents();
    }
    
    private void initComponents() {
        cboRango = new JComboBox<>(new String[]{
            "Hoy", "Última semana", "Último mes", "Último año"
        });
        
        btnGenerar = new JButton("Generar Reporte");
        btnGenerar.addActionListener(e -> generarReporte());
        
        String[] columnas = {"Posición", "Producto", "Cantidad Vendida", "Total Generado"};
        modelo = new DefaultTableModel(columnas, 0) {
            @Override
            public boolean isCellEditable(int row, int column) {
                return false;
            }
        };
        tblProductos = new JTable(modelo);
        
        lblTotalGeneral = new JLabel("Total General: $0");
        lblTotalGeneral.setFont(lblTotalGeneral.getFont().deriveFont(Font.BOLD, 14f));
    }
    
    private void layoutComponents() {
        setLayout(new BorderLayout(10, 10));
        setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));
        
        // Panel superior
        JPanel panelSuperior = new JPanel(new FlowLayout(FlowLayout.LEFT));
        panelSuperior.add(new JLabel("Rango:"));
        panelSuperior.add(cboRango);
        panelSuperior.add(btnGenerar);
        
        // Tabla
        JScrollPane scroll = new JScrollPane(tblProductos);
        
        // Panel inferior
        JPanel panelInferior = new JPanel(new FlowLayout(FlowLayout.LEFT));
        panelInferior.add(lblTotalGeneral);
        
        add(panelSuperior, BorderLayout.NORTH);
        add(scroll, BorderLayout.CENTER);
        add(panelInferior, BorderLayout.SOUTH);
    }
    
    private void generarReporte() {
        try {
            String rango = (String) cboRango.getSelectedItem();
            LocalDate[] fechas = calcularFechas(rango);
            
            List<ProductoVendido> productos = ventaService.topProductos(
                fechas[0], fechas[1], 5
            );
            
            modelo.setRowCount(0);
            
            int posicion = 1;
            java.math.BigDecimal totalGeneral = java.math.BigDecimal.ZERO;
            
            for (ProductoVendido pv : productos) {
                modelo.addRow(new Object[]{
                    posicion++,
                    pv.getNombre(),
                    pv.getCantidadVendida(),
                    "$" + pv.getTotalGenerado()
                });
                
                totalGeneral = totalGeneral.add(pv.getTotalGenerado());
            }
            
            lblTotalGeneral.setText("Total General: $" + totalGeneral);
            
        } catch (Exception e) {
            JOptionPane.showMessageDialog(this,
                "Error al generar reporte: " + e.getMessage(),
                "Error",
                JOptionPane.ERROR_MESSAGE);
        }
    }
    
    private LocalDate[] calcularFechas(String rango) {
        LocalDate fin = LocalDate.now();
        LocalDate inicio;
        
        switch (rango) {
            case "Hoy":
                inicio = fin;
                break;
            case "Última semana":
                inicio = fin.minusWeeks(1);
                break;
            case "Último mes":
                inicio = fin.minusMonths(1);
                break;
            case "Último año":
                inicio = fin.minusYears(1);
                break;
            default:
                inicio = fin;
        }
        
        return new LocalDate[]{inicio, fin};
    }
}
```

---

## 📄 Paso 5: Exportación a CSV (5 min)

```java
package cl.cmartinezs.pnb.util;

import javax.swing.*;
import javax.swing.table.TableModel;
import java.io.FileWriter;
import java.io.IOException;

/**
 * Utilidad para exportar tablas a formato CSV
 */
public class ExportadorCSV {
    
    /**
     * Exporta una JTable a archivo CSV
     */
    public static void exportarTabla(JTable tabla, String nombreArchivo) throws IOException {
        TableModel modelo = tabla.getModel();
        
        try (FileWriter writer = new FileWriter(nombreArchivo)) {
            // Escribir encabezados
            for (int col = 0; col < modelo.getColumnCount(); col++) {
                writer.write(escaparCSV(modelo.getColumnName(col)));
                if (col < modelo.getColumnCount() - 1) {
                    writer.write(",");
                }
            }
            writer.write("\n");
            
            // Escribir filas
            for (int row = 0; row < modelo.getRowCount(); row++) {
                for (int col = 0; col < modelo.getColumnCount(); col++) {
                    Object valor = modelo.getValueAt(row, col);
                    String texto = valor != null ? valor.toString() : "";
                    writer.write(escaparCSV(texto));
                    if (col < modelo.getColumnCount() - 1) {
                        writer.write(",");
                    }
                }
                writer.write("\n");
            }
        }
    }
    
    /**
     * Escapa caracteres especiales para CSV
     */
    private static String escaparCSV(String valor) {
        if (valor.contains(",") || valor.contains("\"") || valor.contains("\n")) {
            valor = "\"" + valor.replace("\"", "\"\"") + "\"";
        }
        return valor;
    }
    
    /**
     * Muestra diálogo para exportar tabla
     */
    public static void mostrarDialogoExportar(JTable tabla, Component parent) {
        JFileChooser fileChooser = new JFileChooser();
        fileChooser.setDialogTitle("Exportar a CSV");
        fileChooser.setSelectedFile(new java.io.File("reporte.csv"));
        
        int resultado = fileChooser.showSaveDialog(parent);
        
        if (resultado == JFileChooser.APPROVE_OPTION) {
            try {
                String ruta = fileChooser.getSelectedFile().getAbsolutePath();
                if (!ruta.toLowerCase().endsWith(".csv")) {
                    ruta += ".csv";
                }
                
                exportarTabla(tabla, ruta);
                
                JOptionPane.showMessageDialog(parent,
                    "Archivo exportado exitosamente:\n" + ruta,
                    "Exportación Exitosa",
                    JOptionPane.INFORMATION_MESSAGE);
                    
            } catch (IOException e) {
                JOptionPane.showMessageDialog(parent,
                    "Error al exportar: " + e.getMessage(),
                    "Error",
                    JOptionPane.ERROR_MESSAGE);
            }
        }
    }
}
```

### Agregar Botón de Exportación

En cualquier panel con tabla:

```java
private void agregarBotonExportar(JPanel panel, JTable tabla) {
    JButton btnExportar = new JButton("Exportar a CSV");
    btnExportar.setIcon(CargadorIconos.cargarEscalado("export.png", 16, 16));
    btnExportar.addActionListener(e -> ExportadorCSV.mostrarDialogoExportar(tabla, this));
    
    panel.add(btnExportar);
}
```

---

## ✅ Checklist de Progreso

- [ ] Iconos agregados a la aplicación
- [ ] Barra de estado implementada y funcional
- [ ] Reloj en tiempo real funcionando
- [ ] Ventana "Acerca de..." creada
- [ ] Reporte Top 5 Productos implementado
- [ ] Exportación a CSV funcionando
- [ ] Mejoras visuales aplicadas

---

## 🔗 Navegación

- ⬅️ [Volver al índice de la clase](00-intro.md)
- ➡️ [Siguiente: Empaquetado](02-empaquetado.md)

---

**Tiempo estimado:** 35 minutos  
**Dificultad:** Media

