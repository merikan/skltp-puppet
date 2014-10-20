package se.callista.skltp;

import org.apache.log4j.*;
import org.slf4j.*;
import se.riv.clinicalprocess.logistics.getcarecontactsrequest.v2.*;
import se.riv.clinicalprocess.logistics.getcarecontactsresponder.v2.*;
import se.riv.clinicalprocess.logistics.v2.*;

/**
 * Groovy implementation of the GetCareContacts responder interface
 *
 * @author Magnus Larsson
 */
public class CareContactsGroovyImpl implements GetCareContactsResponderInterface {

    private static final org.slf4j.Logger logger = LoggerFactory.getLogger("org.soitoolkit.commons.mule.messageLogger");
    // private static final org.slf4j.Logger log = LoggerFactory.getLogger(CareContactsGroovyImpl.class);

    private static final String HSAID_SOURCE_SYSTEM_1 = "HSAID-SOURCE_SYSTEM-1";
    private static final String HSAID_SOURCE_SYSTEM_2 = "HSAID-SOURCE_SYSTEM-2";
    private static final String HSAID_SOURCE_SYSTEM_3 = "HSAID-SOURCE_SYSTEM-3";

    private static final String HSAID_VC_KUSTEN  = "HSAID-VC-KUSTEN";
    private static final String HSAID_VC_MOLNET  = "HSAID-VC-MOLNET";
    private static final String HSAID_VC_STACKEN = "HSAID-VC-STACKEN";

    public static final String PNR_AGDA     = "188803099368"; // Agda Andersson
    public static final String PNR_SVEN     = "194911172296"; // Sven Sturesson
    public static final String PNR_ULLA     = "198611062384"; // Ulla Alm
    public static final String PNR_GUNBRITT = "192011189228"; // Gunbritt Boden
    public static final String PNR_LABAN    = "194804032094"; // Laban Meijer
    public static final String PNR_TOLVAN   = "121212121212"; // Tolvan...

    private static def authMap = [
      "HSAID-VC-KUSTEN":  [ "client", "client-1" ], 
      "HSAID-VC-MOLNET":  [ "client", "client-2" ],
      "HSAID-VC-STACKEN": [ "client", "client-1" , "client-2" ]
    ]

    /**
     * Implementation of GetCareContactsResponderInterface
     *
     * @param logicalAddress
     * @param request
     * @return
     */
    @Override
    public GetCareContactsResponseType getCareContacts(String logicalAddress, GetCareContactsType request) {

        GetCareContactsResponseType response = new GetCareContactsResponseType();

        // CareUnit Kusten and Molnet is handled by Source System 1
        // CareUnit Stacken is handled by Source System 2

        // Agda has one care contact with care unit Kusten
        matchAndAdd(logicalAddress, request, response, PNR_AGDA, HSAID_VC_KUSTEN, HSAID_SOURCE_SYSTEM_1,"DOC-NR 1");

        // Sven has one care contact with care unit Kusten and two with care unit Stacken
        matchAndAdd(logicalAddress, request, response, PNR_SVEN, HSAID_VC_KUSTEN,  HSAID_SOURCE_SYSTEM_1,"DOC-NR 2");
        matchAndAdd(logicalAddress, request, response, PNR_SVEN, HSAID_VC_STACKEN, HSAID_SOURCE_SYSTEM_2,"DOC-NR 3");
        matchAndAdd(logicalAddress, request, response, PNR_SVEN, HSAID_VC_STACKEN, HSAID_SOURCE_SYSTEM_2,"DOC-NR 4");

        // We are done
        return response;
    }

    /**
     * Match the request to the given values and if they match add a corresponding Care Contact element to the response
     *
     * @param logicalAddress
     * @param request
     * @param response
     * @param pnr
     * @param orgUnit
     * @param sourceSystem
     * @param documentId
     */
    private void matchAndAdd(String logicalAddress, GetCareContactsType request, GetCareContactsResponseType response, String pnr, String orgUnit, String sourceSystem, String documentId) {

        String       sourceSystemHSAId = logicalAddress;
        List<String> orgUnitHSAIdList  = request.getCareUnitHSAId();
        String       patientId         = request.getPatientId().getId();
        String       originalSenderId  = (String)request.getAny().get(0);

        // Matching rules:
        // 1. patient id has to match (i.e. mandatory)
        // 2. source system has to match if specified (i.e. optional)
        // 3. care unit has to match if the list of care units contains some elements (i.e. optional)
        // 4. the original sender id must be authorized for the org unit
        if (pnr.equals(patientId)) {
            if (sourceSystemHSAId == null || sourceSystem.equals(sourceSystemHSAId)) {
                if (orgUnitHSAIdList == null || orgUnitHSAIdList.size() == 0 || orgUnitHSAIdList.contains(orgUnit)) {
                    if (isOriginalSenderAuthorized(orgUnit, originalSenderId)) {
                        response.getCareContact().add(createResponseItem(sourceSystem, orgUnit, pnr, documentId));
                    } else {
                        logger.warn("Original sender id $originalSenderId NOT AUTHORIZED for org unit $orgUnit, remove documentId $documentId from resident id $pnr")
                    } 
                }
            }
        }
    }

