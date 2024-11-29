public class Usuario
{
    public int id_usuario { get; set; }
    public int? dni { get; set; } // Permitir que el DNI sea nulo
    public string? foto_dni { get; set; }
    public string nombre { get; set; }
    public string apellido { get; set; }
    public string email { get; set; }
    public string contrasena { get; set; }
    public string? foto_usuario { get; set; }

    public Usuario() { }

    // Constructor que acepta dni como nullable
    public Usuario(string nombre, string apellido, string email, string contrasena, string marca, string modelo, string patente)
    {
        this.nombre = nombre;
        this.apellido = apellido;
        this.email = email;
        this.contrasena = contrasena;
    }
}