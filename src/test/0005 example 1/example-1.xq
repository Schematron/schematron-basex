import module namespace schematron = "http://github.com/vincentml/schematron-basex" at '../../main/content/schematron.xqm';

let $sch := schematron:compile(doc('example-1.sch'))
for $file in ('example-1a.xml', 'example-1b.xml')
let $svrl := schematron:validate(doc($file), $sch)
return (
  concat('*** ', $file, ' ***'), 
  if (schematron:is-valid($svrl)) then 'Valid!' else 'Not valid',
  if (schematron:has-messages($svrl)) then 
    for $message in schematron:messages($svrl) 
    return concat(
      schematron:message-level($message)
      , ': ', 
      $message/*:text
      , ' (location: ',
      $message/@location
      , ')'
    )
  else 'No messages were reported'
)