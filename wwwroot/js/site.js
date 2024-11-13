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
            // Intentamos obtener la calle y la altura
            let calle = data.address.road || 'Calle desconocida';
            let altura = data.address.house_number || 'sin número';

            // Si no tiene altura, buscamos la más cercana
            if (altura === 'sin número') {
                // Llamamos de nuevo para encontrar la calle más cercana con número
                fetch(`https://nominatim.openstreetmap.org/search?street=${calle}&city=Buenos Aires&format=json`)
                    .then(response => response.json())
                    .then(closestData => {
                        // Encontrar la mejor altura más cercana en la misma calle
                        if (closestData && closestData.length > 0) {
                            // Asignamos el primer número de casa disponible
                            altura = closestData[0].address.house_number || 'sin número';
                        }
                        let direccion = `${calle} ${altura}`;
                        callback(direccion);
                    });
            } else {
                let direccion = `<p>${calle} ${altura}</p>`;
                callback(direccion);
            }
        })
        .catch(error => {
            console.error('Error al obtener la dirección:', error);
            callback('Dirección no disponible');
        });
}


var puntosAlmagro = [
    [-34.6064, -58.4116], // 1
    [-34.6053, -58.4109], // 2
    [-34.6078, -58.4155], // 3
    [-34.6090, -58.4170], // 4
    [-34.6080, -58.4182], // 5
    [-34.6102, -58.4201], // 6
    [-34.6110, -58.4233], // 7
    [-34.6021, -58.4083], // 8
    [-34.6034, -58.4065], // 9
    [-34.6041, -58.4140], // 10
    [-34.6018, -58.4051], // 11
    [-34.6108, -58.4227], // 12
    [-34.6073, -58.4199], // 13
    [-34.6069, -58.4178], // 14
    [-34.6050, -58.4132], // 15
    [-34.6084, -58.4136], // 16
    [-34.6095, -58.4112], // 17
    [-34.6023, -58.4092], // 18
    [-34.6038, -58.4075], // 19
    [-34.6123, -58.4194], // 20
    [-34.6132, -58.4209], // 21
    [-34.6104, -58.4148], // 22
    [-34.6045, -58.4165], // 23
    [-34.6012, -58.4107], // 24
    [-34.6076, -58.4138], // 25
    [-34.6093, -58.4129], // 26
    [-34.6120, -58.4215], // 27
    [-34.6130, -58.4176], // 28
    [-34.6042, -58.4197], // 29
    [-34.6061, -58.4152], // 30
    [-34.6106, -58.4089], // 31
    [-34.6082, -58.4141], // 32
    [-34.6059, -58.4170], // 33
    [-34.6079, -58.4114], // 34
    [-34.6127, -58.4183], // 35
    [-34.6049, -58.4204], // 36
    [-34.6091, -58.4160], // 37
    [-34.6035, -58.4110], // 38
    [-34.6124, -58.4221], // 39
    [-34.6013, -58.4159], // 40
    [-34.6072, -58.4135], // 41
    [-34.6100, -58.4192], // 42
    [-34.6099, -58.4078], // 43
    [-34.6020, -58.4145], // 44
    [-34.6117, -58.4133], // 45
    [-34.6088, -58.4202], // 46
    [-34.6031, -58.4127], // 47
    [-34.6057, -58.4156], // 48
    [-34.6107, -58.4204], // 49
    [-34.6113, -58.4174], // 50
];

