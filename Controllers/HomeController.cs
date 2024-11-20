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

    public IActionResult OcuparEspacio(int idAuto, string calle, string altura, float ubicacionX, float ubicacionY)
    {   
        Console.WriteLine(calle, altura);
  
        BD.OcuparEspacio(1, calle, altura, ubicacionX, ubicacionY);
        return View("Estacionar");
    }

    public IActionResult Reportar()
    {

        ViewBag.MotivosReporte = ParkPointService.ObtenerDetallesReporte();

        return View();
    }

    [HttpPost]
    public IActionResult GuardarDireccion(string calle, int altura)
    {
        ViewBag.Calle = calle;
        ViewBag.Altura = altura;

        Console.WriteLine("SSDDS");
        return RedirectToAction("OcuparEspacio", new { calle = calle, altura = altura});
    }


    //public IActionResult MostrarDireccion()
    //{
    //  ViewBag.Calle = Estacionamiento.Calle;
    // ViewBag.Altura = Estacionamiento.altura_Calle;

    //return View("Estacionar");
    //}
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
    public IActionResult Registro1(string nombre, string apellido, string email, string contra)
    {

        Usuario usuario = new Usuario();
        usuario.nombre = nombre;
        usuario.apellido = apellido;
        usuario.email = email;
        usuario.contrasena = contra;



        return RedirectToAction("Registro3", usuario);
    }

    public IActionResult Registro2()
    {

        return View();
    }

    [HttpPost]
    public IActionResult Registro2(string id_marca, string id_modelo, string patente)
    {
        Auto auto = new Auto();
        ViewBag.id_marca = auto.id_marca;
        ViewBag.id_modelo = auto.id_modelo;
        ViewBag.patente = auto.patente;


        return View();
    }

    public IActionResult Registro3(Usuario usuario)
    {
        Usuario usuario1 = usuario;

        return View();
    }

    [HttpPost]
    public IActionResult Registro3(Usuario usuario, string dni, string foto_dni)
    {

        Usuario usuario1 = usuario;
        ViewBag.dni = usuario1.dni;
        ViewBag.foto_dni = usuario1.foto_dni;


        return RedirectToAction("Index", usuario);

    }
    public IActionResult Ubicaciones()
    {
        ViewBag.ListaCoordenadas = BD.ListarEstacionamientos();
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
