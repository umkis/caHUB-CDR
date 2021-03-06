package nci.obbr.cahub

import nci.obbr.cahub.util.BpvCaseStatus
import nci.obbr.cahub.datarecords.CaseRecord
import nci.obbr.cahub.datarecords.SpecimenRecord
import nci.obbr.cahub.staticmembers.Protocol
import nci.obbr.cahub.util.ComputeMethods

class BpvCaseStatusService {

    static transactional = true

    /* 1: Form not started
     * 2: Form in progress
     * 3: Form submitted
     */
    def getStatus(caseRecordInstance) {
        def bpvCaseStatus = new BpvCaseStatus()
        
        if (!caseRecordInstance.bpvBloodForm) {
            bpvCaseStatus.blood = 1
        } else if (!caseRecordInstance.bpvBloodForm.dateSubmitted) {
            bpvCaseStatus.blood = 2
        } else {
            bpvCaseStatus.blood = 3
        }
        
        if (!caseRecordInstance.bpvSurgeryAnesthesiaForm) {
            bpvCaseStatus.surgeryAnesthesia = 1
        } else if (!caseRecordInstance.bpvSurgeryAnesthesiaForm.dateSubmitted) {
            bpvCaseStatus.surgeryAnesthesia = 2
        } else {
            bpvCaseStatus.surgeryAnesthesia = 3
        }
        
        if (!caseRecordInstance.bpvTissueGrossEvaluation) {
            bpvCaseStatus.tissueGrossEvaluation = 1
        } else if (!caseRecordInstance.bpvTissueGrossEvaluation.dateSubmitted) {
            bpvCaseStatus.tissueGrossEvaluation = 2
        } else {
            bpvCaseStatus.tissueGrossEvaluation = 3
        }
        
        if (!caseRecordInstance.bpvTissueReceiptDissection) {
            bpvCaseStatus.tissueReceiptDissection = 1
        } else if (!caseRecordInstance.bpvTissueReceiptDissection.dateSubmitted) {
            bpvCaseStatus.tissueReceiptDissection = 2
        } else {
            bpvCaseStatus.tissueReceiptDissection = 3
        }
        
        if (!caseRecordInstance.bpvWorkSheet) {
            bpvCaseStatus.workSheet = 1
        } else if (!caseRecordInstance.bpvWorkSheet.dateSubmitted) {
            bpvCaseStatus.workSheet = 2
        } else {
            bpvCaseStatus.workSheet = 3
        }
        
        if (!caseRecordInstance.bpvTissueProcessEmbed) {
            bpvCaseStatus.tissueProcessEmbed = 1
        } else if (!caseRecordInstance.bpvTissueProcessEmbed.dateSubmitted) {
           
            bpvCaseStatus.tissueProcessEmbed = 2
        } else {
            bpvCaseStatus.tissueProcessEmbed = 3
        }
       
        /* The FFPE section/stain Form is available only when 
        the QC FFPE specimen exists. */
        /**for (SpecimenRecord specimen: caseRecordInstance.specimens) {
        if (specimen.protocol == Protocol.findByCode("BPV_QCFFPE")) {
        if (!specimen.bpvSlidePrep) {
        bpvCaseStatus.slidePrep = 1
        } else if (!specimen.bpvSlidePrep.dateSubmitted) {
        bpvCaseStatus.slidePrep = 2
        } else {
        bpvCaseStatus.slidePrep = 3
        } 
        bpvCaseStatus.qcSpecimenId = specimen.id
        }
        }**/
        
        
        if (!caseRecordInstance.bpvSlidePrep) {
            bpvCaseStatus.slidePrep = 1
        } else if (!caseRecordInstance.bpvSlidePrep.dateSubmitted) {
            bpvCaseStatus.slidePrep = 2
        } else {
            bpvCaseStatus.slidePrep = 3
        }
        
        if (!caseRecordInstance.bpvClinicalDataEntry) {
            bpvCaseStatus.clinicalDataEntry = 1
        } else if (!caseRecordInstance.bpvClinicalDataEntry.dateSubmitted) {
            bpvCaseStatus.clinicalDataEntry = 2
        } else {
            bpvCaseStatus.clinicalDataEntry = 3
        }
        
        if (!caseRecordInstance.bpvCaseQualityReview) {
            bpvCaseStatus.caseQualityReview = 1
        } else if (!caseRecordInstance.bpvCaseQualityReview.dateSubmitted) {
            bpvCaseStatus.caseQualityReview = 2
        } else {
            bpvCaseStatus.caseQualityReview = 3
        }
        
        
        //pmh 02/05/2014 cdrqa: 1032
        
        // if (caseRecordInstance?.bpvBloodForm?.bloodMinimum == 'No') {
        //    bpvCaseStatus.stopCondition1 = true
        // }
       
        if (ComputeMethods.compareCDRVersion(caseRecordInstance?.cdrVer, '5.3') < 0) {
            if (caseRecordInstance?.bpvBloodForm?.bloodMinimum == 'No') {          
                bpvCaseStatus.stopCondition1 = true        
            }
            if (caseRecordInstance?.bpvTissueReceiptDissection?.bloodSamplesCollected == 'No') {
                bpvCaseStatus.stopCondition3 = true
            }
        }
        if (ComputeMethods.compareCDRVersion(caseRecordInstance?.cdrVer, '5.3') >= 0) { 
           
            if (caseRecordInstance?.bpvBloodForm?.bloodMinimum == 'No' && !(caseRecordInstance.primaryTissueType.code.equals("LUNG"))) {
                bpvCaseStatus.stopCondition1 = true
            }
            if (caseRecordInstance?.bpvTissueReceiptDissection?.bloodSamplesCollected == 'No' && !(caseRecordInstance.primaryTissueType.code.equals("LUNG")) ) {
                bpvCaseStatus.stopCondition3 = true
            }
        }
        //pmh end 02/05/2014 cdrqa: 1032
          
        if (caseRecordInstance?.bpvTissueGrossEvaluation?.excessReleased == 'No') {
            bpvCaseStatus.stopCondition2 = true
        }
        
        //if (caseRecordInstance?.bpvTissueReceiptDissection?.bloodSamplesCollected == 'No') {
        // bpvCaseStatus.stopCondition3 = true
        // }
        
        if (ComputeMethods.compareCDRVersion(caseRecordInstance?.cdrVer, '5.0') < 0) {
            if (!caseRecordInstance?.bpvBloodForm?.bloodMinimum || bpvCaseStatus.stopCondition1) {
                bpvCaseStatus.hideTissueGrossEvaluation = true
                bpvCaseStatus.hideSurgeryAnesthesia = true
                bpvCaseStatus.hideClinicalDataEntry = true
            }
            if (!caseRecordInstance?.bpvBloodForm?.bloodMinimum || bpvCaseStatus.stopCondition1 || bpvCaseStatus.stopCondition2) {
                bpvCaseStatus.hideTissueReceiptDissection = true
            }
            if (!caseRecordInstance?.bpvBloodForm?.bloodMinimum || bpvCaseStatus.stopCondition1 || bpvCaseStatus.stopCondition2 || bpvCaseStatus.stopCondition3) {
                bpvCaseStatus.hideWorkSheet = true
                bpvCaseStatus.hideTissueProcessEmbed = true
                bpvCaseStatus.hideSlidePrep = true
                bpvCaseStatus.hideFinalSurgicalPath = true
            }
            if (!caseRecordInstance?.bpvBloodForm?.bloodMinimum) {
                bpvCaseStatus.hideCaseQualityReview = true
            }
        } else {
            
            if (!caseRecordInstance?.bpvBloodForm?.bloodMinimum || bpvCaseStatus.stopCondition1) {
                bpvCaseStatus.hideTissueGrossEvaluation = true
            }
            if (!caseRecordInstance?.bpvBloodForm?.bloodMinimum || bpvCaseStatus.stopCondition1 || !caseRecordInstance?.bpvTissueGrossEvaluation?.excessReleased || bpvCaseStatus.stopCondition2) {
                bpvCaseStatus.hideSurgeryAnesthesia = true
                bpvCaseStatus.hideTissueReceiptDissection = true
            }
            if (!caseRecordInstance?.bpvBloodForm?.bloodMinimum || bpvCaseStatus.stopCondition1 || !caseRecordInstance?.bpvTissueGrossEvaluation?.excessReleased || bpvCaseStatus.stopCondition2 || bpvCaseStatus.stopCondition3) {
                bpvCaseStatus.hideWorkSheet = true
                bpvCaseStatus.hideTissueProcessEmbed = true
                bpvCaseStatus.hideSlidePrep = true
                bpvCaseStatus.hideFinalSurgicalPath = true
            }
            if (!caseRecordInstance?.bpvBloodForm?.bloodMinimum || bpvCaseStatus.stopCondition1 || !caseRecordInstance?.bpvTissueGrossEvaluation?.excessReleased) {
                bpvCaseStatus.hideClinicalDataEntry = true
            }
            if (!caseRecordInstance?.bpvBloodForm?.bloodMinimum || (!bpvCaseStatus.stopCondition1 && !caseRecordInstance?.bpvTissueGrossEvaluation?.excessReleased)) {
                bpvCaseStatus.hideCaseQualityReview = true
            }
            
        
                                            
        }
        
        //pmh hub req 862 04/02/14
        //exclude BLOOD ONLY cases
        def isSixMonthFollowUpCase = SpecimenRecord.executeQuery("select s from SpecimenRecord s inner join s.caseRecord c where s.tissueType.code NOT IN('BLOODPLAS', 'BLOODSRM','BLOODDW','BLOODRNA', 'BLOODDNA') and c.id=?", [caseRecordInstance.id])
       
        // show form only after 6 months since surgery date has elapsed
        def surgiDate =caseRecordInstance.bpvSurgeryAnesthesiaForm?.surgeryDate
        def sixMonthPriorToday= ComputeMethods.getSixMonthPrior()
        if(isSixMonthFollowUpCase){
            if (surgiDate && surgiDate.compareTo(sixMonthPriorToday) < 0 ){
                if ( !caseRecordInstance.bpvSixMonthFollowUp) {
                    bpvCaseStatus.sixMonthFollowUp = 1
                } else if (!caseRecordInstance.bpvSixMonthFollowUp?.dateSubmitted) {
                    bpvCaseStatus.sixMonthFollowUp = 2
                } else {
                    bpvCaseStatus.sixMonthFollowUp = 3
                }                            
            }
            bpvCaseStatus.hideFollowUp=false
        }
        else{
            bpvCaseStatus.hideFollowUp=true
        }
            
        
      
        
        return bpvCaseStatus
    }
    
