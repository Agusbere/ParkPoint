var map = L.map('map').setView([-34.6037, -58.3816], 13);

    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        maxZoom: 19,
    }).addTo(map);


        
// Función para obtener la ubicación en tiempo real
function obtenerUbicacion() {
    if (navigator.geolocation) {
        navigator.geolocation.watchPosition(
            function(position) {
                var lat = position.coords.latitude;
                var lon = position.coords.longitude;
                var userLocation = L.marker([lat, lon]).addTo(map)
                    .bindPopup('Tu ubicación actual').openPopup();
                
                // Mover el mapa a la ubicación del usuario
                map.setView([lat, lon], 13);

                // Aquí puedes llamar a tu API para guardar la ubicación
                guardarUbicacion(lat, lon);
            },
            function(error) {
                console.error('Error al obtener la ubicación:', error);
            }
        );
    } else {
        alert('La geolocalización no es soportada por este navegador.');
    }
}

// Función para guardar la ubicación en el servidor
function guardarUbicacion(lat, lon) {
    fetch('/Home/GuardarUbicacion', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            ubicacionX: lat,
            ubicacionY: lon
        })
    }).then(response => {
        if (!response.ok) {
            throw new Error('Error al guardar la ubicación');
        }
        return response.json();
    }).then(data => {
        console.log('Ubicación guardada:', data);
    }).catch(error => {
        console.error('Error:', error);
    });
}

// Llama a la función para obtener la ubicación
obtenerUbicacion();