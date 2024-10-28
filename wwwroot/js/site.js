var map = L.map('map').setView([-34.6037, -58.3816], 13);

    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        maxZoom: 19,
    }).addTo(map);

    L.marker([-34.6037, -58.3816]).addTo(map)
        .bindPopup('Buenos Aires, CABA')
        // .openPopup();