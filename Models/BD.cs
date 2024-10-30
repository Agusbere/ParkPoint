using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using Dapper;
public static class BD
{
    private static string _connectionString = @"Server=localhost; DataBase=ParkPoint ; Trusted_Connection=True ;";

    public static List<Tiempo_Real> listaMotivosTiempoReal(){

        List<Tiempo_Real> listaMotivosTiempoReal = new List<Tiempo_Real>();

        using (SqlConnection BD  = new SqlConnection(_connectionString))
        {
            string sql = "SELECT * FROM Tiempo_Real";
            listaMotivosTiempoReal = BD.Query<Tiempo_Real>(sql).ToList();
        }

        return listaMotivosTiempoReal;


    } 

}