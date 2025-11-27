# 👥 Parte 1: CRUD Completo de Usuarios (30 minutos)

En esta parte implementaremos todas las operaciones CRUD para el módulo de Usuarios, incluyendo validaciones, hash de contraseñas y control de acceso por roles.

---

## 🎯 Objetivos

- Crear formulario de usuario (crear/editar)
- Implementar validaciones de negocio
- Agregar hash de contraseñas (SHA-256)
- Controlar acceso (solo ADMIN)
- Refrescar tabla después de operaciones

---

## 🔐 Paso 1: Utilidad para Hash de Contraseñas (5 min)

### ¿Por qué hashear contraseñas?
- **Seguridad:** Si la BD es comprometida, las contraseñas no se leen en texto plano
- **Buena práctica:** Nunca almacenar credenciales sin protección
- **Estándar:** SHA-256 es un algoritmo ampliamente usado (aunque BCrypt es mejor)

### Implementación

Crear la clase `PasswordHasher` en el paquete `util`:

```java
package cl.tuusuario.pnb.util;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * Utilidad para hashear contraseñas usando SHA-256
 * 
 * @author Carlos Martínez
 */
public class PasswordHasher {
    
    /**
     * Convierte una contraseña en texto plano a su hash SHA-256
     * 
     * @param plainPassword contraseña en texto plano
     * @return hash de la contraseña en hexadecimal
     */
    public static String hashPassword(String plainPassword) {
        if (plainPassword == null || plainPassword.isEmpty()) {
            throw new IllegalArgumentException("La contraseña no puede ser nula o vacía");
        }
        
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hashBytes = digest.digest(plainPassword.getBytes(StandardCharsets.UTF_8));
            
            // Convertir bytes a hexadecimal
            StringBuilder hexString = new StringBuilder();
            for (byte b : hashBytes) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) {
                    hexString.append('0');
                }
                hexString.append(hex);
            }
            
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error al hashear contraseña", e);
        }
    }
    
    /**
     * Verifica si una contraseña en texto plano coincide con un hash
     * 
     * @param plainPassword contraseña en texto plano
     * @param hashedPassword hash almacenado
     * @return true si coinciden, false en caso contrario
     */
    public static boolean verifyPassword(String plainPassword, String hashedPassword) {
        String hashOfInput = hashPassword(plainPassword);
        return hashOfInput.equals(hashedPassword);
    }
}
```

### 💡 Notas sobre SHA-256
- **Ventaja:** Rápido y disponible en Java sin librerías externas
- **Desventaja:** No incluye "salt" (sal) para prevenir rainbow tables
- **Mejora futura:** Usar BCrypt, Argon2 o PBKDF2 con sal

---

## 🔄 Paso 2: Actualizar Script de Base de Datos (5 min)

### Actualizar contraseñas existentes

Necesitamos convertir las contraseñas del seed a hash. Crear un nuevo archivo opcional:

**`/docs/sql/03_update_passwords.sql`**

```sql
-- Actualizar contraseñas a hash SHA-256
-- admin123 → 240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9
-- op123 → a80e3c87dcb08e52e6c7d3bc40d3f22ae3dc0a8f5e88d2e3c832daeba064f6b4

UPDATE usuario 
SET password = '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9'
WHERE username = 'admin';

UPDATE usuario 
SET password = 'a80e3c87dcb08e52e6c7d3bc40d3f22ae3dc0a8f5e88d2e3c832daeba064f6b4'
WHERE username = 'operador';

-- Verificar
SELECT id, username, 
       LEFT(password, 20) as password_hash,
       rol, activo
FROM usuario;
```

**Ejecutar en phpMyAdmin o MySQL Workbench:**
```sql
USE pixelandbean;
SOURCE /ruta/al/proyecto/docs/sql/03_update_passwords.sql;
```

### Alternativa rápida (UPDATE directo)
Si prefieres no crear archivo, ejecuta directamente:
```sql
UPDATE usuario SET password = '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9' WHERE username = 'admin';
UPDATE usuario SET password = 'a80e3c87dcb08e52e6c7d3bc40d3f22ae3dc0a8f5e88d2e3c832daeba064f6b4' WHERE username = 'operador';
```

---

## 🎨 Paso 3: Formulario de Usuario (10 min)

### Diseño del Formulario

Crear `UsuarioDialog.java` en el paquete `gui`:

