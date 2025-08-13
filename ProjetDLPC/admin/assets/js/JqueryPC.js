$(document).ready(function () {
    $('td[data-champ]').on("blur", function () {
        let cell = $(this);
        let champ = cell.attr("data-champ");
        let id_pc = cell.attr("id");
        let nouveau = cell.text().trim();

        let param = {
            champ: champ,
            valeur: nouveau,
            id_pc: id_pc
        };

        $.ajax({
            type: 'GET',
            url: "src/php/ajax/ajax_update_pc.php",
            data: param,
            dataType: 'json',
            success: function (data) {
                if (data.status === "success") {
                    $('#msg').html("<div class='alert alert-success'>✅ Modifié avec succès </div>");
                    cell.css("background-color", "#d4edda");
                    setTimeout(() => {
                        cell.css("background-color", "");
                    }, 1500);
                } else {
                    $('#msg').html("<div class='alert alert-danger'>❌ Erreur : " + data.message + "</div>");
                    cell.css("background-color", "#f8d7da");
                }
            }
        });
    });
});
