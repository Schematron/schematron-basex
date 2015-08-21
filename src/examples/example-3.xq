import module namespace schematron = "http://github.com/vincentml/schematron-basex";

let $sch := schematron:compile(doc('example-1.sch'))
let $svrl := schematron:validate(doc('example-1b.xml'), $sch)
return (
  schematron:is-valid($svrl),
  for $message in schematron:messages($svrl)
  return concat(schematron:message-level($message), ': ', string($message))
)