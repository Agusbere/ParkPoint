var map = L.map('map').setView([-34.6037, -58.3816], 13);

    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        maxZoom: 19,
    }).addTo(map);

    L.marker([-34.6037, -58.3816]).addTo(map)
        .bindPopup('Buenos Aires, CABA')
        // .openPopup();

// Crea un marcador para la ubicación en tiempo real
var realTimeMarker = L.marker([-34.6037, -58.3816]).addTo(map)
    .bindPopup('Tu ubicación actual');

// Verifica si el navegador soporta la geolocalización
if ("geolocation" in navigator) {
    const options = {
        enableHighAccuracy: true,
        timeout: 5000,
        maximumAge: 0
    };

function success(position) {
    const ubicacionX = position.coords.latitude;
    const ubicacionY = position.coords.longitude;
    const idUsuario = 1

    fetch('/ubicacion/actualizar', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            idUsuario: idUsuario,
            ubicacionX: ubicacionX,
            ubicacionY: ubicacionY
        })
    })
    .then(response => response.json())
    .then(data => console.log('Ubicación actualizada en el servidor:', data))
    .catch(error => console.error('Error al actualizar la ubicación:', error));
}

    function error(err) {
        console.error(`Error (${err.code}): ${err.message}`);
    }

    // Inicia el seguimiento de la ubicación
    navigator.geolocation.watchPosition(success, error, options);
} else {
    console.error("Geolocalización no es soportada en este navegador.");
}



navigator.geolocation.getCurrentPosition(position => {
    console.log(position);
});