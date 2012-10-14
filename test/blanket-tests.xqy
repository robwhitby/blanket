xquery version "1.0-ml";
module namespace test = "http://github.com/robwhitby/xray/test";
import module namespace assert = "http://github.com/robwhitby/xray/assertions" at "/xray/src/assertions.xqy";

import module namespace blanket = "http://github.com/robwhitby/blanket" at "/blanket/src/blanket.xqy";

declare private variable $bar-module := "/blanket/test/resources/bar.xqy";


declare function should-compare-state-and-parser()
{
  let $_ := blanket:reset()
  let $result-bar := blanket:invoke($bar-module)
  let $coverage := blanket:coverage("/blanket/test/resources/")

  let $expected :=
  	<coverage percentage="16" path="/blanket/test/resources/">
			<module uri="/blanket/test/resources/another-library.xqy" percentage="0">
			  <function name="another-func1" covered="false" start="4"></function>
			  <function name="another-func2" covered="false" start="12"></function>
			  <function name="another-func3" covered="false" start="20"></function>
			</module>
			<module uri="/blanket/test/resources/library.xqy" percentage="33">
			  <function name="func1" covered="true" start="4"></function>
			  <function name="func2" covered="false" start="12"></function>
			  <function name="func3" covered="false" start="20"></function>
			</module>
      </coverage>

  return assert:equal($coverage, $expected)
};	
