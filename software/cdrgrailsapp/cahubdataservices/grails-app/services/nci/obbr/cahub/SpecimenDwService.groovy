package nci.obbr.cahub


import nci.obbr.cahub.datarecords.CaseRecord
import nci.obbr.cahub.staticmembers.Study
import nci.obbr.cahub.staticmembers.StudyPhase
import nci.obbr.cahub.util.AppSetting
import nci.obbr.cahub.datawarehouse.SpecimenDw

class SpecimenDwService {
    
    static transactional = true
    
    def gtexDonorVarsExportService
    def ldaccService
    
    def deleteSpecimenDw(){
        def specimenDwInstance
        def counter = 0
        def specimenDwCollection = SpecimenDw.findAll()
        specimenDwCollection.each() {
            specimenDwInstance = it
            if (specimenDwInstance) {
//                log.info ("Deleting " + specimenDwInstance)
                try {
                    specimenDwInstance.delete(flush: true)
                    counter ++
//                    flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'specimenDw.label', default: 'SpecimenDw'), params.id])}"
//                    redirect(action: "list")
                }
                catch (org.springframework.dao.DataIntegrityViolationException e) {
//                    flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'specimenDw.label', default: 'SpecimenDw'), params.id])}"
//                    redirect(action: "show", id: params.id)
                }
            }
            else {
//                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'specimenDw.label', default: 'SpecimenDw'), params.id])}"
//                redirect(action: "list")
            }
        }
        return counter
    }

/* RINfilter, dateFilterX, surgicalFilterX, casesMatchingDateFilter, casesWithRinData */
    def populateSpecimenDw(caseRecord, specimenDwInstance) {

        
        
        
        
//        def caseRecord = new CaseRecord()
        def gtexCases 
        def gtexCasesDev = []
        
        
        def specCollection = []
        
        
        
        def specimenDwIncludeStatus = AppSetting.findByCode('SPECIMEN_DW_INCLUDE_STATUS')?.value
        
        
        if (developmentFlag) {
            gtexCases = CaseRecord.executeQuery("select c from CaseRecord c where c.study.code='GTEX' and (c.phase.code='BP' or c.phase.code='IP' or c.phase.code='PP')")
            while (i <= 10 ) {
                if (specimenDwIncludeStatus.contains(gtexCases[j].caseStatus?.code)) {
                    gtexCasesDev.add(gtexCases[j])
                    i++
                }
                j++
            }
        } else {
            gtexCases = CaseRecord.findAllByStudy(Study.findByCode("GTEX"))
            gtexCases.each(){
                if (specimenDwIncludeStatus.contains(it.caseStatus?.code)){
                    gtexCasesDev.add(it)
                }
            }
        }
        gtexCasesDev.each() {
            log.debug ("Beginning Case: " + it)
            specCollection = []
            minFixTime = (24 * 60 * 60 * 1000)
//            println "(24 * 60 * 60 * 1000) = " + minFixTime
            maxFixTime = 0
            caseRec = it // for preservation inside the specimen loop
            saveBrainValues = [localIntHeadPutOnIce:0, localIntBrainRemovalStart: 0, localIntBrainEndAliquot: 0]
            localCaseMap = [caseId:"", presumedFlag:"Actual", localBss:"", localPhase:"", localMannerOfDeath:"", localOpoType:"", localCauseOfDeath: "", localVentTime:0, localDateCreated:"1900-JAN-01", localDateCollected:"", localIntDeathToClampTime:0, localIntDeathToProcStart:0, localIntDeathToChestIncision:0, localGender:"", localAge:0, localBMI:0, localRace:"", localEthnicity:"", localHardy:"", localMinTimeToFix:0, localMaxTimeToFix:0, localProcedureDuration:0 ]
            
            deathType = caseRec.caseCollectionType
            
            firstTissueRemovedDate = caseRec.tissueRecoveryGtex?.firstTissueRemovedDate
            firstTissueRemovedTime = caseRec.tissueRecoveryGtex?.firstTissueRemovedTime
            firstTissueRemovedDateTime = ldaccService.calculateDateWithTime(firstTissueRemovedDate,firstTissueRemovedTime)
            it.specimens.each() {
//                println "it.fixative?.code:  " + it.fixative?.code
//                println "it.tissueType.code: " + it.tissueType.code
                if (!it.fixative){
                    log.error("Error!  Missing fixative for GTEx Specimen: " + it.specimenId + " tissueType: " + it.tissueType)
                }
                if (it.fixative?.code.equals("XG") && it.tissueType.code != "BLOODW") {
//                    log.info( "Beginning Specimen: " + it.specimenId +" "+ it.tissueType )
                    specimenDwInstance.specimenRecord = it
                    specimenDwInstance.procedureType = deathType
                    specimenDwInstance.specimenId = it.specimenId
                    specimenDwInstance.tissueType = it.tissueType
                    specimenDwInstance.tissueLocation = it.tissueLocation
//                    log.info("it.specimenId: " + it.specimenId + " deathDate: " + deathDate + " firstTissueRemovedDateTime: " + firstTissueRemovedDateTime + " it.aliquotTimeFixed: " + it.aliquotTimeFixed)
                    aliquotTimeFixedInterval = ldaccService.calculateInterval(deathDate, firstTissueRemovedDateTime,it.aliquotTimeFixed)[1]
                    if (aliquotTimeFixedInterval) {
                        if (aliquotTimeFixedInterval > 0) { // exclude cases with negative ischemic times as likely dirty data
                            specimenDwInstance.ischemicTime = aliquotTimeFixedInterval
                        } else {
                            skipCase = true
                        }
                    }
                    if (!skipCase){
                        sql.eachRow("select latestRin('"+it.specimenId+"') as latest_rin from dual", { row ->
        //                            println "row: " + row
        //                            println "row.datatype: " + row.getProperties()
                            specimenDwInstance.latestRin = row.latest_rin?.toDouble()
                        })
                        if ((specimenDwInstance.ischemicTime) && specimenDwInstance.ischemicTime < minFixTime ) minFixTime = specimenDwInstance.ischemicTime
    //                    println "minFixTime:                      " + minFixTime
    //                    println "specimenDwInstance.ischemicTime: " + specimenDwInstance.ischemicTime
                        if (specimenDwInstance.ischemicTime > maxFixTime ) maxFixTime = specimenDwInstance.ischemicTime
                        if (aliquotTimeFixedInterval) {
                            
                            
                        }
                        if (it.tissueType.code.equals("BRAICE") || it.tissueType.code.equals("BRAICO")){
                            hasBrain = "Yes"
                        }
                        specimenDwInstance.dateCreated = new Date()
                        specCollection.add(specimenDwInstance)
//                        log.info( "Ending Specimen: " + specimenDwInstance )
                        specimenDwInstance.save(flush: true, failOnError: true)
                        specimenDwInstance = new SpecimenDw()
                    } else {
                        log.error("Skipping case: " + caseRec + " for negative ischemic time!")
                    }
                }
            }
            log.debug ("Finished all specimens for case: " + caseRec)
//            specimenDwInstance.save(flush: true, failOnError: true)
            if (numSpec > 0) {
                avgFixTime = sumFixTime.divide(numSpec, 10, BigDecimal.ROUND_HALF_UP)
            }

            
            
            if (!skipCase){
                specCollection.each() {
                    specimenDwInstance = SpecimenDw.findBySpecimenId(it.specimenId)
                    if (specimenDwInstance) {
                        it.minFixTime = minFixTime
                        it.avgFixTime = avgFixTime
                        it.maxFixTime = maxFixTime
                        it.procedureDuration = procDuration
                        it.brain = hasBrain
    //                    log.info("specimenDwInstance: " + it)
                        it.save(flush: true, failOnError: true)
                    }
                }
            }
            log.debug ("Finished Case: " + it)
            skipCase = false // reset this flag
        }
        return specimenDwInstance
    }
}
