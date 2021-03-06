

  <table>
         <tr><td class="name">Select Priority<span id="bpvworksheet.priority" class="vocab-tooltip"></span></td><td class="value ${hasErrors(bean: module1SheetInstance, field: 'priority', 'errors')}"><div><g:radio id ="p1" name="priority1"  value="1" checked="${module1SheetInstance.priority ==1}"  />&nbsp;<label for="p1">Priority I</label><br /><g:radio id ="p2" name="priority1"  value="2" checked="${module1SheetInstance.priority ==2}"  />&nbsp;<label for="p2">Priority II</label></div></td></tr>
       </table>
<g:if test ="${bpvWorkSheetInstance.caseRecord.primaryTissueType.code=='OVARY'}">
       <table>
         <tr><td class="name">Module I tissue was collected from:<span id="bpvworksheet.moduletissuefrom" class="vocab-tooltip"></span></td><td class="value ${hasErrors(bean: module1SheetInstance, field: 'whichOvary', 'errors')}"><div><g:radio id ="l" name="whichOvary1"  value="L" checked="${module1SheetInstance.whichOvary =='L'}"  />&nbsp;<label for="l">Left Ovary</label><br /><g:radio id ="r" name="whichOvary1"  value="R" checked="${module1SheetInstance.whichOvary =='R'}"  />&nbsp;<label for="r">Right Ovary</label></div></td></tr>
       </table>
      </g:if>
<table border="0">
  <tbody>
    <tr><th colspan="2">MODULE 1: Frozen Tissue Sample Information - (Middle Right) of Tumor Block</th></tr>
    <tr class="prop">
      <td  valign="top" class="name" style="width:30%">Barcode ID of frozen tumor tissue cryosette:<span id="bpvworksheet.barcodeidcryosette" class="vocab-tooltip"></span></td>
      <td class="${errorMap.get("sampleId4Frozen_" +module1SheetInstance.sampleFr.id)}"><g:textField class="recorddate" name="sampleId4Frozen_${module1SheetInstance.sampleFr.id}" value="${module1SheetInstance.sampleFr.sampleId4Frozen}" /></td>
</tr>
<tr class="prop">
  <td  valign="top" class="name" >Date/Time the tissue sample was frozen in liquid nitrogen:<span id="bpvworksheet.datefrozenliquidnitrogen" class="vocab-tooltip"></span></td>

  <td> 

<g:if test="${session.LDS == true}">
${module1SheetInstance.sampleFr.dateSampleFrozenStr}
</g:if>
<g:if test="${session.LDS == false || session.LDS == null}">
  <span class="redactedMsg">REDACTED (No LDS privilege)</span>
</g:if>
</td>

</tr>

<tr class="prop">
  <td valign="top" class="name">
    <label for="sampleFrWeight">Weight of frozen tumor block: </label>
  </td>
  <td valign="top" class="value">
<g:textField  name="weight_${module1SheetInstance?.sampleFr?.id}" value="${module1SheetInstance?.sampleFr?.weight}" /> mg
</td>
</tr>

</tbody>
</table>


<table border="0">
  <tr><th colspan="7">Module I: <1 Hour Planned Delay to Fixation Experimental Protocol A-D AND QC FFPE (Middle Left) Section</th></tr>
  <tr>
    <th>Experimental Protocol A-D AND QC FFPE (Middle Left) Section</th>
    <th>Planned Delay to Fixation Time</th>
    <th>Scanned ID of cassette: Record first scan</th>
    <th>Date/Time That Cassette Was First Scanned Or Recorded</th>
    <th>Scanned ID of cassette: Record when placed in fixative</th>
    <th>Date/Time That Cassette Was Placed In Fixative</th>
    <th>Delay to Fixation Time (HH:MM)</th>
  </tr>
  <g:each in="[module1SheetInstance.sampleQc, module1SheetInstance.sampleA, module1SheetInstance.sampleB, module1SheetInstance.sampleC, module1SheetInstance.sampleD]" status="i" var="s">
    <tr id="${s.protocolId}">
      <td>${s.protocol}</td>
      <td>${s.plannedDelay}</td>
      <td class='${errorMap.get("sampleId4Record_" +s.id)}'><g:textField class="recorddate" name="sampleId4Record_${s.id}" value="${s.sampleId4Record}" size="15" /></td>

    <td> 

    <g:if test="${session.LDS == true}">
${s.dateSampleRecordedStr}
    </g:if>
    <g:if test="${session.LDS == false || session.LDS == null}">
      <span class="redactedMsg">REDACTED (No LDS privilege)</span>
    </g:if>
    </td>

    <td class="${errorMap.get("sampleId4Fixative_" +s.id)}"><g:textField class="recorddate"  name="sampleId4Fixative_${s.id}" value="${s.sampleId4Fixative}" size="15" /></td>

    <td> 

    <g:if test="${session.LDS == true}">
