public class Reporte
{
    public int id_reporte { get; set; }
    public DateTime fecha_reporte { get; set; }
    public string calle_infraccion {get;set;}
    public int altura_infraccion {get;set;}
    public string patente_reportada {get;set;}
    public int id_motivo_infraccion {get;set;}
    public int id_usuario { get; set; } 

}