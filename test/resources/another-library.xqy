xquery version "1.0-ml";
module namespace another-library = "another-library";

declare function another-func1()
{
  let $x := fn:true()
  let $y := fn:current-dateTime()
  where $x
  return $y
};

declare function another-library:another-func2 ()
{
  let $x := 1
  let $y := 2
  where $x
  return $y  
};

declare function another-func3(
) 
{
	let $x := 1
  let $y := 2
  where $x
  return $y 	
};
