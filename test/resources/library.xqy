xquery version "1.0-ml";
module namespace library = "library";

declare function func1()
{
  let $x := fn:true()
  let $y := fn:current-dateTime()
  where $x
  return $y
};

declare function library:func2 ()
{
  let $x := 1
  let $y := 2
  where $x
  return $y  
};

declare function func3(

) {
	let $x := 1
  let $y := 2
  where $x
  return $y 	
};