xquery version "1.0-ml";

module namespace blanket = "http://github.com/robwhitby/blanket/state";
declare private variable $server-field-key := "http://github.com/robwhitby/blanket";


declare function get-state() as map:map
{
  xdmp:get-server-field($server-field-key, map:map())
};

declare function add-report($report as element(prof:report)) as map:map
{
  let $map := map:map()
  let $_ := 
    for $uri in fn:distinct-values($report//prof:uri)
    let $lines := distinct-values-sorted($report//prof:expression[prof:uri = $uri]/prof:line/xs:integer(.))
    return map:put($map, $uri, $lines)
  let $_save := update-state($map)
  return get-state()
};

declare function set-state($map as map:map?) as map:map? 
{
  xdmp:set-server-field($server-field-key, $map)
};

declare function update-state($new as map:map?) as map:map?
{
  let $state := get-state()
  let $_ :=
    for $key in map:keys($new)
    let $values := fn:distinct-values((map:get($state, $key), map:get($new, $key)))
    return map:put($state, $key, $values)
  return set-state($state)
};

declare private function distinct-values-sorted($seq as item()*) as item()* 
{
  for $item in fn:distinct-values($seq)
  order by $item
  return $item  
};
