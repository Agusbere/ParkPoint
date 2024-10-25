public class Reporte
{
    public int IdReporte { get; set; }
    public bool EnTiempoRealOInfraccion { get; set; }
    public string MotivoTiempoReal { get; set; }
    public string MotivoInfraccion { get; set; }
    public string CalleInfraccion { get; set; }
    public string AlturaInfraccion { get; set; }
    public string PatenteReportada { get; set; }
    public DateTime FechaReporte { get; set; }
    public int IdUsuario { get; set; } 
}