package nci.obbr.cahub.forms.ctc

import nci.obbr.cahub.CDRBaseClass
import nci.obbr.cahub.datarecords.CaseRecord
import nci.obbr.cahub.datarecords.SpecimenRecord
import nci.obbr.cahub.staticmembers.*

class CtcCrf extends CDRBaseClass{

    CaseRecord caseRecord
    Integer whichVisit
    PhlebotomySite phlebotomySite
    String needleType
    String needleGauge
    String treatmentStatus
    String dateSampleCollectedStr
    Date dateSampleCollected
    String dateSampleShippedStr
    Date dateSampleShipped
    String dateSampleReceivedStr
    Date dateSampleReceived
    String dateSample24hProcessedStr
    Date dateSample24hProcessed
    String dateSample72hProcessedStr
    Date dateSample72hProcessed
    String dateSampleCsProcessedStr
    Date dateSampleCsProcessed
    String dateSampleBestProcessedStr
    Date dateSampleBestProcessed
    boolean started=false
    Date dateSubmitted
    String submittedBy
    String comments
  
    
     static hasMany = [ctcSamples:CtcSample]
    
    static constraints = {
        caseRecord(nullable:false,blank:false)
        phlebotomySite(nullable:true,blank:true)
        needleType(nullable:true,blank:true)
        needleGauge(nullable:true,blank:true)
        treatmentStatus(nullable:true,blank:true)
        dateSampleCollectedStr(nullable:true,blank:true)
        dateSampleCollected(nullable:true,blank:true)
        dateSampleShippedStr(nullable:true,blank:true)
        dateSampleShipped(nullable:true,blank:true)
        dateSampleReceivedStr(nullable:true,blank:true)
        dateSampleReceived(nullable:true,blank:true)
        dateSample24hProcessedStr(nullable:true,blank:true)
        dateSample24hProcessed(nullable:true,blank:true)
        dateSample72hProcessedStr(nullable:true,blank:true)
        dateSample72hProcessed(nullable:true,blank:true)
        dateSampleCsProcessedStr(nullable:true,blank:true)
        dateSampleCsProcessed(nullable:true,blank:true)
        dateSampleBestProcessedStr(nullable:true,blank:true)
        dateSampleBestProcessed(nullable:true,blank:true)
        dateSubmitted(nullable:true,blank:true)
        submittedBy(nullable:true,blank:true)
        comments(nullable:true,blank:true )
    }

     static mapping = {
        table 'ctc_crf'
        id generator:'sequence', params:[sequence:'ctc_crf_pk']
     } 


     
    

    
    
}