---
---   this file generated from mime.types by codegen.lua
---   Thu, 26 Dec 2024 09:40:39 +0900
---
--- @alias mime.ext2mime table<string, string>
--- @alias mime.mime2exts table<string, string[]>
--- default returns the default mime types and its associated extensions
--- @return table<string, mime.ext2mime|mime.mime2exts>
local function default()
    return {
        ext2mime = {
            ["3gp"] = "video/3gpp",
            ["3gpp"] = "video/3gpp",
            ["7z"] = "application/x-7z-compressed",
            aac = "audio/mp4",
            ai = "application/postscript",
            appcache = "text/cache-manifest",
            asf = "video/x-ms-asf",
            asx = "video/x-ms-asf",
            atom = "application/xml",
            avi = "video/x-msvideo",
            bin = "application/octet-stream",
            bmp = "image/bmp",
            cco = "application/x-cocoa",
            crt = "application/x-x509-ca-cert",
            crx = "application/x-chrome-extension",
            css = "text/css",
            cur = "image/x-icon",
            deb = "application/octet-stream",
            der = "application/x-x509-ca-cert",
            dll = "application/octet-stream",
            dmg = "application/octet-stream",
            doc = "application/msword",
            docx = "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
            ear = "application/java-archive",
            eot = "application/vnd.ms-fontobject",
            eps = "application/postscript",
            exe = "application/octet-stream",
            f4a = "audio/mp4",
            f4b = "audio/mp4",
            f4p = "video/mp4",
            f4v = "video/mp4",
            flv = "video/x-flv",
            gif = "image/gif",
            hqx = "application/mac-binhex40",
            htc = "text/x-component",
            htm = "text/html",
            html = "text/html",
            ico = "image/x-icon",
            img = "application/octet-stream",
            iso = "application/octet-stream",
            jad = "text/vnd.sun.j2me.app-descriptor",
            jar = "application/java-archive",
            jardiff = "application/x-java-archive-diff",
            jng = "image/x-jng",
            jnlp = "application/x-java-jnlp-file",
            jpeg = "image/jpeg",
            jpg = "image/jpeg",
            js = "application/javascript",
            json = "application/json",
            kar = "audio/midi",
            kml = "application/vnd.google-earth.kml+xml",
            kmz = "application/vnd.google-earth.kmz",
            m4a = "audio/mp4",
            m4v = "video/mp4",
            manifest = "text/cache-manifest",
            mid = "audio/midi",
            midi = "audio/midi",
            mml = "text/mathml",
            mng = "video/x-mng",
            mov = "video/quicktime",
            mp3 = "audio/mpeg",
            mp4 = "video/mp4",
            mpeg = "video/mpeg",
            mpg = "video/mpeg",
            msi = "application/octet-stream",
            msm = "application/octet-stream",
            msp = "application/octet-stream",
            oex = "application/x-opera-extension",
            oga = "audio/ogg",
            ogg = "audio/ogg",
            ogv = "video/ogg",
            opus = "audio/ogg",
            otf = "font/opentype",
            pdb = "application/x-pilot",
            pdf = "application/pdf",
            pem = "application/x-x509-ca-cert",
            pl = "application/x-perl",
            pm = "application/x-perl",
            png = "image/png",
            ppt = "application/vnd.ms-powerpoint",
            pptx = "application/vnd.openxmlformats-officedocument.presentationml.presentation",
            prc = "application/x-pilot",
            ps = "application/postscript",
            ra = "audio/x-realaudio",
            rar = "application/x-rar-compressed",
            rdf = "application/xml",
            rpm = "application/x-redhat-package-manager",
            rss = "application/xml",
            rtf = "application/rtf",
            run = "application/x-makeself",
            safariextz = "application/octet-stream",
            sea = "application/x-sea",
            shtml = "text/html",
            sit = "application/x-stuffit",
            svg = "image/svg+xml",
            svgz = "image/svg+xml",
            swf = "application/x-shockwave-flash",
            tcl = "application/x-tcl",
            tif = "image/tiff",
            tiff = "image/tiff",
            tk = "application/x-tcl",
            torrent = "application/x-bittorrent",
            ttc = "application/x-font-ttf",
            ttf = "application/x-font-ttf",
            txt = "text/plain",
            vcf = "text/x-vcard",
            vtt = "text/vtt",
            war = "application/java-archive",
            wav = "audio/x-wav",
            wbmp = "image/vnd.wap.wbmp",
            webapp = "application/x-web-app-manifest+json",
            webm = "video/webm",
            webp = "image/webp",
            wml = "text/vnd.wap.wml",
            wmlc = "application/vnd.wap.wmlc",
            wmv = "video/x-ms-wmv",
            woff = "application/font-woff",
            woff2 = "application/font-woff2",
            xhtml = "application/xhtml+xml",
            xls = "application/vnd.ms-excel",
            xlsx = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
            xml = "application/xml",
            xpi = "application/x-xpinstall",
            xsl = "application/xslt+xml",
            zip = "application/zip",
        },
        mime2exts = {
            ["application/font-woff"] = {
                [1] = "woff",
            },
            ["application/font-woff2"] = {
                [1] = "woff2",
            },
            ["application/java-archive"] = {
                [1] = "jar",
                [2] = "war",
                [3] = "ear",
            },
            ["application/javascript"] = {
                [1] = "js",
            },
            ["application/json"] = {
                [1] = "json",
            },
            ["application/mac-binhex40"] = {
                [1] = "hqx",
            },
            ["application/msword"] = {
                [1] = "doc",
            },
            ["application/octet-stream"] = {
                [1] = "bin",
                [2] = "exe",
                [3] = "dll",
                [4] = "deb",
                [5] = "dmg",
                [6] = "iso",
                [7] = "img",
                [8] = "msi",
                [9] = "msp",
                [10] = "msm",
                [11] = "safariextz",
            },
            ["application/pdf"] = {
                [1] = "pdf",
            },
            ["application/postscript"] = {
                [1] = "ps",
                [2] = "eps",
                [3] = "ai",
            },
            ["application/rtf"] = {
                [1] = "rtf",
            },
            ["application/vnd.google-earth.kml+xml"] = {
                [1] = "kml",
            },
            ["application/vnd.google-earth.kmz"] = {
                [1] = "kmz",
            },
            ["application/vnd.ms-excel"] = {
                [1] = "xls",
            },
            ["application/vnd.ms-fontobject"] = {
                [1] = "eot",
            },
            ["application/vnd.ms-powerpoint"] = {
                [1] = "ppt",
            },
            ["application/vnd.openxmlformats-officedocument.presentationml.presentation"] = {
                [1] = "pptx",
            },
            ["application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"] = {
                [1] = "xlsx",
            },
            ["application/vnd.openxmlformats-officedocument.wordprocessingml.document"] = {
                [1] = "docx",
            },
            ["application/vnd.wap.wmlc"] = {
                [1] = "wmlc",
            },
            ["application/x-7z-compressed"] = {
                [1] = "7z",
            },
            ["application/x-bittorrent"] = {
                [1] = "torrent",
            },
            ["application/x-chrome-extension"] = {
                [1] = "crx",
            },
            ["application/x-cocoa"] = {
                [1] = "cco",
            },
            ["application/x-font-ttf"] = {
                [1] = "ttc",
                [2] = "ttf",
            },
            ["application/x-java-archive-diff"] = {
                [1] = "jardiff",
            },
            ["application/x-java-jnlp-file"] = {
                [1] = "jnlp",
            },
            ["application/x-makeself"] = {
                [1] = "run",
            },
            ["application/x-opera-extension"] = {
                [1] = "oex",
            },
            ["application/x-perl"] = {
                [1] = "pl",
                [2] = "pm",
            },
            ["application/x-pilot"] = {
                [1] = "prc",
                [2] = "pdb",
            },
            ["application/x-rar-compressed"] = {
                [1] = "rar",
            },
            ["application/x-redhat-package-manager"] = {
                [1] = "rpm",
            },
            ["application/x-sea"] = {
                [1] = "sea",
            },
            ["application/x-shockwave-flash"] = {
                [1] = "swf",
            },
            ["application/x-stuffit"] = {
                [1] = "sit",
            },
            ["application/x-tcl"] = {
                [1] = "tcl",
                [2] = "tk",
            },
            ["application/x-web-app-manifest+json"] = {
                [1] = "webapp",
            },
            ["application/x-x509-ca-cert"] = {
                [1] = "der",
                [2] = "pem",
                [3] = "crt",
            },
            ["application/x-xpinstall"] = {
                [1] = "xpi",
            },
            ["application/xhtml+xml"] = {
                [1] = "xhtml",
            },
            ["application/xml"] = {
                [1] = "atom",
                [2] = "rdf",
                [3] = "rss",
                [4] = "xml",
            },
            ["application/xslt+xml"] = {
                [1] = "xsl",
            },
            ["application/zip"] = {
                [1] = "zip",
            },
            ["audio/midi"] = {
                [1] = "mid",
                [2] = "midi",
                [3] = "kar",
            },
            ["audio/mp4"] = {
                [1] = "aac",
                [2] = "f4a",
                [3] = "f4b",
                [4] = "m4a",
            },
            ["audio/mpeg"] = {
                [1] = "mp3",
            },
            ["audio/ogg"] = {
                [1] = "oga",
                [2] = "ogg",
                [3] = "opus",
            },
            ["audio/x-realaudio"] = {
                [1] = "ra",
            },
            ["audio/x-wav"] = {
                [1] = "wav",
            },
            ["font/opentype"] = {
                [1] = "otf",
            },
            ["image/bmp"] = {
                [1] = "bmp",
            },
            ["image/gif"] = {
                [1] = "gif",
            },
            ["image/jpeg"] = {
                [1] = "jpeg",
                [2] = "jpg",
            },
            ["image/png"] = {
                [1] = "png",
            },
            ["image/svg+xml"] = {
                [1] = "svg",
                [2] = "svgz",
            },
            ["image/tiff"] = {
                [1] = "tif",
                [2] = "tiff",
            },
            ["image/vnd.wap.wbmp"] = {
                [1] = "wbmp",
            },
            ["image/webp"] = {
                [1] = "webp",
            },
            ["image/x-icon"] = {
                [1] = "ico",
                [2] = "cur",
            },
            ["image/x-jng"] = {
                [1] = "jng",
            },
            ["text/cache-manifest"] = {
                [1] = "manifest",
                [2] = "appcache",
            },
            ["text/css"] = {
                [1] = "css",
            },
            ["text/html"] = {
                [1] = "html",
                [2] = "htm",
                [3] = "shtml",
            },
            ["text/mathml"] = {
                [1] = "mml",
            },
            ["text/plain"] = {
                [1] = "txt",
            },
            ["text/vnd.sun.j2me.app-descriptor"] = {
                [1] = "jad",
            },
            ["text/vnd.wap.wml"] = {
                [1] = "wml",
            },
            ["text/vtt"] = {
                [1] = "vtt",
            },
            ["text/x-component"] = {
                [1] = "htc",
            },
            ["text/x-vcard"] = {
                [1] = "vcf",
            },
            ["video/3gpp"] = {
                [1] = "3gpp",
                [2] = "3gp",
            },
            ["video/mp4"] = {
                [1] = "mp4",
                [2] = "m4v",
                [3] = "f4v",
                [4] = "f4p",
            },
            ["video/mpeg"] = {
                [1] = "mpeg",
                [2] = "mpg",
            },
            ["video/ogg"] = {
                [1] = "ogv",
            },
            ["video/quicktime"] = {
                [1] = "mov",
            },
            ["video/webm"] = {
                [1] = "webm",
            },
            ["video/x-flv"] = {
                [1] = "flv",
            },
            ["video/x-mng"] = {
                [1] = "mng",
            },
            ["video/x-ms-asf"] = {
                [1] = "asx",
                [2] = "asf",
            },
            ["video/x-ms-wmv"] = {
                [1] = "wmv",
            },
            ["video/x-msvideo"] = {
                [1] = "avi",
            },
        },
    }
end

return default
