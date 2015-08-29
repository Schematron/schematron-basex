module namespace _ = "0005";

import module namespace s = "http://github.com/vincentml/schematron-basex" at "../../main/content/schematron.xqm";

declare %unit:test function _:example1a() {
  let $sch := s:compile(doc('example-1.sch'))
  let $svrl := s:validate(doc('example-1a.xml'), $sch)
  return (
    unit:assert(not(s:is-valid($svrl))),
    unit:assert(s:has-messages($svrl)),
    unit:assert-equals(count(s:messages($svrl)), 4),
    unit:assert-equals(s:message-level(s:messages($svrl)[1]), 'info'),
    unit:assert-equals(s:message-level(s:messages($svrl)[2]), 'info'),
    unit:assert-equals(s:message-level(s:messages($svrl)[3]), 'warn'),
    unit:assert-equals(s:message-level(s:messages($svrl)[4]), 'error'),
    unit:assert-equals(s:message-location(s:messages($svrl)[3]), '/document/title'),
    unit:assert-equals(s:message-description(s:messages($svrl)[3]), 'short section has fewer than 3 paragraphs'),
    unit:assert-equals(s:message-location(s:messages($svrl)[4]), '/document/p[2]'),
    unit:assert-equals(s:message-description(s:messages($svrl)[4]), 'p (paragraph) should not be empty')
  )
};

declare %unit:test function _:example1b() {
  let $sch := s:compile(doc('example-1.sch'))
  let $svrl := s:validate(doc('example-1b.xml'), $sch)
  return (
    unit:assert(s:is-valid($svrl)),
    unit:assert(s:has-messages($svrl)),
    unit:assert-equals(count(s:messages($svrl)), 3),
    unit:assert-equals(s:message-level(s:messages($svrl)[1]), 'info'),
    unit:assert-equals(s:message-level(s:messages($svrl)[2]), 'info'),
    unit:assert-equals(s:message-level(s:messages($svrl)[3]), 'warn'),
    unit:assert-equals(s:message-location(s:messages($svrl)[3]), '/document/title'),
    unit:assert-equals(s:message-description(s:messages($svrl)[3]), 'short section has fewer than 3 paragraphs')
  )
};

declare %unit:test function _:example1c() {
  let $sch := s:compile(doc('example-1.sch'))
  let $svrl := s:validate(doc('example-1c.xml'), $sch)
  return (
    unit:assert(s:is-valid($svrl)), 
    unit:assert(not(s:has-messages($svrl)))
  )
};
