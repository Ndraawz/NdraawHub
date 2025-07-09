Ioad = function(id)
    local url = "https://script-auth.pages.dev/data/" .. id .. ".lua"
    local success, result = pcall(function()
        return game:HttpGet(url)
    end)
    if success then
        loadstring(result)()
    else
        warn("Gagal load:", id)
    end
end
