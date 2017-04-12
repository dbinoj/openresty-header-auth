
local keys = {
    '01234567-89ab-cdef-ghij-klmnopqrstuv',
    '82318cf2-1f56-11e7-93ae-92361f002671'
}

local function has_value(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

local function return_four_not_one(msg)
    ngx.req.discard_body()
    ngx.header["Content-type"] = "application/json"
    ngx.status = ngx.HTTP_UNAUTHORIZED
    ngx.say('{"status":"KO","host": "' .. ngx.var.host .. '","error":"' .. msg .. '"}')
    ngx.exit(ngx.HTTP_UNAUTHORIZED)
end

local header = ngx.req.get_headers()['apiKey']

if header == nil then
    return_four_not_one('API Key is missing.')
end

if type(header) == "string" and not has_value(keys, header) then
    return_four_not_one("Invalid API Key.")
end

