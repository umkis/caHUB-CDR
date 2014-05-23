package nci.obbr.cahub.forms.ctc

import nci.obbr.cahub.datarecords.ctc.PatientRecord
import nci.obbr.cahub.datarecords.*
import nci.obbr.cahub.util.*
import grails.plugins.springsecurity.Secured

class CtcCrfController {
    def ctcService
    static allowedMethods = [save: "POST", update: "POST", delete: "POST", submit:"POST", resume:"POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 25, 100)
        [ctcCrfInstanceList: CtcCrf.list(params), ctcCrfInstanceTotal: CtcCrf.count()]
    }

    def create = {
         def username= session.SPRING_SECURITY_CONTEXT?.authentication?.principal?.getUsername().toLowerCase() 
        if (!session.authorities.contains('ROLE_NCI-FREDERICK_CAHUB_SUPER') && !session.authorities.contains('ROLE_ADMIN') &&  !AppSetting.findByCode('CTC_USER_LIST').bigValue.split(',').contains(username)) {
                redirect(controller: "login", action: "denied")
                return
         }
        def caseRecord=CaseRecord.findById(params.caseRecord.id)
        def ctcCrfInstance=CtcCrf.findByCaseRecordAndWhichVisit(caseRecord, params.whichVisit)
        if(!ctcCrfInstance){
           ctcCrfInstance = new CtcCrf()
           ctcCrfInstance.properties = params
           ctcService.createCrf(ctcCrfInstance)
        }else{
           // println("found!!!!")
        }
       // return [ctcCrfInstance: ctcCrfInstance]
         redirect(action: "edit", id: ctcCrfInstance.id)
    }

