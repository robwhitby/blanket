xquery version "1.0-ml";

module namespace blanket = "http://github.com/robwhitby/blanket";
import module namespace state = "http://github.com/robwhitby/blanket/state" at "state.xqy";
import module namespace parser = "http://github.com/robwhitby/blanket/parser" at "parser.xqy";

declare function invoke($path as xs:string, $vars as item()*, $options as node()?) as item()*
{
  let $result := prof:invoke($path, $vars, $options)
  let $_ := state:add-report($result[1])
  return fn:subsequence($result, 2)  
};

declare function invoke($path as xs:string) as item()*
{ 
  invoke($path, (), ())
};

declare function invoke($path as xs:string, $vars as item()*) as item()*
{ 
  invoke($path, $vars, ())
};

declare function reset() as empty-sequence()
{
  state:set-state(())
};

declare function state() as map:map
{
  state:get-state()
};

declare function coverage() as element(coverage)
{
	coverage(xdmp:modules-root())
};

declare function coverage($source-dir as xs:string) as element(coverage)
{
	let $modules := coverage-modules($source-dir)
	let $pct := fn:count($modules/function[@covered eq "true"]) * 100 idiv fn:max((fn:count($modules/function), 1))
	return
	<coverage percentage="{$pct}" path="{$source-dir}">
		{$modules}
	</coverage>
};

declare private function coverage-modules($source-dir) as element(module)*
{
	let $state := state()
	let $module-functions := parser:get-module-functions($source-dir)
	for $module in $module-functions/module
	let $lines-hit := map:get($state, $module/@uri)
	let $functions := 
		for $func in $module/function
		let $line-from := $func/@start/xs:integer(.)
		let $line-to := ($module/function[xs:integer(@start) gt $line-from]/@start/xs:integer(.) - 1, 9999999)[1]
		let $covered := fn:exists($lines-hit[. ge $line-from and . lt $line-to])
		return <function name="{$func/@name}" covered="{$covered}" start="{$func/@start}"/>
	let $pct := fn:count($functions[@covered eq "true"]) * 100 idiv fn:max((fn:count($functions), 1))
	return
		<module uri="{$module/@uri}" percentage="{$pct}">
			{$functions}
		</module>
};

