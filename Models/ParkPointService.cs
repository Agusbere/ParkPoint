using System.Text.RegularExpressions;

public class ParkPointService
{
    const string ID_USUARIO_LLAVE = "idUsuario";
    DetallesUbicacion detalles = new DetallesUbicacion();

    public static Usuario Registrarse(string Nombre, string Apellido, string Email, string Contrasena, string Patente, int IdMarca, int IdModelo)
    {
        Usuario usuario = BD.Registrarse(Nombre, Apellido, Email, Contrasena, Patente, IdMarca, IdModelo);
        return usuario;
    }

    public static Usuario IniciarSesion(string Email, string Contra)
    {
        Usuario usuario = BD.IniciarSesion(Email, Contra);
        return usuario;
    }
    public static void GuardarIdUsuario(HttpContext httpContext, int idUsuario)
    {
        httpContext.Session.SetInt32(ID_USUARIO_LLAVE, idUsuario);
    }
    public static void RemoverIdUsuario(HttpContext httpContext)
    {
        httpContext.Session.Remove(ID_USUARIO_LLAVE);
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

    public static Recompensa ObtenerRecompensa(int idRecompensa)
    {
        return BD.ObtenerDatosRecompensa(idRecompensa);
    }

    public static Notificacion ObtenerNotificacionesPorUsuario(int id_usuario)
    {
        return BD.VerNotificacionesXUsuario(id_usuario);
    }

    public static int? ObtenerIdUsuario(HttpContext httpContext)
    {
        return httpContext.Session.GetInt32(ID_USUARIO_LLAVE);
    }
}