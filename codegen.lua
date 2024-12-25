--
-- Copyright (C) 2024 Masatoshi Fukunaga
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
local dump = require('dump')
local read = require('mime.parser').read

-- read mime.types
local f = assert(io.open('./mime.types', 'r'))
local mimetypes = f:read('*a')
f:close()

-- parse mime.types
local mime2exts = {}
local ext2mime = {}
local invalids = read(mime2exts, ext2mime, mimetypes)
if #invalids > 0 then
    error('invalid mime types:\n' .. table.concat(invalids, '\n\t'))
end

io.output('./lib/default.lua'):write(([==[
---
---   this file generated from mime.types by codegen.lua
---   %s
---
--- @alias mime.ext2mime table<string, string>
--- @alias mime.mime2exts table<string, string[]>
--- default returns the default mime types and its associated extensions
--- @return table<string, mime.ext2mime|mime.mime2exts>
local function default()
    return %s
end

return default
]==]):format(os.date('%a, %d %b %Y %T %z'), dump({
    mime2exts = mime2exts,
    ext2mime = ext2mime,
}, nil, 4)))
