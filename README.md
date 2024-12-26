# lua-mime

[![test](https://github.com/mah0x211/lua-mime/actions/workflows/test.yml/badge.svg)](https://github.com/mah0x211/lua-mime/actions/workflows/test.yml)
[![Coverage Status](https://coveralls.io/repos/github/mah0x211/lua-mime/badge.svg?branch=master)](https://coveralls.io/github/mah0x211/lua-mime?branch=master)

MIME type utility module.


## Installation

```
luarocks install mime
```

---

## mimetype = mime.getmime( ext [, as_filename] )

get a MIME type string associated with `ext` argument. if `as_filename` argument is `true`, then a `ext` argument is treated as a filename and extract the extension from it.

**Parameters**

- `ext:string`: extension string or filename. extension string should not include a leading dot.
- `as_filename:boolean`: treat `ext` argument as a filename. (default: `false`)

**Returns**

- `mimetype:string`: mime type string or `nil`.

**Example**

```lua
local mime = require('mime')
print(mime.getmime('js')) -- 'application/javascript'
print(mime.getmime('/foo/bar/baz.js', true)) -- 'application/javascript'
```


## exts = mime.getexts( mime )

get extension strings associated with `mime` argument.

**Parameters**

- `mime:string`: mime type string. (e.g. `application/javascript`)

**Returns**

- `exts:string[]`: extension strings table or `nil`.

**Example**

```lua
local dump = require('dump')
local mime = require('mime')
local exts = mime.getexts('application/xml')
print(dump(exts))
-- {
--     [1] = "atom",
--     [2] = "rdf",
--     [3] = "rss",
--     [4] = "xml"
-- }
```


## m = mime.new()

create a new mime object. this object contains a default mime types.

**Returns**

- `m:mime`: mime object

**Example**

```lua
local mime = require('mime')
local m = mime.new()
print(m) -- mime: 0x600000398040
```


## mimetype = mime:getmime( ext )

same as `mime.getmime( ext )`.


## exts = mime:getexts( mime )

same as `mime.getexts( mime )`.


## ok, err = mime:add( mimetype, exts )

add new mime type and extension strings.

**Parameters**

- `mimetype:string`: a mime type string. (e.g. `application/javascript`)
- `exts:string[]`: extension strings table. (e.g. `{ 'js' }`)

**Returns**

- `ok:boolean`: `true` on success, `false` on failure. (e.g. already exists)
- `err:any`: error message.


## ok = mime:del( mimetype )

delete a mime type and associated extension strings.

**Parameters**

- `mimetype:string`: a mime type string. (e.g. `application/javascript`)

**Returns**

- `ok:boolean`: `true` on deleted, `false` on not found.


## invalid_lines = mime:read( mimetypes )

read mime types from a string.

**Parameters**

- `mimetypes:string`: mime string.

**Returns**

- `invalid_lines:string[]`: list of invalid lines.

**Example**

```lua
local dump = require('dump')
local mime = require('mime')
local m = mime.new()
local invalid_lines = m:read([[
    my/mimetype     my myfile; # my custom mime-type

    # no needs to last semicolon
    application/json json

    # invalid mime type definition
    extension/is-not-declared

    invalid_mime*/type foo # invalid mime type is ignored
]])
print(dump(invalid_lines))
-- {
--     [1] = "extension/is-not-declared",
--     [2] = "invalid_mime*/type foo # invalid mime type is ignored"
-- }
```


