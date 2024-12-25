require('luacov')
local testcase = require('testcase')
local assert = require('assert')
local parser = require('mime.parser')

function testcase.read()
    -- test that parse the mimetypes string
    local mime2exts = {}
    local ext2mime = {}
    local invalids = parser.read(mime2exts, ext2mime, [[
        my/mimetype     my myfile; # my custom mime-type

        # no needs to last semicolon
        application/json json

        # invalid mime type definition
        extension/is-not-declared

        invalid_mime*/type foo # invalid mime type is ignored
    ]])
    assert.equal(ext2mime, {
        my = 'my/mimetype',
        myfile = 'my/mimetype',
        json = 'application/json',
    })
    assert.equal(mime2exts, {
        ['my/mimetype'] = {
            'my',
            'myfile',
        },
        ['application/json'] = {
            'json',
        },
    })
    assert.equal(invalids, {
        'extension/is-not-declared',
        'invalid_mime*/type foo # invalid mime type is ignored',
    })

    -- test that throws an error if mime2exts is not table
    local err = assert.throws(parser.read, 1, ext2mime, [[
        my/mimetype     my myfile;    # my custom mime-type
    ]])
    assert.match(err, 'mime2exts must be table')

    -- test that throws an error if ext2mime is not table
    err = assert.throws(parser.read, mime2exts, 1, [[
        my/mimetype     my myfile;    # my custom mime-type
    ]])
    assert.match(err, 'ext2mime must be table')

    -- test that throws an error if mimetypes is not string
    err = assert.throws(parser.read, mime2exts, ext2mime, 1)
    assert.match(err, 'mimetypes must be string')
end

function testcase.is_valid_mime()
    -- test that return true if the given mime is valid
    assert.is_true(parser.is_valid_mime('application/atom+xml'))

    -- test that return false if the given mime without subtype
    assert.is_false(parser.is_valid_mime('application'))

    -- test that throws an error if mime is not string
    local err = assert.throws(parser.is_valid_mime, 1)
    assert.match(err, 'mime must be string')
end

function testcase.is_valid_mime_type()
    -- test that return true if the given mime type part is valid
    assert.is_true(parser.is_valid_mime_type('application'))

    -- test that return false if the given mime type part is invalid
    assert.is_false(parser.is_valid_mime_type('atom+xml'))

    -- test that throws an error if mime is not string
    local err = assert.throws(parser.is_valid_mime_type, 1)
    assert.match(err, 'mime must be string')
end

function testcase.is_valid_mime_subtype()
    -- test that return true if the given mime subtype is valid
    assert.is_true(parser.is_valid_mime_subtype('atom+xml'))

    -- test that return false if the given mime subtype is invalid
    assert.is_false(parser.is_valid_mime_subtype('application/atom+xml'))

    -- test that throws an error if mime is not string
    local err = assert.throws(parser.is_valid_mime_subtype, 1)
    assert.match(err, 'mime must be string')
end
