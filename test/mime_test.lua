require('luacov')
local testcase = require('testcase')
local assert = require('assert')
local mime = require('mime')

function testcase.new()
    -- test that create a mime object
    local m = mime.new()
    assert.re_match(m, '^mime: ')
end

function testcase.clear()
    local m = mime.new()

    -- test that clear the mime type table to empty
    m:clear()
    assert.equal(m.ext2mime, {})
    assert.equal(m.mime2exts, {})
end

function testcase.reset()
    local m = mime.new()

    -- test that reset the mime type table to the default
    m:clear()
    m:reset()
    assert.not_nil(next(m.ext2mime))
    assert.not_nil(next(m.mime2exts))
end

function testcase.read()
    local m = mime.new()

    -- test that read mediatype object with custom mimetypes
    m:clear()
    local invalids = m:read([[
        my/mimetype     my myfile;    # my custom mime-type

        # invalid mime type definition
        subtype/is-not-declared
    ]])
    assert.equal(m.ext2mime, {
        my = 'my/mimetype',
        myfile = 'my/mimetype',
    })
    assert.equal(m.mime2exts, {
        ['my/mimetype'] = {
            'my',
            'myfile',
        },
    })
    assert.equal(invalids, {
        'subtype/is-not-declared',
    })

    -- test that throws an error with invalid argument
    local err = assert.throws(m.read, m, 1)
    assert.match(err, 'mimetypes must be string')
end

function testcase.add()
    local m = mime.new()
    m:clear()

    -- test that add a new mime type and its associated extensions
    local ok, err = m:add('application/myjson', {
        'json',
    })
    assert.is_nil(err)
    assert.is_true(ok)
    assert.equal(m.mime2exts, {
        ['application/myjson'] = {
            'json',
        },
    })
    assert.equal(m.ext2mime, {
        json = 'application/myjson',
    })

    -- test that cannot add a new mime type if the extension is already registered
    ok, err = m:add('application/json', {
        'json',
    })
    assert.is_nil(err)
    assert.is_false(ok)
    assert.equal(m.mime2exts, {
        ['application/myjson'] = {
            'json',
        },
    })
    assert.equal(m.ext2mime, {
        json = 'application/myjson',
    })

    -- test that throws an error if mime is not a string
    err = assert.throws(m.add, m, 1, {
        1,
    })
    assert.match(err, 'mime must be string in a valid MIME type format')

    -- test that throws an error if mime is not a valid mime type
    err = assert.throws(m.add, m, 'subtype-is-not-declared', {
        'json',
    })
    assert.match(err, 'mime must be string in a valid MIME type format')

    -- test that throws an error if exts is not a table
    err = assert.throws(m.add, m, 'application/json', 1)
    assert.match(err, 'exts must be string[]')

    -- test that throws an error if exts contains a non-string element
    err = assert.throws(m.add, m, 'application/json', {
        1,
    })
    assert.match(err, 'exts#1 "number" is not a string')

    -- test that throws an error if exts contains an invalid extension
    err = assert.throws(m.add, m, 'application/json', {
        'json;',
    })
    assert.match(err, 'exts#1 "json;" is not a valid extension')
end

function testcase.del()
    local m = mime.new()
    m:clear()
    assert(m:add('application/myjson', {
        'json',
    }))
    assert.equal(m.mime2exts, {
        ['application/myjson'] = {
            'json',
        },
    })

    -- test that delete a mime type and its associated extensions
    local ok = m:del('application/myjson')
    assert.is_true(ok)
    assert.equal(m.mime2exts, {})
    assert.equal(m.ext2mime, {})

    -- test that return false if the mime type is not registered
    ok = m:del('application/myjson')
    assert.is_false(ok)

    -- test that throws an error if mime is not a string
    local err = assert.throws(m.del, m, 1)
    assert.match(err, 'mime must be string in a valid MIME type format')

    -- test that throws an error if mime is not a valid mime type
    err = assert.throws(m.del, m, 'subtype-is-not-declared')
    assert.match(err, 'mime must be string in a valid MIME type format')
end

function testcase.getmime()
    -- test that return mime types associated with extension with default mimetypes
    local t = mime.getmime('json')
    assert.equal(t, 'application/json')

    -- test that return mime type associated with extension of pathname
    t = mime.getmime('/foo/bar/baz.json', true)
    assert.equal(t, 'application/json')

    -- test that return nil if the extension is not registered
    t = mime.getmime('json;')
    assert.is_nil(t)

    -- test that return nil if the extension is not string
    t = mime.getmime(1)
    assert.is_nil(t)

    -- test that return mime type associated with extension
    local m = mime.new()
    m:clear()
    m:add('application/myjson', {
        'json',
    })
    t = m:getmime('json')
    assert.equal(t, 'application/myjson')

    -- test that throws an error if as_pathname is not a boolean
    local err = assert.throws(m.getmime, m, 'json', 1)
    assert.match(err, 'as_pathname must be boolean')
end

function testcase.getexts()
    -- test that return extensions associated with mime type with default mimetypes
    local exts = mime.getexts('application/json')
    assert.equal(exts, {
        'json',
    })

    -- test that return extensions associated with mime type
    local m = mime.new()
    m:clear()
    m:add('application/myjson', {
        'json',
    })
    exts = m:getexts('application/myjson')
    assert.equal(exts, {
        'json',
    })
end

