xquery version "1.0-ml";
module namespace test = "http://github.com/robwhitby/xray/test";
import module namespace assert = "http://github.com/robwhitby/xray/assertions" at "/xray/src/assertions.xqy";

import module namespace blanket = "http://github.com/robwhitby/blanket" at "/blanket/src/blanket.xqy";

declare private variable $foo-module := "/blanket/test/resources/foo.xqy";
declare private variable $foo-lines := (3,4);

declare private variable $bar-module := "/blanket/test/resources/bar.xqy";
declare private variable $bar-lines := (6,16);

declare private variable $library-module := "/blanket/test/resources/library.xqy";
declare private variable $library-lines-func1 := (6,7);
declare private variable $library-lines-func2 := (14);

declare function invoke-module()
{
  let $result := blanket:invoke($foo-module)
  return assert:equal($result, "foo") 
};

declare function should-contain-uri()
{
  let $_ := blanket:reset()
  let $result := blanket:invoke($foo-module)
  let $state := blanket:state()
  return (
    assert:equal($result, "foo"),
    assert:equal(map:keys($state), $foo-module)
  )
};

declare function should-contain-line-numbers()
{
  let $_ := blanket:reset()
  let $result := blanket:invoke($foo-module)
  let $state := blanket:state()
  return assert:equal(map:get($state, $foo-module), $foo-lines)
};

declare function should-record-multiple-identical-invokes()
{
  let $_ := blanket:reset()
  let $result := blanket:invoke($foo-module)
  let $result := blanket:invoke($foo-module)
  let $state := blanket:state()
  return assert:equal(map:get($state, $foo-module), $foo-lines)
};

declare function should-record-multiple-different-invokes()
{
  let $_ := blanket:reset()
  let $result-foo := blanket:invoke($foo-module)
  let $result-bar := blanket:invoke($bar-module)
  let $state := blanket:state()
  return (
    assert:equal(map:get($state, $foo-module), $foo-lines),
    assert:equal(map:get($state, $bar-module), $bar-lines)
  )
};

declare function should-include-library-modules()
{
  let $_ := blanket:reset()
  let $result-bar := blanket:invoke($bar-module)
  let $state := blanket:state()
  return assert:equal(map:get($state, $library-module), $library-lines-func1)
};


