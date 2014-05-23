

<%@ page import="nci.obbr.cahub.forms.ctc.CtcCrf" %>
<%@ page import="nci.obbr.cahub.staticmembers.*" %>
<%@ page import="nci.obbr.cahub.datarecords.ctc.*" %>
<g:set var="bodyclass" value="new_page_enter_lowercase_folder_name_here edit" scope="request"/>
<g:set var="bodyclass" value="ctccrf edit wide" scope="request"/>
<html>
    <head>
        <meta name="layout" content="cahubTemplate"/>
        <g:set var="entityName" value="${message(code: 'ctcCrf.label', default: 'CtcCrf')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
        <g:javascript>
          var selected_id = ${selected}
        
           
           $(document).ready(function() {
              
                 
                 $(".fpy").change(function(){
                    var thisid = this.id
                    var id = thisid.substring(3);
                    
                    if(selected_id != id && selected_id !=0){
                      alert("You can only select one 72h sample for further process");
                     // document.getElementById("f1_"+id).checked=false;
                     $("#f1_" +id).prop("checked", false)
                     $("#f2_" +id).prop("checked", true)
                   
                    }else{
                      selected_id = id;
                      // alert("hhhh " +id)
                      $("#dateSampleStainedStr_" +id).show();
                      $("#dateSampleImagedStr_"+id).show();
                      $("#dateSampleAnalyzedStr_"+id).show();
                      $("#ctcValue_"+id).show();
                      $("#dateLoadedDccStr_"+id).show();
                  
                    }
                    
                
                 });
                 
                 
                 
                  $(".fpn").change(function(){
                    var thisid = this.id
                    var id = thisid.substring(3);
                    
                      selected_id = 0
                      // alert("hhhh " +id)
                      $("#dateSampleStainedStr_" +id).hide();
                      $("#dateSampleImagedStr_"+id).hide();
                      $("#dateSampleAnalyzedStr_"+id).hide();
                      $("#ctcValue_"+id).hide();
                      $("#dateLoadedDccStr_"+id).hide();
                  
                    
                    
                
                 });
                 
                 $(".tube_id").change(function(){
                   var thisid = this.id
                    var id = thisid.substring(3);
                    var tube_id = $(this).attr('value')
                    //alert("id" + id + " tube_id: " + tube_id)
                      $("#t2_"+id).html(tube_id);
                 
                 });
                 
                 
                  $(".tube_type").change(function(){
                 
                    var selected =  $(this).attr('value')
                  
                    var tube_type = $("#tt1 option:selected").text()
                      $("#tt2").html(tube_type);
                 
                 });
                 
                 $(".bench_time_c").change(function(){
                     var v = $(this).attr('value')
                      $("#btc").html(v);
                 });
                 
                  $(".bench_time_b").change(function(){
                     var v = $(this).attr('value')
                      $("#btb").html(v);
                 });
                 
               
                 
                   $(".cl").click(function(){
                        var theid = this.id;
                        var id = theid.substring(3);
                    
                       // alert("the id: " + theid + " id: " + id);
                         $("#row_"+id).find('input:text').attr('value','');
                         $("#row_"+id).find('input:checkbox').attr('checked',false);
                         $("#row_"+id).find('input:radio').attr('checked',false);
                          $("#row_"+id).find('input:radio.fpn').attr('checked',true);
                           $("#t2_"+id).html('');
                        
                      //  alert("hhh")
                        return false
                    });
                    
                    
                     $(".cl2").click(function(){
                        var theid = this.id;
                        var id = theid.substring(4);
                    
                       // alert("the id: " + theid + " id: " + id);
                         $("#row2_"+id).find('input:text').attr('value','');
                           $("#row2_"+id).find('input:radio').attr('checked',false);
                        
                      //  alert("hhh")
                        return false
                    });
                    
                    $(":input").change(function(){
                      document.getElementById("changed").value = "Y"
                      //alert("Changed!")
                    });
           });
           
            function sub(){
            var changed = document.getElementById("changed").value
            if(changed == "Y"){
               alert("Please save the change!")
               return false
               }
            
          }
        </g:javascript>
    </head>
    <body>
      <div id="nav" class="clearfix">
          <div id="navlist">
            <a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
        </div>
      </div>
      <div id="container" class="clearfix">
            <h1>CTC Case Report Form </h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${ctcCrfInstance}">
            <div class="errors">
                <g:renderErrors bean="${ctcCrfInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:render template="/caseRecord/caseDetails" bean="${ctcCrfInstance.caseRecord}" var="caseRecord" /> 
            <g:form method="post" >
                <g:hiddenField name="id" value="${ctcCrfInstance?.id}" />
                <g:hiddenField name="version" value="${ctcCrfInstance?.version}" />
                <input type="hidden" name="changed" value="N" id="changed"/>
                <div class="dialog">
                    <table>
                        <tbody>
                        
                           
                            <tr class="prop">
                              <td valign="top" class="name" style="width:400px" >
                                  <label for="whichVisit"><g:message code="ctcCrf.whichVisit.label" default="Which Visit:" /></label>
                                </td>
                                <td>
                                <g:if test="${ctcCrfInstance?.whichVisit==1}">
                                  First
                                </g:if>
                               <g:elseif test="${ctcCrfInstance?.whichVisit==2}" >
                                 Second
                               </g:elseif>
                               <g:else>
                                Third
                               </g:else>
                                </td>
                               
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="phlebotomySite"><g:message code="ctcCrf.phlebotomySite.label" default="Phlebotomy Site:" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: ctcCrfInstance, field: 'phlebotomySite', 'errors')}">
                                    <g:select  name="phlebotomySite.id" from="${nci.obbr.cahub.staticmembers.PhlebotomySite.list()}" optionKey="id" value="${ctcCrfInstance?.phlebotomySite?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="needleType"><g:message code="ctcCrf.needleType.label" default="Needle Type:" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: ctcCrfInstance, field: 'needleType', 'errors')}">
                                  <div>
                                <g:radio name="needleType" id ="nt1" value="Regular Butterfly" checked="${ctcCrfInstance?.needleType =='Regular Butterfly'}"/>&nbsp;<label for="nt1">Regular Butterfly</label>&nbsp;&nbsp;&nbsp;
                                <g:radio name="needleType" id="nt2" value="Other" checked="${ctcCrfInstance?.needleType =='Other'}"/>&nbsp;<label for="nt2">Other</label>
                                  </div>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="needleGauge"><g:message code="ctcCrf.needleGauge.label" default="Needle Gauge:" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: ctcCrfInstance, field: 'needleGauge', 'errors')}">
                                  <div>
                                    <g:radio name="needleGauge" id ="ng1" value="20" checked="${ctcCrfInstance?.needleGauge =='20'}"/>&nbsp;<label for="ng1">20</label>&nbsp;&nbsp;&nbsp;
                                    <g:radio name="needleGauge" id ="ng2" value="21" checked="${ctcCrfInstance?.needleGauge =='21'}"/>&nbsp;<label for="ng2">21</label>&nbsp;&nbsp;&nbsp;
                                    <g:radio name="needleGauge" id ="ng3" value="22" checked="${ctcCrfInstance?.needleGauge =='22'}"/>&nbsp;<label for="ng3">22</label>&nbsp;&nbsp;&nbsp;
                                    <g:radio name="needleGauge" id ="ng4" value="23" checked="${ctcCrfInstance?.needleGauge =='23'}"/>&nbsp;<label for="ng4">23</label>
                                  </div>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="treatmentStatus"><g:message code="ctcCrf.treatmentStatus.label" default="Treatment Status:" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: ctcCrfInstance, field: 'treatmentStatus', 'errors')}">
                                  <div>
                                  <g:radio name="treatmentStatus" id ="t1" value="Pre" checked="${ctcCrfInstance?.treatmentStatus =='Pre'}"/>&nbsp;<label for="t1">Pre</label>&nbsp;&nbsp;&nbsp;
                                   <g:radio name="treatmentStatus" id ="t2" value="Post" checked="${ctcCrfInstance?.treatmentStatus =='Post'}"/>&nbsp;<label for="t2">Post</label>
                                  </div>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="dateSampleCollectedStr">Date/hour at which patients has had first blood draw:*</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: ctcCrfInstance, field: 'dateSampleCollectedStr', 'errors')}">
                                    <g:textField name="dateSampleCollectedStr" value="${ctcCrfInstance?.dateSampleCollectedStr}" />
                                </td>
                            </tr>
                        
                       
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="dateSampleShippedStr">Date/hour of shipping sample to Scripps:*</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: ctcCrfInstance, field: 'dateSampleShippedStr', 'errors')}">
                                    <g:textField name="dateSampleShippedStr" value="${ctcCrfInstance?.dateSampleShippedStr}" />
                                </td>
                            </tr>
                        
                           
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="dateSampleReceivedStr">Date/hour at which sample was received at Scripps:*</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: ctcCrfInstance, field: 'dateSampleReceivedStr', 'errors')}">
                                    <g:textField name="dateSampleReceivedStr" value="${ctcCrfInstance?.dateSampleReceivedStr}" />
                                </td>
                            </tr>
                        
                            
                            <g:if test="${PatientRecord.findByCaseRecord(ctcCrfInstance?.caseRecord).experiment!='VC'}">
                              <tr class="prop" >
                                  <td valign="top" class="name">
                                  <label for="dateSample24hProcessedStr">Date/hour at which sample for the 24 hour time point was processed on to slides:*</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: ctcCrfInstance, field: 'dateSample24hProcessedStr', 'errors')}">
                                   <g:textField name="dateSample24hProcessedStr" value="${ctcCrfInstance?.dateSample24hProcessedStr}" />
                                </td>
                            </tr>
                          
                            <tr class="prop" >
                                <td valign="top" class="name">
                                  <label for="dateSample72hProcessedStr">Date/hour at which sample for the 72 hour time point was processed on to slides:*</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: ctcCrfInstance, field: 'dateSample72hProcessedStr', 'errors')}">
                                    <g:textField name="dateSample72hProcessedStr" value="${ctcCrfInstance?.dateSample72hProcessedStr}" />
                                </td>
                            </tr>
                                    </g:if>
                        
                        <g:if test="${PatientRecord.findByCaseRecord(ctcCrfInstance?.caseRecord).experiment=='VC'}">
                          <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="dateSampleCsProcessedStr">Date/hour at which sample with best tube type was processed on to slides:*</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: ctcCrfInstance, field: 'dateSampleBestProcessedStr', 'errors')}">
                                    <g:textField name="dateSampleBestProcessedStr" value="${ctcCrfInstance?.dateSampleBestProcessedStr}" />
                                </td>
                            </tr>
                          <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="dateSampleCsProcessedStr">Date/hour at which sample with tube type cellsearch  was processed on to slides:*</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: ctcCrfInstance, field: 'dateSampleCsProcessedStr', 'errors')}">
                                    <g:textField name="dateSampleCsProcessedStr" value="${ctcCrfInstance?.dateSampleCsProcessedStr}" />
                                </td>
                            </tr>
           
                        </g:if>
                           <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="comments">Comments:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: ctcCrfInstance, field: 'comments', 'errors')}">
                                    <g:textArea  name="comments" rows="4" cols="50" value="${ctcCrfInstance.comments}" />
                                </td>
                            </tr>
                         <tr ><td colspan="2">*Date/hour format: <i>mm/dd/yyyy hh</i></td></tr>
                          
                        
                        </tbody>
                    </table>
                </div>
                <br></br>
                <div class='list'>
                  <table>
                    <thead>
                         <tr ><th colspan="7">Sample Sheet</th></tr>
                    <tr>
                      <th>Tube ID</th>
                      <th>Tube Type</th>
                      <th>Bench Time</th>
                      <th>CTC Measurement Technology</th>
                      <g:if test="${sample_list.size() !=2}">
                         <th>Will Sample be further processed </th>
                      </g:if>
                      <th>Probes Employed </th>
                      <th>Morphological Criteria Employed </th>
                       
                    </tr>
                    </thead>
                    <tbody>
                      <g:each in="${sample_list}" status="i" var="sample">
                        <tr id='row_${sample.id}'>
                          <td class="value ${errorMap.get('tubeId_'+sample.id)}"><g:textField class="tube_id" id="t1_${sample.id}" name="tubeId_${sample.id}" value="${sample.tubeId}"  /></td>
                           <g:if test="${sample_list.size() !=2 || sample.tubeType?.code=='CELLSEARCH'}">
                           <td class='value'>${sample.tubeType?.code}</td>
                           </g:if>
                          <g:else>
                            <td class="value ${errorMap.get('tubeType_'+sample.id)}"> <g:select class="tube_type" id="tt1" name="tubeType_${sample.id}" from="${[Fixative.findByCode('STRECK'), Fixative.findByCode('EDTA'), Fixative.findByCode('HEPARIN'), Fixative.findByCode('ACD')] }" optionKey="id" optionValue="code" value="${sample.tubeType?.id}" noSelection="['null': '']" /></td>
                          </g:else>
                           <g:if test="${sample_list.size() !=2}">
                           <td class='value'>${sample.benchTime}</td>
                           </g:if>
                          <g:else>
                            <g:if test="${sample.tubeType?.code=='CELLSEARCH'}">
                              <td class="value ${errorMap.get('benchTime_'+sample.id)}"> <g:textField class='bench_time_c' name="benchTime_${sample.id}" id ="benchTime_${sample.id}" value="${sample.benchTime}" size='4' /> </td>
                            </g:if>
                            <g:else>
                              <td class="value ${errorMap.get('benchTime_'+sample.id)}"> <g:select class='bench_time_b' name="benchTime_${sample.id}" from="${['24', '72'] }"  value="${sample.benchTime}" noSelection="['': '']"  /></td>
                            </g:else>
                          </g:else>
                           <td class="value ${errorMap.get('measureTech_'+sample.id)}">
                             <div>
                              <g:radio name="measureTech_${sample.id}" id ="m1_${sample.id}" value="Scripps" checked="${sample.measureTech =='Scripps'}"/><label for="m1_${sample.id}">Scripps</label><br/>
                              <g:radio name="measureTech_${sample.id}" id ="m2_${sample.id}" value="Veridex" checked="${sample.measureTech =='Veridex'}"/><label for="m2_${sample.id}">Veridex</label>
                             </div>  
                              </td>
                            <g:if test="${sample_list.size() !=2}">
                           <td class='value' nowrap="nowap">
                                  <g:if test="${sample.benchTime=='72'}">
                                  <g:radio name="furtherProcessed_${sample.id}" id ="f1_${sample.id}" value="Yes" checked="${sample.furtherProcessed =='Yes'}" class="fpy"  /><label for="f1_${sample.id}">Yes</label><br/>
                                  <g:radio name="furtherProcessed_${sample.id}" id ="f2_${sample.id}" value="No" checked="${sample.furtherProcessed =='No'}" class="fpn" /><label for="f2_${sample.id}">No</label> 
                                  </g:if>
                                 <g:else>
                                   &nbsp;
                                 </g:else>
                                  </td>
                              </g:if>
                           <td class="value ${errorMap.get('probe_'+sample.id)}" nowrap="nowap">
                             <g:if test="${sample.tubeType?.code=='CELLSEARCH'}">
                                 <g:textField name="probes4Cs_${sample.id}" value="${sample.probes4Cs}" size="35"  />
                               </g:if>
                           <g:else>
                            <g:each in="${sample.probeSelections.sort{it.id}}"  status ="j" var="probe">
                               <g:checkBox name="probe_${probe.id}" id="probe_${probe.id}" value="${probe.selected}" />&nbsp;<label for="probe_${probe.id}">${probe?.ctcProbe.name}</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                             </g:each>
                           </g:else>
                           </td>
                           <td class="value ${errorMap.get('criteria_'+sample.id)}" nowrap="nowap">
                              <g:if test="${sample.tubeType?.code=='CELLSEARCH'}">
                                 <g:textField name="criteria4Cs_${sample.id}" value="${sample.criteria4Cs}"  size="35"  />
                               </g:if>
                           <g:else>
                             <g:each in="${sample.criteriaSelections.sort{it.id}}"  status ="j" var="criteria">
                               <g:checkBox name="criteria_${criteria.id}" id="criteria_${criteria.id}" value="${criteria.selected}" />&nbsp;<label for="criteria_${criteria.id}">${criteria?.morphCrireria.name}</label> <br/>
                             </g:each>
                           </g:else>
                           </td> 
                          
                        </tr>
                      </g:each>
                       
                    </tbody>
                  </table>
                  
                  <br></br>
                   <table>
                    <thead>
                        <tr ><th colspan="9">Sample Sheet Cont.</th></tr>
                    <tr>
                      <th>Tube ID</th>
                      <th>Tube Type</th>
                      <th>Bench Time</th>
                      
                      <th>Date Sample Stained*</th>
                      <th>Date Sample Imaged*</th>
                      <th>Date Sample Analysed*</th>
                      <th>CTC Value Reported</th>
                      <th>Date Sample Uploaded to DCC*</th>
                      <th>Sample Status</th>
                       
                    </tr>
                    </thead>
                    <tbody>
                      <g:each in="${sample_list}" status="i" var="sample">
                        <tr id='row2_${sample.id}'>
                          <td class="value " style="width: 130px"><span id="t2_${sample.id}" >${sample.tubeId}</span></td>
                           <g:if test="${sample_list.size() !=2 || sample.tubeType?.code=='CELLSEARCH'}">
                           <td class='value'>${sample.tubeType?.code}</td>
                           </g:if>
                          <g:else>
                            <td><span id="tt2" > ${sample.tubeType?.code}</span></td>
                          </g:else>
                           <g:if test="${sample_list.size() !=2}">
                           <td class='value'>${sample.benchTime}</td>
                           </g:if>
                          <g:else>
                            <g:if test="${sample.tubeType?.code=='CELLSEARCH'}">
                              <td><span id='btc'> ${sample.benchTime}</span> </td>
                            </g:if>
                            <g:else>
                              <td><span id='btb'> ${sample.benchTime}</span></td>
                            </g:else>
                          </g:else>
                          
                          
                           <td class="value ${errorMap.get('dateSampleStainedStr_'+sample.id)}">
                             <g:if test="${sample.benchTime=='24' || sample.furtherProcessed == 'Yes' || sample_list.size()==2}">
                              <span id="dateSampleStainedStr_${sample.id}" style="display: block">
                              </g:if>
                             <g:else>
                               <span id="dateSampleStainedStr_${sample.id}" style="display: none">
                             </g:else>
                             <g:if test="${sample.tubeType?.code=='CELLSEARCH'}">
                               &nbsp;
                             </g:if>
                              <g:else>
                                 <g:textField name="dateSampleStainedStr_${sample.id}" value="${sample.dateSampleStainedStr}"  />
                              </g:else>
                              </span>
                           </td>
                           
                            <td class="value ${errorMap.get('dateSampleImagedStr_'+sample.id)}">
                               <g:if test="${sample.benchTime=='24' || sample.furtherProcessed == 'Yes' || sample_list.size()==2}">
                              <span id="dateSampleImagedStr_${sample.id}" style="display: block">
                              </g:if>
                             <g:else>
                               <span id="dateSampleImagedStr_${sample.id}" style="display: none">
                             </g:else>
                                <g:if test="${sample.tubeType?.code=='CELLSEARCH'}">
                                  &nbsp;
                                </g:if>
                                <g:else>
                                  <g:textField name="dateSampleImagedStr_${sample.id}" value="${sample.dateSampleImagedStr}" />
                                </g:else>
                            </span>
                            </td>
                            
                            <td class="value ${errorMap.get('dateSampleAnalyzedStr_'+sample.id)}">
                               <g:if test="${sample.benchTime=='24' || sample.furtherProcessed == 'Yes' || sample_list.size()==2}">
                              <span id="dateSampleAnalyzedStr_${sample.id}" style="display: block">
                              </g:if>
                            <g:else>
                               <span id="dateSampleAnalyzedStr_${sample.id}" style="display: none">
                             </g:else>
                                  <g:if test="${sample.tubeType?.code=='CELLSEARCH'}">
                                    &nbsp;
                                  </g:if>
                                 <g:else>
                                    <g:textField name="dateSampleAnalyzedStr_${sample.id}" value="${sample.dateSampleAnalyzedStr}"  />
                                 </g:else>
                            </span>
                            </td>
                            
                            
                             <td class="value ${errorMap.get('ctcValueStr_'+sample.id)}">
                              <g:if test="${sample.benchTime=='24' || sample.furtherProcessed == 'Yes' || sample_list.size()==2}">
                              <span id="ctcValue_${sample.id}" style="display: block">
                              </g:if>
                            <g:else>
                               <span id="ctcValue_${sample.id}" style="display: none">
                             </g:else>
                                   <g:textField name="ctcValueStr_${sample.id}" value="${sample.ctcValueStr}"  />
                             </span>
                             </td>
                             
                             
                             <td class="value ${errorMap.get('dateLoadedDccStr_'+sample.id)}">
                                <g:if test="${sample.benchTime=='24' || sample.furtherProcessed == 'Yes' || sample_list.size()==2}">
                              <span id="dateLoadedDccStr_${sample.id}" style="display: block">
                              </g:if>
                            <g:else>
                               <span id="dateLoadedDccStr_${sample.id}" style="display: none">
                            </g:else>
                             <g:textField name="dateLoadedDccStr_${sample.id}" value="${sample.dateLoadedDccStr}"  />
                               </span>
                             </td>
                             <td class="value ${errorMap.get('status_'+sample.id)}" nowrap="nowap">
                               <div>
                               <g:radio name="status_${sample.id}" id ="st1_${sample.id}" value="Processing" checked="${sample.status =='Processing'}"/><label for="st1_${sample.id}">Processing</label><br/>
                               <g:radio name="status_${sample.id}" id ="st2_${sample.id}" value="Finished" checked="${sample.status =='Finished'}"/><label for="st2_${sample.id}">Finished</label>
                               </div>
                               </td>
                             
                        </tr>
                      </g:each>
                         <tr ><td colspan="9">*Date format: <i>mm/dd/yyyy</i></td></tr>
                    </tbody>
                  </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <g:if test="${canSub}">
                      <g:actionSubmit class="save" action="submit" value="Submit" onclick="return sub()"/>
                    </g:if>
                </div>
            </g:form>
        </div>
    </body>
</html>
