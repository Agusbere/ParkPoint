var map = L.map("map").setView([-34.6037, -58.4116], 15);

L.tileLayer("https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}", {
  maxZoom: 19,
  attribution: "©Parkpoint",
}).addTo(map);

// Variables para el círculo de ubicación y su "aura" difusa
var userLocationMarker;
var userLocationAura;

var selectedLat;
var selectedLon;

// Función para obtener la dirección a partir de coordenadas
function obtenerDireccion(lat, lon, callback) {
  fetch(
    `https://nominatim.openstreetmap.org/reverse?lat=${lat}&lon=${lon}&format=json`
  )
    .then((response) => response.json())
    .then((data) => {
      // Intentamos obtener la calle y la altura
      let calle = data.address.road || "Calle desconocida";
      let altura = data.address.house_number || "sin número";

      // Si no tiene altura, buscamos la más cercana
      if (altura === "sin número") {
        // Llamamos de nuevo para encontrar la calle más cercana con número
        fetch(
          `https://nominatim.openstreetmap.org/search?street=${calle}&city=Buenos Aires&format=json`
        )
          .then((response) => response.json())
          .then((closestData) => {
            // Encontrar la mejor altura más cercana en la misma calle
            if (closestData && closestData.length > 0) {
              // Asignamos el primer número de casa disponible
              altura = closestData[0].address.house_number || "sin número";
            }
            let direccion = `${calle} ${altura}`;
            callback(direccion);
          });
      } else {
        let direccion = `<p>${calle} ${altura}</p><button name="btnOcupar" onclick="enviarDatosAControlador('${calle}', '${altura}', '${selectedLat}', '${selectedLon}')">Ocupar</button>`;
        callback(direccion);
      }
    })
    .catch((error) => {
      console.error("Error al obtener la dirección:", error);
      callback("Dirección no disponible");
    });
    
}

// Función para crear un marcador y asignar la función de obtener dirección
function crearMarcador(lat, lon) {
  var marker = L.marker([lat, lon]).addTo(map);

  marker.on("click", function (e) {
    selectedLat = lat;
    selectedLon = lon;
    obtenerDireccion(lat, lon, (direccion) => {
      marker.bindPopup(direccion).openPopup();
    });
  });
}
function enviarDatosAControlador(calle, altura, selectedLat, selectedLon) {
  $.ajax({
    url: "/Home/GuardarDireccion", // Ruta al método del controlador
    method: "POST",
    data: {
      calle: calle,
      altura: altura,
      ubicacionY: selectedLat,
      ubicacionX: selectedLon,
    }, // Enviar como datos serializados
    success: function (response) {
      console.log("Dirección enviada correctamente al controlador.");
      if (response.redirectUrl) {
        window.location.href = response.redirectUrl; // Redirigir si es necesario
      } else {
        window.location.reload(); // Recargar la página si no hay redirección
      }
    },
    error: function (xhr, status, error) {
      console.error("Error al enviar la dirección:", error);
      console.error(xhr);
    },
  });
}

// Crear los marcadores para cada punto en Almagro

function actualizarUbicacion(lat, lon) {
  // Si el marcador de ubicación ya existe, se actualiza su posición
  if (userLocationMarker) {
    userLocationMarker.setLatLng([lat, lon]);
    selectedLat = lat;
    selectedLon = lon;
  } else {
    // Crear el marcador de ubicación principal en azul oscuro
    userLocationMarker = L.circleMarker([lat, lon], {
      color: "blue",
      radius: 8,
      fillColor: "blue",
      fillOpacity: 0.7,
    }).addTo(map);
  }

  // Si el círculo difuso no existe, se crea con un tamaño y opacidad bajos
  if (!userLocationAura) {
    userLocationAura = L.circle([lat, lon], {
      color: "#87CEEB", // Celeste
      radius: 50, // Radio inicial
      fillColor: "#87CEEB",
      fillOpacity: 0.2,
    }).addTo(map);
  } else {
    // Si ya existe, simplemente se actualiza su posición
    userLocationAura.setLatLng([lat, lon]);
  }

  // Cambiar el tamaño del círculo difuso según el nivel de zoom
  map.on("zoom", function () {
    var zoom = map.getZoom();
    var radius = zoom >= 15 ? 100 : 50; // Radio más grande cuando el zoom es cercano
    userLocationAura.setRadius(radius);
  });

  // Centrar el mapa en la ubicación actual
  map.setView([lat, lon], map.getZoom());

  // Obtener la dirección y mostrarla en la consola (o puedes usarla en otro lugar)
  obtenerDireccion(lat, lon, (direccion) => {
    console.log("Ubicación actual aproximada:", direccion);
  });
}

