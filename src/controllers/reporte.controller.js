const reporteModel = require('../models/reportesModel');


exports.vistaMenuReportes = (req, res) => {
    res.render('reportes/index');
  };

// 1. Ventas por turno y tipo de producto
exports.reporteVentasCombustibleTurno = (req, res) => {
    reporteModel.obtenerVentasCombustibleTurno((err, datos) => {
        if (err) console.error(err);
        res.render('reportes/ventasCombustibleTurno', { ventas: datos });
    });
};

// 2. Facturas pendientes
exports.reporteFacturasPendientes = (req, res) => {
    reporteModel.obtenerFacturasPendientes((err, datos) => {
        if (err) console.error(err);
        res.render('reportes/facturasPendientes', { facturas: datos });
    });
};

// 3. Ingresos por fecha
exports.reporteIngresos = (req, res) => {
    const { desde, hasta } = req.query;
    if (!desde || !hasta) {
        return res.status(400).send("Faltan parámetros: desde y hasta");
    }
    reporteModel.obtenerIngresosPorFecha(desde, hasta, (err, datos) => {
        if (err) console.error(err);
        res.render('reportes/ingresosPorFecha', { ingresos: datos, desde, hasta });
    });
};

// 4. Comisiones
exports.reporteComisiones = (req, res) => {
    const { mes } = req.query;
    if (!mes) {
        return res.status(400).send("Debe especificar el mes");
    }
    reporteModel.obtenerComisiones(mes, (err, datos) => {
        if (err) console.error(err);
        res.render('reportes/comisiones', { comisiones: datos, mes });
    });
};

// 5. Stock mínimo
exports.reporteStockMinimo = (req, res) => {
    reporteModel.obtenerStockMinimo((err, datos) => {
        if (err) console.error(err);
        res.render('reportes/stockTanques', { stocks: datos });
    });
};


exports.vistaFormularioIngresos = (req, res) => {
    res.render('reportes/form_ingresos');
  };
  