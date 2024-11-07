var map = L.map('map').setView([-34.6037, -58.4116], 15);

L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    maxZoom: 19,
}).addTo(map);

// Variables para el círculo de ubicación y su "aura" difusa
var userLocationMarker;
var userLocationAura;

// Función para obtener la dirección a partir de coordenadas
function obtenerDireccion(lat, lon, callback) {
    fetch(`https://nominatim.openstreetmap.org/reverse?lat=${lat}&lon=${lon}&format=json`)
        .then(response => response.json())
        .then(data => {
            let calle = data.address.road || 'Calle desconocida';
            let altura = data.address.house_number || 'sin número';
            let direccion = `${calle} ${altura}`;
            callback(direccion);
        })
        .catch(error => {
            console.error('Error al obtener la dirección:', error);
            callback('Dirección no disponible');
        });
}

// Lista de puntos alrededor del barrio de Almagro
var puntosAlmagro = [
    [-34.6067, -58.4123],
    [-34.6055, -58.4138],
    [-34.6043, -58.4115],
    [-34.6071, -58.4102],
    [-34.6039, -58.4146]
];

// Función para crear un marcador y asignar la función de obtener dirección
function crearMarcador(lat, lon) {
    var marker = L.marker([lat, lon]).addTo(map);
    marker.on('click', function(e) {
        obtenerDireccion(lat, lon, (direccion) => {
            marker.bindPopup(direccion).openPopup();
        });
    });
}

// Crear los marcadores para cada punto en Almagro
puntosAlmagro.forEach(coord => crearMarcador(coord[0], coord[1]));

function actualizarUbicacion(lat, lon) {
    // Si el marcador de ubicación ya existe, se actualiza su posición
    if (userLocationMarker) {
        userLocationMarker.setLatLng([lat, lon]);
    } else {
        // Crear el marcador de ubicación principal en azul oscuro
        userLocationMarker = L.circleMarker([lat, lon], {
            color: 'blue',
            radius: 8,
            fillColor: 'blue',
            fillOpacity: 0.7
        }).addTo(map);
    }

    // Si el círculo difuso no existe, se crea con un tamaño y opacidad bajos
    if (!userLocationAura) {
        userLocationAura = L.circle([lat, lon], {
            color: '#87CEEB',  // Celeste
            radius: 50,  // Radio inicial
            fillColor: '#87CEEB',
            fillOpacity: 0.2
        }).addTo(map);
    } else {
        // Si ya existe, simplemente se actualiza su posición
        userLocationAura.setLatLng([lat, lon]);
    }

    // Cambiar el tamaño del círculo difuso según el nivel de zoom
    map.on('zoom', function() {
        var zoom = map.getZoom();
        var radius = zoom >= 15 ? 100 : 50; // Radio más grande cuando el zoom es cercano
        userLocationAura.setRadius(radius);
    });

    // Centrar el mapa en la ubicación actual
    map.setView([lat, lon], map.getZoom());

    // Obtener la dirección y mostrarla en la consola (o puedes usarla en otro lugar)
    obtenerDireccion(lat, lon, (direccion) => {
        console.log('Ubicación actual aproximada:', direccion);
    });
}

function obtenerUbicacion() {
    if (navigator.geolocation) {
        navigator.geolocation.watchPosition(
            function(position) {
                var lat = position.coords.latitude;
                var lon = position.coords.longitude;
                actualizarUbicacion(lat, lon);

                // Aquí puedes llamar a tu API para guardar la ubicación, si es necesario
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