```java
package cl.tuusuario.pnb.gui;

import cl.tuusuario.pnb.model.Usuario;
import cl.tuusuario.pnb.model.Rol;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

/**
 * Diálogo para crear/editar usuarios
 */
public class UsuarioDialog extends JDialog {
    
    // Componentes
    private JTextField txtUsername;
    private JPasswordField txtPassword;
    private JPasswordField txtPasswordConfirm;
    private JTextField txtNombreCompleto;
    private JComboBox<Rol> cboRol;
    private JCheckBox chkActivo;
    
    private JButton btnGuardar;
    private JButton btnCancelar;
    
    // Estado
    private Usuario usuario;  // null = crear, no null = editar
    private boolean confirmado = false;
    
    /**
     * Constructor para crear nuevo usuario
     */
    public UsuarioDialog(Frame parent) {
        this(parent, null);
    }
    
    /**
     * Constructor para editar usuario existente
     */
    public UsuarioDialog(Frame parent, Usuario usuario) {
        super(parent, usuario == null ? "Nuevo Usuario" : "Editar Usuario", true);
        this.usuario = usuario;
        
        initComponents();
        layoutComponents();
        setupListeners();
        
        if (usuario != null) {
            cargarDatos();
        }
        
        pack();
        setLocationRelativeTo(parent);
        setResizable(false);
    }
    
    private void initComponents() {
        txtUsername = new JTextField(20);
        txtPassword = new JPasswordField(20);
        txtPasswordConfirm = new JPasswordField(20);
        txtNombreCompleto = new JTextField(30);
        cboRol = new JComboBox<>(Rol.values());
        chkActivo = new JCheckBox("Activo");
        chkActivo.setSelected(true);
        
        btnGuardar = new JButton("Guardar");
        btnCancelar = new JButton("Cancelar");
        
        // Si es edición, el username no es editable
        if (usuario != null) {
            txtUsername.setEditable(false);
            txtUsername.setBackground(Color.LIGHT_GRAY);
        }
    }
    
    private void layoutComponents() {
        JPanel panelCampos = new JPanel(new GridBagLayout());
        panelCampos.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));
        
        GridBagConstraints gbc = new GridBagConstraints();
        gbc.insets = new Insets(5, 5, 5, 5);
        gbc.anchor = GridBagConstraints.WEST;
        
        // Username
        gbc.gridx = 0; gbc.gridy = 0;
        panelCampos.add(new JLabel("Username:*"), gbc);
        gbc.gridx = 1; gbc.fill = GridBagConstraints.HORIZONTAL;
        panelCampos.add(txtUsername, gbc);
        
        // Password
        gbc.gridx = 0; gbc.gridy = 1; gbc.fill = GridBagConstraints.NONE;
        String labelPassword = usuario == null ? "Contraseña:*" : "Nueva Contraseña:";
        panelCampos.add(new JLabel(labelPassword), gbc);
        gbc.gridx = 1; gbc.fill = GridBagConstraints.HORIZONTAL;
        panelCampos.add(txtPassword, gbc);
        
        // Confirmar password
        gbc.gridx = 0; gbc.gridy = 2; gbc.fill = GridBagConstraints.NONE;
        panelCampos.add(new JLabel("Confirmar:*"), gbc);
        gbc.gridx = 1; gbc.fill = GridBagConstraints.HORIZONTAL;
        panelCampos.add(txtPasswordConfirm, gbc);
        
        // Nombre completo
        gbc.gridx = 0; gbc.gridy = 3; gbc.fill = GridBagConstraints.NONE;
        panelCampos.add(new JLabel("Nombre Completo:"), gbc);
        gbc.gridx = 1; gbc.fill = GridBagConstraints.HORIZONTAL;
        panelCampos.add(txtNombreCompleto, gbc);
        
        // Rol
        gbc.gridx = 0; gbc.gridy = 4; gbc.fill = GridBagConstraints.NONE;
        panelCampos.add(new JLabel("Rol:*"), gbc);
        gbc.gridx = 1; gbc.fill = GridBagConstraints.HORIZONTAL;
        panelCampos.add(cboRol, gbc);
        
        // Activo
        gbc.gridx = 1; gbc.gridy = 5;
        panelCampos.add(chkActivo, gbc);
        
        // Nota
        if (usuario == null) {
            gbc.gridx = 0; gbc.gridy = 6; gbc.gridwidth = 2;
            JLabel lblNota = new JLabel("* Campos obligatorios");
            lblNota.setFont(lblNota.getFont().deriveFont(Font.ITALIC, 11f));
            panelCampos.add(lblNota, gbc);
        } else {
            gbc.gridx = 0; gbc.gridy = 6; gbc.gridwidth = 2;
            JLabel lblNota = new JLabel("* Dejar en blanco para mantener contraseña actual");
            lblNota.setFont(lblNota.getFont().deriveFont(Font.ITALIC, 11f));
            panelCampos.add(lblNota, gbc);
        }
        
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
        
        txtUsername.addKeyListener(enterListener);
        txtPassword.addKeyListener(enterListener);
        txtPasswordConfirm.addKeyListener(enterListener);
        txtNombreCompleto.addKeyListener(enterListener);
        
        // ESC -> cancelar
        KeyAdapter escListener = new KeyAdapter() {
            @Override
            public void keyPressed(KeyEvent e) {
                if (e.getKeyCode() == KeyEvent.VK_ESCAPE) {
                    cancelar();
                }
            }
        };
        
        getRootPane().addKeyListener(escListener);
    }
    
    private void cargarDatos() {
        txtUsername.setText(usuario.getUsername());
        txtNombreCompleto.setText(usuario.getNombreCompleto());
        cboRol.setSelectedItem(usuario.getRol());
        chkActivo.setSelected(usuario.isActivo());
        
        // No cargar password (es hash)
        txtPassword.setText("");
        txtPasswordConfirm.setText("");
    }
    
    private void guardar() {
        // Validar campos
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
        String username = txtUsername.getText().trim();
        String password = new String(txtPassword.getPassword());
        String passwordConfirm = new String(txtPasswordConfirm.getPassword());
        
        // Username obligatorio
        if (username.isEmpty()) {
            JOptionPane.showMessageDialog(this,
                "El username es obligatorio",
                "Error de Validación",
                JOptionPane.ERROR_MESSAGE);
            txtUsername.requestFocus();
            return false;
        }
        
        // Username: solo letras, números y guión bajo
        if (!username.matches("^[a-zA-Z0-9_]+$")) {
            JOptionPane.showMessageDialog(this,
                "El username solo puede contener letras, números y guión bajo",
                "Error de Validación",
                JOptionPane.ERROR_MESSAGE);
            txtUsername.requestFocus();
            return false;
        }
        
        // Password obligatorio solo al crear
        if (usuario == null) {
            if (password.isEmpty()) {
                JOptionPane.showMessageDialog(this,
                    "La contraseña es obligatoria",
                    "Error de Validación",
                    JOptionPane.ERROR_MESSAGE);
                txtPassword.requestFocus();
                return false;
            }
        }
        
        // Si ingresó password, validar
        if (!password.isEmpty()) {
            // Longitud mínima
            if (password.length() < 4) {
                JOptionPane.showMessageDialog(this,
                    "La contraseña debe tener al menos 4 caracteres",
                    "Error de Validación",
                    JOptionPane.ERROR_MESSAGE);
                txtPassword.requestFocus();
                return false;
            }
            
            // Confirmar password
            if (!password.equals(passwordConfirm)) {
                JOptionPane.showMessageDialog(this,
                    "Las contraseñas no coinciden",
                    "Error de Validación",
                    JOptionPane.ERROR_MESSAGE);
                txtPasswordConfirm.requestFocus();
                return false;
            }
        }
        
        return true;
    }
    
    // Getters para obtener los datos
    
    public boolean isConfirmado() {
        return confirmado;
    }
    
    public String getUsername() {
        return txtUsername.getText().trim();
    }
    
    public String getPassword() {
        String pwd = new String(txtPassword.getPassword());
        return pwd.isEmpty() ? null : pwd;
    }
    
    public String getNombreCompleto() {
        return txtNombreCompleto.getText().trim();
    }
    
    public Rol getRol() {
        return (Rol) cboRol.getSelectedItem();
    }
    
    public boolean isActivo() {
        return chkActivo.isSelected();
    }
    
    /**
     * Construye el objeto Usuario con los datos del formulario
     */
    public Usuario getUsuario() {
        if (usuario == null) {
            usuario = new Usuario();
        }
        
        usuario.setUsername(getUsername());
        usuario.setNombreCompleto(getNombreCompleto());
        usuario.setRol(getRol());
        usuario.setActivo(isActivo());
        
        // Password solo si se ingresó
        String pwd = getPassword();
        if (pwd != null) {
            usuario.setPassword(pwd);  // Se hasheará en el servicio
        }
        
        return usuario;
    }
}
```

