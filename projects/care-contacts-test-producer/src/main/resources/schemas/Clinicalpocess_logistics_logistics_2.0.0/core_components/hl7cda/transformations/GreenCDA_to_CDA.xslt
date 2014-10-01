<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                xmlns:ns1="urn:hl7-org:v3" exclude-result-prefixes="xs ns1 fn"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xsi:schemaLocation="urn:riv:ehr:patientsummary:caredocumentation file:/Users/khaleddaham/slask/rivta/ServiceInteractions/riv/ehr/patientsummary/branches/TD_PATIENTSUMMARY_2/schemas/interactions/GetCareDocumentationInteraction/hl7cda/infrastructure/cda/greenCDA.xsd"
                xmlns:gcda="urn:riv:ehr:patientsummary:caredocumentation">

    <!-- Start of transformation -->
    <xsl:output method="xml" encoding="UTF-8" indent="yes"/>
    <xsl:template match="/*[name()='careDocumentationResponse']/*[name()='careDocumentation']">
        <ClinicalDocument xsi:schemaLocation="urn:hl7-org:v3 ../infrastructure/cda/CDA.xsd" xmlns="urn:hl7-org:v3"
                          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
            <typeId root="2.16.840.1.113883.1.3" extension="POCD_HD000040"/>

            <id root="" extension="">
                <xsl:attribute name="extension">
                    <xsl:value-of
                            select="*[name()='careDocumentationHeader']/*[name()='careDocumentID']/@extension"/>
                </xsl:attribute>
                <xsl:attribute name="root">
                    <xsl:value-of
                            select="*[name()='careDocumentationHeader']/*[name()='careDocumentID']/@root"/>
                </xsl:attribute>
            </id>
            <code code="R-42BAC" codeSystem="2.16.840.1.113883.6.96"/>

            <xsl:if test="*[name()='careDocumentationHeader']/*[name()='careDocumentTitle']">
                <title>Namn på dokument</title>
            </xsl:if>

            <effectiveTime value="">
                <xsl:attribute name="value">
                    <xsl:value-of
                            select="*[name()='careDocumentationHeader']/*[name()='careDocumentTime']/@value"/>
                </xsl:attribute>
            </effectiveTime>

            <confidentialityCode code="N" codeSystem="2.16.840.1.113883.5.25"/>

            <recordTarget>
                <patientRole>
                    <!-- Id på patienten. RIV: vård- och omsorgstagare.person-id -->
                    <!-- root sätt till typ av personidentifierare. Bland tillåtna typer finns:
                        personnummer (1.2.752.129.2.1.3.1)
                        nationell reservnummer (1.2.752.129.2.1.3.2)
                        samordningsnummer (1.2.752.129.2.1.3.3)
                        reservnummer SLL (1.2.752.97.3.1.3) -->
                    <id extension="" root="">
                        <xsl:attribute name="root">
                            <xsl:value-of
                                    select="*[name()='careDocumentationHeader']/*[name()='patientID']/@root"/>
                        </xsl:attribute>
                        <xsl:attribute name="extension">
                            <xsl:value-of
                                    select="*[name()='careDocumentationHeader']/*[name()='patientID']/@extension"/>
                        </xsl:attribute>
                    </id>
                </patientRole>
            </recordTarget>

            <xsl:for-each select="*[name()='careDocumentationHeader']/*[name()='author']">
                <!-- Person som skapat vård- och omsorgsdokumentet -->
                <author>

                    <!-- Tidpunkt då dokumentet skapades, format YYYYMMDDHHMMSS -->
                    <time value="">
                        <xsl:attribute name="value">
                            <xsl:value-of select="*[name()='authorTime']/@value"/>
                        </xsl:attribute>
                    </time>

                    <assignedAuthor>
                        <!-- HSA för författare extension = HSA-id för författaren, RIV:vård- och omsorgspersonal.personal-id
