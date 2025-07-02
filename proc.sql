DELIMITER $$

CREATE PROCEDURE reporte_ventas_combustible_por_turno()
BEGIN
    SELECT 
        t.id_turno,
        t.nombre AS turno,
        p.nombre AS producto,
        SUM(dv.cantidad) AS litros_vendidos,
        SUM(dv.subtotal) AS total_generado
    FROM venta v
    JOIN detalle_venta dv ON v.id_venta = dv.id_venta
    JOIN producto p ON dv.id_producto = p.id_producto
    JOIN empleado_turno et ON v.id_empleado = et.id_empleado AND et.id_turno = v.id_turno
    JOIN turno t ON et.id_turno = t.id_turno
    WHERE p.tipo = 'combustible'
    GROUP BY t.id_turno, p.id_producto;
END$$

DELIMITER ;



DELIMITER $$

CREATE PROCEDURE reporte_facturas_pendientes()
BEGIN
    SELECT 
        f.id_factura,
        c.nombre AS cliente,
        f.total,
        f.fecha_emision,
        f.fecha_vencimiento,
        f.estado_pago
    FROM factura f
    JOIN cliente c ON f.id_cliente = c.id_cliente
    WHERE f.estado_pago IN ('pendiente', 'vencido');
END$$

DELIMITER ;


DELIMITER $$

CREATE PROCEDURE reporte_ingresos_por_fecha(IN fecha_inicio DATE, IN fecha_fin DATE)
BEGIN
    SELECT 
        v.metodo_pago,
        DATE(v.fecha) AS dia,
        SUM(v.total) AS total_diario
    FROM venta v
    WHERE v.fecha BETWEEN fecha_inicio AND fecha_fin
    GROUP BY DATE(v.fecha), v.metodo_pago
    ORDER BY DATE(v.fecha);
END$$

DELIMITER ;



DELIMITER $$

CREATE PROCEDURE reporte_comisiones_empleados(IN mes_nombre VARCHAR(20))
BEGIN
    SELECT 
        e.nombre AS empleado,
        c.litros_vendidos,
        c.meta_cumplida,
        c.monto_bonificacion
    FROM comision c
    JOIN empleado e ON c.id_empleado = e.id_empleado
    WHERE c.mes = mes_nombre;
END$$

DELIMITER ;




DELIMITER $$

CREATE PROCEDURE reporte_stock_minimo()
BEGIN
    SELECT 
        s.nombre AS sucursal,
        p.nombre AS producto,
        t.nivel_actual,
        p.stock_minimo,
        CASE
            WHEN t.nivel_actual < p.stock_minimo THEN 'ALERTA: Bajo stock'
            ELSE 'OK'
        END AS estado_stock
    FROM tanque t
    JOIN producto p ON t.id_producto = p.id_producto
    JOIN sucursal s ON t.id_sucursal = s.id_sucursal;
END$$

DELIMITER ;


