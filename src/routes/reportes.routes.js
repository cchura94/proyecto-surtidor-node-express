const express = require('express');
const router = express.Router();
const repController = require('../controllers/reporte.controller');

router.get('/', repController.vistaMenuReportes);

// Las rutas
router.get('/ventas-combustible-turno', repController.reporteVentasCombustibleTurno);
router.get('/facturas-pendientes', repController.reporteFacturasPendientes);
router.get('/ingresos', repController.reporteIngresos); // enviar datos ?desde=YYYY-MM-DD&hasta=YYYY-MM-DD
router.get('/comisiones', repController.reporteComisiones); // enviar datos ?mes=Junio
router.get('/stock', repController.reporteStockMinimo);
router.get('/form-ingresos', repController.vistaFormularioIngresos);


module.exports = router;

