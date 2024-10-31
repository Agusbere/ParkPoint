using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using Dapper;
public class BD
{
    private static string _connectionString = @"Server=localhost; DataBase=ParkPoint ; Trusted_Connection=True ;";

    public static List<Tiempo_Real> ListaMotivosTiempoReal(){

        List<Tiempo_Real> listaMotivosTiempoReal = new List<Tiempo_Real>();

        using (SqlConnection db  = new SqlConnection(_connectionString))
        {
            string sql = "SELECT * FROM Tiempo_Real";
            listaMotivosTiempoReal = db.Query<Tiempo_Real>(sql).ToList();
        }

        return listaMotivosTiempoReal;

    }

   

}