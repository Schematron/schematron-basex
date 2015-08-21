<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    
    <sch:pattern>
        <sch:title>title</sch:title>
        <sch:p>paragraph</sch:p>
        <sch:rule context="title">
            <sch:report test="true()" role="info">
                always true
            </sch:report>
            <sch:assert test="false()" role="info">
                always false
            </sch:assert>
            <sch:report test="3 > count(following-sibling::p)" role="warn">
                short section has fewer than 3 paragraphs
            </sch:report>
        </sch:rule>
        <sch:rule context="p">
            <sch:assert test="boolean(normalize-space())" role="error">
                p (paragraph) should not be empty
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
</sch:schema>