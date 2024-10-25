public class Usuario
{
    public int IdUsuario { get; set; }
    public int Dni { get; set; }
    public string FotoDni { get; set; }
    public string Nombre { get; set; }
    public string Apellido { get; set; }
    public string Email { get; set; }
    public string Contrasena { get; set; }
    public TimeSpan FechaRegistro { get; set; }
    public string FotoUsuario { get; set; }
}