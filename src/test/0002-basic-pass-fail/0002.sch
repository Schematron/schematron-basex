<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    
    <sch:pattern>
        <sch:rule context="title">
            <sch:assert test="following-sibling::p">
                title should be followed by a p (paragraph) element
            </sch:assert>
        </sch:rule>
        <sch:rule context="p">
            <sch:assert test="boolean(normalize-space())">
                p (paragraph) should not be empty
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
</sch:schema>