    /**
     * Checks if a sender id is authorized for a specified org unit
     *
     * @param orgUnit
     * @param originalSenderId
     * @return
     */
    private boolean isOriginalSenderAuthorized(String orgUnit, String originalSenderId) {

        // Orignial sender authorization check:
        // 1. If the org-unit doesn't have any list of allowed sender-id's then allow everyone
        // 2. Otherwise the original-sender-id must exist in the list of approved sender-id's for the orgUnit

        logger.info("Is original sender id $originalSenderId authorized for org unit $orgUnit?")
        logger.info("1. Look for authorized sender-id's for orgUnit: $orgUnit")
        def authSenderIds = authMap[orgUnit]
        logger.info("2. Found $authSenderIds")

        if (authSenderIds == null) {
            logger.info("3. No list of approved sender-id's exists for $orgUnit, $originalSenderId is authorized")
            return true // AUTHORIZED
        }

        logger.info("4. authSenderIds size: " + authSenderIds.size)
        logger.info("5. Check $originalSenderId in $authSenderIds: " + (originalSenderId in authSenderIds))
        if (originalSenderId in authSenderIds) {
            logger.info("6. $originalSenderId found in list, $originalSenderId is authorized for $orgUnit")
            return true // AUTHORIZED
        } else {
            logger.info("7. $originalSenderId not authorized for $orgUnit")
            return false // NOT_AUTHORIZED
        }
    }


    /**
     * Create a Care Contact response element
     *
     * @param sourceSystemHSAId
     * @param orgUnitHSAId
     * @param registeredResidentId
     * @param documentId
     * @return
     */
    private CareContactType createResponseItem(String sourceSystemHSAId, String orgUnitHSAId, String registeredResidentId, String documentId) {

        logger.debug("Created one response item for SourceSystemHSAId {}, orgUnitHSAId {}, registeredResidentId {} and documentId {}", sourceSystemHSAId, orgUnitHSAId, registeredResidentId, documentId);
//                new String[] {sourceSystemHSAId, orgUnitHSAId, registeredResidentId, documentId});

        CareContactType response = new CareContactType();

        PatientSummaryHeaderType header = new PatientSummaryHeaderType();

        PersonIdType patientId = new PersonIdType();
        patientId.setId(registeredResidentId);
        patientId.setType("1.2.752.129.2.1.3.1");
        header.setPatientId(patientId);

        header.setApprovedForPatient(true);
        header.setSourceSystemHSAId(sourceSystemHSAId);
        header.setDocumentId(documentId);

        HealthcareProfessionalType author = new HealthcareProfessionalType();
        author.setHealthcareProfessionalCareGiverHSAId(orgUnitHSAId);
        author.setAuthorTime("20141111100000");

        OrgUnitType orgUnit = new OrgUnitType();
        orgUnit.setOrgUnitHSAId(orgUnitHSAId);
        orgUnit.setOrgUnitName(getOrgUnitName(orgUnitHSAId));

        author.setHealthcareProfessionalOrgUnit(orgUnit);
        header.setAccountableHealthcareProfessional(author);

        response.setCareContactHeader(header);

        CareContactBodyType body = new CareContactBodyType();
        body.setCareContactCode(0);
        body.setCareContactReason("reason");
        body.setCareContactStatus(0);

        body.setCareContactOrgUnit(orgUnit);
        response.setCareContactBody(body);
        return response;
    }

    /**
     * Return readable names of known care units
     *
     * @param orgUnitHSAId
     * @return
     */
    private String getOrgUnitName(String orgUnitHSAId) {
        String name = "";
        if(HSAID_VC_KUSTEN.equals(orgUnitHSAId)){
            name = "Vårdcentralen Kusten";

        } else if(HSAID_VC_MOLNET.equals(orgUnitHSAId)){
            name = "Vårdcentralen Molnet";

        } else if(HSAID_VC_STACKEN.equals(orgUnitHSAId)){
            name = "Vårdcentralen Stacken";
        }
        return name;
    }

    /**
     * Main method can be used to test that the getCareContacts method seems to work.
     *
     * @param args
     */
    public static void main(String[] args) {

        configureLog4J();

        // Create a request
        GetCareContactsType request = new GetCareContactsType();
        PersonIdType patientId = new PersonIdType();
        patientId.setId(PNR_SVEN);
        patientId.setType("1.2.752.129.2.1.3.1");
        request.setPatientId(patientId);
        request.setSourceSystemHSAId(HSAID_SOURCE_SYSTEM_2);

        // Test the method getCareContacts()
        GetCareContactsResponseType response = new JavaTestGroovyImpl().getCareContacts(HSAID_SOURCE_SYSTEM_2, request);

        // Print out the result
        System.out.println("Found " + response.getCareContact().size() + " care contacts");
        for(CareContactType cc: response.getCareContact() ) {
            System.out.println(
                    "PatientId: " + cc.getCareContactHeader().getPatientId().getId() +
                            ", CareUnit: " + cc.getCareContactBody().getCareContactOrgUnit().getOrgUnitHSAId() +
                            " - " + cc.getCareContactBody().getCareContactOrgUnit().getOrgUnitName() +
                            ", Source system: " + cc.getCareContactHeader().getSourceSystemHSAId() +
                            ", DocumentId: " + cc.getCareContactHeader().getDocumentId()
            );
        }
    }

    /**
     * Configure Log4J programmatic instead of a separate log4j - config file
     */
    private static void configureLog4J() {
        org.apache.log4j.Logger rootLogger = org.apache.log4j.Logger.getRootLogger();
        rootLogger.setLevel(Level.INFO); // Change to DEBUG to see some output
        rootLogger.addAppender(new ConsoleAppender(new PatternLayout("%d{ISO8601} [%t] %-5p %c %x - %m%n")));
    }
}