---

## 💼 Paso 4: Operaciones CRUD en Repositorio (5 min)

### Completar `UsuarioRepositoryImpl`

Agregar los métodos faltantes:

```java
@Override
public void update(Usuario usuario) throws SQLException {
    String sql = "UPDATE usuario SET password = ?, nombre_completo = ?, rol = ?, activo = ? " +
                 "WHERE username = ?";
    
    try (Connection conn = connectionFactory.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {
        
        stmt.setString(1, usuario.getPassword());
        stmt.setString(2, usuario.getNombreCompleto());
        stmt.setString(3, usuario.getRol().name());
        stmt.setBoolean(4, usuario.isActivo());
        stmt.setString(5, usuario.getUsername());
        
        int rowsAffected = stmt.executeUpdate();
        if (rowsAffected == 0) {
            throw new SQLException("Usuario no encontrado: " + usuario.getUsername());
        }
    }
}

@Override
public void delete(String username) throws SQLException {
    String sql = "DELETE FROM usuario WHERE username = ?";
    
    try (Connection conn = connectionFactory.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {
        
        stmt.setString(1, username);
        
        int rowsAffected = stmt.executeUpdate();
        if (rowsAffected == 0) {
            throw new SQLException("Usuario no encontrado: " + username);
        }
    }
}

@Override
public boolean existsByUsername(String username) throws SQLException {
    String sql = "SELECT COUNT(*) FROM usuario WHERE username = ?";
    
    try (Connection conn = connectionFactory.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {
        
        stmt.setString(1, username);
        
        try (ResultSet rs = stmt.executeQuery()) {
            return rs.next() && rs.getInt(1) > 0;
        }
    }
}
```

