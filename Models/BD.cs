using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using Dapper;
public class BD
{
    private static string _connectionString = @"Server=localhost; DataBase=ParkPoint ; Trusted_Connection=True ;";

    public static Usuario Registrarse(int DNI, string FotoDNI, string Nombre, string Apellido, string Email, string Contrasena, DateTime FechaNacimiento, DateTime FechaVencimientoCarnet, string FotoCarnet, int IdGenero)
    {
        Usuario nuevoUsuario = null;
        string sp = "SP_Registrarse";
        using (SqlConnection db = new SqlConnection(_connectionString))
        {
            nuevoUsuario = db.QuerySingleOrDefault<Usuario>(sp, new
            {
                @DNI = DNI,
                @FotoDNI = FotoDNI,
                @Nombre = Nombre,
                @Apellido = Apellido,
                @Email = Email,
                @Contrasena = Contrasena,
                @FechaNacimiento = FechaNacimiento,
                @FechaVencimientoCarnet = FechaVencimientoCarnet,
                @FotoCarnet = FotoCarnet,
                @IdGenero = IdGenero
            }, commandType: System.Data.CommandType.StoredProcedure);
        }

        return nuevoUsuario;
    }

    public static Usuario IniciarSesion(string Email, string Contrasena)
    {
        Usuario usuario = null;
        string sp = "SP_IniciarSesion";

        using (SqlConnection db = new SqlConnection(_connectionString))
        {
            usuario = db.QueryFirstOrDefault<Usuario>(sp, new { @Email = Email, @Contrasena = Contrasena }, commandType: System.Data.CommandType.StoredProcedure);
        }

        return usuario;
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

    public static List<string> ObtenerMail()
    {
        string query = "SELECT email FROM Usuario";
        List<string> email = null;
        using (SqlConnection db = new SqlConnection(_connectionString))
        {
            email = db.Query<string>(query).ToList();
        }

        return email;
    }



}