<%@ page import="nci.obbr.cahub.util.AppSetting" %>
<%@ page import="nci.obbr.cahub.datarecords.CaseRecord" %>
<%@ page import="nci.obbr.cahub.ldacc.Donor" %>
<%@ page import="nci.obbr.cahub.util.FileUpload" %>
<%@ page import="nci.obbr.cahub.datarecords.ShippingEvent" %>
<%@ page import="nci.obbr.cahub.forms.ctc.CtcCrf" %>


            <div class="dialog">
                <table class="nowrap">
                    <tbody>
                        <tr class="prop toptable">
                          <td valign="top" class="name">Case ID:</td>
                          <td valign="top" class="value">${caseRecordInstance.caseId}</td>
                        </tr>
                        <tr class="prop toptable">
                          <td valign="top" class="name">Case Status:</td>
                          <td valign="top" class="value" ><span class="ca-tooltip-nobg" data-msg="<b>${caseRecordInstance.caseStatus}</b>. ${caseRecordInstance.caseStatus.description}">${caseRecordInstance.caseStatus}</span>                             
                               <g:if test="${session.authorities.contains('ROLE_NCI-FREDERICK_CAHUB_SUPER') || session.authorities.contains('ROLE_ADMIN') ||  AppSetting.findByCode('CTC_USER_LIST').bigValue.split(',').contains(username)}"><g:link controller="caseRecord" action="changeCtcStatus" id="${caseRecordInstance?.id}">(Change)</g:link></g:if></td>
                        </tr>
                        <tr class="prop toptable">
                          <td valign="top" class="name">BSS:</td>
                          <td valign="top" class="value">${caseRecordInstance?.bss.name} (${caseRecordInstance?.bss.code})</td>
                       </tr>
                        <tr class="prop toptable">
                            <td valign="top" class="name">Study:</td>
                            <td valign="top" class="value">${caseRecordInstance.study}</td>
                        </tr>
                        <tr class="prop toptable">
                            <td valign="top" class="name"><g:message code="caseRecord.lastUpdated.label" default="Last Updated:" /></td>
                            <td valign="top" class="value"><g:formatDate date="${caseRecordInstance?.lastUpdated}" /></td>
                        </tr>
                        <tr class="prop toptable">
                            <td valign="top" class="name"><g:message code="caseRecord.dateCreated.label" default="Date Created:" /></td>
                            <td valign="top" class="value"><g:formatDate date="${caseRecordInstance?.dateCreated}" /></td>
                        </tr>
                        <tr class="prop toptable">
                            <td valign="top" class="name"><g:message code="caseRecord.internalComments.label" default="Comments:" /></td>
                            <td valign="top" class="value">${fieldValue(bean: caseRecordInstance, field: "internalComments")}</td>
                        </tr>
                       
                        <g:if test="${session.authorities.contains('ROLE_NCI-FREDERICK_CAHUB_SUPER') || session.authorities.contains('ROLE_ADMIN') ||  AppSetting.findByCode('CTC_USER_LIST').bigValue.split(',').contains(username)}">
                        <tr class="prop toptable">
                             <g:if test="${ctc_patient_visits.equals('One')}">
                            <td valign="top" class="name">Blood Sample CRF:</td>
                           </g:if>
                           <g:else>
                              <td valign="top" class="name">Blood Sample CRF for The First Visit:</td>
                           </g:else>
                        <g:if test="${CtcCrf.findByCaseRecordAndWhichVisit(caseRecordInstance, 1) && CtcCrf.findByCaseRecordAndWhichVisit(caseRecordInstance, 1).dateSubmitted }">
                            <td valign="top" class="value"> <a href="/cahubdataservices/ctcCrf/view/${CtcCrf.findByCaseRecordAndWhichVisit(caseRecordInstance, 1).id}">View </a></td>
                        </g:if>
                         <g:elseif test="${CtcCrf.findByCaseRecordAndWhichVisit(caseRecordInstance, 1) && !CtcCrf.findByCaseRecordAndWhichVisit(caseRecordInstance, 1).dateSubmitted && !caseRecordInstance.patientRecord.dateSubmitted }">
                             <td valign="top" class="value"> <a href="/cahubdataservices/ctcCrf/view/${CtcCrf.findByCaseRecordAndWhichVisit(caseRecordInstance, 1).id}">View </a></td>
                         </g:elseif>
                         <g:elseif test="${CtcCrf.findByCaseRecordAndWhichVisit(caseRecordInstance, 1) && !CtcCrf.findByCaseRecordAndWhichVisit(caseRecordInstance, 1).dateSubmitted && caseRecordInstance.patientRecord.dateSubmitted }">
                          <td valign="top" class="value"> <a href="/cahubdataservices/ctcCrf/edit/${CtcCrf.findByCaseRecordAndWhichVisit(caseRecordInstance, 1).id}">Edit </a> |
                            <a href="/cahubdataservices/ctcCrf/view/${CtcCrf.findByCaseRecordAndWhichVisit(caseRecordInstance, 1).id}">View </a>
                          </td>
                            </g:elseif>
                        <g:else>
                          <g:if test="${caseRecordInstance.patientRecord.dateSubmitted}">
                            <td valign="top" class="value"> <a href="/cahubdataservices/ctcCrf/create?caseRecord.id=${caseRecordInstance?.id}&whichVisit=1">Add</a></td>
                          </g:if>
                          <g:else>
                             <td valign="top" class="value"> &nbsp;</td>
                          </g:else>
                        </g:else>
                        </tr>
                        
                       <g:if test="${ctc_patient_visits.equals('Two') || ctc_patient_visits.equals('Three')}">
                          <tr class="prop toptable">
                              <td valign="top" class="name">Blood Sample CRF for The Second Visit:</td>
                        <g:if test="${CtcCrf.findByCaseRecordAndWhichVisit(caseRecordInstance, 2) && CtcCrf.findByCaseRecordAndWhichVisit(caseRecordInstance, 2).dateSubmitted  }">
                            <td valign="top" class="value"> <a href="/cahubdataservices/ctcCrf/view/${CtcCrf.findByCaseRecordAndWhichVisit(caseRecordInstance, 2).id}">View</a></td>
                        </g:if>
                        <g:elseif test="${CtcCrf.findByCaseRecordAndWhichVisit(caseRecordInstance, 2) && !CtcCrf.findByCaseRecordAndWhichVisit(caseRecordInstance, 2).dateSubmitted && !caseRecordInstance.patientRecord.dateSubmitted }">
                             <td valign="top" class="value"> <a href="/cahubdataservices/ctcCrf/view/${CtcCrf.findByCaseRecordAndWhichVisit(caseRecordInstance, 2).id}">View</a></td>
                         </g:elseif>
                          <g:elseif test="${CtcCrf.findByCaseRecordAndWhichVisit(caseRecordInstance, 2) && !CtcCrf.findByCaseRecordAndWhichVisit(caseRecordInstance, 2).dateSubmitted  && caseRecordInstance.patientRecord.dateSubmitted }">
                          <td valign="top" class="value"> <a href="/cahubdataservices/ctcCrf/edit/${CtcCrf.findByCaseRecordAndWhichVisit(caseRecordInstance, 2).id}">Edit </a> |
                            <a href="/cahubdataservices/ctcCrf/view/${CtcCrf.findByCaseRecordAndWhichVisit(caseRecordInstance, 2).id}">View </a>
                          </td>
                            </g:elseif>
                          
                        <g:else>
                           <g:if test="${caseRecordInstance.patientRecord.dateSubmitted}">
                            <td valign="top" class="value"> <a href="/cahubdataservices/ctcCrf/create?caseRecord.id=${caseRecordInstance?.id}&whichVisit=2">Add </a></td>
                           </g:if>
                          <g:else>
                            <td valign="top" class="value"> &nbsp;</td>
                          </g:else>
                        </g:else>
                        </tr>
                         
                       </g:if>
                        
                        <g:if test="${ctc_patient_visits.equals('Three')}">
                          <tr class="prop toptable">
                              <td valign="top" class="name">Blood Sample CRF for The Third Visit:</td>
                        <g:if test="${CtcCrf.findByCaseRecordAndWhichVisit(caseRecordInstance, 3) && CtcCrf.findByCaseRecordAndWhichVisit(caseRecordInstance, 3).dateSubmitted  }">
                            <td valign="top" class="value"> <a href="/cahubdataservices/ctcCrf/view/${CtcCrf.findByCaseRecordAndWhichVisit(caseRecordInstance, 3).id}">View</a></td>
                        </g:if>
                        <g:elseif test="${CtcCrf.findByCaseRecordAndWhichVisit(caseRecordInstance, 3) && !CtcCrf.findByCaseRecordAndWhichVisit(caseRecordInstance, 3).dateSubmitted && !caseRecordInstance.patientRecord.dateSubmitted }">
                             <td valign="top" class="value"> <a href="/cahubdataservices/ctcCrf/view/${CtcCrf.findByCaseRecordAndWhichVisit(caseRecordInstance, 3).id}">View</a></td>
                         </g:elseif>
                          <g:elseif test="${CtcCrf.findByCaseRecordAndWhichVisit(caseRecordInstance, 3) && !CtcCrf.findByCaseRecordAndWhichVisit(caseRecordInstance, 3).dateSubmitted  && caseRecordInstance.patientRecord.dateSubmitted }">
                          <td valign="top" class="value"> <a href="/cahubdataservices/ctcCrf/edit/${CtcCrf.findByCaseRecordAndWhichVisit(caseRecordInstance, 3).id}">Edit </a> |
                            <a href="/cahubdataservices/ctcCrf/view/${CtcCrf.findByCaseRecordAndWhichVisit(caseRecordInstance, 3).id}">View </a>
                          </td>
                            </g:elseif>
                          
                        <g:else>
                           <g:if test="${caseRecordInstance.patientRecord.dateSubmitted}">
                            <td valign="top" class="value"> <a href="/cahubdataservices/ctcCrf/create?caseRecord.id=${caseRecordInstance?.id}&whichVisit=3">Add </a></td>
                           </g:if>
                          <g:else>
                            <td valign="top" class="value"> &nbsp;</td>
                          </g:else>
                        </g:else>
                        </tr>
                         
                       </g:if>
                    </g:if> 
                     <g:else>
                       
                       <tr class="prop toptable">
                             <g:if test="${ctc_patient_visits.equals('One')}">
                            <td valign="top" class="name">Blood Sample CRF:</td>
                           </g:if>
                           <g:else>
                              <td valign="top" class="name">Blood Sample CRF for The First Visit:</td>
                           </g:else>
                        <g:if test="${CtcCrf.findByCaseRecordAndWhichVisit(caseRecordInstance, 1)}">
                            <td valign="top" class="value"> <a href="/cahubdataservices/ctcCrf/view/${CtcCrf.findByCaseRecordAndWhichVisit(caseRecordInstance, 1).id}">View </a></td>
                        </g:if>
                          <g:else>
                             <td valign="top" class="value"> No</td>
                          </g:else>
                        </tr>
                        <g:if test="${ctc_patient_visits.equals('Two') || ctc_patient_visits.equals('Three')}">
                          
                           <tr class="prop toptable">
                              <td valign="top" class="name">Blood Sample CRF for The Second Visit:</td>
                              <g:if test="${CtcCrf.findByCaseRecordAndWhichVisit(caseRecordInstance, 2)}">
                                  <td valign="top" class="value"> <a href="/cahubdataservices/ctcCrf/view/${CtcCrf.findByCaseRecordAndWhichVisit(caseRecordInstance, 2).id}">View</a></td>
                              </g:if>

                          <g:else>
                            <td valign="top" class="value"> No</td>
                          </g:else>
                      
                        </g:if>
                        
                        <g:if test="${ctc_patient_visits.equals('Three')}">
                          
                           <tr class="prop toptable">
                              <td valign="top" class="name">Blood Sample CRF for The Third Visit:</td>
                              <g:if test="${CtcCrf.findByCaseRecordAndWhichVisit(caseRecordInstance, 3)}">
                                  <td valign="top" class="value"> <a href="/cahubdataservices/ctcCrf/view/${CtcCrf.findByCaseRecordAndWhichVisit(caseRecordInstance, 3).id}">View</a></td>
                              </g:if>

                          <g:else>
                            <td valign="top" class="value"> No</td>
                          </g:else>
                      
                        </g:if>
                       
                     </g:else>
                        
                        <tr class="prop toptable">
                            <td valign="top" class="name">Patient Visits:</td>
                            <td valign="top" class="value">${ctc_patient_visits}</td>
                        </tr>
                       
                  <%--      <tr class="prop"><td valign="top" class="name formheader" colspan="3">Uploaded Files:</td></tr>
                        <tr>
                          <td valign="top" class="value" colspan="3"><g:if test="${FileUpload.findAll('from FileUpload as f where f.caseId=?', [caseRecordInstance?.caseId])}">
                                    <div class="list">
                                        <table>
                                            <thead>
                                                <tr>
                                                  <th>File Name</th>
                                                  <th class="dateentry">Date Uploaded</th>
                                                  <th>Comments</th>
                                                  <g:if test="${session.DM}"><th></th></g:if>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <g:each in="${FileUpload.findAll('from FileUpload as f where f.caseId=?', [caseRecordInstance?.caseId])}" status="i" var="fileUploadInstance">
                                                    <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                                                        <td><g:link controller="fileUpload" action="download" id="${fileUploadInstance.id}">${fileUploadInstance.fileName}</g:link></td>
                                                        <td><nobr>${fileUploadInstance.uploadTime}</nobr></td>
                                                        <td class="unlimitedstr"><div>${fieldValue(bean: fileUploadInstance, field: "comments")}</div></td>
                                                        <g:if test="${session.DM}"><td><g:link controller="fileUpload" action="remove" id="${fileUploadInstance.id}" onclick="return confirm('Are you sure to remove the file?')">Remove</g:link></td></g:if>
                                                    </tr>
                                                </g:each>
                                            </tbody>
                                        </table>
                                    </div>
                                </g:if>
                                <g:if test="${session.DM}">
                                    <a class="uibutton" href="/cahubdataservices/fileUpload/create?caseRecord.id=${caseRecordInstance.id}" title="Upload case documents" />
                                        <span class="ui-icon ui-icon-circle-arrow-n"></span>Upload
                                    </a>
                                </g:if>
                            </td>
                        </tr>--%>
                        
            <tr class="prop"><td valign="top" class="name formheader" colspan="2">Specimens (${caseRecordInstance.specimens.size()}):</td></tr>
            <tr>
                <td valign="top" class="value" colspan="2"><div class="list">
                    <table class="nowrap">
                        <thead>
                            <tr>
                              <th>Specimen Id</th>
                              <th>Tissue Type</th>
                              <th>Treatment Group</th>  
                              <th>Fixative</th>
                            </tr>
                        </thead>
                        <tbody>
                        <g:each in="${caseRecordInstance.specimens}" status="i" var="s">
                            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                                <td class="itemid">${s.specimenId}</td>
                                <td>${s.tissueType}</td>
                                <td>${s.protocol?.name}</td>
                                <td>${s.fixative}</td>
                            </tr>
                        </g:each>
                        </tbody>
                    </table></div>
                </td>
           </tr>
          </tbody>
        </table>
    </div>

