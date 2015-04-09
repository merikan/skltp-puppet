package se.callista.skltp;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import riv.itintegration.engagementindex._1.EngagementTransactionType;
import riv.itintegration.engagementindex._1.EngagementType;
import riv.itintegration.engagementindex.update._1.rivtabp21.UpdateResponderInterface;
import riv.itintegration.engagementindex.update._1.rivtabp21.UpdateResponderService;
import riv.itintegration.engagementindex.updateresponder._1.UpdateResponseType;
import riv.itintegration.engagementindex.updateresponder._1.UpdateType;

import javax.xml.ws.soap.SOAPFaultException;
import java.net.MalformedURLException;
import java.net.URL;

/**
 * Created by magnus on 21/11/14.
 */
public class EiUpdateConsumer {

    private static final Logger log = LoggerFactory.getLogger(EiUpdateConsumer.class);

    public static void main(String[] args) throws MalformedURLException {
        String serviceAddress = "http://localhost:8081/skltp-ei/update-service/v1?wsdl";
        String logicalAddress = "ei-hsa-id";
        int txsPerReq = 3;
        int reqs = 1;

        UpdateResponderInterface service =  new UpdateResponderService(new URL(serviceAddress)).getUpdateResponderPort();

        for (int j = 0; j < reqs; j++) {
            UpdateType request = new UpdateType();
            for (int i = 0; i < txsPerReq; i++) {
                request.getEngagementTransaction().add(genEngagementTransaction(genResidentIdentification()));
            }
            try {
                log.info("Call #{}...", j);
                UpdateResponseType response = service.update(logicalAddress, request);
                log.info("Call #{} returned: {}", j, response.getResultCode());
            } catch (SOAPFaultException fse) {
                log.warn("Call #{} failed: {}", j, fse.getMessage());
//                log.warn("Code #{} failed: {}", j, fse.getMessage());
//                fse.getFault().getDetail()
//                fse.getFault().getFaultActor()
//                fse.getFault().getFaultCode()
            }
        }
    }

    private static EngagementTransactionType genEngagementTransaction(long residentIdentification) {
        EngagementTransactionType et = new EngagementTransactionType();
        et.setDeleteFlag(false);
        et.setEngagement(genEngagement(Long.toString(residentIdentification)));

        return et;
    }

    private static EngagementType genEngagement(String residentIdentification) {
        EngagementType e = new EngagementType();

        e.setRegisteredResidentIdentification(residentIdentification);
        e.setServiceDomain("TEST_DOMAIN");
        e.setCategorization("TEST_CATEGORY");
        e.setLogicalAddress("TEST_URL");
        e.setBusinessObjectInstanceIdentifier("NA");
        e.setClinicalProcessInterestId("NA");
        e.setMostRecentContent("20141121121854");
        e.setSourceSystem("TEST_SOURCE_SYSTEM");
        e.setDataController("TEST_DATA_CONTROLLER");

       return e;
    }

    private static long genResidentIdentification() {
        return (long) Math.floor(Math.random() * 9000000000L) + 1000000000L;
    }
}