    //pmh 04/03/14 cdrqa:1104 Six month follow up status form display rule
    def getSixMonthFollowUpStatus(caseList){
        def followupStatusMap =[:]
        def isSixMonthFollowUpCase
        def statusStr
        def sixMonthPriorToday= ComputeMethods.getSixMonthPrior()
        //println "six month prior is "+sixMonthPriorToday.toString()
        def surgiDate
        caseList.each{
            statusStr=null
            isSixMonthFollowUpCase = SpecimenRecord.executeQuery("select s from SpecimenRecord s inner join s.caseRecord c where s.tissueType.code NOT IN('BLOODPLAS', 'BLOODSRM','BLOODDW','BLOODRNA', 'BLOODDNA') and c.id=?", [it.id])
            // if(isSixMonthFollowUpCase && it.bpvSurgeryAnesthesiaForm?.surgeryDate?.plus(186)?.before(new Date())){
            if(isSixMonthFollowUpCase){
                surgiDate=it.bpvSurgeryAnesthesiaForm?.surgeryDate
            
                if (surgiDate && surgiDate.compareTo(sixMonthPriorToday) < 0){
                    //println surgiDate.toString()+" is surgiDate"
                    if (!it.bpvSixMonthFollowUp) {
                        statusStr = 'Not Started'
                        //followupStatusMap.put(it, statusStr)
                    } else if (!it.bpvSixMonthFollowUp?.dateSubmitted) {
                        statusStr = 'In Progress'
                    } else {
                        statusStr = 'Completed'
                    }
                }
            }
            followupStatusMap.put(it.id, statusStr)
            
            
        }
              
        return followupStatusMap
        
    }
}
