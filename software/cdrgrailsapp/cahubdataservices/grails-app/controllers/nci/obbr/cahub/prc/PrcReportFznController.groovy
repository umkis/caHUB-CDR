package nci.obbr.cahub.prc

import nci.obbr.cahub.datarecords.*
import nci.obbr.cahub.staticmembers.*
import grails.plugins.springsecurity.Secured

class PrcReportFznController {
    
    def prcReportFznService

    static allowedMethods = [ update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 25, 100)
        [prcReportFznInstanceList: PrcReportFzn.list(params), prcReportFznInstanceTotal: PrcReportFzn.count()]
    }

    def create = {
        def prcReportFznInstance = new PrcReportFzn()
        prcReportFznInstance.properties = params
        return [prcReportFznInstance: prcReportFznInstance]
    }

    def save = {
        
          def prcReportFznInstance = new PrcReportFzn(params)
      
        try{
            
             prcReportFznService.createReport(prcReportFznInstance)
             
             flash.message = "${message(code: 'default.created.message', args: [message(code: 'caseReportForm.label', default: 'PRC Report For'), prcReportFznInstance?.caseRecord?.caseId])}"
         
             redirect(action: "edit", id:prcReportFznInstance.id)
        }catch(Exception e){
            flash.message="Failed: " + e.toString()  
        
          redirect(action:"edit", params:[id:prcReportFznInstance.id])
         
          }
        
        
       
    }

    def show = {
        def prcReportFznInstance = PrcReportFzn.get(params.id)
        if (!prcReportFznInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'prcReportFzn.label', default: 'PrcReportFzn'), params.id])}"
            redirect(action: "list")
        }
        else {
            [prcReportFznInstance: prcReportFznInstance]
        }
    }

    def edit = {
        
         def prcReportFznInstance = PrcReportFzn.get(params.id)
        def prcSpecimenList
         def prcSpecimenFrList
        def prcIssueList
        def prcReportSubList
        def specimenList
        def errorMap=[:]
        def canSub=false
        def prcIssueResolutionDisplayList
        
        
         try{
             prcSpecimenList=prcReportFznService.getPrcSpeciemenList4EditFull(prcReportFznInstance)
              prcSpecimenFrList=prcReportFznService.getPrcSpeciemenList4Edit(prcReportFznInstance)
             prcIssueList=prcReportFznService.getPrcIssueList(prcReportFznInstance)
            // println("size: " + prcIssueList.size())
             prcReportSubList = prcReportFznService.getPrcReportSubList(prcReportFznInstance)
             specimenList= prcReportFznService.getSpecimenList(prcReportFznInstance)
            
          
             prcIssueResolutionDisplayList = prcReportFznService.getPrcIssueResolutionDisplayList(prcReportFznInstance)
           
            
            if(isStarted(prcReportFznInstance, prcSpecimenFrList, prcIssueList)){
              //println("after is started ")
                  def result= checkError(prcReportFznInstance, prcSpecimenList, prcIssueList)
                //  println("after check result...")
                  if(result){
                    result.each(){key,value->
                  
                      prcReportFznInstance.errors.reject(value, value)
                      errorMap.put(key, "errors")
                    }//each
                  }else{
                    
                      canSub=true
                  }
              
             }
             return [prcReportFznInstance: prcReportFznInstance, prcSpecimenList:prcSpecimenList, prcSpecimenFrList:prcSpecimenFrList, prcIssueList:prcIssueList, specimenList:specimenList, prcReportSubList:prcReportSubList, specimenList:specimenList, errorMap:errorMap, canSub:canSub, prcIssueResolutionDisplayList:prcIssueResolutionDisplayList ]
        }catch(Exception e){
            flash.message="Failed: " + e.toString()  
         
        
            return [prcReportFznInstance: prcReportFznInstance, prcSpecimenList:prcSpecimenList, prcSpecimenFrList:prcSpecimenFrList, prcIssueList:prcIssueList, specimenList:specimenList, prcReportSubList:prcReportSubList, specimenList:specimenList, errorMap:errorMap, canSub:canSub,  prcIssueResolutionDisplayList:prcIssueResolutionDisplayList ]
          }
        
        
        
        
       
    }

    
    
      def view = {
        
         def prcReportFznInstance = PrcReportFzn.get(params.id)
        def prcSpecimenList
         //def prcSpecimenFrList
        def prcIssueList
        def prcReportSubList
        def specimenList
        def errorMap=[:]
        def canSub=false
        def prcIssueResolutionDisplayList
        
        
         try{
             prcSpecimenList=prcReportFznService.getPrcSpeciemenList4EditFull(prcReportFznInstance)
             // prcSpecimenFrList=prcReportFznService.getPrcSpeciemenList4Edit(prcReportFznInstance)
             prcIssueList=prcReportFznService.getPrcIssueList(prcReportFznInstance)
            // println("size: " + prcIssueList.size())
             prcReportSubList = prcReportFznService.getPrcReportSubList(prcReportFznInstance)
             specimenList= prcReportFznService.getSpecimenList(prcReportFznInstance)
            
          
             prcIssueResolutionDisplayList = prcReportFznService.getPrcIssueResolutionDisplayList(prcReportFznInstance)
           
            
         
             return [prcReportFznInstance: prcReportFznInstance, prcSpecimenList:prcSpecimenList,prcIssueList:prcIssueList, specimenList:specimenList, prcReportSubList:prcReportSubList, specimenList:specimenList,  prcIssueResolutionDisplayList:prcIssueResolutionDisplayList ]
        }catch(Exception e){
            flash.message="Failed: " + e.toString()  
         
        
            return [prcReportFznInstance: prcReportFznInstance, prcSpecimenList:prcSpecimenList,  prcIssueList:prcIssueList, specimenList:specimenList, prcReportSubList:prcReportSubList, specimenList:specimenList,   prcIssueResolutionDisplayList:prcIssueResolutionDisplayList ]
          }
        
        
        
        
       
    }

  
    
    
    def update = {
        def prcReportFznInstance = PrcReportFzn.get(params.id)
        if (prcReportFznInstance) {
           
            
          
            prcReportFznService.saveReport(params, request)
            
           
           redirect(action:"edit", params:[id:prcReportFznInstance.id])
         
          
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'prcReportFzn.label', default: 'PrcReportFzn'), params.id])}"
            redirect(action: "list")
        }
    }

    @Secured(['ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_ADMIN', 'ROLE_NCI-FREDERICK_CAHUB_PRC'])   
    def delete = {
        def prcReportFznInstance = PrcReportFzn.get(params.id)
        if (prcReportFznInstance) {
            try {
                prcReportFznInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'prcReportFzn.label', default: 'PrcReportFzn'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'prcReportFzn.label', default: 'PrcReportFzn'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'prcReportFzn.label', default: 'PrcReportFzn'), params.id])}"
            redirect(action: "list")
        }
    }
    
    
    
    static Map checkError(prcReportInstance, prcSpecimenList, prcIssueList){
           def studyCode = prcReportInstance.caseRecord.study.code
          def result = [:]
          def releaseMap=[:]
        def stainingOfSlides = prcReportInstance.stainingOfSlides
        if(!stainingOfSlides)
          result.put("stainingOfSlides", "The Overall Staining of Slides is a required field.")
        
      //  def stainingOfImages = prcReportInstance.stainingOfImages
       // if(!stainingOfImages){
        //     result.put("stainingOfImages", "The Overall Staining of Images is a required field.")
      //  }
        
        def processing = prcReportInstance.processing
        if(!processing){
            result.put("processing", "The Overall Processing/Embedding is a required field.")
        }
        prcSpecimenList.each() {
             def specimenId =it.specimenRecord.specimenId
           
          
         
           
             def inventoryStatus=it.inventoryStatus
             if(!inventoryStatus){
                result.put("${it.id}_inventoryStatus".trim(), "The Inventory Status for specimen ${specimenId} is a required field.")
            }
            
         
            
            def comments=it.comments
             if(!comments){
                result.put("${it.id}_comments".trim(), "The comments for specimen ${specimenId} is a required field.")
            }
            
         }
        
        prcIssueList.each(){
             def specimenId =it.specimenRecord?.specimenId
            // def releaseToInventory = it.releaseToInventory
           //  if(!releaseToInventory){
                // result.put("${it.id}_releaseToInventory2".trim(), "The Rlease To Inventory for specimen ${specimenId} is a required field.")
          //   }
             def resolved = it.resolved
             if(!resolved){
                 result.put("${it.id}_resolved".trim(), "The Resolved for specimen ${specimenId} is a required field.")
             }
             
             if(resolved == 'Y'){
                 def resolutionComments = it.resolutionComments
                 if(!resolutionComments){
                     result.put("${it.id}_resolutionComments".trim(), "Please specify Resolution Comments for specimen ${specimenId}.")
                 }
                 
             }
             
          
            
            def issueDescription = it.issueDescription
            if(!issueDescription){
                result.put("${it.id}_issueDescription".trim(), "The Issue Description for specimen ${specimenId} is a required field.")
            }  
            
            def pendingFurtherFollowUp=it.pendingFurtherFollowUp
            if(!pendingFurtherFollowUp){
                result.put("${it.id}_pendingFurtherFollowUp".trim(), "The Pending Further Follow Up for specimen ${specimenId} is a required field.")
            }

        }
        
        return result
    }

    
     static boolean isStarted(prcReportFznInstance, prcSpecimenList, prcIssueList){
        def result=false
        if(prcReportFznInstance.version > 0)
          return true;
          
         prcSpecimenList.each() {
             if(it.version > 0){
                 result=true
             }
               
         }
       
         
        if(prcIssueList)
           return true;
           
        return result
        
    }
    
    
    
     @Secured(['ROLE_NCI-FREDERICK_CAHUB_PRC'])
    def submit = {
         def prcReportFznInstance = PrcReportFzn.get(params.id)
       
        def prcSpecimenFrList
        def prcIssueList
       
        
        try{
             
             prcSpecimenFrList=prcReportFznService.getPrcSpeciemenList4Edit(prcReportFznInstance)
             prcIssueList=prcReportFznService.getPrcIssueList(prcReportFznInstance)
            
            
             
             def result= checkError(prcReportFznInstance, prcSpecimenFrList, prcIssueList)
               if(result){
                    result.each(){key,value->
                    
                      prcReportFznInstance.errors.reject(value, value)
                      errorMap.put(key, "errors")
                    }//each
                     flash.message="failed to submit"
                     
                
                
                     redirect(action:"edit", params:[id:prcReportFznInstance.id])
               }else{
                    //prcReportService.submitReport(prcReportInstance)
                   def username= session.SPRING_SECURITY_CONTEXT?.authentication?.principal?.getUsername()
                
                   prcReportFznService.submitReport(prcReportFznInstance, username, prcIssueList)
                 
                   redirect(action:"view", params:[id:prcReportFznInstance.id])
                   
               
               }
              
             }catch(Exception e){
            flash.message="Failed: " + e.toString()  
          
          
               redirect(action:"edit", params:[id:prcReportFznInstance.id])
          
            
          }
        
    }
    
    
    
    def qareview={
         def prcReportFznInstance = PrcReportFzn.get(params.id)
        
        
        
         
        try{
            def username= session.SPRING_SECURITY_CONTEXT?.authentication?.principal?.getUsername()
            def submission = prcReportFznInstance.currentSubmission
            if(username == submission.submittedBy){
                flash.message="QA review cannot be performed by same user who submitted the report"
            }else{
                prcReportFznService.qaReview(prcReportFznInstance, username)
            }
            
            
               redirect(action:"view", params:[id:prcReportFznInstance.id])
           
            
           //redirect(action:"view", params:[id:prcReportInstance.id])
        }catch(Exception e){
            flash.message="Failed: " + e.toString() 
               redirect(action:"view", params:[id:prcReportFznInstance.id])
           
        }
        
    }
    
    
     def startnew ={
        
        def prcReportFznInstance = PrcReportFzn.get(params.id)
         
             
        try{
           
            prcReportFznService.startNew(prcReportFznInstance)
          
            
           
            redirect(action:"edit", params:[id:prcReportFznInstance.id])
            
        }catch(Exception e){
            flash.message="Failed: " + e.toString() 
           
            redirect(action:"view", params:[id:prcReportFznInstance.id])
           
        }
        
        
    }
    
    
    
}