${s.dateSampleInFixativeStr}
    </g:if>
    <g:if test="${session.LDS == false || session.LDS == null}">
      <span class="redactedMsg">REDACTED (No LDS privilege)</span>
    </g:if>
    </td>

    <g:if test="${i==0}">
      <td><span id="in1_${s.id}">${intervalMap1.get('interval1_' + s.id)}</span></td>
    </g:if>
    <g:else>
      <td class="${warningMap?.get('interval1_' + s.id) ? 'warnings' : ''}"><span id="in1_${s.id}">${intervalMap1.get('interval1_' + s.id)}</span></td>
    </g:else>
    </tr>
  </g:each>
</table>

<table border="0">
  <tr><th colspan="10">Module I: <1 Hour Planned Delay to Fixation Experimental Protocol A-D AND QC FFPE (Middle Left) Section.<br />Continue entering data for Protocol A-D cassettes and QC FFPE Section</th></tr>
  <tr>
    <th>Experimental Protocol A-D AND QC FFPE (Middle Left) Section</th>
    <th>Scanned ID of cassette: Record when placed in tissue processor</th>
    <th>Date/Time Cassette Was Placed in Processor</th>                      
    <th>Date/Time Tissue Processor Cycle Ended</th>
    <th>Actual Time in Fixative (HH:MM)</th>
    <th>Scanned ID of cassette: Record when removed from tissue processor</th>
    <th>Date/Time Tissue Cassettes Were Removed From Tissue Processor</th>
    <th>Scanned ID of cassette: Record when tissue embedding was started</th>
    <th>Date/Time Tissue Embedding Was Started</th>
    <th>Time between Tissue Processor Cycle Completion and Embedding (HH:MM)</th>
  </tr>
  <g:each in="[module1SheetInstance.sampleQc, module1SheetInstance.sampleA, module1SheetInstance.sampleB, module1SheetInstance.sampleC, module1SheetInstance.sampleD]" status="i" var="s">
    <tr id="${s.protocolId}">
      <td>${s.protocol}</td>
      <td class="${errorMap.get("sampleId4Proc_" +s.id)}"><g:textField class="recorddate" name="sampleId4Proc_${s.id}" value="${s.sampleId4Proc}" size="15" /></td>

    <td> 

    <g:if test="${session.LDS == true}">
${s.dateSampleInProcStr}
    </g:if>
    <g:if test="${session.LDS == false || session.LDS == null}">
      <span class="redactedMsg">REDACTED (No LDS privilege)</span>
    </g:if>
    </td>


    <td> 

    <g:if test="${session.LDS == true}">
${s.dateSampleProcEndStr}
    </g:if>
    <g:if test="${session.LDS == false || session.LDS == null}">
      <span class="redactedMsg">REDACTED (No LDS privilege)</span>
    </g:if>
    </td>



    <g:if test="${i==0}">
      <td><span id="in2_${s.id}">${intervalMap1.get('interval2_' + s.id)}</span></td>
    </g:if>
    <g:else>
      <td class="${warningMap?.get('interval2_' + s.id) ? 'warnings' : ''}"><span id="in2_${s.id}">${intervalMap1.get('interval2_' + s.id)}</span></td>
    </g:else>

    <td class='${errorMap.get("sampleId4Removal_" +s.id)}'><g:textField class="recorddate" name="sampleId4Removal_${s.id}" value="${s.sampleId4Removal}" size="15" /></td>
   
    <td> 

    <g:if test="${session.LDS == true}">
${s.dateSampleRemovedStr}
    </g:if>
    <g:if test="${session.LDS == false || session.LDS == null}">
      <span class="redactedMsg">REDACTED (No LDS privilege)</span>
    </g:if>
    </td>
    
    <td class='${errorMap.get("sampleId4Embedding_" +s.id)}'><g:textField class="recorddate" name="sampleId4Embedding_${s.id}" value="${s.sampleId4Embedding}" size="15" /></td>
   
    
    <td> 

    <g:if test="${session.LDS == true}">
${s.dateSampleEmbStartedStr}
    </g:if>
    <g:if test="${session.LDS == false || session.LDS == null}">
      <span class="redactedMsg">REDACTED (No LDS privilege)</span>
    </g:if>
    </td>
    
    
    <g:if test="${i==0}">
      <td><span id="in3_${s.id}">${intervalMap1.get('interval3_' + s.id)}</span></td>
    </g:if>
    <g:else>
      <td><span id="in3_${s.id}">${intervalMap1.get('interval3_' + s.id)}</span></td>
    </g:else>
    </tr>
  </g:each>

</table>

