# Schematron for BaseX

XQuery module to use ISO Schematron in [BaseX](http://basex.org/). This module uses the standard Schematron implementation from https://code.google.com/p/schematron/. 

## Usage

Install the module in one of the ways described in the BaseX documentation. Using the GUI, go to the Options menu, Packages, then Install, and select schematron-basex-1.0.xar. Alternatively, use the command `REPO INSTALL schematron-basex-1.0.xar`.

After the module is installed, in your XQuery code declare the module import:

    import module namespace schematron = "http://github.com/vincentml/schematron-basex";

Your Schematron schema file first has to be compiled before it can be used to validate XML. The compiled Schematron can be re-used to validate multiple documents, or possibly stored in a collection for later use.

    let $sch := schematron:compile(doc('rules.sch'))

If your Schematron contains phases you can specify the phase to use by passing its name in a `phase` parameter.

    let $sch := schematron:compile(doc('rules.sch'), map{'phase': 'phase1'}))

Next, validate an XML using the compiled Schematron.

    let $svrl := schematron:validate(doc('document.xml'), $sch)

The validate method returns SVRL XML. This module provides several utility methods for inspecting SVRL.

To simply check whether validation has passed or failed use the is-valid method, which returns a boolean value.

    let $boolean := schematron:is-valid($svrl)

Schematron validation may return warnings or informational messages in addition to error messages. The has-messages method returns a boolean value to indicate if any messages are present.

    let $boolean := schematron:has-messages($svrl)

To get all messages that were generated as a sequence:

    let $messages := schematron:messages($svrl)

The message-level method returns 'error', 'warn' or 'info' (or custom values) based on the `role` attribute on Schematron `<assert>` and `<report>` elements. This method normalizes the role attribute value from the Schematron schema: if the role attribute is absent or contains 'error' or 'fatal' this method returns 'error'; if role contains 'warn' or 'warning' this method returns 'warn'; if role contains 'info' or 'information' this method returns 'info'. Any other value of the role attribute is returned unchanged. 

    let $level := schematron:message-level($message)

To get the human text description from a message:

    let $string := schematron:message-description($message)

To get the XPath location where a message was generated:

    let $string := schematron:message-location($message)

Putting this all together:

```
import module namespace schematron = "http://github.com/vincentml/schematron-basex";

let $sch := schematron:compile(doc('rules.sch'))
let $svrl := schematron:validate(doc('document.xml'), $sch)
return (
  schematron:is-valid($svrl),
  for $message in schematron:messages($svrl)
  return concat(schematron:message-level($message), ': ', schematron:message-description($message))
)
```

More examples are available in the src/examples folder.

## Using XPath 2.0 and above

By default XPath 1.0 is supported. This is based on BaseX's XSLT module which by default uses Java's Xalan. XPath 2.0 can be used if Saxon 9.x is available to BaseX. Place saxon9he.jar, saxon9pe.jar, or saxon9ee.jar in the `lib` folder of BaseX (or add the Saxon jar to the classpath). Then make sure the root element of your Schematron specifies `xslt2` in attribute `queryBinding="xslt2"`.


## Developing

This module was developed using BaseX verion 8.2.3 beta, although it may work with earlier versions of BaseX.

To run the unit tests:

    basex -t src/test

There are two build scripts included to create a xar file. They are identical except that one can be run by BaseX, and one can be run by Gradle. To build the xar using BaseX:

    basex build.xq

To build the xar using Gradle:

    gradle build