    def save = {
        def ctcCrfInstance = new CtcCrf(params)
        if (ctcCrfInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'ctcCrf.label', default: 'CtcCrf'), ctcCrfInstance.id])}"
            redirect(action: "show", id: ctcCrfInstance.id)
        }
        else {
            render(view: "create", model: [ctcCrfInstance: ctcCrfInstance])
        }
    }

    def show = {
        def ctcCrfInstance = CtcCrf.get(params.id)
        if (!ctcCrfInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'ctcCrf.label', default: 'CtcCrf'), params.id])}"
            redirect(action: "list")
        }
        else {
            [ctcCrfInstance: ctcCrfInstance]
        }
    }

    def edit = {
        def ctcCrfInstance = CtcCrf.get(params.id)
        def username= session.SPRING_SECURITY_CONTEXT?.authentication?.principal?.getUsername().toLowerCase() 
        if ((!session.authorities.contains('ROLE_NCI-FREDERICK_CAHUB_SUPER') && !session.authorities.contains('ROLE_ADMIN') &&  !AppSetting.findByCode('CTC_USER_LIST').bigValue.split(',').contains(username)) ||ctcCrfInstance.dateSubmitted) {
                redirect(controller: "login", action: "denied")
                return
         }
        
        def  errorMap=[:]
        def canSub=false
        
        if (!ctcCrfInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'ctcCrf.label', default: 'CtcCrf'), params.id])}"
            redirect(action: "list")
        }
        else {
          //  println("here???")
            def caseRecord=ctcCrfInstance.caseRecord
          //  println("caseRecord " + caseRecord.caseId)
            def patient = PatientRecord.findByCaseRecord(caseRecord)
           // def patient = caseRecord.patient
            def exp = patient.experiment
          //  println("exp: " + exp)
            def sample_list = CtcSample.findAllByExperimentAndCtcCrf( exp, ctcCrfInstance )
            def benchTime=''
            if(exp=='VC'){
                sample_list.each(){
                    def tubeType= it.tubeType
                    if(tubeType != 'VC'){
                        benchTime=it.benchTime
                    }
                }
            }
            def selected = 0
            if(exp=='BTBT'){
                sample_list.each(){
                    if(it.furtherProcessed == 'Yes')
                    selected = it.id
                }
            }
          //  println("????sample list size: " + sample_list.size())
            if(ctcCrfInstance.started){
             def result= checkError(ctcCrfInstance, exp, sample_list)
                if(result){
                    result.each(){key,value->
                           if(key.startsWith("tubeId_") || key.startsWith("measureTech_") || key.startsWith("probe_") || key.startsWith("criteria_") || key.startsWith("dateSampleStainedStr_") || key.startsWith("dateSampleImagedStr_") || key.startsWith("dateSampleAnalyzedStr_") || key.startsWith("ctcValueStr_") || key.startsWith("dateLoadedDccStr_") || key.startsWith("status_") || key.startsWith("tubeType_") || key.startsWith("benchTime_")){
                              ctcCrfInstance.errors.reject(key, value)
                           }else{
                               ctcCrfInstance.errors.rejectValue(key, value)
                           }
                        
                         errorMap.put(key, "errors")
                    }//each
                }else{
                    canSub=true
                }
            }
            return [ctcCrfInstance: ctcCrfInstance, sample_list:sample_list, benchTime:benchTime,  errorMap:errorMap, selected:selected, canSub:canSub]
        }
    }

    
     def view = {
          
         def username= session.SPRING_SECURITY_CONTEXT?.authentication?.principal?.getUsername().toLowerCase() 
         println("user name: " + username)
        if (!session.authorities.contains('ROLE_NCI-FREDERICK_CAHUB') &&  !session.authorities.contains('ROLE_ADMIN') && !AppSetting.findByCode('CTC_USER_LIST').bigValue.split(',').contains(username)) {
                redirect(controller: "login", action: "denied")
                return
         }
        
      
        
        def  errorMap=[:]
        def canSub=false
        def ctcCrfInstance = CtcCrf.get(params.id)
        if (!ctcCrfInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'ctcCrf.label', default: 'CtcCrf'), params.id])}"
            redirect(action: "list")
        }
        else {
          //  println("here???")
            def caseRecord=ctcCrfInstance.caseRecord
           // println("caseRecord " + caseRecord.caseId)
            def patient = PatientRecord.findByCaseRecord(caseRecord)
           // def patient = caseRecord.patient
            def exp = patient.experiment
           // println("exp: " + exp)
            def sample_list = CtcSample.findAllByExperimentAndCtcCrf( exp, ctcCrfInstance )
            sample_list.each(){
                def probes=''
                def criteria =''
                if(it.tubeType?.code!='CELLSEARCH'){
                    (it.probeSelections).sort{it.id}.each(){it2->
                        if(it2.selected)
                        probes = probes + ", " +it2.ctcProbe.name

                    }
                  if(probes)
                         probes = probes.substring(2)
                }else{
                    probes = it.probes4Cs
                }
                
                
                 if(it.tubeType?.code!='CELLSEARCH'){
                        (it.criteriaSelections).sort{it.id}.each(){it2->
                            if(it2.selected)
                            criteria= criteria + ", " +it2.morphCrireria.name

                        }

              
                 
                if(criteria)
                     criteria = criteria.substring(2)
                 }else{
                     criteria = it.criteria4Cs
                 }
                 
                it.probes=probes
                it.criteria = criteria
                
            }
           
            
            //println("????sample list size: " + sample_list.size())
              //def username= session.SPRING_SECURITY_CONTEXT?.authentication?.principal?.getUsername().toLowerCase() 
            return [ctcCrfInstance: ctcCrfInstance, sample_list:sample_list,   errorMap:errorMap, username:username]
        }
    }

    
    def update = {
        def ctcCrfInstance = CtcCrf.get(params.id)
        if (ctcCrfInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (ctcCrfInstance.version > version) {
                    
                    ctcCrfInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'ctcCrf.label', default: 'CtcCrf')] as Object[], "Another user has updated this CtcCrf while you were editing")
                    render(view: "edit", model: [ctcCrfInstance: ctcCrfInstance])
                    return
                }
            }
            /**ctcCrfInstance.properties = params
            if (!ctcCrfInstance.hasErrors() && ctcCrfInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'ctcCrf.label', default: 'CtcCrf'), ctcCrfInstance.id])}"
                redirect(action: "show", id: ctcCrfInstance.id)
            }
            else {
                render(view: "edit", model: [ctcCrfInstance: ctcCrfInstance])
            }**/
            
             ctcService.saveCrf(params)
             redirect(action: "edit", id: ctcCrfInstance.id)
             
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'ctcCrf.label', default: 'CtcCrf'), params.id])}"
            redirect(action: "list")
        }
    }

    @Secured(['ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_ADMIN']) 
    def delete = {
        def ctcCrfInstance = CtcCrf.get(params.id)
        if (ctcCrfInstance) {
            try {
                ctcCrfInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'ctcCrf.label', default: 'CtcCrf'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'ctcCrf.label', default: 'CtcCrf'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'ctcCrf.label', default: 'CtcCrf'), params.id])}"
            redirect(action: "list")
        }
    }
    
    Map checkError(ctcCrfInstance, exp, sample_list){
        def result =[:]
        def otherList =getSampleListFromOtherVisit(ctcCrfInstance)
        def visit = ctcCrfInstance.whichVisit
        def caseRecord = ctcCrfInstance.caseRecord
        if(!ctcCrfInstance.phlebotomySite){
            result.put('phlebotomySite', 'Phlebotomy site is a required field.')
        }
        
        if(!ctcCrfInstance.needleType){
            result.put('needleType', 'Needle type is a required field.')
        }
       
        if(!ctcCrfInstance.needleGauge){
            result.put('needleGauge', 'Needle gauge is a required field.')
        }
        if(!ctcCrfInstance.needleGauge){
            result.put('needleGauge', 'Needle gauge is a required field.')
        }
        
        if(!ctcCrfInstance.treatmentStatus){
            result.put('treatmentStatus', 'Treatment status is a required field.')
        }
        
        if(!ctcCrfInstance.treatmentStatus){
            result.put('treatmentStatus', 'Treatment status is a required field.')
        }
        
         if(!ctcCrfInstance.dateSampleCollectedStr){
            result.put('dateSampleCollectedStr', 'Date/hour at which patients has had first blood draw is a required field.')
        }
        
         if(ctcCrfInstance.dateSampleCollectedStr && !ctcService.isDateHour(ctcCrfInstance.dateSampleCollectedStr)){
            result.put('dateSampleCollectedStr', 'Wrong date/hour fromat for the field of date/hour at which patients has had first blood draw.')
        }
        
         if(!ctcCrfInstance.dateSampleShippedStr){
            result.put('dateSampleShippedStr', 'Date/hour of shipping sample to Scripps is a required field.')
        }
        
         if(ctcCrfInstance.dateSampleShippedStr && !ctcService.isDateHour(ctcCrfInstance.dateSampleShippedStr)){
            result.put('dateSampleShippedStr', 'Wrong date/hour fromat for the field of date/hour of shipping sample to Scripps')
        }
        
        
          if(!ctcCrfInstance.dateSampleReceivedStr){
            result.put('dateSampleReceivedStr', 'Date/hour at which sample was received at Scripps is a required field.')
        }
        
         if(ctcCrfInstance.dateSampleReceivedStr && !ctcService.isDateHour(ctcCrfInstance.dateSampleReceivedStr)){
            result.put('dateSampleReceivedStr', 'Wrong date/hour fromat for the field of date/hour at which sample was received at Scripps ')
        }
        
        if(exp=='BTBT'){
             if(!ctcCrfInstance.dateSample24hProcessedStr){
                   result.put('dateSample24hProcessedStr', 'Date/hour at which sample for the 24 hour time point was processed on to slides is a required field.')
             }
        
            if(ctcCrfInstance.dateSample24hProcessedStr && !ctcService.isDateHour(ctcCrfInstance.dateSample24hProcessedStr)){
               result.put('dateSample24hProcessedStr', 'Wrong date/hour fromat for the field of date/hour at which sample for the 24 hour time point was processed on to slides')
            }
        }
        
       
         if(exp=='BTBT'){
            if(!ctcCrfInstance.dateSample72hProcessedStr){
                   result.put('dateSample72hProcessedStr', 'Date/hour at which sample for the 72 hour time point was processed on to slides is a required field.')
             }
        
            if(ctcCrfInstance.dateSample72hProcessedStr && !ctcService.isDateHour(ctcCrfInstance.dateSample72hProcessedStr)){
               result.put('dateSample72hProcessedStr', 'Wrong date/hour fromat for the field of date/hour at which sample for the 72 hour time point was processed on to slides')
            }
        
            
        }
        
        
        if(exp=='VC'){
             if(!ctcCrfInstance.dateSampleBestProcessedStr){
                   result.put('dateSampleBestProcessedStr', 'Date/hour at which sample with best tube type was processed on to slides is a required field.')
             }
        
            if(ctcCrfInstance.dateSampleBestProcessedStr && !ctcService.isDateHour(ctcCrfInstance.dateSampleBestProcessedStr)){
               result.put('dateSampleBestProcessedStr', 'Wrong date/hour fromat for the field of date/hour at which sample with best tube type was processed on to slides ')
            }
        
            if(!ctcCrfInstance.dateSampleCsProcessedStr){
                   result.put('dateSampleCsProcessedStr', 'Date/hour at which sample with tube type cellsearch was processed on to slides is a required field.')
             }
        
            if(ctcCrfInstance.dateSampleCsProcessedStr && !ctcService.isDateHour(ctcCrfInstance.dateSampleCsProcessedStr)){
               result.put('dateSampleCsProcessedStr', 'Wrong date/hour fromat for the field of date/hour at which sample with tube type cellsearch was processed on to slides')
            }
        
            
        }
        
        sample_list.each(){
            def id = it.id
            def tube_type = it.tubeType
            if(exp=='BTBT'){
                if(!it.tubeId){
                    result.put("tubeId_"+id, "Tube Id for ${it.tubeType.code}/${it.benchTime} is a required field")
                }
            } 
            
            if(exp=='BTBT' &&  !hasFurtherProcessed(sample_list)){
                result.put("tubeId_", "Please select one 72 hour time proint tube for the further processing")
            }
           
           
                
            if(exp=='VC'){
                if(!it.tubeId){
                    if(tube_type?.code=='CELLSEARCH')
                       result.put("tubeId_"+id, "Tube Id with type CELLSEARCH is a required field")
                     else
                       result.put("tubeId_"+id, "Tube Id for best tube is a required field")
                }
            } 
            
            if(exp=='VC'){
                if(!it.tubeType){
                   result.put("tubeType_"+id, "Tube type for best tube is a required field") 
                }
                
                  if(!it.benchTime){
                      if(tube_type?.code=='CELLSEARCH')
                        result.put("benchTime_"+id, "Bench time for the tube with type CELLSEARCH is a required field")
                      else
                        result.put("benchTime_"+id, "Bench time for the best tube is a required field")
                  }
            }
            
             if(exp=='BTBT'){
                 if(!it.measureTech){
                    result.put("measureTech_"+id, "CTC Measurement Technology for ${it.tubeType.code}/${it.benchTime} is a required field")
                }
              }
              
              if(exp=='VC'){
                      if(!it.measureTech){
                           if(tube_type?.code=='CELLSEARCH')
                              result.put("measureTech_"+id, "CTC Measurement Technology with tube type CELLSEARCH  is a required field")
                            else
                               result.put("measureTech_"+id, "CTC Measurement Technology for best tube is a required field")
                      } 
                     
                 }
                 
              if(exp=='BTBT'){
               if(!selected(it.probeSelections)){
                    result.put("probe_"+id, "Please select at least one probe for ${it.tubeType.code}/${it.benchTime}")
                }
             }
             
             if(exp=='VC'){
                    if(tube_type?.code=='CELLSEARCH'){
                        if(!it.probes4Cs){
                           result.put("probe_"+id, "the probe is a required field for the tube with type CELLSEARCH") 
                        }
                        
                    }else{
                        if(!selected(it.probeSelections)){
                            
                             result.put("probe_"+id, "Please select at least one probe for the best tube")
                        }
                    }
              }  
            
              if(exp=='BTBT'){
                if(!selected(it.criteriaSelections)){
                    result.put("criteria_"+id, "Please select at least one morphological criteria for ${it.tubeType.code}/${it.benchTime}")
                }
               }
               
              if(exp=='VC'){
                  if(tube_type?.code=='CELLSEARCH'){
                      if(!it.criteria4Cs){
                          result.put("criteria_"+id, "The morphological criteria is a required field for the tube with type CELLSEARCH" )
                      }
                  }else{
                   if(!selected(it.criteriaSelections)){
                         result.put("criteria_"+id, "Please select at least one morphological criteria for the best tube" ) 
                   }
                  }
               }
               
              if( exp=='BTBT' && (it.benchTime=='24' || it.furtherProcessed == 'Yes')){
                           if(!it.dateSampleStainedStr){
                               result.put('dateSampleStainedStr_'+id, "Date sample stained for ${it.tubeType.code}/${it.benchTime} is a required field")
                    }
               }
 
             if(exp=='VC'){
                 if(!it.dateSampleStainedStr){
                            if(tube_type?.code=='CELLSEARCH'){
                             //result.put('dateSampleStainedStr_'+id, "Date sample stained for tube with type CELLSEARCH is a required field")
                            }else
                             result.put('dateSampleStainedStr_'+id, "Date sample stained for best is a required field")
                       }

             }
             
            
              if( exp=='BTBT'  && (it.benchTime=='24' || it.furtherProcessed == 'Yes')){
                     if(it.dateSampleStainedStr && !ctcService.isDate(it.dateSampleStainedStr) ){
                        result.put('dateSampleStainedStr_'+id, "Wrong date format of date sample stained for ${it.tubeType.code}/${it.benchTime}")
                    }

              }
              
              if(exp=='VC'){
                   if(it.dateSampleStainedStr && !ctcService.isDate(it.dateSampleStainedStr) ){
                        if(tube_type?.code=='CELLSEARCH'){
                         //result.put('dateSampleStainedStr_'+id, "Wrong date format of date sample stained for the tube with type CELLSEARCH")
                        }else
                         result.put('dateSampleStainedStr_'+id, "Wrong date format of date sample stained for the best tube")
                   }
              }
              
               if( exp=='BTBT' && (it.benchTime=='24' || it.furtherProcessed == 'Yes')){
                   if(!it.dateSampleImagedStr){
                        result.put('dateSampleImagedStr_'+id, "Date sample imaged for ${it.tubeType.code}/${it.benchTime} is a required field")
                    }

              }
              
              if(exp=='VC'){
                   if(!it.dateSampleImagedStr){
                       if(tube_type?.code=='CELLSEARCH'){
                         //result.put('dateSampleImagedStr_'+id, "Date sample imaged for the tube with type CELLSEARCH is a required field")
                   }else
                         result.put('dateSampleImagedStr_'+id, "Date sample imaged for the best tube is a required field")
                   }
              }
              
               if( exp=='BTBT'  && (it.benchTime=='24' || it.furtherProcessed == 'Yes')){
                                          
                     if(it.dateSampleImagedStr && !ctcService.isDate(it.dateSampleImagedStr) ){
                        result.put('dateSampleImagedStr_'+id, "Wrong date format of date sample imaged for ${it.tubeType.code}/${it.benchTime}")
                    }

               }
               
                if(exp=='VC'){
                      if(it.dateSampleImagedStr && !ctcService.isDate(it.dateSampleImagedStr) ){
                            if(tube_type?.code=='CELLSEARCH'){
                                //result.put('dateSampleImagedStr_'+id, "Wrong date format of date sample imaged for the tube with type CELLSEARCH")
                            }else
                                result.put('dateSampleImagedStr_'+id, "Wrong date format of date sample imaged for the best tube")
                      }    
                }
                
                 if( exp=='BTBT'  && (it.benchTime=='24' || it.furtherProcessed == 'Yes')){
                     if(!it.dateSampleAnalyzedStr){
                           result.put('dateSampleAnalyzedStr_'+id, "Date sample analysed for ${it.tubeType.code}/${it.benchTime} is a required field")
                    }

                 }
                 
                  if(exp=='VC'){
                       if(!it.dateSampleAnalyzedStr){
                           if(tube_type?.code=='CELLSEARCH'){
                             // result.put('dateSampleAnalyzedStr_'+id, "Date sample analysed for the tube with type CELLSEARCH")
                           }else
                             result.put('dateSampleAnalyzedStr_'+id, "Date sample analysed for the best tube is a required field")
                       }
                  }
                  
                  if( exp=='BTBT'  && (it.benchTime=='24' || it.furtherProcessed == 'Yes')){
                     if(it.dateSampleAnalyzedStr && !ctcService.isDate(it.dateSampleAnalyzedStr) ){
                        result.put('dateSampleAnalyzedStr_'+id, "Wrong date format of date sample analysed for ${it.tubeType.code}/${it.benchTime}")
                    }

                 }
            
                if(exp=='VC'){
                     if(it.dateSampleAnalyzedStr && !ctcService.isDate(it.dateSampleAnalyzedStr) ){
                         if(tube_type?.code=='CELLSEARCH'){
                           //result.put('dateSampleAnalyzedStr_'+id, "Wrong date format of date sample analysed for the tube with type CELLSEARCH")
                         }else
                            result.put('dateSampleAnalyzedStr_'+id, "Wrong date format of date sample analysed for the best tube")
                     }
                }
                
                    
                if( exp=='BTBT'  && (it.benchTime=='24' || it.furtherProcessed == 'Yes')){             
                    if(!it.ctcValueStr){
                        result.put('ctcValueStr_'+id, "CTC value reported  for ${it.tubeType.code}/${it.benchTime} is a required field")
                    }

               }
                if(exp=='VC'){
                     if(!it.ctcValueStr){
                               result.put('ctcValueStr_'+id, "CTC value reported  for the tube with best tube is a required field")
                     }
                }
                
                if( exp=='BTBT'  && (it.benchTime=='24' || it.furtherProcessed == 'Yes')){
                     if(it.ctcValueStr && !ctcService.isFloat(it.ctcValueStr)){
                        result.put('ctcValueStr_'+id, "CTC value reported  for ${it.tubeType.code}/${it.benchTime} must be a number")
                    }

                }
                
                if(exp=='VC'){
                     if(it.ctcValueStr && !ctcService.isFloat(it.ctcValueStr)){
                         // if(tube_type?.code=='CELLSEARCH'){
                           //result.put('ctcValueStr_'+id, "CTC value reported  for the tube with type CELLSEARCH must be a number")
                         // }else
                           result.put('ctcValueStr_'+id, "CTC value reported  for the best tube must be a number")
                     }
                }
                 
                 if( exp=='BTBT' && (it.benchTime=='24' || it.furtherProcessed == 'Yes')){
                     if(!it.dateLoadedDccStr){
                        result.put('dateLoadedDccStr_'+id, "Date sample uploaded to DCC for ${it.tubeType.code}/${it.benchTime} is a required field")
                    }

                 }
                 
                  if(exp=='VC'){
                       if(!it.dateLoadedDccStr){
                            if(tube_type?.code=='CELLSEARCH')
                               result.put('dateLoadedDccStr_'+id, "Date sample uploaded to DCC for the tube with type CELLSEARCH is a required field")
                            else
                               result.put('dateLoadedDccStr_'+id, "Date sample uploaded to DCC for the best tube with is a required field")
                       }  
                  }
                  
                    if( exp=='BTBT' && (it.benchTime=='24' || it.furtherProcessed == 'Yes')){
                       if(it.dateLoadedDccStr && !ctcService.isDate(it.dateLoadedDccStr) ){
                        result.put('dateLoadedDccStr_'+id, "Wrong date format of date sample uploaded to DCC  for ${it.tubeType.code}/${it.benchTime}")
                    }

                   }
                   
                  if(exp=='VC'){
                       if(it.dateLoadedDccStr && !ctcService.isDate(it.dateLoadedDccStr) ){
                            if(tube_type?.code=='CELLSEARCH')
                               result.put('dateLoadedDccStr_'+id, "Wrong date format of date sample uploaded to DCC for the tube with type CELLSEARCH")
                            else
                              result.put('dateLoadedDccStr_'+id, "Wrong date format of date sample uploaded to DCC for the best tube")
                       }
                  }
                   
                   if(exp=='BTBT'){
                        if(!it.status){
                        result.put('status_'+id, "Sample status for ${it.tubeType.code}/${it.benchTime} is a required field")
                        }

                   } 
                   
                     if(exp=='VC'){
                          if(!it.status){
                               if(tube_type?.code=='CELLSEARCH')
                                  result.put('status_'+id, "Sample status for the tube with type CELLSEARCH is a required field")                        
                               else
                                  result.put('status_'+id, "Sample status for the best tube is a required field") 
                          }
                     }
                     
                if(it.tubeId && nameExistsInCrf(sample_list, it))
                   result.put("tubeId_"+id, "The Tube Id " + it.tubeId + " appears more than once in this CRF.")
                
               if(it.tubeId && nameExistsInOtherCrf(otherList, it))
                   result.put("tubeId_"+id, "The Tube Id " + it.tubeId + " exists in another CRF of this case.")
                   
               if(it.tubeId){
                   def otherCase=nameExistsInOtherCase(caseRecord, it)
                   if(otherCase)
                   result.put("tubeId_"+id, "The Tube Id " + it.tubeId + " exists in case " + otherCase)
               }
                  
        }//end sample_id
        
        
        return result
    }
   
    def submit = {
         def ctcCrfInstance = CtcCrf.get(params.id)
            def caseRecord = ctcCrfInstance.caseRecord
          if(caseRecord.patientRecord.dateSubmitted){
       
         def user =  session.SPRING_SECURITY_CONTEXT?.authentication?.principal?.getUsername()
        ctcService.submitCrf(ctcCrfInstance, user)
        
          
           
        //render(view: "edit", model: [tissueRecoveryBmsInstance: tissueRecoveryBmsInstance])
        redirect(controller:"caseRecord", action: "accessCtc", id:ctcCrfInstance.caseRecord.id)
          }else{
                flash.message="the patient form has not been submitted yet,  can't submit CRF"
             redirect(action: "view", id: ctcCrfInstance.id)
          }
            
      
    }
    
      def resume = {
         def ctcCrfInstance = CtcCrf.get(params.id)
         def caseRecord = ctcCrfInstance.caseRecord
         if(caseRecord.patientRecord.dateSubmitted){
             ctcService.resumeCrf(ctcCrfInstance)
              redirect(action: "edit", id: ctcCrfInstance.id)
         }else{
             flash.message="the patient form has not been submitted yet, the crf can't be edited"
             redirect(action: "view", id: ctcCrfInstance.id)
         }
       
       
            
      
    }
     
    
  def selected(probe_list){
      def result = false
      probe_list.each{
          if(it.selected)
          result = true
      }
      return result
  }
    
  def has24(sample_list){
      def result = false
      sample_list.each(){
           if(it.tubeId && it.benchTime=='24'){
             result = true
             return
           }
      }
      return result
  }  
  
  def has72(sample_list){
      def result = false
      sample_list.each(){
         if(it.tubeId && it.benchTime=='72'){
          result = true
          return
         }
      }
      return result
  }  
  
  def hasOne(sample_list){
       def result = false
      sample_list.each(){
         if(it.tubeId ){
          result = true
          return
         }
      }
      return result
  }
  
    def hasFurtherProcessed(sample_list){
      def result = false
      sample_list.each(){
         if(it.furtherProcessed=='Yes' && it.benchTime=='72'){
          result = true
          return
         }
      }
      return result
  } 
  
  def nameExistsInCrf(sample_list, sample){
      def result=false
      sample_list.each(){
          def tube_id = it.tubeId
          if(tube_id == sample.tubeId && it.id != sample.id){
              result = true
              return
          }
            
      }
      return result
  }
  
  def getSampleListFromOtherVisit(ctcCrfInstance){
         def result=[]
         def caseRecord = ctcCrfInstance.caseRecord
         def patient = PatientRecord.findByCaseRecord(caseRecord)
         def exp = patient.experiment
         def ctcCrfList=caseRecord.ctcCrfs
         if(ctcCrfList.size()==1)
           return result
         ctcCrfList.each(){
             if(it.id != ctcCrfInstance.id){
                 result = CtcSample.findAllByExperimentAndCtcCrf( exp, it )
             }
         }
         return result
    }
    
     def nameExistsInOtherCrf(sample_list, sample){
        // println("other sample list size: " + sample_list.size() )
           def result=false
        sample_list.each(){
          //println("specimen id: " + it.sample?.specimenId + " this ample id: " + sample.tubeId )
          if(it.sample?.specimenId == sample.tubeId ){
              result = true
              return
          }
            
      }
      return result
         
     }
     
    
     def nameExistsInOtherCase(caseRecord, sample){
         def result=''
         def tubeId = sample.tubeId
         def specimen = SpecimenRecord.findBySpecimenId(tubeId)
         if(specimen && specimen.caseRecord.id != caseRecord.id){
             result=specimen.caseRecord.caseId
         }
         return result
     }
}
