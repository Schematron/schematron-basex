module namespace _ = "0001";

import module namespace s = "http://github.com/Schematron/schematron-basex" at "../../main/content/schematron.xqm";

declare namespace svrl="http://purl.oclc.org/dsdl/svrl";
declare namespace xsl="http://www.w3.org/1999/XSL/Transform";

(:~ 
 : Probably not able to test automatically the variations of having Saxon available (can use xslt2), or not having Saxon available. Stick to xslt 1.0 without using Saxon for most of the unit tests.
 :)

declare %unit:test function _:compile() {
  let $c := s:compile(doc('0001.sch'))
  return unit:assert($c[xsl:stylesheet])
};

declare %unit:test function _:validationResult() {
  let $c := s:compile(doc('0001.sch'))
  let $r := s:validate(doc('0001.xml'), $c)
  return unit:assert($r[svrl:schematron-output])
};


