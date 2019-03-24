document.addEventListener("turbolinks:load", function () {
    $input = $("[data-behavior='autocomplete']");
    console.log('wenas');
    var options = {
        getValue: "name",
        url: function (phrase) {
            return "/search.json?q=" + phrase;
        },
        categories: [
            {listLocation: "films", header: "<strong>Films</strong>"},
            {listLocation: "characters", header: "<strong>Characters</strong>"},
            {listLocation: "planets", header: "<strong>Planets</strong>"},
            {listLocation: "starships", header: "<strong>Starship</strong>"}
        ],
        list: {
            onChooseEvent: function () {
                var url = $input.getSelectedItemData().url
                $input.val("")
                Turbolinks.visit(url)
            }

        }
    }
    console.log(options);
    $input.easyAutocomplete(options)
});