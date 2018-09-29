---
layout: map
title: Summer 2018 🏍
---

ohai.

<style>
.fa-divicon {color: red;}
</style>


<script type="text/javascript">
    (function(_map) {
        var gasIcon = L.divIcon({
            className: "fa-divicon",
            // fa-gas-pump is in 5.0.13, we're using 5.0.12 :-(
            html: '<i class="fas fa-battery-quarter fa-lg"></i>',
            // iconSize: [40, 40]
        });
        
        getJSON("/assets/fuel_report.json", function(data) {
            var fuelData = L.geoJSON(data, {
                onEachFeature: popUp,
                pointToLayer: function(pt, latlng) {
                    return L.marker(latlng, {
                        icon: gasIcon
                    });
                }
            });

            _map.fitBounds(fuelData.getBounds());
            fuelData.addTo(_map);
        });

        var photoGroup = L.featureGroup([]);

        {% for post in site.tags["summer2018"] %}
            {% for img in post.images %}
                {% if img[1].exif.location %}
        photoGroup.addLayer(
            L.marker(
                [
                    parseFloat("{{ img[1].exif.location.latitude }}"),
                    parseFloat("{{ img[1].exif.location.longitude }}")
                ],
                {
                    title: "{{ post.title }} – {{ img[1].exif.location.name }}",
                    icon: L.icon({
                        iconUrl: "{{ site.static_images_base_url }}/fit-in/40x40/{{ img[1].path }}",
                    })
                }
            ).bindPopup(
                '<img src="{{ site.static_images_base_url }}/fit-in/400x/{{ img[1].path }}" alt="image" /><br /><a href="{{ post.url | relative_url }}">{{ post.title }}</a>',
                {
                    maxWidth: 400,
                    minWidth: 400
                }
            )
        );
                {% endif %}
            {% endfor %}
            
            {% for gpx in post.gpx %}
            loadGpx("{{ gpx }}", _map);
            {% endfor %}
        {% endfor %}

        photoGroup.addTo(_map);
        _map.fitBounds(photoGroup.getBounds());
    })({{ layout.map_var }});
</script>
