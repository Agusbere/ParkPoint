using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using Dapper;
public class BD
{
    private static string _connectionString = @"Server=localhost; DataBase=ParkPoint; Trusted_Connection=True ;";

    public static Usuario Registrarse(string Nombre, string Apellido, string Email, string Contrasena, string Patente, int IdMarca, int IdModelo)
{
    using (SqlConnection db = new SqlConnection(_connectionString))
    {
      
        string sql = "EXEC SP_Registrarse @Nombre, @Apellido, @Email, @Contrasena, @Patente, @IdMarca, @IdModelo";
        db.Execute(sql, new
        {
            @Nombre = Nombre,
            @Apellido = Apellido,
            @Email = Email,
            @Contrasena = Contrasena,
            @Patente = Patente,
            @IdMarca = IdMarca,
            @IdModelo = IdModelo
        });

        // Aquí deberías obtener el ID del usuario recién registrado
        // Suponiendo que tienes una forma de obtener el ID, puedes hacer lo siguiente:
        string sqlSelectUser = "SELECT * FROM Usuario WHERE email = @Email";
        string sqlSelectAuto = "SELECT * FROM Auto WHERE patente = @Patente"; 
         // O usa otro campo único
        Usuario nuevoUsuario = db.QueryFirstOrDefault<Usuario>(sqlSelectUser, new { @Email = Email });
        Auto auto = db.QueryFirstOrDefault<Auto>(sqlSelectAuto, new{@Patente = Patente});
        return nuevoUsuario; // Retorna el nuevo usuario
    }
}
    public static List<Infraccion> ListarMotivosReporte()
    {

        List<Infraccion> listaMotivosReporte = new List<Infraccion>();

        using (SqlConnection db = new SqlConnection(_connectionString))
        {
            string sql = "SELECT * FROM Infraccion";
            listaMotivosReporte = db.Query<Infraccion>(sql).ToList();
        }

        return listaMotivosReporte;

    }

    public static List<Estacionamiento> ListarEstacionamientos()
    {

        List<Estacionamiento> listaEstacionamientos = new List<Estacionamiento>();

        using (SqlConnection db = new SqlConnection(_connectionString))
        {
            string sql = "SELECT ubicacionX, ubicacionY FROM Estacionamiento WHERE ocupado = 0";
            listaEstacionamientos = db.Query<Estacionamiento>(sql).ToList();
        }

        return listaEstacionamientos;

    }

    public static List<Marca> ListarMarcas()
    {
        List<Marca> listaMarcas = new List<Marca>();

        using (SqlConnection db = new SqlConnection(_connectionString))
        {
            string sql = "SELECT * FROM Marca";
            listaMarcas = db.Query<Marca>(sql).ToList();
        }

        return listaMarcas;
    }

    public static List<Modelo> ListarModelos(int idMarca)
    {
        List<Modelo> listaModelos = new List<Modelo>();
        using (SqlConnection db = new SqlConnection(_connectionString))
        {
            string sql = "SELECT * FROM Modelo INNER JOIN Marca ON Modelo.id_marca = Marca.id_marca WHERE Modelo.id_marca = @id_marca";
            listaModelos = db.Query<Modelo>(sql, new { @id_marca = idMarca }).ToList();
        }

        return listaModelos;
    }

    public static List<string> ObtenerMail()
    {

        List<string> email = null;
        using (SqlConnection db = new SqlConnection(_connectionString))
        {
            string sql = "SELECT email FROM Usuario";
            email = db.Query<string>(sql).ToList();
        }

        return email;
    }

    public static List<string> ObtenerConstrasena()
    {

        List<string> contrasena = null;
        using (SqlConnection db = new SqlConnection(_connectionString))
        {
            string sql = "SELECT constrasena FROM Usuario";
            contrasena = db.Query<string>(sql).ToList();
        }

        return contrasena;
    }

    public static string ObtenerMailParaUsuario(int idUsuario)
    {
        string email = null;
        using (SqlConnection db = new SqlConnection(_connectionString))
        {
            string sql = "SELECT email FROM Usuario WHERE IdUsuario = @idUsuario";
            email = db.QueryFirstOrDefault<string>(sql, new { @idUsuario = idUsuario });
        }

        return email;
    }

    public static string ObtenerContrasenaParaUsuario(int idUsuario)
    {
        string constrasena = null;
        using (SqlConnection db = new SqlConnection(_connectionString))
        {
            string sql = "SELECT contrasena FROM Usuario WHERE IdUsuario = @idUsuario";
            constrasena = db.QueryFirstOrDefault<string>(sql, new { @idUsuario = idUsuario });
        }

        return constrasena;
    }

