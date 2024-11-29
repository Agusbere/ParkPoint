using System.Text.RegularExpressions;

public class ParkPointService
{
    public static Usuario Usuario;
    DetallesUbicacion detalles = new DetallesUbicacion();

    public static Usuario Registrarse(string Nombre, string Apellido, string Email, string Contrasena, string Patente, int IdMarca, int IdModelo)
    {
        Usuario usuario = BD.Registrarse(Nombre, Apellido, Email, Contrasena, Patente, IdMarca, IdModelo);
        return usuario;

    }

    public static bool GuardarReporte(string calleInfraccion, int alturaInfraccion, string patenteReportada, int idMotivoInfraccion, int idUsuario)
    {
        if (!(BD.CrearReporte(calleInfraccion, alturaInfraccion, patenteReportada, idMotivoInfraccion, idUsuario)))
        {
            return false;
        }
        else
        {
            return BD.CrearReporte(calleInfraccion, alturaInfraccion, patenteReportada, idMotivoInfraccion, idUsuario);
        }

    }
    public static DetallesUbicacion ObtenerDetallesUbicacion(int idEstacionamiento)
    {
        return BD.MostrarDetallesUbicacion(idEstacionamiento);
    }

    public static List<Infraccion> ObtenerDetallesReporte()
    {
        return BD.ListarMotivosReporte();
    }

    public static List<Marca> ObtenerMarcas()
    {
        return BD.ListarMarcas();
    }

    public static List<Modelo> ObtenerModelos(int idMarca)
    {
        return BD.ListarModelos(idMarca);
    }

    public static List<string> ObtenerMails()
    {
        return BD.ObtenerMail();
    }

    public static List<string> ObtenerConstrasenas()
    {
        return BD.ObtenerConstrasena();
    }

    public static string ObtenerMailParaUsuario(int idUsuario)
    {
        return BD.ObtenerMailParaUsuario(idUsuario);
    }

    public static string ObtenerConstrasenaParaUsuario(int idUsuario)
    {
        return BD.ObtenerContrasenaParaUsuario(idUsuario);
    }
    public static Puntos ObtenerPuntosUsuario(int idUsuario)
    {
        return BD.ObtenerPuntosUsuario(idUsuario);
    }

    public static Recompensa ObtenerRecompensa(int idRecompensa)
    {
        return BD.ObtenerDatosRecompensa(idRecompensa);
    }

    public static Notificacion ObtenerNotificacionesPorUsuario(int id_usuario)
    {
        return BD.VerNotificacionesXUsuario(id_usuario);
    }


}