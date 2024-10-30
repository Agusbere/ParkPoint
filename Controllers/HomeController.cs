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
    
    public IActionResult Puntos(){

        return View();
    }
    public IActionResult Reportar(){

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

    public IActionResult VerMotivosInfoEnTiempoReal(){

        ViewBag.MotivosInfoEnTiempoReal = BD.VerMotivosInfoEnTiempoReal();

        return View("ReportarInfoenTiempoReal");
    }
}
