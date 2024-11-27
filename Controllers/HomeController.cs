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

    public IActionResult OcuparEspacio(string calle, int altura, string ubicacionX, string ubicacionY, int idAuto = 0)
    {
        Console.WriteLine(calle, altura, ubicacionX, ubicacionY);
        BD.OcuparEspacio(1, calle, altura, ubicacionX, ubicacionY); // Cambiar a 1 devuelta
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


    //     public IActionResult Registro2()
    //     {
    //         return View();
    //     }

    //     [HttpPost]
    //     public IActionResult Registro2(string dni, string fotoDNI)
    // {
    //     var usuarioJson = TempData["Usuario"] as string;
    //     var usuario = JsonConvert.DeserializeObject<Usuario>(usuarioJson);

    //     // Convertir el DNI a int
    //     int dniInt;
    //     if (!int.TryParse(dni, out dniInt))
    //     {
    //         ViewBag.Error = "El DNI debe ser un número válido.";
    //         return View(); // Regresar a la vista de registro con un mensaje de error
    //     }

    //     // Guardamos los datos en TempData para el siguiente paso
    //     TempData["DNI"] = dniInt; // Guardar como int
    //     TempData["FotoDNI"] = fotoDNI;

    //     return RedirectToAction("Registro3");
    // }

    //     public IActionResult Registro3()
    //     {
    //         ViewBag.Marcas = BD.ListarMarcas(); // Obtener marcas para el dropdown
    //         return View();
    //     }

    //     [HttpPost]
    //     public IActionResult Registro3(string patente, int idMarca, int idModelo)
    // {
    //     var usuarioJson = TempData["Usuario"] as string;
    //     var usuario = JsonConvert.DeserializeObject<Usuario>(usuarioJson);
    //     var dni = (int)TempData["DNI"]; // Obtener como int
    //     var fotoDNI = TempData["FotoDNI"] as string;

    //     // Aquí se inserta el usuario y el auto en la base de datos
    //     ParkPointService.Registrarse(dni, fotoDNI, usuario.nombre, usuario.apellido, usuario.email, usuario.contrasena, patente, idMarca, idModelo);

    //     return RedirectToAction("Index");
    // }


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