root= fast värde, OID för HSA (1.2.752.129.2.1.4.1)  -->
                        <id extension="" root="">
                            <xsl:attribute name="extension">
                                <xsl:value-of select="*[name()='authorID']/@extension"></xsl:value-of>
                            </xsl:attribute>
                            <xsl:attribute name="root">
                                <xsl:value-of select="*[name()='authorID']/@root"></xsl:value-of>
                            </xsl:attribute>
                        </id>

                        <xsl:if test="*[name()='authorRoleCode']">
                            <code code="lämplig_kod" codeSystem="1.2.752.129.2.2.1.4" displayName="Lämplig befattning"/>
                        </xsl:if>

                        <xsl:if test="*[name()='authorName']">
                            <assignedPerson>
                                <name>
                                    <xsl:copy-of select="*[name()='authorName']/node()"/>
                                </name>
                            </assignedPerson>
                        </xsl:if>

                        <representedOrganization>
                            <!--  Id för den enhet där den som är författare är uppdragstagare.
extension = HSA-id för organisation, RIV: enhet.enhets-id
root = fast värde OID för HSA (1.2.752.129.2.1.4.1)-->
                            <id extension="" root="">
                                <xsl:attribute name="extension">
                                    <xsl:value-of
                                            select="*[name()='authorOrganizationID']/@extension"></xsl:value-of>
                                </xsl:attribute>
                                <xsl:attribute name="root">
                                    <xsl:value-of select="*[name()='authorOrganizationID']/@root"></xsl:value-of>
                                </xsl:attribute>
                            </id>

                            <xsl:if test="*[name()='authorOrganizationName']/node()">
                                <name>
                                    <xsl:value-of
                                            select="*[name()='authorOrganizationName']/node()"></xsl:value-of>
                                </name>
                            </xsl:if>

                            <xsl:if test="*[name()='authorOrganizationTelecom']">
                                <telecom value="">
                                    <xsl:attribute name="value">
                                        <xsl:value-of select="*[name()='authorOrganizationTelecom']/node()"/>
                                    </xsl:attribute>
                                        </telecom>
                            </xsl:if>

                            <xsl:if test="*[name()='authorOrganizationAddress']">
                                <addr><xsl:value-of select="*[name()='authorOrganizationAddress']/node()"/> </addr>
                            </xsl:if>

                            <!-- Information om vårdgivare -->
                            <asOrganizationPartOf>
                                <wholeOrganization>
                                    <id extension="" root="">
                                        <xsl:attribute name="extension">
                                            <xsl:value-of
                                                    select="*[name()='careProviderID']/@extension"></xsl:value-of>
                                        </xsl:attribute>
                                        <xsl:attribute name="root">
                                            <xsl:value-of
                                                    select="*[name()='careProviderID']/@root"></xsl:value-of>
                                        </xsl:attribute>
                                    </id>
                                </wholeOrganization>
                            </asOrganizationPartOf>
                        </representedOrganization>
                    </assignedAuthor>
                </author>
            </xsl:for-each>

            <xsl:for-each select="*[name()='careDocumentationHeader']/*[name()='custodian']">
                <!-- Information om PDL-enhet som har ägandeskap över informationen-->
                <custodian>
                    <assignedCustodian>
                        <representedCustodianOrganization>
                            <!-- 	Ägande PDL-enhet.
                            extension = HSA-id för PDL-enhet. RIV: Informationsmängd.ägande vårdenhets-id
                            root = fast värde OID för HSA (1.2.752.129.2.1.4.1) -->
                            <id extension="" root="">
                                <xsl:attribute name="extension">
                                    <xsl:value-of
                                            select="*[name()='custodianID']/@extension"></xsl:value-of>
                                </xsl:attribute>
                                <xsl:attribute name="root">
                                    <xsl:value-of
                                            select="*[name()='custodianID']/@root"></xsl:value-of>
                                </xsl:attribute>
                            </id>
                        </representedCustodianOrganization>
                    </assignedCustodian>
                </custodian>
            </xsl:for-each>

            <!-- Information om signering -->
            <xsl:for-each select="*[name()='careDocumentationHeader']/*[name()='legalAuthenticator']">
                <legalAuthenticator>
                    <!-- Tidpunkt för signering, format YYYYMMDDHHMMSS. RIV: Vård- och omsorgsdokument.signeringstidpunkt-->
                    <time value="">
                        <xsl:attribute name="value">
                            <xsl:value-of select="*[name()='signatureTime']/@value"/>
                        </xsl:attribute>
                    </time>
                    <signatureCode code="S"/>
                    <assignedEntity>
                        <!-- HSA id för signerande person. Motsvarighet i RIV saknas
                        extension = HSA-id för signerande person
                        root = fast värde OID för HSA (1.2.752.129.2.1.4.1)-->
                        <id extension="" root="">
                            <xsl:attribute name="root">
                                <xsl:value-of
                                        select="*[name()='assignedEntity']/*[name()='assignedEntityID']/@root"/>
                            </xsl:attribute>
                            <xsl:attribute name="extension">

                                <xsl:value-of
                                        select="*[name()='assignedEntity']/*[name()='assignedEntityID']/@extension"/>
                            </xsl:attribute>
                        </id>
                        <representedOrganization>
                            <!-- Id för den enhet där den som är signerare är uppdragstagare. Motsvarighet i RIV saknas
                            extension = HSA för organisation
                            root = fast värde OID för HSA (1.2.752.129.2.1.4.1) -->
                            <id extension="" root="">
                                <xsl:attribute name="root">

                                    <xsl:value-of
                                            select="*[name()='assignedEntity']/*[name()='representedOrganizationID']/@root"/>
                                </xsl:attribute>
                                <xsl:attribute name="extension">

                                    <xsl:value-of
                                            select="*[name()='assignedEntity']/*[name()='representedOrganizationID']/@extension"/>
                                </xsl:attribute>
                            </id>

                        </representedOrganization>
                    </assignedEntity>
                </legalAuthenticator>
            </xsl:for-each>

            <xsl:for-each select="*[name()='careDocumentationHeader']/*[name()='authorization']">
                <authorization>
                    <consent>
                        <code code="" codeSystem="">
                            <xsl:attribute name="code">
                                <xsl:value-of
                                        select="*[name()='authorizationCode']/@extension"/>
                            </xsl:attribute>
                            <xsl:attribute name="codeSystem">
                                <xsl:value-of
                                        select="*[name()='authorizationCode']/@root"/>
                            </xsl:attribute>
                        </code>
                        <statusCode code="completed"></statusCode>
                    </consent>
                </authorization>
            </xsl:for-each>

            <xsl:for-each select="*[name()='careDocumentationHeader']/*[name()='encompassingEncounter']">
                <componentOf>
                    <encompassingEncounter>
                        <id root="" extension="">
                            <xsl:attribute name="extension">
                                <xsl:value-of
                                        select="*[name()='encounterID']/@extension"/>
                            </xsl:attribute>
                            <xsl:attribute name="root">
                                <xsl:value-of
                                        select="*[name()='encounterID']/@root"/>
                            </xsl:attribute>
                        </id>
                        <effectiveTime value="">
                            <xsl:attribute name="value">
                                <xsl:value-of
                                        select="*[name()='encounterTime']/@value"/>
                            </xsl:attribute>
                        </effectiveTime>
                    </encompassingEncounter>
                </componentOf>
            </xsl:for-each>


            <xsl:for-each select="*[name()='careDocumentationBody']">
                <!-- CDA Body -->
                <component>
                    <structuredBody>
                        <!-- Sektion för vårddokumentation -->
                        <!-- I varje CDA skickas ett vård- och omsorgsdokument -->
                        <component>
                            <section>
                                <xsl:for-each
                                        select="*[name()='clinicalDocumentNote']/*[name()='careDocumentNoteCode']">
                                    <!-- Typ av vård- och omsorgsdokumentation
                                    code = kod för typ av anteckning. RIV: Vård- och omsorgsdokument.anteckningstyp
                                    CodeSystem = OID för kodverk Anteckningstyp (1.2.752.129.2.2.2.11)

                                    Tillåtna värden från KV Anteckningstyp
                                    utr = Utredning
                                    atb = åtgärd/Behandling
                                    sam = Sammanfattning
                                    sao = Samordning
                                    ins = Inskrivning
                                    slu = Slutanteckning
                                    auf = Anteckning utan fysiskt möte
                                    sva = Slutenvårdsanteckning
                                    bes = Besöksanteckning
                                    -->
                                    <code code="" codeSystem="">
                                        <xsl:attribute name="codeSystem">
                                            <xsl:value-of
                                                    select="./@codeSystem"/>
                                        </xsl:attribute>
                                        <xsl:attribute name="code">
                                            <xsl:value-of
                                                    select="./@code"/>
                                        </xsl:attribute>
                                    </code>
                                </xsl:for-each>

                                <xsl:if test="*[name()='clinicalDocumentNote']/*[name()='careDocumentNoteTitle']">

                                    <xsl:for-each
                                            select="*[name()='clinicalDocumentNote']/*[name()='careDocumentNoteTitle']">
                                        <title>
                                            <xsl:value-of select="."/>
                                        </title>

                                    </xsl:for-each>
                                </xsl:if>

                                <!-- @TODO text block -->
                                <xsl:if test="*[name()='clinicalDocumentNote']/*[name()='careDocumentNoteText']">
                                    <text>

                                        <xsl:copy-of
                                                select="*[name()='clinicalDocumentNote']/*[name()='careDocumentNoteText']/text()"/>
                                        <!-- clinicalDocumentNote/careDocumentNoteText/renderMultiMedia -->
                                        <xsl:for-each
                                                select="*[name()='clinicalDocumentNote']/*[name()='careDocumentNoteText']/*[name()='renderMultiMedia']">
                                            <!-- själva anteckningen, här läggs texten -->
                                            <renderMultiMedia referencedObject="">
                                                <xsl:attribute name="referencedObject">
                                                    <xsl:value-of select="./text()"
                                                            />
                                                </xsl:attribute>
                                            </renderMultiMedia>
                                        </xsl:for-each>

                                    </text>
                                </xsl:if>

                                <xsl:for-each select="*[name()='multimediaEntry']">
                                    <!-- Optional, sektionen <entry> används endast om multimedia skickas med i dokumentet och <renderMultiMedia> ovan är angiven -->
                                    <entry>
                                        <!-- ID sätts till samma ID som angivits i referencedObject i <renderMultimedia> ovan -->
                                        <observationMedia classCode="OBS" moodCode="EVN" ID="">
                                            <xsl:attribute name="ID">
                                                <xsl:value-of
                                                        select="*[name()='multiMediaID']/node()[./self::text()]"/>
                                            </xsl:attribute>

                                            <!-- mediaType anger lämplig mime-typ representation anger kodningstyp-->
                                            <value xsi:type="ED" mediaType="" representation="B64">
                                                <xsl:attribute name="mediaType">
                                                    <xsl:value-of select="*[name()='value']/@mediaType"/>
                                                </xsl:attribute>
                                                <xsl:copy-of
                                                        select="*[name()='value']/node()[./self::text()]"/>
                                            </value>
                                        </observationMedia>
                                    </entry>
                                </xsl:for-each>
                            </section>
                        </component>
                    </structuredBody>
                </component>
            </xsl:for-each>
        </ClinicalDocument>
    </xsl:template>
    <xsl:template match="/*[name()='careDocumentationResponse']/*[name()='result']"/>
</xsl:stylesheet>
