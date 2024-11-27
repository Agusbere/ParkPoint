using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using ParkPoint.Models;
using Newtonsoft.Json;

namespace ParkPoint.Controllers;

public class HomeController : Controller
{
    private readonly ILogger<HomeController> _logger;

    public HomeController(ILogger<HomeController> logger)
    {
        _logger = logger;
    }

    public IActionResult InicioSesion(){

        BD.IniciarSesion(string email, string contra);
        return View();
    }

    public IActionResult Index()
    {
        ViewBag.ListaCoordenadas = BD.ListarEstacionamientos();
        ViewBag.Ubicaciones = "var puntosAlmagro = [";
        string conector = "";
        foreach (Estacionamiento ubicacion in ViewBag.ListaCoordenadas)
        {

            ViewBag.Ubicaciones += conector + "[" + ubicacion.ubicacionX.ToString().Replace(",", ".") + "," + ubicacion.ubicacionY.ToString().Replace(",", ".") + "]";
            conector = ",";

        }
        ViewBag.Ubicaciones += "];";

        return View();
    }

    public IActionResult OcuparEspacio(string calle, int altura, string ubicacionX, string ubicacionY, int idAuto)
    {
        Console.WriteLine(calle, altura, ubicacionX, ubicacionY);
        BD.OcuparEspacio(idAuto, calle, altura, ubicacionX, ubicacionY);
        return View("Estacionar");
    }

    public IActionResult Reportar()
    {

        ViewBag.MotivosReporte = ParkPointService.ObtenerDetallesReporte();

        return View();
    }

    [HttpPost]
    public IActionResult GuardarDireccion(string calle, int altura, string ubicacionY, string ubicacionX)
    {
        Console.WriteLine(ubicacionY);
        return RedirectToAction("OcuparEspacio", new { calle = calle, altura = altura, ubicacionX = ubicacionX, ubicacionY = ubicacionY });
    }
    public IActionResult Ayuda()
    {

        return View();
    }

    public IActionResult Puntos()
    {


        return View();
    }
    [HttpGet]
public IActionResult ObtenerModelos(int idMarca)
{
    List<Modelo> modelos = BD.ListarModelos(idMarca);
    return Json(modelos);
}

    public IActionResult Registro()
    {   
        List<int> IdMarca = new List<int>();
        ViewBag.Marcas = BD.ListarMarcas();

        for(int i = 0; i < ViewBag.Marcas.Count; i++){
            IdMarca.Add(ViewBag.Marcas[i].id_marca);
        }

        List<Modelo> Modelos = new List<Modelo>();

        for(int i = 0; i < IdMarca.Count; i++){
            Console.WriteLine(IdMarca[i]);

            Modelos.AddRange(BD.ListarModelos(IdMarca[i]));
        }

        ViewBag.Modelos = Modelos;

        return View();
    }

    [HttpPost]
    public IActionResult Registro(string nombre, string apellido, string email, string contra, string confirmacionContra, string patente, int id_marca, int id_modelo)
    {   


        ParkPointService.Registrarse(nombre, apellido, email, contra, patente, id_marca, id_modelo);

        return View("Index");
    }


    public IActionResult Ubicaciones()
    {
        
        return View("Index");
    }

    public IActionResult indexBloqueado()
    {

        return View();
    }

    public IActionResult IniciarSesion(string Contrasena, string Email)
    {
        Usuario usuario = ParkPointService.IniciarSesion(Email, Contrasena);

        if (usuario == null)
        {
            ViewBag.Error = "Ingreso incorrectamente el e-mail o la contraseña";
            return RedirectToAction("IniciarSesion");
        }
        else
        {
            ParkPointService.Usuario = usuario;
            return RedirectToAction("Index");
        }
    }

    public IActionResult GuardarReporte(string calleInfraccion, int alturaInfraccion, string patenteReportada, int idMotivoInfraccion, int idUsuario)
    {

        ViewBag.CrearReporte = ParkPointService.GuardarReporte(calleInfraccion, alturaInfraccion, patenteReportada, idMotivoInfraccion, idUsuario);

        return RedirectToAction("Index");
    }

    public Notificacion VerNotificaciones(int id_usuario)
    {
        return ParkPointService.ObtenerNotificacionesPorUsuario(id_usuario);
    }




}
