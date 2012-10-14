xquery version "1.0-ml";
module namespace test = "http://github.com/robwhitby/xray/test";
import module namespace assert = "http://github.com/robwhitby/xray/assertions" at "/xray/src/assertions.xqy";

import module namespace parser = "http://github.com/robwhitby/blanket/parser" at "/blanket/src/parser.xqy";

declare private variable $module-dir := "/blanket/test/resources/";


declare function get-function-line-numbers()
{
  let $result := parser:get-module-functions($module-dir)

  let $expected :=
    <modules path="{$module-dir}">
    	<module uri="/blanket/test/resources/another-library.xqy">
			<function name="another-func1" start="4"></function>
			<function name="another-func2" start="12"></function>
			<function name="another-func3" start="20"></function>
	    </module>
    	<module uri="{$module-dir}library.xqy">
	      <function name="func1" start="4"/>
	      <function name="func2" start="12"/>
	      <function name="func3" start="20"/>
	    </module>
    </modules>
    
  return assert:equal($result, $expected) 
};


