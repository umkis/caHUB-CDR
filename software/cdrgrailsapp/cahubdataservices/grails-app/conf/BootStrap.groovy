import nci.obbr.cahub.datarecords.*
import nci.obbr.cahub.authservice.*
import nci.obbr.cahub.staticmembers.*
import grails.plugins.springsecurity.*
import nci.obbr.cahub.forms.*
import nci.obbr.cahub.util.*
import nci.obbr.cahub.prc.*
import nci.obbr.cahub.util.appaccess.*
import nci.obbr.cahub.util.querytracker.*
import grails.util.Environment
import grails.converters.JSON
import java.text.SimpleDateFormat

class BootStrap {
    def userService
    def springSecurityService
    //def exceptionHandler

    def init = { servletContext ->
        def currentEnvironment = Environment.current?.toString()

        
        //CDR 5.3 release bootstrap
        new Study(code: "CTC", name: "CTC").save(failOnError: false, flush: true)  
            
        def ctcStudy = Study.findByCode('CTC')
        
        new BSS(code: "BILLI", name: "Billings", study: ctcStudy).save(failOnError: false, flush: true)  
        new BSS(code: "DUKE", name: "Duke", study: ctcStudy).save(failOnError: false, flush: true)  
            
        def sri = BSS.findByCode('SRI')
        sri?.name = 'Scripps Research Institute'
        sri?.code = 'SPRI'
        sri?.save(failOnError: false, flush: true)
        
        new BSS(code: "SPRI", name: "Scripps Research Institute", study: ctcStudy).save(failOnError: false, flush: true)    
        new BSS(code: "SPC", name: "Scripps Clinic", study: ctcStudy).save(failOnError: false, flush: true)              
        
        new Organization(code: "BILLI", name: "Billings", study: ctcStudy).save(failOnError: false, flush: true)  
        new Organization(code: "DUKE", name: "Duke", study: ctcStudy).save(failOnError: false, flush: true)  
        new Organization(code: "SPRI", name: "Scripps Research Institute", study: ctcStudy).save(failOnError: false, flush: true)              
        new Organization(code: "SPC", name: "Scripps Clinic", study: ctcStudy).save(failOnError: false, flush: true) 
        new Organization(code: "CTC", name: "CTC", study: ctcStudy).save(failOnError: false, flush: true) 
 
        //deny list appsettings
        new AppSetting(code: "NIH_USER_DENY_GTEX", name: "Deny NIH user access for GTEX. Enter NIH usernames separated by commas.", value: "see big value", bigValue: "").save(failOnError: false, flush: true)
        new AppSetting(code: "NIH_USER_DENY_BPV", name: "Deny NIH user access for BPV. Enter NIH usernames separated by commas.", value: "see big value", bigValue: "").save(failOnError: false, flush: true)        
        new AppSetting(code: "NIH_USER_DENY_CTC", name: "Deny NIH user access for CTC. Enter NIH usernames separated by commas.", value: "see big value", bigValue: "").save(failOnError: false, flush: true)        
        new AppSetting(code: "APP_RELEASE_MILESTONE_AR", name: "Application release milestone (AR)", value: "see big value", bigValue: "").save(failOnError: false, flush: true)
        
        // Case and specimen DW settings
        new AppSetting(code: "SPECIMEN_DW_ON_OFF", name: "Whether to run the nightly job to rebuild the Specimen DW", value: "On", bigValue: "").save(failOnError: false, flush: true)
        new AppSetting(code: "SPECIMEN_DW_INCLUDE_STATUS", name: "Case data entry status to include in specimen DW", value: "BSSQACOMP,QA,COMP,RELE", bigValue: "").save(failOnError: false, flush: true)
        new AppSetting(code: "SPECIMEN_DW_RUN_STATUS", name: "whether or not the specimen DW quartz job is running", value: "NOTRUNNING", bigValue: "").save(failOnError: false, flush: true)
        
        new ContainerType(code: "ACD", name: "ACD Vacutainer").save(failOnError: false, flush: true)          
        new ContainerType(code: "BUCKET", name: "Bucket").save(failOnError: false, flush: true) 
        new ContainerType(code: "ENVELOPE", name: "Envelope").save(failOnError: false, flush: true) 
        //END CDR 5.3 release bootstrap
        
        
        // Populate bss field for existing Deviation
        Deviation.list().each {
            if (!it.bss && it.caseRecord) {
                it.bss = it.caseRecord?.bss?.parentBss
            }
        }
                
        // new report goals done a little differently
        // new Goal(name: "GTEx Pilot period, Overall enrollment", beginDate: dtFormat("2011-05-01"), endDate: dtFormat("2013-02-28"), study:Study.findByCode("GTEX"), numPeriods: 22, milestone: "GTEx Pilot period", criteria:"Overall enrollment", total: 270).save(failOnError: false, flush: true)
        
        new AppSetting(code: "CDR_AR_BPV_OBBR_IFRAME_HGT", name: "CDR-AR GTEX OBBR iframe height px", value: "476", bigValue: "").save(failOnError: false, flush: true)  
        new AppSetting(code: "CDR_AR_BPV_BSS_IFRAME_HGT", name: "CDR-AR GTEX BSS iframe height px", value: "476", bigValue: "").save(failOnError: false, flush: true)  
        
               
        
        new ActivityType(code: "PROCFEEDAVAI", name:"PF Form available").save(failOnError: false, flush: true)
        
        new AppSetting(code: "PROC_FEEDBACK_AVAILABLE_DISTRO", name:"GTEx procurement feedback availability distribution list", value: "see big value", bigValue:"noreply@cahub.ncifcrf.gov").save(failOnError: false, flush: true)
        new CVocabType(code: "PCT", name: "PCT",description: "Primary Cancer Type").save(failOnError: false, flush: true)
        
        // New Activity Event
        new ActivityType(name:"New BPV ELSI Interview", code:"INTERVIEW").save(failOnError: false, flush: true) 
        new AppSetting(name: "New BPV ELSI Interview distribution list", code: "NEW_INTERVIEW_DISTRO", value:"see big value", bigValue: "noreply@cahub.ncifcrf.gov").save(failOnError: false, flush:true)
    
        new ActivityType(name:"Interview status change", code:"INTERVIEWSTATUS").save(failOnError: false, flush: true) 
        new AppSetting(name: "Interview status change distribution list", code: "INTERVIEW_STATUS_DISTRO", value:"see big value", bigValue: "noreply@cahub.ncifcrf.gov").save(failOnError: false, flush:true)
        
        new AppSetting(code: "PRC_DISCLAIMER", name: "Disclaimer for PRC report", value: "see big value", bigValue: "<b><i>Disclaimer:</i></b>  This report has been generated for research purposes only and is not intended for clinical use.  Specimen processing and interpretation have not been performed in a CLIA-certified laboratory.").save(failOnError: false, flush: true)  
        
        new AppSetting(code: "PF_DISCLAIMER", name: "Disclaimer for Procurement feedback", value: "see big value", bigValue: "<b><i>Disclaimer:</i></b>  This information has been generated for research purposes only and is not intended for clinical use.").save(failOnError: false, flush: true)  
        new AppSetting(code: "APERIO_URL", name: "APERIO_URL", value: "https://microscopy.vai.org/ViewImage.php?ImageId=").save(failOnError: false, flush: true)  
   
        new ShippingEventType(code: "INSPECTION", name:"Inspection").save(failOnError: false, flush: true)
                
        if (ActivityType.findByCode("IMAGEREADY")?.name == "Images ready") {
            ActivityType.findByCode("IMAGEREADY")?.name = "Aperio images ready"
        }
        if (ActivityType.findByCode("BPVCASE")?.name == "BPV case creation") {
            ActivityType.findByCode("BPVCASE")?.name = "BPV case created"
        }
        if (ActivityType.findByCode("PROCFEEDAVAI")?.name == "Procurement feedback available") {
            ActivityType.findByCode("PROCFEEDAVAI")?.name = "PF Form available"
        }
        
        
        new ActivityType(code:"PFFCOMP", name: "PF form complete").save(failOnError: false, flush: true)
           
        
        new ActivityType(code:"PFFFZNCOMP", name: "PF form FZN complete").save(failOnError: false, flush: true)
        
        new ActivityType(code:"PRCFZNCOMP", name: "PRC report FZN complete").save(failOnError: false, flush: true)
        new ActivityType(code:"PROCFEEDFZNAVAI", name: "PF form FZN available").save(failOnError: false, flush: true)
        new ActivityType(code:"SHIPRECPTDISC", name: "Shipment rcvd w/ discrep").save(failOnError: false, flush: true)
        new ActivityType(code:"PROCESSEVT", name: "Processing event").save(failOnError: false, flush: true)
        new ActivityType(code:"SHIPINSP", name: "Shipping Inspection").save(failOnError: false, flush: true)
        
        
        // new AppSetting(name: "GTEx procurement feedback availability NDRI distribution list", code: "PROC_FEEDBACK_AVAILABLE_NDRI_DISTRO", value:"see big value", bigValue: "noreply@cahub.ncifcrf.gov").save(failOnError: false, flush:true)
        // new AppSetting(name: "GTEx procurement feedback availability RPCI distribution list", code: "PROC_FEEDBACK_AVAILABLE_RPCI_DISTRO", value:"see big value", bigValue: "noreply@cahub.ncifcrf.gov").save(failOnError: false, flush:true)
        
        
        //CTC project : added by pmh 10/28/13
        new Protocol(code:"CTCBT24", name:"CTC Sample Bench Time 24",timeInFixative: "CTC Sample Bench Time 24",study:Study.findByCode('CTC'),delayToFixation:"24 hours").save(failOnError: false, flush: true)    
        new Protocol(code:"CTCBT72", name:"CTC Sample Bench Time 72",timeInFixative: "CTC Sample Bench Time 72",study:Study.findByCode('CTC'),delayToFixation:"72 hours").save(failOnError: false, flush: true)
        
        new Fixative(code:"HEPARIN", name:"HEPARIN CTC blood tube type",description: "HEPARIN CTC blood tube type").save(failOnError: false, flush: true)
        new Fixative(code:"STRECK", name:"STRECK").save(failOnError: false, flush: true)
        new Fixative(code:"CELLSEARCH", name:"CELLSEARCH").save(failOnError: false, flush: true)
        new Fixative(code:"OCT", name:"OCT Embedded").save(failOnError: false, flush: true)
        
        new CtcProbe(code:"PanCK", name:"Pan CK",description: "Pan CK").save(failOnError: false, flush: true)
        new CtcProbe(code:"CD45", name:"CD45",description: "CD45").save(failOnError: false, flush: true)
        new CtcProbe(code:"DAPI", name:"DAPI",description: "DAPI").save(failOnError: false, flush: true)
        new CtcProbe(code:"HER2", name:"HER2",description: "HER2").save(failOnError: false, flush: true)
        new CtcProbe(code:"OestrogenReceptor", name:"Oestrogen Receptor",description: "Oestrogen Receptor").save(failOnError: false, flush: true)
        
        new MorphologicalCriteria(code:"NUCLEARSHAPE", name:"Nuclear Shape",description: "NUCLEAR SHAPE").save(failOnError: false, flush: true)
        new MorphologicalCriteria(code:"CELLMORPHOLOGY", name:"Cell Morphology",description: "CELL MORPHOLOGY").save(failOnError: false, flush: true)
        
        new PhlebotomySite(code:"VENIPUCTURE", name:"Venipucture",description: "Venipucture").save(failOnError: false, flush: true)
        //new PhlebotomySite(code:"ARTERIAL", name:"Arterial",description: "Arterial").save(failOnError: false, flush: true)
        new PhlebotomySite(code:"PORT", name:"Port",description: "Port").save(failOnError: false, flush: true)
        new PhlebotomySite(code:"CENTRALLINEPICC", name:"Central Line/PICC",description: "Central Line/PICC").save(failOnError: false, flush: true)

        new AppSetting(code: "PROCESSING_EVENT_DISTRO", name: "Processing event distribution list", value: "see big value", bigValue: "noreply@cahub.ncifcrf.gov").save(failOnError: false, flush: true)
           
        //PMH 11/18/13 new category type for BSS File Uploads
        new CaseAttachmentType(name:'ACCRUAL STATUS',description:'BSS uploads for Accrual Status', code:'ACCRUAL_STATUS').save(failOnError: false, flush:true)
    
        
        new AppSetting(code: "CTC_USER_LIST", name: "CTC user list", value: "see big value", bigValue: "grochk,poschetjf,hestermt").save(failOnError: false, flush: true)
        
                
        //PMH 01/06/14 new category type for BSS File Uploads. this is needed for the brain bank feedback form
        new CaseAttachmentType(name:'BRAIN BANK',description:'Brain bank feedback uploads', code:'BRAINBANK').save(failOnError: false, flush:true)
        
        //PMH 02/21/14 new category type for BPV  file uploads/6 month follow up 
        new CaseAttachmentType(name:'SIX MONTH FOLLOW UP',description:'6 month follow up', code:'6MFUP').save(failOnError: false, flush:true)
     
        //auto generate deviations for past UPMC cases. TAKE OUT AFTER CDR 5.3 release!   
        //commented out after 5.3 build    
        //def upmc = BSS.findByCode('UPMC')
        
        //def upmcCaseList = CaseRecord.findAllByBss(upmc)

        //def deviation
        
        //upmcCaseList.each{
        //   if(!Deviation.findByCaseRecordAndMemoCiNum(it,"Memo-45")){
        //   deviation = new Deviation(caseRecord:it,
        //               description:"CDR 5.3 auto generated deviation for Memo-45 at UPMC. Please refer to Memo-45 for deviation details.",
        //               memoCiNum:"Memo-45",
        //               nonConformance:"No",
        //               planned:"Yes",
        //               type:"Minor").save(flush: true)
        //   }
        // }
       
        new QueryStatus(code: "UNRESOLVED", name:"Unresolved").save(failOnError: false, flush: true)
         
        // for release 5.4 pmh 03/21/14 cdrqa 1079
        new AppSetting(code: "GTEX_DONELIGQ15YES_DISTRO", name: "GTEX_DONELIGQ15YES_DISTRO", value: "see big value", bigValue: "pushpa.hariharan@nih.gov").save(failOnError: false, flush: true)
        new ActivityType(code: "DONORTRANSPLANT", name:"DONOR ORGAN TRANSPLANT").save(failOnError: false, flush: true)
        
        //pmh cdrqa 1104        
        new FormMetadata(timeConstraintLabel:"At least 6 months after Date of surgery",cdrFormName:"PR-0014-F1 BPV 6 Month Follow up Form",name: "PR-0014-F1 BPV 6 Month Follow up Form",paperFormName: "PR-0014-F1 BPV Six Month Follow up Form",code:'6MFUP', study:Study.findByCode('BPV'), timeConstraintVal:0).save(failOnError: false, flush: true)
        
        //pmh cdrqa 1114 Add timeZone defaults for BSS
       
        BSS.list().each {
            if (it.code?.equals('UNM')) {
                it.timeZone = 'MOUNTAIN'
            }
            else if(it.code?.equals('NDRI-LG')){
                 it.timeZone = 'CENTRAL'
            }
            else{
                it.timeZone='EASTERN'
            }
        }
        
         new Module (code: "MODULE3N", name: "Module III").save(failOnError: false, flush: true)
         new Module (code: "MODULE4N", name: "Module IV").save(failOnError: false, flush: true)
         new Protocol(code: "BPV_PROTOCOL_I", name: "Protocol I", delayToFixation: "n/a", study:Study.findByCode("BPV"), timeInFixative: "n/a"  ).save(failOnError: false, flush: true)
         new Protocol(code: "BPV_PROTOCOL_J", name: "Protocol J", delayToFixation: "n/a", study:Study.findByCode("BPV"), timeInFixative: "n/a"  ).save(failOnError: false, flush: true)
         new Protocol(code: "BPV_PROTOCOL_K", name: "Protocol K", delayToFixation: "n/a", study:Study.findByCode("BPV"), timeInFixative: "n/a"  ).save(failOnError: false, flush: true)
         new Protocol(code: "BPV_PROTOCOL_L", name: "Protocol L", delayToFixation: "n/a", study:Study.findByCode("BPV"), timeInFixative: "n/a"  ).save(failOnError: false, flush: true)
         new Protocol(code: "BPV_PROTOCOL_M", name: "Protocol M", delayToFixation: "n/a", study:Study.findByCode("BPV"), timeInFixative: "n/a"  ).save(failOnError: false, flush: true)
         new Protocol(code: "BPV_PROTOCOL_N", name: "Protocol N", delayToFixation: "n/a", study:Study.findByCode("BPV"), timeInFixative: "n/a"  ).save(failOnError: false, flush: true)
         new Protocol(code: "BPV_PROTOCOL_O", name: "Protocol O", delayToFixation: "n/a", study:Study.findByCode("BPV"), timeInFixative: "n/a"  ).save(failOnError: false, flush: true)
         new Protocol(code: "BPV_PROTOCOL_P", name: "Protocol P", delayToFixation: "n/a", study:Study.findByCode("BPV"), timeInFixative: "n/a"  ).save(failOnError: false, flush: true)
         new Protocol(code: "BPV_PROTOCOL_Q", name: "Protocol Q", delayToFixation: "n/a", study:Study.findByCode("BPV"), timeInFixative: "n/a"  ).save(failOnError: false, flush: true)
         new Protocol(code: "BPV_PROTOCOL_R", name: "Protocol R", delayToFixation: "n/a", study:Study.findByCode("BPV"), timeInFixative: "n/a"  ).save(failOnError: false, flush: true)
         new Protocol(code: "BPV_PROTOCOL_S", name: "Protocol S", delayToFixation: "n/a", study:Study.findByCode("BPV"), timeInFixative: "n/a"  ).save(failOnError: false, flush: true)
         new Protocol(code: "BPV_PROTOCOL_T", name: "Protocol T", delayToFixation: "n/a", study:Study.findByCode("BPV"), timeInFixative: "n/a"  ).save(failOnError: false, flush: true)
         
    
    }
    
    def dtFormat(dateString) {
        SimpleDateFormat dFormat = new SimpleDateFormat("yyyy-MM-dd")
        return dFormat.parse(dateString)
    }

    def destroy = {
    }
}
