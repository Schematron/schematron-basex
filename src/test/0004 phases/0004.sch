<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    
    <sch:phase id="phase1">
        <sch:active pattern="pattern1"/>
    </sch:phase>
    
    <sch:phase id="phase2">
        <sch:active pattern="pattern2"/>
    </sch:phase>
    
    <sch:pattern id="pattern1">
        <sch:rule context="/">
            <sch:assert test="true()">
                Pass Valid
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="pattern2">
        <sch:rule context="/">
            <sch:assert test="false()">
                Fail Invalid
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    
</sch:schema>