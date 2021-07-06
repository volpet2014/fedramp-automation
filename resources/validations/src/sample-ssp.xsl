<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    exclude-result-prefixes="xs math uuid expath oscal"
    version="3.0"
    xmlns:expath="http://expath.org/ns/binary"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:oscal="http://csrc.nist.gov/ns/oscal/1.0"
    xmlns:uuid="java.util.UUID"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://csrc.nist.gov/ns/oscal/1.0">
    <!-- 
        This transform will produce a FedRAMP OSCAL SSP.
        Input to the transform is one of the resolved FedRAMP baselines (catalogs), namely
            FedRAMP_rev4_LOW-baseline-resolved-profile_catalog.xml
            FedRAMP_rev4_MODERATE-baseline-resolved-profile_catalog.xml
            FedRAMP_rev4_HIGH-baseline-resolved-profile_catalog.xml
    -->
    <xsl:mode
        on-no-match="fail" />
    <xsl:output
        indent="true"
        method="xml" />
    <xsl:variable
        as="xs:string"
        name="component-uuid"
        select="uuid:randomUUID()" />
    <xsl:variable
        as="xs:string*"
        name="statuses"
        select="
            (
            'implemented',
            'partial',
            'planned',
            'alternative',
            'not-applicable'
            )" />
    <xsl:template
        match="/">
        <xsl:processing-instruction name="xml-model"> href="https://raw.githubusercontent.com/usnistgov/OSCAL/release-1.0/xml/schema/oscal_complete_schema.xsd" schematypens="http://www.w3.org/2001/XMLSchema" title="OSCAL complete schema"</xsl:processing-instruction>
        <xsl:processing-instruction name="xml-model"> href="https://raw.githubusercontent.com/18F/fedramp-automation/master/resources/validations/src/ssp.sch" schematypens="http://purl.oclc.org/dsdl/schematron" title="FedRAMP SSP constraints"</xsl:processing-instruction>
        <system-security-plan
            xmlns="http://csrc.nist.gov/ns/oscal/1.0">
            <xsl:attribute
                name="uuid"
                select="uuid:randomUUID()" />
            <metadata>
                <title>
                    <xsl:text>DRAFT, SAMPLE </xsl:text>
                    <xsl:value-of
                        select="/catalog/metadata/title" />
                </title>
                <last-modified>
                    <xsl:value-of
                        select="current-dateTime()" />
                </last-modified>
                <version>0.1</version>
                <oscal-version>1.0.0</oscal-version>
            </metadata>
            <import-profile
                href="" />
            <system-characteristics>
                <system-id
                    identifier-type="https://fedramp.gov">F00000000</system-id>
                <system-name>Sample SSP</system-name>
                <system-name-short>SSSP</system-name-short>
                <description />
                <prop
                    name="authorization-type"
                    ns="https://fedramp.gov/ns/oscal"
                    value="fedramp-agency" />
                <prop
                    class="security-eauth"
                    name="security-eauth-level"
                    ns="https://fedramp.gov/ns/oscal"
                    value="2" />
                <security-sensitivity-level>
                    <xsl:choose>
                        <xsl:when
                            test="matches(base-uri(), 'LOW')">
                            <xsl:text>low</xsl:text>
                        </xsl:when>
                        <xsl:when
                            test="matches(base-uri(), 'MODERATE')">
                            <xsl:text>moderate</xsl:text>
                        </xsl:when>
                        <xsl:when
                            test="matches(base-uri(), 'HIGH')">
                            <xsl:text>high</xsl:text>
                        </xsl:when>
                    </xsl:choose>
                </security-sensitivity-level>
                <system-information>
                    <xsl:comment> Attachment 4, PTA/PIA Designation </xsl:comment>
                    <prop
                        name="privacy-sensitive"
                        value="yes" />
                    <xsl:comment> Attachment 4, PTA Qualifying Questions </xsl:comment>
                    <!--Does the ISA collect, maintain, or share PII in any identifiable form? -->
                    <prop
                        class="pta"
                        name="pta-1"
                        ns="https://fedramp.gov/ns/oscal"
                        value="yes" />
                    <xsl:comment> Does the ISA collect, maintain, or share PII information from or about the public? </xsl:comment>
                    <prop
                        class="pta"
                        name="pta-2"
                        ns="https://fedramp.gov/ns/oscal"
                        value="yes" />
                    <xsl:comment> Has a Privacy Impact Assessment ever been performed for the ISA? </xsl:comment>
                    <prop
                        class="pta"
                        name="pta-3"
                        ns="https://fedramp.gov/ns/oscal"
                        value="yes" />
                    <xsl:comment> Is there a Privacy Act System of Records Notice (SORN) for this ISA system? (If so, please specify the SORN ID.) </xsl:comment>
                    <prop
                        class="pta"
                        name="pta-4"
                        ns="https://fedramp.gov/ns/oscal"
                        value="no" />
                    <prop
                        class="pta"
                        name="sorn-id"
                        ns="https://fedramp.gov/ns/oscal"
                        value="[No SORN ID]" />
                    <information-type>
                        <xsl:attribute
                            name="uuid"
                            select="uuid:randomUUID()" />
                        <title />
                        <description />
                        <categorization
                            system="https://doi.org/10.6028/NIST.SP.800-60v2r1">
                            <information-type-id>C.2.4.1</information-type-id>
                        </categorization>
                        <confidentiality-impact>
                            <base>fips-199-moderate</base>
                            <selected>fips-199-moderate</selected>
                            <adjustment-justification>
                                <p>Required if the base and selected values do not match.</p>
                            </adjustment-justification>
                        </confidentiality-impact>
                        <integrity-impact>
                            <base>fips-199-moderate</base>
                            <selected>fips-199-moderate</selected>
                            <adjustment-justification>
                                <p>Required if the base and selected values do not match.</p>
                            </adjustment-justification>
                        </integrity-impact>
                        <availability-impact>
                            <base>fips-199-moderate</base>
                            <selected>fips-199-moderate</selected>
                            <adjustment-justification>
                                <p>Required if the base and selected values do not match.</p>
                            </adjustment-justification>
                        </availability-impact>
                    </information-type>
                </system-information>
                <security-impact-level>
                    <security-objective-confidentiality>fips-199-moderate</security-objective-confidentiality>
                    <security-objective-integrity>fips-199-moderate</security-objective-integrity>
                    <security-objective-availability>fips-199-moderate</security-objective-availability>
                </security-impact-level>
                <status
                    state="operational" />
                <authorization-boundary>
                    <description />
                </authorization-boundary>
            </system-characteristics>
            <system-implementation>
                <user
                    uuid="">
                    <xsl:attribute
                        name="uuid"
                        select="uuid:randomUUID()" />
                </user>
                <component
                    type="validation"
                    uuid="772ea84a-0d4e-4225-b82f-66fdc498a934">
                    <title>FIPS 140-2 Validation</title>
                    <description>
                        <p>FIPS 140-2 Validation</p>
                    </description>
                    <prop
                        name="validation-reference"
                        value="3928" />
                    <link
                        href="https://csrc.nist.gov/projects/cryptographic-module-validation-program/certificate/3928"
                        rel="validation-details" />
                    <status
                        state="active" />
                </component>
                <component
                    type="type"
                    uuid="">
                    <xsl:attribute
                        name="uuid"
                        select="$component-uuid" />
                    <title />
                    <description>
                        <p>This component is the answer to almost everything</p>
                    </description>
                    <status
                        state="operational" />
                </component>
            </system-implementation>
            <control-implementation>
                <description />
                <xsl:for-each
                    select="//control">
                    <implemented-requirement>
                        <xsl:attribute
                            name="control-id"
                            select="@id" />
                        <xsl:attribute
                            name="uuid"
                            select="uuid:randomUUID()" />
                        <xsl:comment expand-text="true">{title}</xsl:comment>
                        <xsl:variable
                            as="xs:integer"
                            expand-text="true"
                            name="r">{floor(random-number-generator(generate-id())?number * 100 ) + 1}</xsl:variable>
                        <xsl:variable
                            as="xs:integer"
                            name="w">
                            <xsl:choose>
                                <xsl:when
                                    test="$r gt 5">
                                    <xsl:value-of
                                        select="1" />
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of
                                        select="$r" />
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:variable>
                        <xsl:variable
                            as="xs:string"
                            name="status"
                            select="$statuses[$w]" />
                        <prop
                            name="implementation-status"
                            value="{$status}">
                            <xsl:choose>
                                <xsl:when
                                    test="$status = 'planned'">
                                    <remarks>
                                        <p>A description of the plan to complete implementation.</p>
                                    </remarks>
                                </xsl:when>
                                <xsl:when
                                    test="$status = 'partial'">
                                    <remarks>
                                        <p>A description the portion of the control that is not satisfied.</p>
                                    </remarks>
                                </xsl:when>
                                <xsl:when
                                    test="$status = 'not-applicable'">
                                    <remarks>
                                        <p>An explanation of why the control is not applicable.</p>
                                    </remarks>
                                </xsl:when>
                                <xsl:when
                                    test="$status = 'alternative'">
                                    <remarks>
                                        <p>A description of the alternative control.</p>
                                    </remarks>
                                </xsl:when>
                            </xsl:choose>

                        </prop>
                        <xsl:if
                            test="$status = 'planned'">
                            <prop
                                name="planned-completion-date"
                                ns="https://fedramp.gov/ns/oscal"
                                value="2021-09-22Z" />
                        </xsl:if>
                        <xsl:apply-templates
                            select="part" />
                    </implemented-requirement>
                </xsl:for-each>
            </control-implementation>
            <back-matter>
                <xsl:for-each
                    select="//control[matches(@id, '-1$')]">
                    <xsl:comment expand-text="true">{parent::group/title} Policy and Procedures attachments</xsl:comment>
                    <resource>
                        <xsl:attribute
                            name="uuid"
                            select="uuid:randomUUID()" />
                        <xsl:variable
                            as="xs:string"
                            expand-text="true"
                            name="text">{prop[@name = 'label']/@value} {title} - Policy</xsl:variable>
                        <title>
                            <xsl:value-of
                                select="$text" />
                        </title>
                        <prop
                            name="type"
                            value="policy" />
                        <rlink
                            href="SSSP-A1-ISPP-{@id}-policy.txt" />
                        <base64
                            filename="SSSP-A1-ISPP-{@id}-policy.txt"
                            media-type="text/plain">
                            <xsl:value-of
                                select="expath:encode-string($text)" />
                        </base64>
                    </resource>
                    <resource>
                        <xsl:attribute
                            name="uuid"
                            select="uuid:randomUUID()" />
                        <xsl:variable
                            as="xs:string"
                            expand-text="true"
                            name="text">{prop[@name = 'label']/@value} {title} - Procedures</xsl:variable>
                        <title>
                            <xsl:value-of
                                select="$text" />
                        </title>
                        <prop
                            name="type"
                            value="procedures" />
                        <rlink
                            href="SSSP-A1-ISPP-{@id}-procedures.txt" />
                        <base64
                            filename="SSSP-A1-ISPP-{@id}-procedures.txt"
                            media-type="text/plain">
                            <xsl:value-of
                                select="expath:encode-string($text)" />
                        </base64>
                    </resource>
                </xsl:for-each>
                <resource>
                    <xsl:attribute
                        name="uuid"
                        select="uuid:randomUUID()" />
                    <title>User Guide</title>
                    <rlink
                        href="SSSP-A2-UG" />
                    <base64
                        filename="SSSP-A2-UG.txt"
                        media-type="text/plain" />
                </resource>
                <resource>
                    <xsl:attribute
                        name="uuid"
                        select="uuid:randomUUID()" />
                    <title>Privacy Impact Analysis</title>
                    <rlink
                        href="SSSP-A4-PIA" />
                    <base64
                        filename="SSSP-A4-PIA.txt"
                        media-type="text/plain" />
                </resource>
                <resource>
                    <xsl:attribute
                        name="uuid"
                        select="uuid:randomUUID()" />
                    <title>Rules of Behavior</title>
                    <rlink
                        href="SSSP-A5-ROB" />
                    <base64
                        filename="SSSP-A5-ROB.txt"
                        media-type="text/plain" />
                </resource>
                <resource>
                    <xsl:attribute
                        name="uuid"
                        select="uuid:randomUUID()" />
                    <title>Information System Contingency Plan</title>
                    <rlink
                        href="SSSP-A6-ISCP" />
                    <base64
                        filename="SSSP-A6-ISCP.txt"
                        media-type="text/plain" />
                </resource>
                <resource>
                    <xsl:attribute
                        name="uuid"
                        select="uuid:randomUUID()" />
                    <title>Configuration Management Plan</title>
                    <rlink
                        href="SSSP-A7-CMP" />
                    <base64
                        filename="SSSP-A7-CMP.txt"
                        media-type="text/plain" />
                </resource>
                <resource>
                    <xsl:attribute
                        name="uuid"
                        select="uuid:randomUUID()" />
                    <title>Incident Response Plan</title>
                    <rlink
                        href="SSSP-A8-IRP" />
                    <base64
                        filename="SSSP-A8-IRP.txt"
                        media-type="text/plain" />
                </resource>
                <resource>
                    <xsl:attribute
                        name="uuid"
                        select="uuid:randomUUID()" />
                    <title>CIS Workbook</title>
                    <rlink
                        href="SSSP-A9-CIS-Workbook" />
                    <base64
                        filename="SSSP-A9-CIS-Workbook.txt"
                        media-type="text/plain" />
                </resource>
                <resource>
                    <xsl:attribute
                        name="uuid"
                        select="uuid:randomUUID()" />
                    <title>Inventory</title>
                    <rlink
                        href="SSSP-A13-INV" />
                    <base64
                        filename="SSSP-A13-INV.txt"
                        media-type="text/plain" />
                </resource>
            </back-matter>
        </system-security-plan>
    </xsl:template>
    <xsl:template
        match="part[@name = 'statement']">
        <xsl:apply-templates
            select="part" />
    </xsl:template>
    <xsl:template
        match="part[@name = 'item']">
        <xsl:element
            name="statement"
            namespace="http://csrc.nist.gov/ns/oscal/1.0">
            <xsl:attribute
                name="statement-id"
                select="@id" />
            <xsl:attribute
                name="uuid"
                select="uuid:randomUUID()" />
            <xsl:element
                name="by-component"
                namespace="http://csrc.nist.gov/ns/oscal/1.0">
                <xsl:attribute
                    name="uuid"
                    select="uuid:randomUUID()" />
                <xsl:attribute
                    name="component-uuid"
                    select="$component-uuid" />
                <xsl:element
                    name="description"
                    namespace="http://csrc.nist.gov/ns/oscal/1.0">
                    <xsl:element
                        name="p"
                        namespace="http://csrc.nist.gov/ns/oscal/1.0">This description is more than 20 characters in length</xsl:element>
                </xsl:element>
                <xsl:element
                    name="remarks"
                    namespace="http://csrc.nist.gov/ns/oscal/1.0">
                    <xsl:element
                        name="p"
                        namespace="http://csrc.nist.gov/ns/oscal/1.0">
                        <xsl:value-of
                            select="oscal:p" />
                    </xsl:element>
                </xsl:element>
            </xsl:element>

        </xsl:element>
        <xsl:apply-templates
            select="part" />
    </xsl:template>
    <xsl:template
        match="part"> </xsl:template>
</xsl:stylesheet>
