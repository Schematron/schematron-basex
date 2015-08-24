module namespace _ = "0002";

import module namespace s = "http://github.com/vincentml/schematron-basex" at "../../main/content/schematron.xqm";

declare %unit:test function _:valid() {
  let $r := s:validate(doc('0002-valid.xml'), s:compile(doc('0002.sch')))
  return unit:assert(s:is-valid($r), $r)
};

declare %unit:test function _:invalid() {
  let $r := s:validate(doc('0002-invalid.xml'), s:compile(doc('0002.sch')))
  return unit:assert(not(s:is-valid($r)), $r)
};

declare %unit:test function _:valid-messages() {
  let $r := s:messages(s:validate(doc('0002-valid.xml'), s:compile(doc('0002.sch'))))
  return unit:assert(empty($r))
};

declare %unit:test function _:invalid-messages() {
  let $r := s:messages(s:validate(doc('0002-invalid.xml'), s:compile(doc('0002.sch'))))
  return unit:assert-equals(count($r), 1, $r)
};
