
<%@ page import="nci.obbr.cahub.util.AppSetting" %>
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
                <div class="list">
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
                               <g:elseif test="${ctcCrfInstance?.whichVisit==2}">
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
                                   ${ctcCrfInstance?.phlebotomySite?.name}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="needleType"><g:message code="ctcCrf.needleType.label" default="Needle Type:" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: ctcCrfInstance, field: 'needleType', 'errors')}">
                                  <div>
                                    ${ctcCrfInstance?.needleType}
                                  </div>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="needleGauge"><g:message code="ctcCrf.needleGauge.label" default="Needle Gauge:" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: ctcCrfInstance, field: 'needleGauge', 'errors')}">
                                  <div>
                                    ${ctcCrfInstance?.needleGauge}
                                  </div>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="treatmentStatus"><g:message code="ctcCrf.treatmentStatus.label" default="Treatment Status:" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: ctcCrfInstance, field: 'treatmentStatus', 'errors')}">
                                  <div>
                                    ${ctcCrfInstance?.treatmentStatus}
                                  </div>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="dateSampleCollectedStr">Date/hour at which patients has had first blood draw:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: ctcCrfInstance, field: 'dateSampleCollectedStr', 'errors')}">
                                  
                                    <g:if test="${ctcCrfInstance?.dateSampleCollected}">
                                      <g:formatDate date="${ctcCrfInstance?.dateSampleCollected}" type="datetime" style="MEDIUM" timeStyle="SHORT"/>
                                      </g:if>
                                </td>
                            </tr>
                        
                       
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="dateSampleShippedStr">Date/hour of shipping sample to Scripps:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: ctcCrfInstance, field: 'dateSampleShippedStr', 'errors')}">
                                   <g:formatDate date="${ctcCrfInstance?.dateSampleShipped}" type="datetime" style="MEDIUM" timeStyle="SHORT"/>
                                </td>
                            </tr>
                        
                           
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="dateSampleReceivedStr">Date/hour at which sample was received at Scripps:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: ctcCrfInstance, field: 'dateSampleReceivedStr', 'errors')}">
                                   <g:formatDate date="${ctcCrfInstance?.dateSampleReceived}" type="datetime" style="MEDIUM" timeStyle="SHORT"/>
                                </td>
                            </tr>
                        
                            
                            <g:if test="${PatientRecord.findByCaseRecord(ctcCrfInstance?.caseRecord).experiment!='VC'}">
                              <tr class="prop" >
                                  <td valign="top" class="name">
                                  <label for="dateSample24hProcessedStr">Date/hour at which sample for the 24 hour time point was processed on to slides:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: ctcCrfInstance, field: 'dateSample24hProcessedStr', 'errors')}">
                                  <g:formatDate date="${ctcCrfInstance?.dateSample24hProcessed}" type="datetime" style="MEDIUM" timeStyle="SHORT"/>
                                </td>
                            </tr>
                          
                            <tr class="prop" >
                                <td valign="top" class="name">
                                  <label for="dateSample72hProcessedStr">Date/hour at which sample for the 72 hour time point was processed on to slides:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: ctcCrfInstance, field: 'dateSample72hProcessedStr', 'errors')}">
                                   <g:formatDate date="${ctcCrfInstance?.dateSample72hProcessed}" type="datetime" style="MEDIUM" timeStyle="SHORT"/>
                                </td>
                            </tr>
                                    </g:if>
                        
                        <g:if test="${PatientRecord.findByCaseRecord(ctcCrfInstance?.caseRecord).experiment=='VC'}">
                          <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="dateSampleCsProcessedStr">Date/hour at which sample with best tube type was processed on to slides:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: ctcCrfInstance, field: 'dateSampleBestProcessedStr', 'errors')}">
                                  <g:formatDate date="${ctcCrfInstance?.dateSampleBestProcessed}" type="datetime" style="MEDIUM" timeStyle="SHORT"/>
                                </td>
                            </tr>
                          <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="dateSampleCsProcessedStr">Date/hour at which sample with tube type cellsearch  was processed on to slides:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: ctcCrfInstance, field: 'dateSampleCsProcessedStr', 'errors')}">
                                   <g:formatDate date="${ctcCrfInstance?.dateSampleCsProcessed}" type="datetime" style="MEDIUM" timeStyle="SHORT"/>
                                </td>
                            </tr>
           
                        </g:if>
                        
                           <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="comments"><g:message code="ctcCrf.comments.label" default="Comments:" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: ctcCrfInstance, field: 'comments', 'errors')}">
                                   ${ctcCrfInstance?.comments}
                                </td>
                            </tr>

                        
                        </tbody>
                    </table>
                </div>
                <br></br>
                <div class='list'>
                  <table>
                    <thead>
                         <tr ><th colspan="12">Sample Sheet</th></tr>
                    <tr>
                      <th>Tube ID</th>
                      <th>Tube Type</th>
                      <th>Bench Time</th>
                      <th>CTC Measurement Technology</th>
                      <th>Probes Employed </th>
                      <th>Morphological Criteria Employed </th>
                       <th>Date Sample Stained</th>
                      <th>Date Sample Imaged</th>
                      <th>Date Sample Analysed</th>
                      <th>CTC Value Reported </th>
                      <th>Date Sample Uploaded to DCC</th>
                      <th>Sample Status</th>
                    </tr>
                    </thead>
                    <tbody>
                      <g:each in="${sample_list}" status="i" var="sample">
                        <tr id='row_${sample.id}'>
                            <td nowrap="nowrap" class="value ${errorMap.get('tubeId_'+sample.id)}">${sample.tubeId}</td>
                           <td class='value'>${sample.tubeType?.code}</td>
                           <td class='value'>${sample.benchTime}</td>
                           <td class="value ${errorMap.get('measureTech_'+sample.id)}">${sample.measureTech}</td>
                           
                           <td class="value ${errorMap.get('probe_'+sample.id)}" nowrap="nowap">
                              ${sample.probes}
                           </td>
                           <td class="value ${errorMap.get('criteria_'+sample.id)}" nowrap="nowap">
                              ${sample.criteria}
                           </td> 
                           <td nowrap="nowrap" class="value ${errorMap.get('dateSampleStainedStr_'+sample.id)}"> <g:formatDate date="${sample.dateSampleStained}" type="date" style="MEDIUM"/></td>  
                           <td nowrap="nowrap" class="value ${errorMap.get('dateSampleImagedStr_'+sample.id)}"><g:formatDate date="${sample.dateSampleImaged}" type="date" style="MEDIUM"/></td>  
                           <td nowrap="nowrap" class="value ${errorMap.get('dateSampleAnalyzedStr_'+sample.id)}"><g:formatDate date="${sample.dateSampleAnalyzed}" type="date" style="MEDIUM"/></td>  
                           <td nowrap="nowrap" class="value ${errorMap.get('ctcValueStr_'+sample.id)}">${sample.ctcValueStr}</td>
                            <td nowrap="nowrap" class="value ${errorMap.get('dateLoadedDccStr_'+sample.id)}"><g:formatDate date="${sample.dateLoadedDcc}" type="date" style="MEDIUM"/></td>
                             <td nowrap="nowrap" class="value ${errorMap.get('status_'+sample.id)}" nowrap="nowap">${sample.status}</td>
                        </tr>
                      </g:each>
                    </tbody>
                  </table>
                  
                 
                </div>
                <g:if test="${(session.authorities.contains('ROLE_NCI-FREDERICK_CAHUB_SUPER') || session.authorities.contains('ROLE_ADMIN') ||  AppSetting.findByCode('CTC_USER_LIST').bigValue.split(',').contains(username)) &&ctcCrfInstance.dateSubmitted}">
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="resume" value="Resume Editing"/></span>
                </div>
                </g:if>
            </g:form>
        </div>
    </body>
</html>
