(:~ 
 : Schematron module for BaseX
 : 
 : @author Vincent M. Lizzi
 : @see LICENSE (The MIT License)
 : @see http://basex.org/
 : @see http://github.com/Schematron/schematron-basex
 :)

module namespace _ = "http://github.com/Schematron/schematron-basex";

declare namespace sch = "http://purl.oclc.org/dsdl/schematron";
declare namespace svrl = "http://purl.oclc.org/dsdl/svrl";
declare namespace xsl = "http://www.w3.org/1999/XSL/Transform";

declare variable $_:include := "iso-schematron/iso_dsdl_include.xsl";
declare variable $_:expand := "iso-schematron/iso_abstract_expand.xsl";
declare variable $_:compile1 := "iso-schematron/iso_svrl_for_xslt1.xsl";
declare variable $_:compile2 := "iso-schematron/iso_svrl_for_xslt2.xsl";

declare variable $_:error := ('error', 'fatal');
declare variable $_:warn := ('warn', 'warning');
declare variable $_:info := ('info', 'information');

(:~ 
 : Compile a given Schematron file so that it can be used to validate documents. 
 :)
declare function _:compile($schematron) as document-node(element(xsl:stylesheet)) {
  _:compile($schematron, map{} )
};

(:~ 
 : Compile a given Schematron file using given parameters so that it can be used to validate documents. 
 :)
declare function _:compile($schematron, $params) as document-node(element(xsl:stylesheet)) {
  let $p := typeswitch ($params) 
    case xs:string return map{'phase': $params}
    default return $params
  let $step1 := xslt:transform($schematron, file:base-dir() || $_:include, $p)
  let $step2 := xslt:transform($step1, file:base-dir() || $_:expand, $p)
  let $step3 := if (xslt:version() eq "1.0") 
    then xslt:transform($step2, file:base-dir() || $_:compile1, $p) 
    else xslt:transform($step2, file:base-dir() || $_:compile2, $p)
  return $step3
};

(:~ 
 : Validate a given document using a compiled Schematron. Returns SVRL validation result.
 :)
declare function _:validate($document as node(), $compiledSchematron as node()) as document-node(element(svrl:schematron-output))? {
  xslt:transform($document, $compiledSchematron)
};

(:~ 
 : Check whether a SVRL validation result indicates valid in a pass/fail sense.
 :)
declare function _:is-valid($svrl) as xs:boolean {
  boolean($svrl[//svrl:fired-rule]) and
  not(boolean(($svrl/svrl:schematron-output/svrl:failed-assert union $svrl/svrl:schematron-output/svrl:successful-report)[
    not(@role) or @role = $_:error
  ]))
};

(:~ 
 : Check whether a SVRL validation result contains any error, warning, or informational messages.
 :)
declare function _:has-messages($svrl) as xs:boolean {
  boolean(($svrl/svrl:schematron-output/svrl:failed-assert union $svrl/svrl:schematron-output/svrl:successful-report))
};

(:~ 
 : Return messages from a SVRL validation result.
 :)
declare function _:messages($svrl) as item()* {
  ($svrl/svrl:schematron-output/svrl:failed-assert union $svrl/svrl:schematron-output/svrl:successful-report)
};

(:~ 
 : Return severity (error, warn, info) of a message based on the role attribute. 
 : Variations are standardized: 
 :     'error' and 'fatal' return 'error', 
 :     'warn' and 'warning' returns 'warn', 
 :     'info' and 'information' returns 'info'
 : If the role attribute value is unrecognized the value is returned unchanged. 
 :)
declare function _:message-level($message) as xs:string {
  if ($message[not(@role) or @role = $_:error]) then $_:error[1]
  else if ($message[@role = $_:warn]) then $_:warn[1]
  else if ($message[@role = $_:info]) then $_:info[1]
  else data($message/@role)
};


declare function _:message-description($message) as xs:string {
  data($message/svrl:text)
};

declare function _:message-location($message) as xs:string {
  data($message/@location)
};
