using System.Runtime.InteropServices.ComTypes;
using System.ComponentModel;
using System.IO.Compression;
using System.Net;
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

    public IActionResult Index()
    {
        bool estaRegistrado;
        int? idUsuario = ParkPointService.ObtenerIdUsuario(HttpContext);

        Usuario usuario = null;
        Auto auto = null;

        if (idUsuario != null)
        {
            estaRegistrado = true;

            usuario = BD.ObtenerDatosUsuarioLogeado(idUsuario);
            auto = BD.ObtenerDatosAutoLogeado(idUsuario);

            ViewData["EstaRegistrado"] = estaRegistrado;
            ViewData["Usuario"] = usuario;
            ViewData["Auto"] = auto;
            TempData["IdAuto"] = auto.id_auto;

            int idAuto = BD.VerIdAutoActual(new Usuario { id_usuario = (int)idUsuario });

            bool autoOcupado = BD.VerificarAutoOcupado(idAuto);

            ViewBag.idAutoOcupando = idAuto;

            ViewBag.AutoOcupado = autoOcupado;

            ViewBag.ListaCoordenadas = BD.ListarEstacionamientos();

            ViewBag.Ubicaciones = "var puntosAlmagro = [";
            string conector = "";
            foreach (Estacionamiento ubicacion in ViewBag.ListaCoordenadas)
            {
                ViewBag.Ubicaciones += conector + "[" + ubicacion.ubicacionX.ToString().Replace(",", ".") + "," + ubicacion.ubicacionY.ToString().Replace(",", ".") + "]";
                conector = ",";
            }
            ViewBag.Ubicaciones += "];";

            var tiempoRestante = HttpContext.Session.GetString("TiempoRestante");
            if (tiempoRestante != null)
            {
                DateTime endTime = DateTime.Parse(tiempoRestante);
                if (DateTime.UtcNow < endTime)
                {
                    return View("IndexBloqueado");
                }
            }

            return View();
        }
        else
        {
            return RedirectToAction("InicioSesion");
        }
    }


    public IActionResult OcuparEspacio(string calle, int altura, string ubicacionX, string ubicacionY)
    {
        int? idUsuario = ParkPointService.ObtenerIdUsuario(HttpContext);

        if (idUsuario != null)
        {
            BD.OcuparEspacio((int)idUsuario, calle, altura, ubicacionX, ubicacionY);
        }

        return RedirectToAction("Index"); // Redirigir a Index
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

    public IActionResult InicioSesion()
    {
        return View();
    }

    public IActionResult Puntos()
    {
        int? idUsuario = ParkPointService.ObtenerIdUsuario(HttpContext);

        if (idUsuario == null)
        {
            // Manejo del caso en que el usuario no está autenticado o no tiene ID
            return RedirectToAction("Login"); // Redirige al login o maneja el error
        }

        ViewBag.Puntos = BD.ObtenerPuntosUsuario(idUsuario.Value); // Usa .Value para obtener el valor de int
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
        if (ParkPointService.ObtenerIdUsuario(HttpContext) == null)
        {
            List<int> IdMarca = new List<int>();
            ViewBag.Marcas = BD.ListarMarcas();

            for (int i = 0; i < ViewBag.Marcas.Count; i++)
            {
                IdMarca.Add(ViewBag.Marcas[i].id_marca);
            }

            List<Modelo> Modelos = new List<Modelo>();

            for (int i = 0; i < IdMarca.Count; i++)
            {
                Console.WriteLine(IdMarca[i]);

                Modelos.AddRange(BD.ListarModelos(IdMarca[i]));
            }

            ViewBag.Modelos = Modelos;

            return View();
        }
        else
            return RedirectToAction("Index");
    }

    [HttpPost]
    public IActionResult Registro(string nombre, string apellido, string email, string contra, string confirmacionContra, string patente, int id_marca, int id_modelo)
    {
        if (ParkPointService.ObtenerIdUsuario(HttpContext) == null)
        {
            Usuario usuario = ParkPointService.Registrarse(nombre, apellido, email, contra, patente, id_marca, id_modelo);
            ParkPointService.GuardarIdUsuario(HttpContext, usuario.id_usuario);
        }
        return RedirectToAction("Index");
    }

    [HttpPost]
    public IActionResult InicioSesion(string email, string contra)
    {
        if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(contra))
        {

            ModelState.AddModelError("", "El correo electrónico y la contraseña son requeridos.");
            return View();
        }

        bool loginExitoso = BD.VerificarUsuario(email, contra);

        if (loginExitoso)
        {

            Usuario usuario = ParkPointService.IniciarSesion(email, contra);
            ParkPointService.GuardarIdUsuario(HttpContext, usuario.id_usuario);
            return RedirectToAction("Index");
        }
        else
        {
            return RedirectToAction("InicioSesion");
        }




    }

    public IActionResult Perfil()
    {
        int? idUsuario = ParkPointService.ObtenerIdUsuario(HttpContext);

        if (idUsuario == null)
        {
            return RedirectToAction("InicioSesion");
        }

        Usuario usuario = BD.ObtenerDatosUsuarioLogeado(idUsuario);
        Auto auto = BD.ObtenerDatosAutoLogeado(idUsuario);

        ViewData["Usuario"] = usuario;
        ViewData["Auto"] = auto;
        return View();
    }


    public IActionResult CerrarSesion()
    {
        ParkPointService.RemoverIdUsuario(HttpContext);
        return RedirectToAction("InicioSesion");
    }


    public IActionResult Ubicaciones()
    {

        return View("Index");
    }

    public IActionResult indexBloqueado()
    {
        DateTime endTime = DateTime.UtcNow.AddHours(24);
        HttpContext.Session.SetString("TiempoRestante", endTime.ToString("o"));

        return View();
    }

    public IActionResult GuardarReporte(string calleInfraccion, int alturaInfraccion, string patenteReportada, int idMotivoInfraccion)
    {
        int? idUsuario = ParkPointService.ObtenerIdUsuario(HttpContext);
        if (idUsuario != null)
        {
            ViewBag.CrearReporte = ParkPointService.GuardarReporte(calleInfraccion, alturaInfraccion, patenteReportada, idMotivoInfraccion, (int)idUsuario);
            return RedirectToAction("Index");
        }
        else
            return RedirectToAction("InicioSesion");
    }

    public Notificacion VerNotificaciones(int id_usuario)
    {
        return ParkPointService.ObtenerNotificacionesPorUsuario(id_usuario);
    }

    public IActionResult DesocuparEspacio(int id_auto)
    {
        Console.WriteLine("Desocupar espacio llamado con id_auto: " + id_auto);
        int? idUsuario = ParkPointService.ObtenerIdUsuario(HttpContext); // Obtener el ID del usuario en sesión
        if (idUsuario != null)
        {
            BD.LiberarEspacio(id_auto, (int)idUsuario); // Llama al método para liberar el espacio
        }
        return RedirectToAction("IndexBloqueado"); // Redirige a la página principal
    }
    [HttpPost]
    public IActionResult Canjear(int puntos)
    {
        int? idUsuario = ParkPointService.ObtenerIdUsuario(HttpContext);

        if (idUsuario == null)
        {
            return RedirectToAction("Login"); // Redirige al login si el usuario no está autenticado
        }

        // Verificar si el usuario tiene suficientes puntos
        int puntosActuales = BD.ObtenerPuntosUsuario(idUsuario.Value);

        if (puntosActuales < puntos)
        {
            TempData["Error"] = "No tienes los puntos necesarios para canjear esta recompensa.";
            return RedirectToAction("Puntos"); // Redirige a la vista de puntos con un mensaje de error
        }

        BD.RestarPuntosUsuario(idUsuario.Value, puntos);
        HttpContext.Session.Remove("TiempoRestante");

        return RedirectToAction("Index");
    }
}
