using System.Data;
using System.Data.SqlClient;
using Dapper;
public static class BD
{
    private static string _connectionString = @"Server=localhost; DataBase=ParkPoint ; Trusted_Connection=True ;";

    public static void EliminarDeportista(int idDeportista)
    {
        using (SqlConnection db = new SqlConnection(_connectionString))
        {
            string sql = "DELETE FROM Deportistas WHERE IdDeportista = @pidDeportista";
            db.Execute(sql, new { pidDeportista = idDeportista });
        }
    }

}