public class Usuario
{
    public int id_usuario { get; set; }
    public int dni { get; set; }
    public string foto_dni { get; set; }
    public string nombre { get; set; }
    public string apellido { get; set; }
    public DateTime fecha_nacimiento { get; set; }
    public string email { get; set; }
    public string contrasena { get; set; }
    public DateTime fecha_registro { get; set; }
    public string? foto_usuario { get; set; }
    public int id_ubicacion { get; set; }

}
