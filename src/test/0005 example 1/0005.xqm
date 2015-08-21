module namespace _ = "0005";

import module namespace s = "http://github.com/vincentml/schematron-basex" at "../../main/content/schematron.xqm";

declare %unit:test function _:example1a() {
  let $sch := s:compile(doc('example-1.sch'))
  let $svrl := s:validate(doc('example-1a.xml'), $sch)
  return (
    unit:assert(not(s:is-valid($svrl)))
  )
};

declare %unit:test function _:example1b() {
  let $sch := s:compile(doc('example-1.sch'))
  let $svrl := s:validate(doc('example-1b.xml'), $sch)
  return (
    unit:assert(s:is-valid($svrl))
  )
};
