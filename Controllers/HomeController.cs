using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using ParkPoint.Models;

namespace ParkPoint.Controllers;

public class HomeController : Controller
{
    private readonly ILogger<HomeController> _logger;

    public HomeController(ILogger<HomeController> logger)
    {
        _logger = logger;
    }

    public IActionResult Index()
    {
        return View();
    }

/*private readonly ParkPointService _parkPointService;
private readonly UbicacionService _ubicacionService;

public UbicacionController(ParkPointService parkPointService, UbicacionService ubicacionService)
{
    _parkPointService = parkPointService;
    _ubicacionService = ubicacionService;
}*/

// Método que usa UbicacionService directamente
/*
[HttpPost]
public IActionResult ActualizarUbicacion([FromBody] Ubicacion ubicacion, int idUsuario)
{
    bool exito = _ubicacionService.GuardarUbicacion(idUsuario, ubicacion.ubicacionX, ubicacion.ubicacionY);

    if (exito)
        return Json(new { mensaje = "Ubicación guardada exitosamente" });
    else
        return Json(new { mensaje = "Error al guardar la ubicación" });
}*/

// Método que usa ParkPointService
/*
[HttpPost]
public IActionResult ActualizarUbicacionConParkService([FromBody] Ubicacion ubicacion, int idUsuario)
{
    bool exito = _parkPointService.GuardarUbicacion(idUsuario, ubicacion.ubicacionX, ubicacion.ubicacionY);

    if (exito)
        return Json(new { mensaje = "Ubicación guardada exitosamente" });
    else
        return Json(new { mensaje = "Error al guardar la ubicación" });
}*/


    public IActionResult Reportar()
    {

        ViewBag.MotivosReporte = BD.ListarMotivosReporte();

        return View();
    }
    public IActionResult Estacionar()
    {

        return View();
    }
    public IActionResult Ayuda()
    {

        return View();
    }

    public IActionResult Puntos()
    {


        return View();
    }

    public IActionResult InicioSesion()
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

    public IActionResult GuardarReporte()
    {

        return RedirectToAction("Index");
    }

    public Notificacion VerNotificaciones(int id_usuario)
    {

        return BD.VerNotificacionesXUsuario(id_usuario);
    }

}
