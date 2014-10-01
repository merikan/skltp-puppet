<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:cda="hl7/infrastructure/cda/CDA.xsd"
                exclude-result-prefixes="xsl cda"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xsi:schemaLocation="http://www.w3.org/2005/xpath-functions ">
    <!-- Start of transformation -->
    <xsl:output method="xml" encoding="UTF-8" indent="yes"/>
    <!-- Mapping for careDocumentationResponse -->
    <xsl:template match="/">
        <careDocumentationResponse
                xmlns="urn:riv:ehr:patientsummary:caredocumentation"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xsi:schemaLocation="urn:riv:ehr:patientsummary:caredocumentation file:/Users/khaleddaham/slask/rivta/ServiceInteractions/riv/ehr/patientsummary/branches/TD_PATIENTSUMMARY_2/schemas/interactions/GetCareDocumentationInteraction/hl7cda/infrastructure/cda/greenCDA.xsd">
            <careDocumentation>
                <careDocumentationHeader>
                    <!-- ClinicalDocument/typeId -->
                    <xsl:for-each select="/*[name()='ClinicalDocument']/*[name()='id']">
                        <careDocumentID root="">
                            <xsl:attribute name="extension">
                                <xsl:value-of select="@extension"/>
                            </xsl:attribute>
                            <xsl:attribute name="root">
                                <xsl:value-of select="@root"/>
                            </xsl:attribute>
                        </careDocumentID>
                    </xsl:for-each>

                    <xsl:if test="/*[name()='ClinicalDocument']/*[name()='title']">
                        <careDocumentTitle>
                            <xsl:value-of
                                    select="/*[name()='ClinicalDocument']/*[name()='title']"/>
                        </careDocumentTitle>
                    </xsl:if>

                    <!-- ClinicalDocument/effectiveTime -->
                    <xsl:for-each select="/*[name()='ClinicalDocument']/*[name()='effectiveTime']">
                        <careDocumentTime>
                            <xsl:attribute name="value">
                                <xsl:value-of select="@value"/>
                            </xsl:attribute>
                        </careDocumentTime>
                    </xsl:for-each>

                    <!-- ClinicalDocument/recordTarget/patientRole -->
                    <xsl:for-each
                            select="/*[name()='ClinicalDocument']/*[name()='recordTarget']/*[name()='patientRole']/*[name()='id']">
                        <patientID>
                            <xsl:attribute name="root">
                                <xsl:value-of select="@root"/>
                            </xsl:attribute>
                            <xsl:attribute name="extension">
                                <xsl:value-of select="@extension"/>
                            </xsl:attribute>
                        </patientID>
                    </xsl:for-each>

                    <!-- ClinicalDocument/assignedAuthor -->
                    <xsl:for-each
                            select="/*[name()='ClinicalDocument']/*[name()='author']">
                        <author>
                            <authorTime>
                                <xsl:attribute name="value">
                                    <xsl:value-of select="*[name()='time']/@value"/>
                                </xsl:attribute>
                            </authorTime>
                            <authorID root="1.2.752.129.2.1.4.1">
                                <xsl:attribute name="extension">
                                    <xsl:value-of select="*[name()='assignedAuthor']/*[name()='id']/@extension"/>
                                </xsl:attribute>
                            </authorID>
                            <authorRoleCode root="1.2.752.129.2.2.1.4">
                                <xsl:attribute name="extension">
                                    <xsl:value-of select="*[name()='assignedAuthor']/*[name()='code']/@code"/>
                                </xsl:attribute>
                            </authorRoleCode>
                            <xsl:if test="*[name()='assignedAuthor']/*[name()='assignedPerson']/*[name()='name']/node()[./self::text()]">
                                <authorName>
                                    <xsl:value-of
                                            select="*[name()='assignedAuthor']/*[name()='assignedPerson']/*[name()='name']/node()[./self::text()]"/>
                                </authorName>
                            </xsl:if>
                            <authorOrganizationID root="1.2.752.129.2.1.4.1">
                                <xsl:attribute name="extension">
                                    <xsl:value-of
                                            select="*[name()='assignedAuthor']/*[name()='representedOrganization']/*[name()='id']/@extension"/>
                                </xsl:attribute>
                            </authorOrganizationID>
                            <xsl:if test="*[name()='assignedAuthor']/*[name()='representedOrganization']/*[name()='name']/node()[./self::text()]">
                                <authorOrganizationName>
                                    <xsl:value-of
                                            select="*[name()='assignedAuthor']/*[name()='representedOrganization']/*[name()='name']/node()[./self::text()]"/>
                                </authorOrganizationName>
                            </xsl:if>
                            <xsl:if test="*[name()='assignedAuthor']/*[name()='representedOrganization']/*[name()='telecom']/@value">
                                <authorOrganizationTelecom>
                                    <xsl:value-of
                                            select="*[name()='assignedAuthor']/*[name()='representedOrganization']/*[name()='telecom']/@value"/>
                                </authorOrganizationTelecom>
                            </xsl:if>
                            <xsl:if test="*[name()='assignedAuthor']/*[name()='representedOrganization']/*[name()='addr']/node()[./self::text()]">
                                <authorOrganizationAddress>
                                    <xsl:value-of
                                            select="*[name()='assignedAuthor']/*[name()='representedOrganization']/*[name()='addr']/node()[./self::text()]"/>
                                </authorOrganizationAddress>
                            </xsl:if>
                            <!-- @TODO -->
                            <xsl:for-each
                                    select="*[name()='assignedAuthor']/*[name()='representedOrganization']/*[name()='asOrganizationPartOf']">
                                <careProviderID root="" extension="">
                                    <xsl:attribute name="root">
                                        <xsl:value-of
                                                select="*[name()='wholeOrganization']/*[name()='id']/@root"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="extension">
                                        <xsl:value-of
                                                select="*[name()='wholeOrganization']/*[name()='id']/@extension"/>
                                    </xsl:attribute>
                                </careProviderID>
                            </xsl:for-each>
                        </author>
                    </xsl:for-each>

                    <!-- ClinicalDocumentation/custodian -->
                    <xsl:for-each
                            select="/*[name()='ClinicalDocument']/*[name()='custodian']/*[name()='assignedCustodian']/*[name()='representedCustodianOrganization']">
                        <custodian>
                            <custodianID root="1.2.752.129.2.1.4.1">
                                <xsl:attribute name="extension">
                                    <xsl:value-of
                                            select="*[name()='id']/@extension"/>
                                </xsl:attribute>
                            </custodianID>
                        </custodian>
                    </xsl:for-each>

                    <!-- ClinicalDocumentation/legalAuthenticator -->
                    <xsl:for-each
                            select="/*[name()='ClinicalDocument']/*[name()='legalAuthenticator']">
                        <legalAuthenticator>
                            <signatureTime>
                                <xsl:attribute name="value">
                                    <xsl:value-of
                                            select="*[name()='time']/@value"/>
                                </xsl:attribute>
                            </signatureTime>
                            <assignedEntity>
                                <assignedEntityID root="" extension="">
                                    <xsl:attribute name="root">
                                        <xsl:value-of
                                                select="*[name()='assignedEntity']/*[name()='id']/@root"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="extension">
                                        <xsl:value-of
                                                select="*[name()='assignedEntity']/*[name()='id']/@extension"/>
                                    </xsl:attribute>
                                </assignedEntityID>
                                <representedOrganizationID root="1.2.752.129.2.1.4.1" extension="">
                                    <xsl:attribute name="extension">
                                        <xsl:value-of
                                                select="*[name()='assignedEntity']/*[name()='representedOrganization']/*[name()='id']/@extension"/>
                                    </xsl:attribute>
                                </representedOrganizationID>
                            </assignedEntity>

                        </legalAuthenticator>
                    </xsl:for-each>

                    <!-- ClinicalDocumentation/authorization -->
                    <xsl:for-each
                            select="/*[name()='ClinicalDocument']/*[name()='authorization']">
                        <authorization>
                            <authorizationCode root="">
                                <xsl:attribute name="root">
                                    <xsl:value-of
                                            select="*[name()='consent']/*[name()='code']/@codeSystem"/>
                                </xsl:attribute>
                                <xsl:attribute name="extension">
                                    <xsl:value-of
                                            select="*[name()='consent']/*[name()='code']/@code"/>
                                </xsl:attribute>
                            </authorizationCode>

                        </authorization>
                    </xsl:for-each>

                    <!-- ClinicalDocumentation/componentOf/encompassingEncounter -->
                    <xsl:for-each
                            select="/*[name()='ClinicalDocument']/*[name()='componentOf']/*[name()='encompassingEncounter']">
                        <encompassingEncounter>
                            <encounterID>

                                <xsl:attribute name="root">
                                    <xsl:value-of
                                            select="*[name()='id']/@root"/>
                                </xsl:attribute>
                                <xsl:attribute name="extension">
                                    <xsl:value-of
                                            select="*[name()='id']/@extension"/>
                                </xsl:attribute>
                            </encounterID>
                            <encounterTime>
                                <xsl:attribute name="value">
                                    <xsl:value-of
                                            select="*[name()='effectiveTime']/@value"/>
                                </xsl:attribute>
                            </encounterTime>
                        </encompassingEncounter>
                    </xsl:for-each>
                </careDocumentationHeader>
                <!-- End of careDocumentationHeader -->

                <!-- -->
                <xsl:for-each
                        select="/*[name()='ClinicalDocument']/*[name()='component']">
                    <careDocumentationBody>
                        <xsl:for-each
                                select="*[name()='structuredBody']/*[name()='component']/*[name()='section']">
                            <clinicalDocumentNote>
                                <careDocumentNoteCode codeSystem="1.2.752.129.2.2.2.11" code="">
                                    <xsl:attribute name="code">
                                        <xsl:value-of
                                                select="*[name()='code']/@code"/>
                                    </xsl:attribute>
                                </careDocumentNoteCode>
                                <xsl:if test="*[name()='title']">

                                    <careDocumentNoteTitle>
                                        <xsl:value-of
                                                select="*[name()='title']"/>
                                    </careDocumentNoteTitle>
                                </xsl:if>
                                <!-- @TODO -->
                                <careDocumentNoteText>
                                    <xsl:value-of select="*[name()='text']"/>
                                    <xsl:for-each select="*[name()='text']/*[name()='renderMultiMedia']">
                                        <renderMultiMedia>
                                            <xsl:value-of select="@referencedObject"/>
                                        </renderMultiMedia>
                                    </xsl:for-each>
                                </careDocumentNoteText>
                            </clinicalDocumentNote>
                        </xsl:for-each>
                        <xsl:for-each
                                select="*[name()='structuredBody']/*[name()='component']/*[name()='section']/*[name()='entry']">
                            <multimediaEntry>
                                <multiMediaID>
                                    <xsl:value-of
                                            select="*[name()='observationMedia']/@ID"/>
                                </multiMediaID>
                                <value>
                                    <xsl:attribute name="mediaType">
                                        <xsl:value-of
                                                select="*[name()='observationMedia']/*[name()='value']/@mediaType"/>
                                    </xsl:attribute>
                                    <xsl:value-of
                                            select="*[name()='observationMedia']/*[name()='value']/node()"/>
                                </value>
                            </multimediaEntry>
                        </xsl:for-each>
                    </careDocumentationBody>
                </xsl:for-each>
            </careDocumentation>
            <result>
                <resultCode>OK</resultCode>
            </result>
        </careDocumentationResponse>
    </xsl:template>
</xsl:stylesheet>
