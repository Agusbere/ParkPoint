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

    public IActionResult Reportar()
    {

        ViewBag.MotivosReporte = ParkPointService.ObtenerDetallesReporte();

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

    public IActionResult Registro1()
    {

        return View();
    }

    [HttpPost]
    public IActionResult Registro1(string nombre, string apellido, string email, string contra, string confirmContra)
    {

        Usuario usuario = new Usuario();
        usuario.nombre = nombre;

        if (contra != confirmContra)
        {
            ModelState.AddModelError("", "Las contraseñas no coinciden");
            return View(); // Puedes regresar a la misma vista con el error
        }

        // Si todo está correcto, redirige a otra página o muestra un mensaje de éxito
        return RedirectToAction("Registro2", new Usuario());
    }

    public IActionResult Registro2()
    {

        return View();
    }

    [HttpPost]
    public IActionResult Registro2()
    {

        return View();
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

    public IActionResult GuardarReporte()
    {

        return RedirectToAction("Index");
    }

    public Notificacion VerNotificaciones(int id_usuario)
    {
        return BD.VerNotificacionesXUsuario(id_usuario);
    }

    public IActionResult

}
