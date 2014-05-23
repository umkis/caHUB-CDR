<div id="sect-tissue-rec" class="div-t">

  <div class="div-t-r div-t-h">Patient Data</div>
  <div class="div-t-r clearfix">
    <div >
      
      <div class="left width-30"><label for="patientId">Patient ID: </label></div>
      
        <div class="left width-30 ${hasErrors(bean: patientRecordInstance, field: 'patientId', 'errors')}"> <g:textField name="patientId" value="${patientRecordInstance?.patientId}" /> </div>
      
    </div>
  </div>
  
  <div class="div-t-r clearfix">
    <div >
      
      <div class="left width-30"><label for="experiment">Experiment: </label></label></div>
      
        <div class=" value left width-50 ${hasErrors(bean: patientRecordInstance, field: 'experiment', 'errors')}">  
           <g:if test="${patientRecordInstance.caseRecord?.id && patientRecordInstance.caseRecord.specimens}">
          <div>
            <g:radio  id="exp1" name="experiment"  value="BTBT" checked="${patientRecordInstance.experiment =='BTBT'}" disabled ="true"/><label for="exp1">Best Tube Best Timepoint</label> &nbsp;&nbsp;&nbsp;
            <g:radio id="exp2" name="experiment"  value="VC" checked="${patientRecordInstance.experiment =='VC'}" disabled="true"/><label for="exp2">Veridex Comparison</label>
           </div>
       </g:if>
      <g:else>
        <div>
            <g:radio  id="exp1" name="experiment"  value="BTBT" checked="${patientRecordInstance.experiment =='BTBT'}" /><label for="exp1">Best Tube Best Timepoint</label> &nbsp;&nbsp;&nbsp;
            <g:radio id="exp2" name="experiment"  value="VC" checked="${patientRecordInstance.experiment =='VC'}"  /><label for="exp2">Veridex Comparison</label>
           </div>
        </g:else>
        </div>
          </div>
  </div>
  
  
  <div class="div-t-r clearfix">
    <div >
      <div class="left width-30"><label for="gender">Gender: </label></label></div>
     
        <div class="value left width-30 ${hasErrors(bean: patientRecordInstance, field: 'gender', 'errors')}">   
          <div>
            <g:radio id="gen1" name="gender"  value="Male" checked="${patientRecordInstance.gender =='Male'}"/><label for="gen1">Male</label>&nbsp;&nbsp;&nbsp;
            <g:radio id="gen2" name="gender"  value="Female" checked="${patientRecordInstance.gender =='Female'}"/><label for="gen2">Female</label>&nbsp;&nbsp;&nbsp;
            <g:radio id="gen3" name="gender"  value="Other" checked="${patientRecordInstance.gender =='Other'}"/><label for="gen3">Other</label>
          </div>
        </div>
      
    </div>
  </div>

  <div class="div-t-r clearfix"> 
    <div >
      <div class="left width-30"><label for="disease">Disease: </label> </div>
      
        <div class="left width-30  ${hasErrors(bean: patientRecordInstance, field: 'disease', 'errors')} "> <g:textField name="disease" value="${patientRecordInstance?.disease ?: 'Breast Cancer'}"/></div>
      
    </div>
  </div>

  <div class="div-t-r clearfix">
    <div >
      <div class="left width-30"><label for="consentDate">Consent Date: </label>  </div>
     
        <div class="left width-30 ${hasErrors(bean: patientRecordInstance, field: 'consentDate', 'errors')}"><g:jqDatePicker LDSOverlay="false" name="consentDate" value="${patientRecordInstance?.consentDate}" /></div>
     
    </div>
  </div>
  
  
  <div class="div-t-r clearfix">
    <div >
      <div class="left width-30"><label for="cancerStage">Cancer Stage: </label>  </div>
      
        <div class="left width-30  ${hasErrors(bean: patientRecordInstance, field: 'cancerStage', 'errors')}">
          <g:select name="cancerStage" from="${nci.obbr.cahub.datarecords.ctc.PatientRecord$StageOfCancer?.values()}" keys="${nci.obbr.cahub.datarecords.ctc.PatientRecord$StageOfCancer.values()*.name()}" value="${patientRecordInstance?.cancerStage}" noSelection="['': '']"/>
        </div>
        </div>
  </div> 

   <div class="div-t-r clearfix">
    <div >
      <div class="left width-30"><label for="collectionSite">Collection Site: </label></div>
      
        <div class="left width-30  ${hasErrors(bean: patientRecordInstance, field: 'collectionSite', 'errors')}"><g:select name="collectionSite.id" from="${ctcBssList}" optionKey="id"  optionValue="name" value="${patientRecordInstance?.collectionSite?.id}" noSelection="['null': '']" />   </div>
     
    </div>
  </div> 

  <div class="div-t-r clearfix">
    <div >
      <div class="left width-30"><label for="visit">Visit Number: </label></div>
      <div class="value left width-30 ${hasErrors(bean: patientRecordInstance, field: 'visit', 'errors')} "> 
        <div>
          <g:radio id="v1" name="visit"  value="One" checked="${patientRecordInstance?.visit =='One'}"/><label for="v1">One</label>&nbsp;&nbsp;&nbsp;
          <g:radio id="v2" name="visit"  value="Two" checked="${patientRecordInstance?.visit =='Two'}"/><label for="v2">Two</label>&nbsp;&nbsp;&nbsp;
          <g:radio id="v3" name="visit"  value="Three" checked="${patientRecordInstance?.visit =='Three'}"/><label for="v3">Three</label>
        </div>
      </div>
    </div>
  </div>
  
   <div class="div-t-r clearfix">
    <div >
      <div class="left width-30"><label for="visit">Comments: </label></div>
      <div class="value left width-30 ${hasErrors(bean: patientRecordInstance, field: 'comments', 'errors')} "> 
        <div>
            <g:textArea class="textwide" name="comments" cols="40" rows="5" value="${patientRecordInstance?.comments}" />
        </div>
      </div>
    </div>
  </div>


</div>