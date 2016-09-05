import module namespace s = "http://github.com/Schematron/schematron-basex" at '../../main/content/schematron.xqm';

let $sch := s:compile(doc('example-1.sch'))
let $svrl := s:validate(doc('example-1b.xml'), $sch)
return (
  s:is-valid($svrl), $svrl,
  for $m in s:messages($svrl)
  return s:message-level($m) || ' ' || data($m)
)