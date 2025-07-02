const db = require('../config/db');

// 1. Ventas por combustible y turno
exports.obtenerVentasCombustibleTurno = (callback) => {
    db.query('CALL reporte_ventas_combustible_por_turno()', (err, resultado) => {
        if (err) return callback(err);
        callback(null, resultado[0]);
    });
};

// 2. Facturas pendientes por empresa
exports.obtenerFacturasPendientes = (callback) => {
    db.query('CALL reporte_facturas_pendientes()', (err, resultado) => {
        if (err) return callback(err);
        callback(null, resultado[0]);
    });
};

// 3. Ingresos diarios y mensuales
exports.obtenerIngresosPorFecha = (desde, hasta, callback) => {
    db.query('CALL reporte_ingresos_por_fecha(?, ?)', [desde, hasta], (err, resultado) => {
        if (err) return callback(err);
        callback(null, resultado[0]);
    });
};

// 4. Comisiones por mes
exports.obtenerComisiones = (mes, callback) => {
    db.query('CALL reporte_comisiones_empleados(?)', [mes], (err, resultado) => {
        if (err) return callback(err);
        callback(null, resultado[0]);
    });
};

// 5. Stock mínimo
exports.obtenerStockMinimo = (callback) => {
    db.query('CALL reporte_stock_minimo()', (err, resultado) => {
        if (err) return callback(err);
        callback(null, resultado[0]);
    });
};
