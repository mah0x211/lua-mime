require('luacov')
local testcase = require('testcase')
local assert = require('assert')
local default = require('mime.default')

function testcase.default()
    -- luacheck: ignore 631
    -- test that mime.default returns the table that contains default mime types and its associated extensions look up table
    local tbl = default()
    assert.is_table(tbl)
    assert.is_table(tbl.mime2exts)
    assert.is_table(tbl.ext2mime)
end
