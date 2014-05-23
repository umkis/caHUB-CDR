
<%@ page import="nci.obbr.cahub.datarecords.ctc.PatientRecord" %>
<g:set var="bodyclass" value="patientrecord list" scope="request"/>
<html>
    <head>
        <meta name="layout" content="cahubTemplate"/>
         <g:set var="entityName" value="CTC Patient Record" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
      <div id="nav" class="clearfix">
          <div id="navlist">
            <a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
            <g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link>
        </div>
      </div>
      <div id="container" class="clearfix">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}"
           default="${flash.default}"/></div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                      <tr ><th class="ctcpatient-thtag" colspan="10">CTC Patient List</th></tr>
                        <tr>
                        
                                                                       
                            <g:sortableColumn property="patientId" title="${message(code: 'patientRecordInstance.patientId.label', default: 'Patient ID')}" />
                             <th>Case Status</th>
                        
                            <g:sortableColumn property="gender" title="${message(code: 'patientRecordInstance.gender.label', default: 'Gender')}" />
                        
                            <g:sortableColumn property="visit" title="${message(code: 'patientRecordInstance.visitCount.label', default: 'Visit Count')}" />
                        
                            <g:sortableColumn property="disease" title="${message(code: 'patientRecordInstance.disease.label', default: 'Disease')}" />
                            
                            <g:sortableColumn property="cancerStage" title="${message(code: 'patientRecordInstance.cancerStage.label', default: 'Cancer Stage')}" />
                             <g:sortableColumn property="experiment" title="${message(code: 'patientRecordInstance.experiment.label', default: 'Experiment')}" />
                            <g:sortableColumn property="collectionSite" title="${message(code: 'patientRecordInstance.collectionSite.label', default: 'Collection Site')}" />                                   
                           
                             <g:sortableColumn property="dateCreated" title="Date Created" />
                            <th> Action </th>
                        
                            
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${patientRecordInstanceList}" status="i" var="patientRecordInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                      <g:if test="${patientRecordInstance.caseRecord?.id}">
                        <td>
                          <g:displayCaseRecordLink caseRecord="${patientRecordInstance.caseRecord}" session="${session}"/>
                          %{-- <g:link controller="caseRecord" action="display" id="${patientRecordInstance.caseRecord?.id}">${patientRecordInstance.patientId}</g:link> --}%
                        </td>
                        <td>Data Entry underway</td>
                       </g:if>
                        <g:else> 
                            <td> ${patientRecordInstance.patientId}</td>
                             <td>  &nbsp; </td> 
                        </g:else>
                                                 
                            <td>${fieldValue(bean: patientRecordInstance, field: "gender")}</td>
                        
                            <td>${fieldValue(bean: patientRecordInstance, field: "visit")}</td>
                        
                            <td>${fieldValue(bean: patientRecordInstance, field: "disease")}</td>
                            <td>${fieldValue(bean: patientRecordInstance, field: "cancerStage")}</td>
                             <td>${fieldValue(bean: patientRecordInstance, field: "experiment")}</td>
                                             
                            <td>${fieldValue(bean: patientRecordInstance, field: "collectionSite")}</td>
                            <td>${fieldValue(bean: patientRecordInstance, field: "dateCreated")}</td>
                            <td nowrap>
    <g:link class="ui-button ui-state-default ui-corner-all removepadding borderless" title="view" controller="patientRecord" action="show" id="${patientRecordInstance.id}"><span class="ui-icon ui-icon-table">View</span></g:link>
   <g:if test="${!patientRecordInstance.dateSubmitted}">
    <g:link class="ui-button ui-state-default ui-corner-all removepadding borderless" title="edit" controller="patientRecord" action="edit" id="${patientRecordInstance?.id}" ><span class="ui-icon ui-icon-pencil">Edit</span></g:link>
   </g:if>
  
  </td>       
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${patientRecordInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
