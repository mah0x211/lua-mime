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
local error = error
local ipairs = ipairs
local type = type
local format = string.format
local find = string.find
local match = string.match
local is_valid_mime = require('mime.parser').is_valid_mime
local read_mimetypes = require('mime.parser').read
--- constants
local default = require('mime.default')

--- @class MIME
--- @field private mime2exts mime.mime2exts
--- @field private ext2mime mime.ext2mime
local MIME = {}

--- init
--- @return MIME
function MIME:init()
    return self:reset()
end

--- reset reset the mime type table to the default
--- @return MIME
function MIME:reset()
    local tbl = default()
    self.mime2exts = tbl.mime2exts
    self.ext2mime = tbl.ext2mime
    return self
end

--- clear clear the mime type table to empty
--- @return MIME
function MIME:clear()
    self.mime2exts = {}
    self.ext2mime = {}
    return self
end

--- getmime
--- @param ext string
--- @param as_pathname boolean? if true, ext is treated as a filename
--- @return string? mime
function MIME:getmime(ext, as_pathname)
    if as_pathname ~= nil and type(as_pathname) ~= 'boolean' then
        error('as_pathname must be boolean', 2)
    elseif type(ext) ~= 'string' then
        return nil
    elseif as_pathname then
        -- extract extension from filename without leading dot
        ext = match(ext, '%.([^.]+)$')
    end
    return self.ext2mime[ext]
end

--- getexts
--- @param mime string
--- @return string[]? exts
function MIME:getexts(mime)
    return self.mime2exts[mime]
end

--- add add a new mime type and its associated extensions
--- @param mime string
--- @param exts string[]
--- @return boolean ok
--- @return any err
function MIME:add(mime, exts)
    if type(mime) ~= 'string' or not is_valid_mime(mime) then
        error('mime must be string in a valid MIME type format', 2)
    elseif type(exts) ~= 'table' then
        error('exts must be string[]', 2)
    end

    -- verify extensions format
    for i, ext in ipairs(exts) do
        if type(ext) ~= 'string' then
            error(format('exts#%d %q is not a string', i, type(ext)), 2)
        elseif #ext > 0 and not find(ext, '^%w+$') then
            error(format('exts#%d %q is not a valid extension', i, ext), 2)
        end
    end

    local line = format('%s %s', mime, table.concat(exts, ' '))
    local invalids = self:read(line)
    if #invalids > 0 then
        return false, format('invalid mime type declaration: %s', line)
    elseif not self.mime2exts[mime] then
        -- a mime is already registered
        return false
    end

    return true
end

--- del
--- @param mime string
--- @return boolean ok
function MIME:del(mime)
    if type(mime) ~= 'string' or not is_valid_mime(mime) then
        error('mime must be string in a valid MIME type format', 2)
    end

    local mime2exts = self.mime2exts
    local exts = mime2exts[mime]
    if not exts then
        -- not found
        return false
    end
    mime2exts[mime] = nil

    -- remove extensions associated with the mime type
    local ext2mime = self.ext2mime
    for _, ext in ipairs(exts) do
        ext2mime[ext] = nil
    end
    return true
end

--- read
--- @param mimetypes string
--- @return string[] invalid_lines
function MIME:read(mimetypes)
    if type(mimetypes) ~= 'string' then
        error('mimetypes must be string', 2)
    end
    return read_mimetypes(self.mime2exts, self.ext2mime, mimetypes)
end

MIME = require('metamodule').new(MIME)

-- default MIME
local DefaultMIME = MIME()

--- getmime get mime type associated with the specified extension
--- @param ext string extension or filename
--- @param as_pathname boolean? if true, ext is treated as a filename
--- @return string? mime
local function getmime(ext, as_pathname)
    return DefaultMIME:getmime(ext, as_pathname)
end

--- getexts get extensions associated with the specified mime type
--- @param mime string
--- @return string[]? exts
local function getexts(mime)
    return DefaultMIME:getexts(mime)
end

return {
    getexts = getexts,
    getmime = getmime,
    new = MIME,
}

