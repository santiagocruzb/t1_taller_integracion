json.films do
    json.array!(@films) do |film|
        json.name film["name"]
        json.url film_path(film["id"])
    end
end

json.characters do
    json.array!(@characters) do |character|
        json.name character["name"]
        json.url character_path(character["id"])
    end
end

json.planets do
    json.array!(@planets) do |planet|
        json.name planet["name"]
        json.url planet_path(planet["id"])
    end
end

json.starships do
    json.array!(@starships) do |starship|
        json.name starship["name"]
        json.url starship_path(starship["id"])
    end
end