// Función para crear un marcador y asignar la función de obtener dirección
function crearMarcador(lat, lon) {
    var marker = L.marker([lat, lon]).addTo(map);
    marker.on('click', function(e) {
        obtenerDireccion(lat, lon, (direccion) => {
            marker.bindPopup(direccion).openPopup();
        });

        //direccionSeleccionada = direccion;
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

function ajustarPuntosCercanos() {
    // Definimos el rango en kilómetros dentro del cual queremos los puntos (por ejemplo, 1 km)
    const rangoAjuste = 1;  // 1 km

    // Ubicación actual de tu usuario
    const latUsuario = userLocationMarker.getLatLng().lat;
    const lonUsuario = userLocationMarker.getLatLng().lng;

    // Recorremos todos los puntos y ajustamos aquellos que están fuera del rango
    puntosAlmagro.forEach((coord, index) => {
        const latPunto = coord[0];
        const lonPunto = coord[1];

        // Calculamos la distancia entre tu ubicación y el punto actual
        const distancia = calcularDistancia(latUsuario, lonUsuario, latPunto, lonPunto);

        // Si la distancia es mayor que el rango, ajustamos el punto
        if (distancia > rangoAjuste) {
            // Calculamos el ajuste: movemos el punto hacia tu ubicación
            const angulo = Math.atan2(latUsuario - latPunto, lonUsuario - lonPunto);

            // Calculamos nuevas coordenadas ajustadas
            const latAjustado = latPunto + (rangoAjuste / distancia) * (latUsuario - latPunto);
            const lonAjustado = lonPunto + (rangoAjuste / distancia) * (lonUsuario - lonPunto);

            // Actualizamos la coordenada
            puntosAlmagro[index] = [latAjustado, lonAjustado];
        }
    });

    // Ahora podemos recrear los marcadores con las coordenadas ajustadas
    puntosAlmagro.forEach(coord => crearMarcador(coord[0], coord[1]));
}
// Filtramos los puntos cercanos
function obtenerPuntosCercanos() {
    const rangoAjuste = 5;  // Rango en kilómetros (puedes ajustar este valor)
    const puntosCercanos = [];

    // Ubicación actual del usuario
    const latUsuario = userLocationMarker.getLatLng().lat;
    const lonUsuario = userLocationMarker.getLatLng().lng;

    // Recorremos todos los puntos
    puntosAlmagro.forEach((coord) => {
        const latPunto = coord[0];
        const lonPunto = coord[1];

        // Calculamos la distancia entre tu ubicación y el punto
        const distancia = calcularDistancia(latUsuario, lonUsuario, latPunto, lonPunto);

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
        map.setView([userLocationMarker.getLatLng().lat, userLocationMarker.getLatLng().lng], 13); // Zoom 13 es un valor estándar, ajustable

        // Limpiar los marcadores actuales del mapa
        clearMarkers();

        // Crear los nuevos marcadores para los puntos cercanos
        puntosCercanos.forEach(coord => crearMarcador(coord[0], coord[1]));
    } else {
        // Si no hay puntos cercanos, solo mostrar la ubicación del usuario
        map.setView([userLocationMarker.getLatLng().lat, userLocationMarker.getLatLng().lng], 13);
    }
}

// Llamamos a la función de ajustar puntos una vez que la ubicación se ha actualizado
// Llamamos a la función de obtener la ubicación y ajustar el mapa
function obtenerUbicacion() {
    if (navigator.geolocation) {
        navigator.geolocation.watchPosition(
            function(position) {
                const lat = position.coords.latitude;
                const lon = position.coords.longitude;

                // Actualizamos la ubicación en el mapa
                actualizarUbicacion(lat, lon);

                // Ajustamos los puntos cercanos y el mapa
                ajustarMapa();

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



// Función para calcular la distancia entre dos puntos (en kilómetros)
function calcularDistancia(lat1, lon1, lat2, lon2) {
    const R = 6371; // Radio de la Tierra en kilómetros
    const dLat = (lat2 - lat1) * Math.PI / 180;
    const dLon = (lon2 - lon1) * Math.PI / 180;
    const a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
              Math.cos(lat1 * Math.PI / 180) * Math.cos(lat2 * Math.PI / 180) *
              Math.sin(dLon / 2) * Math.sin(dLon / 2);
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    return R * c; // Distancia en kilómetros
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

// Función para guardar la ubicación en el servidor
function guardarUbicacion(lat, lon) {
    fetch('/Home/GuardarUbicacion', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            ubicacionY: lat,  // Asigna latitud a ubicacionY
            ubicacionX: lon   // Asigna longitud a ubicacionX
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