function ajustarPuntosCercanos() {
  // Definimos el rango en kilómetros dentro del cual queremos los puntos (por ejemplo, 1 km)
  const rangoAjuste = 1; // 1 km

  // Ubicación actual de tu usuario
  const latUsuario = userLocationMarker.getLatLng().lat;
  const lonUsuario = userLocationMarker.getLatLng().lng;

  // Recorremos todos los puntos y ajustamos aquellos que están fuera del rango
  puntosAlmagro.forEach((coord, index) => {
    const latPunto = coord[0];
    const lonPunto = coord[1];

    // Calculamos la distancia entre tu ubicación y el punto actual
    const distancia = calcularDistancia(
      latUsuario,
      lonUsuario,
      latPunto,
      lonPunto
    );

    // Si la distancia es mayor que el rango, ajustamos el punto
    if (distancia > rangoAjuste) {
      // Calculamos el ajuste: movemos el punto hacia tu ubicación
      const angulo = Math.atan2(latUsuario - latPunto, lonUsuario - lonPunto);

      // Calculamos nuevas coordenadas ajustadas
      const latAjustado =
        latPunto + (rangoAjuste / distancia) * (latUsuario - latPunto);
      const lonAjustado =
        lonPunto + (rangoAjuste / distancia) * (lonUsuario - lonPunto);

      // Actualizamos la coordenada
      puntosAlmagro[index] = [latAjustado, lonAjustado];
    }
  });

  // Ahora podemos recrear los marcadores con las coordenadas ajustadas
  puntosAlmagro.forEach((coord) => crearMarcador(coord[0], coord[1]));
}
// Filtramos los puntos cercanos
function obtenerPuntosCercanos() {
  const rangoAjuste = 5; // Rango en kilómetros (puedes ajustar este valor)
  const puntosCercanos = [];

  // Ubicación actual del usuario
  const latUsuario = userLocationMarker.getLatLng().lat;
  const lonUsuario = userLocationMarker.getLatLng().lng;

  // Recorremos todos los puntos
  puntosAlmagro.forEach((coord) => {
    const latPunto = coord[0];
    const lonPunto = coord[1];

    // Calculamos la distancia entre tu ubicación y el punto
    const distancia = calcularDistancia(
      latUsuario,
      lonUsuario,
      latPunto,
      lonPunto
    );

    // Si la distancia es menor o igual al rango, lo añadimos a la lista de puntos cercanos
    if (distancia <= rangoAjuste) {
      puntosCercanos.push(coord);
    }
  });

  // Devolvemos solo los puntos cercanos
  return puntosCercanos;
}
function ajustarMapa() {
  // Obtener los puntos cercanos
  const puntosCercanos = obtenerPuntosCercanos();

  // Si hay puntos cercanos, ajustamos el mapa para mostrarlos
  if (puntosCercanos.length > 0) {
    // Establecer el centro del mapa en tu ubicación actual
    map.setView(
      [userLocationMarker.getLatLng().lat, userLocationMarker.getLatLng().lng],
      13
    ); // Zoom 13 es un valor estándar, ajustable

    // clearMarkers();

    // Crear los nuevos marcadores para los puntos cercanos
    puntosCercanos.forEach((coord) => crearMarcador(coord[0], coord[1]));
  } else {
    // Si no hay puntos cercanos, solo mostrar la ubicación del usuario
    map.setView(
      [userLocationMarker.getLatLng().lat, userLocationMarker.getLatLng().lng],
      13
    );
  }
}

