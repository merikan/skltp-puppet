package se.callista.skltp;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import se.riv.clinicalprocess.logistics.getcarecontactsrequest.v2.GetCareContactsResponderInterface;
import se.riv.clinicalprocess.logistics.getcarecontactsresponder.v2.GetCareContactsResponseType;
import se.riv.clinicalprocess.logistics.getcarecontactsresponder.v2.GetCareContactsType;
import se.skltp.agp.test.producer.TestProducerDb;

import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebResult;
import javax.jws.WebService;

@WebService(serviceName = "GetCareContactsResponderService", portName = "GetCareContactsResponderPort", targetNamespace = "urn:riv:clinicalprocess.logistics.logistics:GetCareContactsResponder:2:rivtabp21", name = "GetCareContactsInteraction")
public class CareContactGroovyWrapperTestProducer implements GetCareContactsResponderInterface {

    private static final Logger log = LoggerFactory.getLogger(CareContactGroovyWrapperTestProducer.class);

    private GetCareContactsResponderInterface groovyImpl;

    public void setGroovyImpl(GetCareContactsResponderInterface groovyImpl) {
        this.groovyImpl = groovyImpl;
    }

    @Override
    @WebResult(name = "GetCareContactsResponse", targetNamespace = "urn:riv:clinicalprocess:logistics:logistics:GetCareContactsResponder:2", partName = "parameters")
    @WebMethod(operationName = "GetCareContacts", action = "urn:riv:ehr:patientsummary:GetCareContactsResponder:2:GetCareContacts")
    public GetCareContactsResponseType getCareContacts(
            @WebParam(partName = "LogicalAddress", name = "LogicalAddress", targetNamespace = "urn:riv:itintegration:registry:1", header = true) String logicalAddress,
            @WebParam(partName = "parameters", name = "GetCareContacts", targetNamespace = "urn:riv:clinicalprocess:logistics:logistics:GetCareContactsResponder:2") GetCareContactsType request) {

        log.info("### Virtual service for GetCareContacts call the source system with logical address: {} and patientId: {}", logicalAddress, request.getPatientId().getId());

        GetCareContactsResponseType response = groovyImpl.getCareContacts(logicalAddress, request);
        if (response == null) {
            // Return an empty response object instead of null if nothing is found
            response = new GetCareContactsResponseType();
        }

        log.info("### Virtual service got {} documents in the reply from the source system with logical address: {} and patientId: {}", new Object[] {response.getCareContact().size(), logicalAddress, request.getPatientId().getId()});

        // We are done
        return response;
    }

}