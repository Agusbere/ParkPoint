using System.Text.RegularExpressions;

public class ParkPointService
{
    public static Usuario Usuario;

    public static Usuario Registrarse(int DNI, string FotoDNI, string Nombre, string Apellido, string Email, string Contrasena, DateTime FechaNacimiento, DateTime FechaVencimientoCarnet, string FotoCarnet, int IdGenero)
    {
        return BD.Registrarse(DNI, FotoDNI, Nombre, Apellido, Email, Contrasena, FechaNacimiento, FechaVencimientoCarnet, FotoCarnet, IdGenero);
    }

    public static Usuario IniciarSesion(string Email, string Contrasena)
    {
        return BD.IniciarSesion(Email, Contrasena);
    }

    //Es para validar que la contraseña sea de minimo 8 digitos, tenga una mayuscula y tenga alguna tecla especial
    public static bool VerificarContraseña(string contraseña)
    {
        Regex validateGuidRegex = new Regex("^(?=.*?[A-Z])(?=.*?[0-9]).{8,}$");

        return validateGuidRegex.IsMatch(contraseña);
    }
}