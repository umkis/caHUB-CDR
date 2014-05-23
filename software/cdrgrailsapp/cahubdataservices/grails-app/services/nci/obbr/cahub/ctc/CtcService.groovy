package nci.obbr.cahub.ctc

import nci.obbr.cahub.datarecords.*
import nci.obbr.cahub.staticmembers.*
import nci.obbr.cahub.forms.ctc.*
import java.text.SimpleDateFormat
import nci.obbr.cahub.datarecords.ctc.*

class CtcService {

    def createCtcCase() {

    }
    
   def createCrf(ctcCrfInstance){
       def caseRecord = ctcCrfInstance.caseRecord
       //println("case id: " + caseRecord.caseId + " which visit: " + ctcCrfInstance.whichVisit)
       ctcCrfInstance.save(failOnError:true)
       def sample_list =[]
       def fixative_list =[]
       fixative_list.add(Fixative.findByCode('STRECK'))
       fixative_list.add(Fixative.findByCode('EDTA'))
       fixative_list.add(Fixative.findByCode('HEPARIN'))
       fixative_list.add(Fixative.findByCode('ACD'))
       def benchTimeList = []
       benchTimeList.add('24')
       benchTimeList.add('72')
       fixative_list.each{it1->
         
           benchTimeList.each(){it2->
              // println("tupe type: " + it1.code + "  bench time: " + it2)
              def ctcSample = new CtcSample()
              ctcSample.ctcCrf=ctcCrfInstance
              ctcSample.tubeType=it1
              ctcSample.benchTime = it2
              if(it2=='72')
                ctcSample.furtherProcessed='No'
              ctcSample.experiment='BTBT'
              ctcSample.measureTech='Scripps'
              ctcSample.save(failOnError:true)
              sample_list.add(ctcSample)
            
              
           }
          
       }
       
        def bestTube = new CtcSample()
         bestTube.ctcCrf=ctcCrfInstance
         bestTube.experiment='VC'
         bestTube.measureTech='Scripps'
         bestTube.save(failOnError:true)
         sample_list.add(bestTube)
         
        def cellSearchTube= new CtcSample()
         cellSearchTube.ctcCrf=ctcCrfInstance
         cellSearchTube.tubeType=Fixative.findByCode('CELLSEARCH')
         cellSearchTube.experiment='VC'
         cellSearchTube.measureTech='Veridex'
         cellSearchTube.save(failOnError:true)
         sample_list.add(cellSearchTube)
         
        
        sample_list.each(){it->
            
              if(!it.tubeType || it.tubeType?.code !='CELLSEARCH'){
                
              def probe_list = CtcProbe.findAll()
             
                probe_list.each(){it3->
                    def probe_selection = new ProbeSelection()
                    probe_selection.ctcProbe=it3
                    if(it3.code=='PanCK' || it3.code=='CD45' || it3.code=='DAPI')
                      probe_selection.selected = true
                    probe_selection.ctcSample = it
                    probe_selection.save(failOnError:true)
                    
                }
              def criteria_list = MorphologicalCriteria.findAll()
              criteria_list.each(){it4->
                  def criteriaSelection = new CriteriaSelection()
                  criteriaSelection.morphCrireria=it4
                  if(it4.code == 'NUCLEARSHAPE')
                  criteriaSelection.selected=true
                  criteriaSelection.ctcSample = it
                  criteriaSelection.save(failOnError:true)
                  
              }
              }
        }
        
         
         
        
        
   }
   
    
    
