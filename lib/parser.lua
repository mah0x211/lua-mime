--
-- Copyright (C) 2024-present Masatoshi Fukunaga
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- THE SOFTWARE.
--
--- modules
local find = string.find
local gmatch = string.gmatch
local match = string.match
local sub = string.sub
local type = type
local new_regex = require('regex').new

--- split
--- @param str string
--- @return string[] arr
local function split(str)
    --
    -- split the following format string:
    --
    --  mime/type       ext1 ext2 ext3
    --
    local arr = {}
    local idx = 0
    local cur = 1
    local last = #str + 1
    local head, tail = find(str, '%s+', cur)
    while head do
        if head ~= cur then
            idx = idx + 1
            arr[idx] = sub(str, cur, head - 1)
        end
        cur = tail + 1
        head, tail = find(str, '%s+', cur)
    end

    -- add last token that has no space after the token
    if cur < last then
        arr[idx + 1] = sub(str, cur)
    end
    return arr
end

-- type part
local MIME_TYPE_PATTERN = '[a-z0-9]+(?:-[a-z0-9]+)*'
local RE_MIME_TYPE = new_regex('^' .. MIME_TYPE_PATTERN .. '$', 'i')

--- is_valid_mime_type check whether the given string is valid mime type
--- @param mime string
--- @return boolean ok
local function is_valid_mime_type(mime)
    if type(mime) ~= 'string' then
        error('mime must be string', 2)
    end
    return RE_MIME_TYPE:test(mime)
end

-- subtype part
local MIME_SUBTYPE_PATTERN = '[a-z0-9]+(?:[.+-][a-z0-9]+)*'
local RE_MIME_SUBTYPE = new_regex('^' .. MIME_SUBTYPE_PATTERN .. '$', 'i')

--- is_valid_mime_subtype check whether the given string is valid mime subtype
--- @param mime string
--- @return boolean ok
local function is_valid_mime_subtype(mime)
    if type(mime) ~= 'string' then
        error('mime must be string', 2)
    end
    return RE_MIME_SUBTYPE:test(mime)
end

-- full mime type
local RE_MIME = new_regex('^' .. MIME_TYPE_PATTERN .. '/' ..
                              MIME_SUBTYPE_PATTERN .. '$', 'i')

--- is_valid_mime check whether the given string is valid mime
--- @param mime string
--- @return boolean ok
local function is_valid_mime(mime)
    if type(mime) ~= 'string' then
        error('mime must be string', 2)
    end
    return RE_MIME:test(mime)
end

--- read
--- @param mimetypes string mimetypes described on each lines
--- @param mime2exts table<string, string[]> mime to exts table
--- @param ext2mime table<string, string> ext to mime table
--- @return string[] invalids invalid mime types
local function read(mime2exts, ext2mime, mimetypes)
    if type(mime2exts) ~= 'table' then
        error('mime2exts must be table', 2)
    elseif type(ext2mime) ~= 'table' then
        error('ext2mime must be table', 2)
    elseif type(mimetypes) ~= 'string' then
        error('mimetypes must be string', 2)
    end

    --
    -- parses the following mime format string:
    --
    --  mime/type       ext1 ext2 ext3 # comments
    --
    -- read each line
    local invalids = {}
    for line in gmatch(mimetypes, '[^\n\r]+') do
        -- trim spaces
        line = match(line, '^%s*(.-)%s*$')
        -- remove comments
        local decl = match(line, '^[^#]+')
        if decl then
            local list = split(decl)
            -- select mime type part if its declared with extensions
            local mime = #list > 1 and list[1]

            if not mime then
                -- invalid declaration
                invalids[#invalids + 1] = line
            elseif not is_valid_mime(mime) then
                -- invalid mime type format
                invalids[#invalids + 1] = line
            else
                local exts = mime2exts[mime]
                if not exts then
                    exts = {}
                end

                -- register only valid mime type and its extensions
                -- select extension
                for i = 2, #list do
                    local ext = match(list[i], '%w+')
                    -- found new extension
                    if ext and not ext2mime[ext] then
                        -- mapping extension to mime type
                        ext2mime[ext] = mime
                        -- add extension to the list
                        exts[#exts + 1] = ext
                    end
                end

                if #exts > 0 then
                    mime2exts[mime] = exts
                end
            end
        end
    end

    return invalids
end

return {
    read = read,
    is_valid_mime = is_valid_mime,
    is_valid_mime_type = is_valid_mime_type,
    is_valid_mime_subtype = is_valid_mime_subtype,
}

