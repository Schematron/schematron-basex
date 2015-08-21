module namespace _ = "0004";

import module namespace s = "http://github.com/vincentml/schematron-basex" at "../../main/content/schematron.xqm";

declare %unit:test function _:phase1() {
  let $s := s:compile(doc('0004.sch'), map{'phase': 'phase1'})
  let $r := s:validate(doc('0004.xml'), $s)
  return unit:assert(s:is-valid($r), $r)
};

declare %unit:test function _:phase2() {
  let $s := s:compile(doc('0004.sch'), map{'phase': 'phase2'})
  let $r := s:validate(doc('0004.xml'), $s)
  return unit:assert(not(s:is-valid($r)), $r)
};

