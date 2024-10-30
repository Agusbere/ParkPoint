public class Reporte
{
    public int id_reporte { get; set; }
    public bool enTiempoRealOInfraccion { get; set; }
    public DateTime fecha_reporte { get; set; }
    public int id_usuario { get; set; } 
    public int id_reporte_tiempo_real {get;set;}
    public int id_reporte_infraccion {get;set;}
}