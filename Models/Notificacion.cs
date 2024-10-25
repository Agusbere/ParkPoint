public class Notificacion
{
    public int IdNotificacion { get; set; }
    public string Titulo { get; set; }
    public string Descripcion { get; set; }
    public DateTime FechaNotificacion { get; set; }
    public bool Leido { get; set; }
    public int IdUsuario { get; set; }
}
