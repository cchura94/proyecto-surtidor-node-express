const mysql = require('mysql')
const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'bd_surtidorandino_srl'
})

connection.connect( (error) => {
    if (error) {
        console.log("Error de Conexion", error);
    } else {
        console.log("Se conecto exitosamente");
    }
});
module.exports = connection;