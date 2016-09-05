module namespace _ = "0003";

import module namespace s = "http://github.com/Schematron/schematron-basex" at "../../main/content/schematron.xqm";

(:~ Expect validation to fail if the Schematron doesn't match anything in the document. :)
declare %unit:test function _:test() {
  let $c := s:compile(doc('0003.sch'))
  let $r := s:validate(doc('0003.xml'), $c)
  return unit:assert(not(s:is-valid($r)))
};
