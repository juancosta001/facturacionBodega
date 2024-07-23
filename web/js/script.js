document.addEventListener("DOMContentLoaded", function() {
    // Obtener todos los elementos del menú que tienen submenús
    var itemsWithSubmenu = document.querySelectorAll("nav ul li.has-submenu");

    // Iterar sobre cada elemento del menú
    itemsWithSubmenu.forEach(function(item) {
        // Obtener el submenú asociado al elemento del menú
        var submenu = item.querySelector(".submenu");

        // Agregar un evento al elemento cuando el cursor entre en él
        item.addEventListener("mouseenter", function() {
            // Ocultar todos los submenús antes de mostrar el submenú actual
            var allSubmenus = document.querySelectorAll(".submenu");
            allSubmenus.forEach(function(sub) {
                sub.style.display = "none";
            });
            // Mostrar el submenú solo del elemento actual
            submenu.style.display = "block";
        });

        item.addEventListener("mouseleave", function() {
           
            submenu.style.display = "none";
        });
    });
    
});

