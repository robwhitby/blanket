xquery version "1.0-ml";

import module namespace blanket = "http://github.com/robwhitby/blanket" at "/blanket/src/blanket.xqy";

declare variable $format as xs:string := xdmp:get-request-field("format", "html");

xdmp:xslt-invoke(fn:concat("src/output/", $format, ".xslt"), blanket:coverage("/modules/"))
