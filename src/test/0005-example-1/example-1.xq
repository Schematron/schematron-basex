import module namespace schematron = "http://github.com/Schematron/schematron-basex" at "../../main/content/schematron.xqm";

let $sch := schematron:compile(doc('example-1.sch'))
for $file in ('example-1a.xml', 'example-1b.xml', 'example-1c.xml')
let $svrl := schematron:validate(doc($file), $sch)
return (
  concat('*** ', $file, ' ***'), 
  if (schematron:is-valid($svrl)) then 'Valid!' else 'Not valid!',
  if (schematron:has-messages($svrl)) then 
    for $message in schematron:messages($svrl) 
    return concat(
      schematron:message-level($message)
      , ': ', 
      schematron:message-description($message)
      , ' (location: ',
      schematron:message-location($message)
      , ')'
    )
  else 'No messages were reported'
)

(: OUTPUT:

*** example-1a.xml ***
Not valid!
info: always true (location: /document/title)
info: always false (location: /document/title)
warn: short section has fewer than 3 paragraphs (location: /document/title)
error: p (paragraph) should not be empty (location: /document/p[2])
*** example-1b.xml ***
Valid!
info: always true (location: /document/title)
info: always false (location: /document/title)
warn: short section has fewer than 3 paragraphs (location: /document/title)
*** example-1c.xml ***
Valid!
No messages were reported

:)