// Llamamos a la función de ajustar puntos una vez que la ubicación se ha actualizado
// Llamamos a la función de obtener la ubicación y ajustar el mapa
function obtenerUbicacion() {
  if (navigator.geolocation) {
    navigator.geolocation.watchPosition(
      function (position) {
        const lat = position.coords.latitude;
        const lon = position.coords.longitude;

        // Actualizamos la ubicación en el mapa
        actualizarUbicacion(lat, lon);

        // Ajustamos los puntos cercanos y el mapa
        ajustarMapa();

        // Aquí puedes llamar a tu API para guardar la ubicación, si es necesario
        //  guardarUbicacion(lat, lon);
      },
      function (error) {
        console.error("Error al obtener la ubicación:", error);
      }
    );
  } else {
    alert("La geolocalización no es soportada por este navegador.");
  }
}

// Función para calcular la distancia entre dos puntos (en kilómetros)
function calcularDistancia(lat1, lon1, lat2, lon2) {
  const R = 6371; // Radio de la Tierra en kilómetros
  const dLat = ((lat2 - lat1) * Math.PI) / 180;
  const dLon = ((lon2 - lon1) * Math.PI) / 180;
  const a =
    Math.sin(dLat / 2) * Math.sin(dLat / 2) +
    Math.cos((lat1 * Math.PI) / 180) *
      Math.cos((lat2 * Math.PI) / 180) *
      Math.sin(dLon / 2) *
      Math.sin(dLon / 2);
  const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
  return R * c; // Distancia en kilómetros
}

// Función para guardar la ubicación en el servidor
function guardarUbicacion(lat, lon) {
  fetch("/Home/GuardarUbicacion", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      ubicacionX: lat,
      ubicacionY: lon,
    }),
  })
    .then((response) => {
      if (!response.ok) {
        throw new Error("Error al guardar la ubicación");
      }
      return response.json();
    })
    .then((data) => {
      console.log("Ubicación guardada:", data);
    })
    .catch((error) => {
      console.error("Error:", error);
    });
}

// Función para guardar la ubicación en el servidor
function guardarUbicacion(lat, lon) {
  fetch("/Home/GuardarUbicacion", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      ubicacionY: lat, // Asigna latitud a ubicacionY
      ubicacionX: lon, // Asigna longitud a ubicacionX
    }),
  })
    .then((response) => {
      if (!response.ok) {
        throw new Error("Error al guardar la ubicación");
      }
      return response.json();
    })
    .then((data) => {
      console.log("Ubicación guardada:", data);
    })
    .catch((error) => {
      console.error("Error:", error);
    });
}

document.addEventListener("DOMContentLoaded", () => {
  console.log(puntosAlmagro);
  puntosAlmagro.forEach((coord) => crearMarcador(coord[0], coord[1]));
  obtenerUbicacion();
});

// Llama a la función para obtener la ubicación
document.getElementById("search-bar").addEventListener("keydown", function (event) {
  if (event.key === "Enter") { // Detectar si la tecla presionada es Enter
      event.preventDefault(); // Evitar que el formulario se envíe si está dentro de uno
      buscarUbicacion(); // Llamar a la función de búsqueda
  }
});
// Función para buscar una ubicación
function buscarUbicacion() {
  const query = document.getElementById("search-bar").value; // Obtener el texto ingresado
  if (!query) {
      alert("Por favor, ingresa una ubicación.");
      return;
  }

  // Llamar a la API de geocodificación de Nominatim
  fetch(`https://nominatim.openstreetmap.org/search?format=json&q=${query}`)
      .then((response) => response.json())
      .then((data) => {
          if (data.length === 0) {
              alert("No se encontró la ubicación.");
              return;
          }

          // Obtener las coordenadas de la primera ubicación encontrada
          const { lat, lon } = data[0];

          // Hacer zoom en el mapa a las coordenadas encontradas
          map.setView([lat, lon], 5); // Zoom nivel 13 para mostrar más mapa
      })
      .catch((error) => {
          console.error("Error al buscar la ubicación:", error);
      });
}