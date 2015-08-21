let $pkg := doc('src/main/expath-pkg.xml')
let $name := concat($pkg/*:package/@abbrev, '-', $pkg/*:package/@version, '.xar')
let $path := 'dist'
let $contents := archive:create-from('src/main')
return (
  file:create-dir($path),
  file:write-binary(concat($path, '/', $name), $contents),
  'Built ' || $name
)
