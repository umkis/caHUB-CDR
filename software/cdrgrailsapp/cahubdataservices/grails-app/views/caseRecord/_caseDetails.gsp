
<%@ page import="nci.obbr.cahub.datarecords.ctc.*" %>
<table>
    <tbody>
        <tr class="prop"><td colspan="8"><h2>Case Details</h2></td></tr>
        <tr class="prop">
            <td valign="top">
              <div class="clearfix">
                 <g:if test="${session.study?.code != 'CTC'}">
                   <dl class="formdetails left">
                     <dt>Case ID:</dt>
                     <dd>
                       <g:displayCaseRecordLink caseRecord="${caseRecord}" session="${session}" />
                       %{--<g:link controller="caseRecord" action="display" id="${caseRecord.id}">${caseRecord.caseId}</g:link> --}%
                     </dd>
                   </dl>
                 </g:if>
                <g:else>
                   <dl class="formdetails left">
                     <dt>Case ID:</dt>
                     <dd>
                       <g:displayCaseRecordLink caseRecord="${caseRecord}" session="${session}" action="accessCtc" />
                       %{-- <g:link controller="caseRecord" action="accessCtc" id="${caseRecord.id}">${caseRecord.caseId}</g:link> --}%
                     </dd>
                   </dl>
                </g:else>
                <g:if test="${session.study?.code == 'BPV' || session.study?.code == 'BRN'}">
                    <dl class="formdetails left"><dt>Primary Organ:</dt><dd>${caseRecord.primaryTissueType}</dd></dl>
                </g:if>
                <g:elseif test="${session.study?.code == 'GTEX' || session.study?.code == 'BMS'}">
                    <dl class="formdetails left"><dt>Collection Type:</dt><dd>${caseRecord.caseCollectionType}</dd></dl>
                </g:elseif>
                <dl class="formdetails left"><dt>BSS:</dt><dd>${caseRecord.bss.name}</dd></dl>
                <g:if test="${session.study?.code == 'BPV' || session.study?.code == 'BRN'}">
                    <dl class="formdetails left"><dt>Tissue Bank ID:</dt><dd>${caseRecord.tissueBankId}</dd></dl>
                </g:if>
                <g:if test="${session.study?.code == 'CTC' && PatientRecord.findByCaseRecord(caseRecord).experiment=='VC'}">
                  <dl class="formdetails left"><dt>Experimental:</dt><dd>Veridex Comparison</dd></dl>
                </g:if>
                <g:if test="${session.study?.code == 'CTC' && PatientRecord.findByCaseRecord(caseRecord).experiment=='BTBT'}">
                  <dl class="formdetails left"><dt>Experimental:</dt><dd>Best Tube Best Timepoint</dd></dl>
                </g:if>
              </div>
            </td>
        </tr>      
    </tbody>
</table>
