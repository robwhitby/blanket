xquery version "1.0-ml";

import module namespace blanket="http://github.com/robwhitby/blanket" at "/blanket/src/blanket.xqy";

blanket:reset(),
xdmp:redirect-response("/blanket")
