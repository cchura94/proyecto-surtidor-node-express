CREATE DATABASE bd_surtidorandino_srl;
use bd_surtidorandino_srl;

CREATE TABLE sucursal (
    id_sucursal INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    ubicacion VARCHAR(200)
);

CREATE TABLE empleado (
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    cargo VARCHAR(50),
    id_sucursal INT,
    FOREIGN KEY (id_sucursal) REFERENCES sucursal(id_sucursal)
);

CREATE TABLE turno (
    id_turno INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    fecha DATE,
    hora_inicio TIME,
    hora_fin TIME,
    id_sucursal INT,
    FOREIGN KEY (id_sucursal) REFERENCES sucursal(id_sucursal)
);

CREATE TABLE empleado_turno (
    id_empleado INT,
    id_turno INT,
    horas_trabajadas DECIMAL(5,2),
    litros_vendidos DECIMAL(10,2),
    meta_alcanzada BOOLEAN,
    PRIMARY KEY (id_empleado, id_turno),
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado),
    FOREIGN KEY (id_turno) REFERENCES turno(id_turno)
);

CREATE TABLE cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    tipo ENUM('particular', 'empresa'),
    nit VARCHAR(20),
    convenio BOOLEAN
);

CREATE TABLE vehiculo (
    id_vehiculo INT AUTO_INCREMENT PRIMARY KEY,
    placa VARCHAR(20),
    tipo ENUM('publico', 'privado'),
    id_cliente INT,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

CREATE TABLE producto (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    tipo ENUM('combustible', 'complementario'),
    unidad_medida VARCHAR(20),
    precio_unitario DECIMAL(10,2),
    stock_minimo DECIMAL(10,2),
    es_promocionable BOOLEAN,
    activo BOOLEAN
);

CREATE TABLE tanque (
    id_tanque INT AUTO_INCREMENT PRIMARY KEY,
    capacidad DECIMAL(10,2),
    nivel_actual DECIMAL(10,2),
    id_producto INT,
    id_sucursal INT,
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
    FOREIGN KEY (id_sucursal) REFERENCES sucursal(id_sucursal)
);

CREATE TABLE carga_tanque (
    id_carga INT AUTO_INCREMENT PRIMARY KEY,
    id_tanque INT,
    fecha_carga DATE,
    proveedor VARCHAR(100),
    cantidad DECIMAL(10,2),
    FOREIGN KEY (id_tanque) REFERENCES tanque(id_tanque)
);

CREATE TABLE surtidor (
    id_surtidor INT AUTO_INCREMENT PRIMARY KEY,
    estado ENUM('operativo', 'mantenimiento'),
    id_sucursal INT,
    id_tanque INT,
    FOREIGN KEY (id_sucursal) REFERENCES sucursal(id_sucursal),
    FOREIGN KEY (id_tanque) REFERENCES tanque(id_tanque)
);

CREATE TABLE factura (
    id_factura INT AUTO_INCREMENT PRIMARY KEY,
    fecha_emision DATE,
    fecha_vencimiento DATE,
    estado_pago ENUM('pagado', 'pendiente', 'vencido'),
    total DECIMAL(10,2),
    siat_referencia VARCHAR(100),
    id_cliente INT,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

CREATE TABLE venta (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATE,
    hora TIME,
    metodo_pago ENUM('contado', 'qr', 'transferencia', 'convenio'),
    total DECIMAL(10,2),
    id_empleado INT,
    id_sucursal INT,
    id_surtidor INT,
    id_cliente INT,
    id_factura INT NULL,
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado),
    FOREIGN KEY (id_sucursal) REFERENCES sucursal(id_sucursal),
    FOREIGN KEY (id_surtidor) REFERENCES surtidor(id_surtidor),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_factura) REFERENCES factura(id_factura)
);

CREATE TABLE detalle_venta (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_venta INT,
    id_producto INT,
    cantidad DECIMAL(10,2),
    precio_unitario DECIMAL(10,2),
    subtotal DECIMAL(10,2),
    FOREIGN KEY (id_venta) REFERENCES venta(id_venta),
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

CREATE TABLE comision (
    id_comision INT AUTO_INCREMENT PRIMARY KEY,
    mes VARCHAR(20),
    litros_vendidos DECIMAL(10,2),
    meta_cumplida BOOLEAN,
    monto_bonificacion DECIMAL(10,2),
    id_empleado INT,
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado)
);

