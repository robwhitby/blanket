xquery version "1.0-ml";
import module namespace library = "library" at "library.xqy";

declare function local:bar()
{
  let $x := library:func1() 
  return "bar"
};

declare function local:not-hit()
{
	let $x := 1
	return $x	
};

local:bar()
