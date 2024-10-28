public class Estacionamiento
{
    public int IdEstacionamiento { get; set; }
    public bool SePuedeEstacionar { get; set; }
    public bool Ocupado { get; set; }
    public string Calle { get; set; }
    public string AlturaCalle { get; set; }
    public DateTime FechaLibre { get; set; }
    public DateTime FechaOcupado { get; set; }
    public DateTime TiempoEstacionado { get; set; }
    public double UbicacionX { get; set; }   
    public double UbicacionY { get; set; }
    public DateTime TiempoPromedioLlegada { get; set; }
    public int IdAuto { get; set; }
}