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
    public IActionResult Reportar(){

        ViewBag.MotivosReporte = BD.ListarMotivosReporte();

        return View();
    }
    public IActionResult Estacionar(){

        return View();
    }
    public IActionResult Ayuda(){

        return View();
    }

    public IActionResult InicioSesion(){

        return View();
    }

    public IActionResult IniciarSesion(string Contrasena, string Email){
        Usuario usuario = ParkPointService.IniciarSesion(Email, Contrasena);

        if(usuario == null){
            ViewBag.Error = "Ingreso incorrectamente el e-mail o la contraseña";
            return RedirectToAction("IniciarSesion");
        }
        else{
            ParkPointService.Usuario = usuario;
            return RedirectToAction("Index");
        }
    }
    
}
