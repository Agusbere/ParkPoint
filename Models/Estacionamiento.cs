public class Estacionamiento
{
    public int id_estacionamiento { get; set; }
    public bool ocupado { get; set; }
    public string calle { get; set; }
    public string altura_Calle { get; set; }
    public DateTime fecha_libre { get; set; }
    public DateTime fecha_ocupado { get; set; }
    public DateTime tiempo_estacionado { get; set; }
    public DateTime tiempo_promedio_llegada { get; set; }
    public int id_auto {get;set;}
    public int id_usuario {get;set;}
    public int id_ubicacion {get;set;}

}