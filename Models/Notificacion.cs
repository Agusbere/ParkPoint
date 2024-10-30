public class Notificacion
{
    public int id_notificacion { get; set; }
    public string titulo { get; set; }
    public string descripcion { get; set; }
    public DateTime fecha_notificacion { get; set; }
    public bool leido { get; set; }
    public int id_usuario { get; set; }
}