    public static bool CrearReporte(string calleInfraccion, int alturaInfraccion, string patenteReportada, int idMotivoInfraccion, int idUsuario)
    {
        int fueCreado;
        using (SqlConnection db = new SqlConnection(_connectionString))
        {
            string sql = "INSERT INTO Reporte (fecha_reporte, calle_infraccion, altura_infraccion, patente_reportada, id_motivo_infraccion, id_usuario) VALUES (@FechaReporte, @CalleInfraccion, @AlturaInfraccion, @PatenteReportada, @IdMotivoInfraccion, @IdUsuario)";

            fueCreado = db.Execute(sql, new { @FechaReporte = DateTime.Today, @CalleInfraccion = calleInfraccion, @AlturaInfraccion = alturaInfraccion, @PatenteReportada = patenteReportada, @IdMotivoInfraccion = idMotivoInfraccion, @IdUsuario = idUsuario });
        }
        if (fueCreado == 0)
        {
            return false;
        }
        else
        {
            return true;
        }
    }

    public static Puntos ObtenerPuntosUsuario(int idUsuario)
    {
        Puntos puntosUsuario = new Puntos();

        using (SqlConnection db = new SqlConnection(_connectionString))
        {
            string sql = "SELECT * FROM Puntos WHERE id_usuario = @IdUsuario";

            puntosUsuario = db.QueryFirstOrDefault<Puntos>(sql, new { @IdUsuario = idUsuario });
        }

        return puntosUsuario;
    }

    public static Recompensa ObtenerDatosRecompensa(int idRecompensa)
    {
        Recompensa recompensa = new Recompensa();

        using (SqlConnection db = new SqlConnection(_connectionString))
        {
            string sql = "SELECT * FROM Recompensa WHERE id_recompensa = @IdRecompensa";

            recompensa = db.QueryFirstOrDefault<Recompensa>(sql, new { @IdRecompensa = idRecompensa });
        }

        return recompensa;
    }

    public static void OcuparEspacio(int idAuto, string calle, int altura, string ubicacionY, string ubicacionX)
    {
        double y, x;
        y = double.Parse(ubicacionY.Replace(".", ","));
        x = double.Parse(ubicacionX.Replace(".", ","));
        Console.WriteLine(x);
        Console.WriteLine("Llego");
        using (SqlConnection db = new SqlConnection(_connectionString))
        {
            string sql = "EXEC SP_OcuparEspacioEstacionamiento @UbicacionY,  @UbicacionX, @Calle, @Altura, @IdAuto";
            db.Execute(sql, new { @Calle = calle, @Altura = altura, @UbicacionY = y, @UbicacionX = x, @IdAuto = idAuto });
        }
    }

    public static void LiberarEspacio(int idEstacionamiento, int idAuto)
    {
        using (SqlConnection db = new SqlConnection(_connectionString))
        {
            string sql = "UPDATE Estacionamiento SET ocupado = 0, fecha_libre = @FechaLibre, id_auto = @IdAuto WHERE id_estacionamiento = @IdEstacionamiento";

            db.Execute(sql, new { @FechaLibre = DateTime.Now, @IdAuto = idAuto, @IdEstacionamiento = idEstacionamiento });
        }
    }

    public static DetallesUbicacion MostrarDetallesUbicacion(int idEstacionamiento)
    {
        DetallesUbicacion detalles = new DetallesUbicacion();
        using (SqlConnection db = new SqlConnection(_connectionString))
        {
            string sql = "SELECT E.tiempo_promedio_llegada, DATEDIFF(MINUTE, E.fecha_libre, GETDATE()) AS tiempo_desde_libre, M.nombre_marca, Mo.nombre_modelo FROM Estacionamiento E JOIN Auto A ON E.id_auto = A.id_auto JOIN Modelo Mo ON A.id_modelo = Mo.id_modelo JOIN Marca M ON Mo.id_marca = M.id_marca WHERE E.id_estacionamiento = @IdEstacionamiento";

            DetallesUbicacion resultado = db.QueryFirstOrDefault<DetallesUbicacion>(sql, new { IdEstacionamiento = idEstacionamiento });

            if (resultado != null)
            {
                detalles.TiempoPromedioLlegada = resultado.TiempoPromedioLlegada;
                detalles.TiempoDesdeLibre = resultado.TiempoDesdeLibre;
                detalles.NombreMarca = resultado.NombreMarca;
                detalles.NombreModelo = resultado.NombreModelo;
            }
            else
            {
                detalles = null;
            }
        }

        return detalles;
    }

    public static Notificacion VerNotificacionesXUsuario(int id_usuario)
    {

        Notificacion notificacion = new Notificacion();

        using (SqlConnection db = new SqlConnection(_connectionString))
        {
            string sql = "SELECT * FROM Notificacion WHERE id_usuario = @IdUsuario";

            notificacion = db.QueryFirstOrDefault<Notificacion>(sql, new { @IdUsuario = id_usuario });
        }

        return notificacion;
    }


}