    def saveCrf(params){
          SimpleDateFormat df = new SimpleDateFormat("MM/dd/yyyy");
        SimpleDateFormat df2 = new SimpleDateFormat("MM/dd/yyyy HH");
          def ctcCrf = CtcCrf.get(params.id)
            def caseRecord = ctcCrf.caseRecord
             def patient = PatientRecord.findByCaseRecord(caseRecord)
            def exp = patient.experiment
            ctcCrf.properties = params
            if(isDateHour(ctcCrf.dateSampleCollectedStr)){
                def dateSampleCollected = df2.parse(ctcCrf.dateSampleCollectedStr)
                ctcCrf.dateSampleCollected=dateSampleCollected
            }else{
                ctcCrf.dateSampleCollected=null
            }
            
            if(isDateHour(ctcCrf.dateSampleShippedStr)){
                def dateSampleShipped = df2.parse(ctcCrf.dateSampleShippedStr)
                ctcCrf.dateSampleShipped=dateSampleShipped
            }else{
                ctcCrf.dateSampleShipped=null
            }
            
            if(isDateHour(ctcCrf.dateSampleReceivedStr)){
                def dateSampleReceived = df2.parse(ctcCrf.dateSampleReceivedStr)
                ctcCrf.dateSampleReceived=dateSampleReceived
            }else{
                ctcCrf.dateSampleReceived=null
            }
            
           
            if(exp=='BTBT'){
                if(isDateHour(ctcCrf.dateSample24hProcessedStr)){
                    def dateSample24hProcessed = df2.parse(ctcCrf.dateSample24hProcessedStr)
                    ctcCrf.dateSample24hProcessed= dateSample24hProcessed
                }else{
                     ctcCrf.dateSample24hProcessed=null
                }
                
                if(isDateHour(ctcCrf.dateSample72hProcessedStr)){
                    def dateSample72hProcessed = df2.parse(ctcCrf.dateSample72hProcessedStr)
                    ctcCrf.dateSample72hProcessed= dateSample72hProcessed
                }else{
                     ctcCrf.dateSample72hProcessed=null
                }
                
            } 
        
        
            if(exp=='VC'){
                 if(isDateHour(ctcCrf.dateSampleBestProcessedStr)){
                    def dateSampleBestProcessed  = df2.parse(ctcCrf.dateSampleBestProcessedStr)
                    ctcCrf.dateSampleBestProcessed= dateSampleBestProcessed
                }else{
                     ctcCrf.dateSampleBestProcessed=null
                }
                
                if(isDateHour(ctcCrf.dateSampleCsProcessedStr)){
                    def dateSampleCsProcessed = df2.parse(ctcCrf.dateSampleCsProcessedStr)
                    ctcCrf.dateSampleCsProcessed=dateSampleCsProcessed
                }else{
                     ctcCrf.dateSampleCsProcessed=null
                }
                
            }
        
           def sample_list = CtcSample.findAllByExperimentAndCtcCrf( exp, ctcCrf )
           
           sample_list.each(){
               def id = it.id
               def tubeId = params.get("tubeId_" +id)
               it.tubeId = tubeId
               def measureTech = params.get("measureTech_" +id)
               it.measureTech = measureTech
               if(exp=='VC'){
                   def tubeType=it.tubeType
                   //println("tube type id: " + tubeType?.id)
                   
                   if(!tubeType || tubeType.code != 'CELLSEARCH'){
                       def fixative_id = params.get("tubeType_" +id)
                        //println("tube id: " + tubeId + "  fixative_id: " + fixative_id)
                        if(fixative_id && fixative_id != 'null'){
                           it.tubeType=Fixative.findById(new Long(fixative_id))
                       }
                     
                   }
                   
                   it.benchTime = params.get("benchTime_" +id)
               }
            
               def probe_list = it.probeSelections
               probe_list.each(){it2->
                   if(params.get("probe_"+it2.id))
                    it2.selected=true
                    else
                    it2.selected=false
                   it2.save(failOnError:true)
               }
               
              
               def criteria_list =it.criteriaSelections
               criteria_list.each(){it2->
                    if(params.get("criteria_"+it2.id))
                     it2.selected=true
                     else
                     it2.selected=false
                    it2.save(failOnError:true)
               }
              
                if(it.tubeType?.code == 'CELLSEARCH'){
                   it.probes4Cs = params.get("probes4Cs_" +it.id)
                   it.criteria4Cs=params.get("criteria4Cs_"+it.id)
               }
            
               it.furtherProcessed=params.get("furtherProcessed_" +id)
            
               def dateSampleStainedStr=params.get("dateSampleStainedStr_"+id)
               it.dateSampleStainedStr=dateSampleStainedStr
                if(isDate(it.dateSampleStainedStr)){
                    def dateSampleStained = df.parse(it.dateSampleStainedStr)
                    it.dateSampleStained=dateSampleStained 
                }else{
                     it.dateSampleStained=null
                }
               
                def dateSampleImagedStr =params.get("dateSampleImagedStr_"+id)
               it.dateSampleImagedStr= dateSampleImagedStr
                if(isDate(it.dateSampleImagedStr)){
                    def dateSampleImaged = df.parse(it.dateSampleImagedStr)
                    it.dateSampleImaged=dateSampleImaged 
                }else{
                     it.dateSampleImaged=null
                }
               
            
                def  dateSampleAnalyzedStr=params.get("dateSampleAnalyzedStr_"+id)
               it.dateSampleAnalyzedStr=dateSampleAnalyzedStr 
                if(isDate(it.dateSampleAnalyzedStr)){
                    def dateSampleAnalyzed = df.parse(it.dateSampleAnalyzedStr)
                    it.dateSampleAnalyzed=dateSampleAnalyzed
                }else{
                     it.dateSampleAnalyzed=null
                }
            
                def ctcValueStr = params.get("ctcValueStr_" +id)
                it.ctcValueStr = ctcValueStr
                if(isFloat(ctcValueStr)){
                     it.ctcValue = new Float(ctcValueStr)
                }else{
                     it.ctcValue = null
                }
                
                def dateLoadedDccStr =params.get("dateLoadedDccStr_"+id)
               it.dateLoadedDccStr=dateLoadedDccStr 
                if(isDate(it.dateLoadedDccStr)){
                    def dateLoadedDcc = df.parse(it.dateLoadedDccStr)
                    it.dateLoadedDcc=dateLoadedDcc
                }else{
                     it.dateLoadedDcc=null
                }
            
                it.status=params.get("status_" +id)
            
               if(exp=='BTBT' && it.benchTime=='72' && it.furtherProcessed == 'No'){
                   it.dateSampleStainedStr=null
                   it.dateSampleStained=null
                   it.dateSampleImagedStr=null
                   it.dateSampleImaged=null
                   it.dateSampleAnalyzedStr=null
                   it.dateSampleAnalyzed=null
                   it.ctcValueStr=null
                   it.ctcValue=null
                   it.dateLoadedDccStr=null
                   it.dateLoadedDcc=null
                   
               }
            
               it.save(failOnError:true)
           }
        
            ctcCrf.started=true
            ctcCrf.save(failOnError:true)
            
        
    }
    
    
     boolean isDate(dateStr){
        boolean result=false
        if(!dateStr)
        return false
        SimpleDateFormat df = new SimpleDateFormat("MM/dd/yyyy");
        df.setLenient(false);
        try{
        
            def date = df.parse(dateStr)
            result=true
        }catch (Exception e){
             
        }
          
        return result
        
        
    }
    
