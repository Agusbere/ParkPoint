using System.Text.RegularExpressions;

public class ParkPointService
{
    public static Usuario Usuario;
    DetallesUbicacion detalles = new DetallesUbicacion();

    public static Usuario Registrarse(int DNI, string FotoDNI, string Nombre, string Apellido, string Email, string Contrasena, DateTime FechaNacimiento, DateTime FechaVencimientoCarnet, string FotoCarnet, int IdMarca, int IdModelo)
    {
        return BD.Registrarse(DNI, FotoDNI, Nombre, Apellido, Email, Contrasena, FechaNacimiento, FechaVencimientoCarnet, FotoCarnet, IdMarca, IdModelo);
    }

    public static Usuario IniciarSesion(string Email, string Contrasena)
    {
        return BD.IniciarSesion(Email, Contrasena);
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

    public static Ubicacion ObtenerUbicacionUsuario(int idUsuario)
    {
        return BD.ObtenerUbicacionUsuario(idUsuario);
    }
    public static Puntos ObtenerPuntosUsuario(int idUsuario)
    {
        return BD.ObtenerPuntosUsuario(idUsuario);
    }

    public static Recompensa ObtenerRecompensa(int idRecompensa)
    {
        return ObtenerRecompensa(idRecompensa);
    }

    public static Notificacion ObtenerNotificacionesPorUsuario(int id_usuario)
    {
        return BD.VerNotificacionesXUsuario(id_usuario);
    }

    //Es para validar que la contraseña sea de minimo 8 digitos, tenga una mayuscula y tenga alguna tecla especial
    public static bool VerificarContraseña(string contraseña)
    {
        Regex validateGuidRegex = new Regex("^(?=.*?[A-Z])(?=.*?[0-9]).{8,}$");

        return validateGuidRegex.IsMatch(contraseña);
    }
}