---

## 🔧 Paso 5: Lógica de Negocio en Servicio (5 min)

### Completar `UsuarioServiceImpl`

```java
package cl.tuusuario.pnb.service.impl;

import cl.tuusuario.pnb.model.Usuario;
import cl.tuusuario.pnb.repository.UsuarioRepository;
import cl.tuusuario.pnb.service.UsuarioService;
import cl.tuusuario.pnb.util.PasswordHasher;

import java.sql.SQLException;
import java.util.List;

public class UsuarioServiceImpl implements UsuarioService {
    
    private final UsuarioRepository usuarioRepository;
    
    public UsuarioServiceImpl(UsuarioRepository usuarioRepository) {
        this.usuarioRepository = usuarioRepository;
    }
    
    @Override
    public void crear(Usuario usuario) throws SQLException {
        // Validar username único
        if (usuarioRepository.existsByUsername(usuario.getUsername())) {
            throw new IllegalArgumentException("El username ya existe: " + usuario.getUsername());
        }
        
        // Validar campos obligatorios
        if (usuario.getUsername() == null || usuario.getUsername().trim().isEmpty()) {
            throw new IllegalArgumentException("El username es obligatorio");
        }
        
        if (usuario.getPassword() == null || usuario.getPassword().trim().isEmpty()) {
            throw new IllegalArgumentException("La contraseña es obligatoria");
        }
        
        // Hashear contraseña
        String hashedPassword = PasswordHasher.hashPassword(usuario.getPassword());
        usuario.setPassword(hashedPassword);
        
        // Crear
        usuarioRepository.save(usuario);
    }
    
    @Override
    public void actualizar(Usuario usuario) throws SQLException {
        // Validar que existe
        if (!usuarioRepository.existsByUsername(usuario.getUsername())) {
            throw new IllegalArgumentException("Usuario no encontrado: " + usuario.getUsername());
        }
        
        // Si hay nueva contraseña, hashearla
        if (usuario.getPassword() != null && !usuario.getPassword().trim().isEmpty()) {
            String hashedPassword = PasswordHasher.hashPassword(usuario.getPassword());
            usuario.setPassword(hashedPassword);
        } else {
            // Mantener contraseña actual (buscar la existente)
            Usuario actual = usuarioRepository.findByUsername(usuario.getUsername());
            usuario.setPassword(actual.getPassword());
        }
        
        // Actualizar
        usuarioRepository.update(usuario);
    }
    
    @Override
    public void eliminar(String username) throws SQLException {
        // No permitir eliminar admin
        if ("admin".equals(username)) {
            throw new IllegalArgumentException("No se puede eliminar el usuario admin");
        }
        
        usuarioRepository.delete(username);
    }
    
    @Override
    public List<Usuario> listarTodos() throws SQLException {
        return usuarioRepository.findAll();
    }
    
    @Override
    public Usuario buscarPorUsername(String username) throws SQLException {
        return usuarioRepository.findByUsername(username);
    }
}
```

---

## 🎮 Paso 6: Integrar en el Panel de Usuarios (Continuará)

En el siguiente paso integraremos el formulario en `UsuariosPanel` para crear, editar y eliminar usuarios desde la tabla.

[Ver implementación completa en el código fuente]

---

## ✅ Checklist de Progreso

- [ ] `PasswordHasher` creado y probado
- [ ] Contraseñas de seed actualizadas a hash
- [ ] `UsuarioDialog` implementado
- [ ] Métodos CRUD completados en repositorio
- [ ] Validaciones en servicio implementadas
- [ ] Hash de contraseñas funcionando
- [ ] Integración con `UsuariosPanel`

---

## 🔗 Navegación

- ⬅️ [Volver al índice de la clase](00-intro.md)
- ➡️ [Siguiente: CRUD de Productos](02-productos-crud.md)

---

**Tiempo estimado:** 30 minutos  
**Dificultad:** Media-Alta