    boolean isDateHour(dateStr){
        boolean result=false
        if(!dateStr)
        return false
        SimpleDateFormat df = new SimpleDateFormat("MM/dd/yyyy HH");
        df.setLenient(false);
        try{
        
            def date = df.parse(dateStr)
            result=true
        }catch (Exception e){
             
        }
          
        return result
        
        
    }
    
    boolean isFloat(floatStr){
          boolean result=false
        if(!floatStr)
        return false
        
        try{
            Float.parseFloat(floatStr)
            result = true
        }catch (Exception e){
             
        }
        return result    
    }
    
    
     def submitCrf(ctcCrfInstance, user){
          def caseRecord = ctcCrfInstance.caseRecord
          def patient = PatientRecord.findByCaseRecord(caseRecord)
          def exp = patient.experiment
          def sample_list = CtcSample.findAllByExperimentAndCtcCrf( exp, ctcCrfInstance )
          sample_list.each(){
              def sample = it.sample
                    if(!sample){
                       sample = new SpecimenRecord()
                     
                    }
              
                    sample.specimenId =it.tubeId
                    if(exp=='BTBT' || (exp=='VC' && it.tubeType.code != 'CELLSEARCH')){
                        def bentchTime=it.benchTime
                        if(it.benchTime == '24')
                        sample.protocol = Protocol.findByCode('CTCBT24')

                    if(it.benchTime == '72')
                        sample.protocol = Protocol.findByCode('CTCBT72')
                    }

                    sample.tissueType=AcquisitionType.findByCode('BLOODW')
                    sample.provisionalTissueType=AcquisitionType.findByCode('BLOODW')
                    sample.fixative=it.tubeType
                    sample.caseRecord=caseRecord
                    sample.save(failOnError:true)
                    it.sample = sample
                    it.save(failOnError:true)
                     
             
          }
         ctcCrfInstance.dateSubmitted = new Date()
         ctcCrfInstance.submittedBy=user
         ctcCrfInstance.save(failOnError:true)
     }
     
    def resumeCrf(ctcCrfInstance){
         ctcCrfInstance.dateSubmitted = null
         ctcCrfInstance.submittedBy=null
         ctcCrfInstance.save(failOnError:true)
        
    }
    
}
