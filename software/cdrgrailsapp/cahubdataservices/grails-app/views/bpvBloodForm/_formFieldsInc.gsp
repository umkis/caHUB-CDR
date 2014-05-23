<%@ page import="nci.obbr.cahub.staticmembers.SOP" %>           
<%  def labelNumber = 1%>
<g:render template="/formMetadata/timeConstraint" bean="${bpvBloodFormInstance.formMetadata}" var="formMetadata"/>
<g:render template="/caseRecord/caseDetails" bean="${bpvBloodFormInstance.caseRecord}" var="caseRecord" />
    <div class="list" >
            <div id="bloodform-tabs">
                <ul id="tabs-list"></ul>
                <div id="tabs-main" class="tabbed-content">
                  <h3>Blood Collection</h3>           
                  <table class="tab-table dec12table ${bpvBloodFormInstance.caseRecord?.primaryTissueType?.code=="LUNG" && version53 == true ?"islung":""}">
                    <tbody>
                      <tr class="prop topsection">
                        <td class="name"><label for="bloodSop">${labelNumber++}. <g:message code="bpvBloodForm.bloodSop.label" default="Blood Collection and Processing SOP:" /></label></td>
                        <td class="value">
                          <g:if test="${params.action == 'create'}">
                            ${bpvBloodFormInstance?.formMetadata?.sops?.get(0)?.sopNumber}
                            ${bpvBloodFormInstance?.formMetadata?.sops?.get(0)?.sopName}  
                            ${bpvBloodFormInstance?.formMetadata?.sops?.get(0)?.activeSopVer}
                          </g:if><g:else>
                            ${bpvBloodFormInstance?.collectProcessSOP?.sopNumber}
                            ${SOP.get(bpvBloodFormInstance?.collectProcessSOP?.sopId)?.sopName}
                            ${bpvBloodFormInstance?.collectProcessSOP?.sopVersion}
                          </g:else>
                        </td>
                      </tr> 
                      <tr class="prop topsection">
                        <td class="name">
                          ${labelNumber++}. The minimum requirement for blood collection was met as per the SOP:
                          <div>
                            <div class="message left">
                              <strong>PLEASE NOTE:</strong>
                              <p>The minimum requirement is (1)  DNA PAXgene blood tube with 7mL blood and (1) RNA PAXgene blood tube with 2.0 mL blood, however the desired volume of blood to be collected in PAXgene Blood DNA  tube is 8.5 mL and PAXgene Blood RNA tube is 2.5 mL.  If the minimum requirement for pre-operative blood collection as specified in the SOP was not met, this participant is <strong>NOT ELIGIBLE</strong> to continue in the study. Do not collect tissue from this participant.</p>
                            </div><div class="clear"></div>
                          </div>
                         </td>
                         <td class="value ${hasErrors(bean: bpvBloodFormInstance, field: 'bloodMinimum', 'errors')}"><g:bpvYesNoRadioPicker checked="${(bpvBloodFormInstance?.bloodMinimum)}"  name="bloodMinimum" /></td>
                      </tr><tr class="prop bottomsection">
                        <td class="name"><label for="bloodDrawType">${labelNumber++}. Blood draw type:</label></td>
                        <td class="value ${hasErrors(bean: bpvBloodFormInstance, field: 'bloodDrawType', 'errors')}"><g:select name="bloodDrawType" from="${['Pre-operative (Pre Anesthesia)', 'Other (specify)']}" onchange="showhideOthDT()" value="${bpvBloodFormInstance?.bloodDrawType}" noSelection="['': '']" /></td>
                      </tr><tr id="bloodDrawTypeOsRow" class="bottomsection">
                        <td class="name"></td>
                        <td class="value ${hasErrors(bean: bpvBloodFormInstance, field: 'bloodDrawTypeOs', 'errors')}"><g:textField name="bloodDrawTypeOs" value="${bpvBloodFormInstance?.bloodDrawTypeOs}" /></td>
                      </tr><tr id="dateTimeBloodDrawRow" class="prop bottomsection">
                        <td class="name"><label for="dateTimeBloodDraw">${labelNumber++}. Date and time blood was drawn:</label></td>
                        <td class="value ${hasErrors(bean: bpvBloodFormInstance, field: 'dateTimeBloodDraw', 'errors')}"><g:jqDateTimePicker LDSOverlay="${bodyclass ?: ''}" name="dateTimeBloodDraw" precision="day" value="${bpvBloodFormInstance?.dateTimeBloodDraw}" default="none" noSelection="['': '']" /></td>
                      </tr>
                      <tr class="prop bottomsection">
                        <td class="name"><label for="bloodDrawNurse">${labelNumber++}. Blood draw was performed by:</label></td>
                        <td class="value ${hasErrors(bean: bpvBloodFormInstance, field: 'bloodDrawNurse', 'errors')}"><g:select name="bloodDrawNurse" from="${nci.obbr.cahub.forms.bpv.BpvBloodForm$BloodDrawTech?.values()}" onchange="showhideOthNurse();showhideBloodNurseName()" keys="${nci.obbr.cahub.forms.bpv.BpvBloodForm$BloodDrawTech?.values()*.name()}" value="${bpvBloodFormInstance?.bloodDrawNurse?.name()}" noSelection="['': '']" /></td>
                      </tr><tr id="bloodDrawNurseOsRow" class="bottomsection">
                        <td class="name"></td>
                        <td class="value ${hasErrors(bean: bpvBloodFormInstance, field: 'bloodDrawNurseOs', 'errors')}"><g:textField name="bloodDrawNurseOs" value="${bpvBloodFormInstance?.bloodDrawNurseOs}" /></td>
                      </tr><tr id="bloodDrawNurseNameRow" class="bottomsection">
                        <td class="name"><label for="bloodDrawNurseName">Name:</label></td>
                        <td class="value ${hasErrors(bean: bpvBloodFormInstance, field: 'bloodDrawNurseName', 'errors')}"><g:textField name="bloodDrawNurseName" value="${bpvBloodFormInstance?.bloodDrawNurseName}" /></td>
                      </tr>
                      <tr id ="second-blood-draw" class="prop D2-draw bottomsection"><td colspan="2"><g:checkBox name="bloodDraw2" id="bloodDraw2" value="${(bpvBloodFormInstance?.dateTimeBloodDraw2 == null || bpvBloodFormInstance?.dateTimeBloodDraw2 == '') && (bpvBloodFormInstance?.bloodDrawNurse2 == null || bpvBloodFormInstance?.bloodDrawNurse2 == '') && (bpvBloodFormInstance?.bloodDrawNurseOs2 == null || bpvBloodFormInstance?.bloodDrawNurseOs2 == '') && (bpvBloodFormInstance?.bloodDrawNurseName2 == null || bpvBloodFormInstance?.bloodDrawNurseName2 == '')? '': 'checked'}" class="checkBxLabelRight" /><label class="namelabel" for="bloodDraw2">Check here for Second Blood Draw if any.</label><span id="checkboxinstr"></td></tr>
                      <tr class="subentry prop D2-draw depends-on bottomsection" data-id="bloodDraw2">
                        <td class="name"><label for="dateTimeBloodDraw2">Second date and time blood was drawn:</label></td>
                        <td class="value ${hasErrors(bean: bpvBloodFormInstance, field: 'dateTimeBloodDraw2', 'errors')}"><g:jqDateTimePicker LDSOverlay="${bodyclass ?: ''}" name="dateTimeBloodDraw2" precision="day" value="${bpvBloodFormInstance?.dateTimeBloodDraw2}" default="none" noSelection="['': '']" /></td>
                      </tr><tr class="subentry prop D2-draw depends-on bottomsection" data-id="bloodDraw2">
                        <td class="name"><label for="bloodDrawNurse2">Second blood draw was performed by:</label></td>
                        <td class="value ${hasErrors(bean: bpvBloodFormInstance, field: 'bloodDrawNurse2', 'errors')}"><g:select name="bloodDrawNurse2" id="bloodDrawNurse2" from="${nci.obbr.cahub.forms.bpv.BpvBloodForm$BloodDrawTech?.values()}" keys="${nci.obbr.cahub.forms.bpv.BpvBloodForm$BloodDrawTech?.values()*.name()}" value="${bpvBloodFormInstance?.bloodDrawNurse2?.name()}" noSelection="['': '']" /></td>
                      </tr><tr id="bloodDrawNurseOsRow2" class="subentry D2-draw depends-on"  data-id="bloodDrawNurse2" data-select="OtherSpecify">
                        <td class="name"></td>
                        <td class="value ${hasErrors(bean: bpvBloodFormInstance, field: 'bloodDrawNurseOs2', 'errors')}"><g:textField name="bloodDrawNurseOs2" value="${bpvBloodFormInstance?.bloodDrawNurseOs2}" class="dependent-clear"/></td>
                      </tr><tr id="bloodDrawNurseNameRow2" class="subentry D2-draw depends-on bottomsection" data-id="bloodDraw2">
                        <td class="name"><label for="bloodDrawNurseName2">Name:</label></td>
                        <td class="value ${hasErrors(bean: bpvBloodFormInstance, field: 'bloodDrawNurseName2', 'errors')}"><g:textField name="bloodDrawNurseName2" value="${bpvBloodFormInstance?.bloodDrawNurseName2}" /></td>
                      </tr><tr class="prop bottomsection">
                        <td class="name"><label for="bloodSource">${labelNumber++}. Blood source</label>:</td>
                        <td class="value ${hasErrors(bean: bpvBloodFormInstance, field: 'bloodSource', 'errors')}"><g:select name="bloodSource" from="${['Fresh Venous Needle Stick', 'Other (specify)']}" onchange="showhideOthSource();" value="${bpvBloodFormInstance?.bloodSource}" noSelection="['': '']" /></td>
                      </tr><tr id="bloodSourceOsRow" class="bottomsection"><td class="name"></td>
                        <td class="value ${hasErrors(bean: bpvBloodFormInstance, field: 'bloodSourceOs', 'errors')}"><g:textField name="bloodSourceOs"  value="${bpvBloodFormInstance?.bloodSourceOs}" /></td>
                      </tr><tr class="prop bottomsection" id="blooddrawcomments">
                        <td colspan="2" class="name ${hasErrors(bean: bpvBloodFormInstance, field: 'bloodDrawComments', 'errors')}"><label for="bloodDrawComments">${labelNumber++}. Blood collection comments:</label><br />
                        <g:textArea class="textwide" name="bloodDrawComments"  value="${bpvBloodFormInstance?.bloodDrawComments}" /></td>
                      </tr>

                      <tr class="bottomsection"><td colspan="2" class="formheader">Blood Processing Overview</td></tr>
                      <tr class="prop bottomsection">
                          <td class="name"><label for="dateTimeBloodReceived">${labelNumber++}. Date and time blood received in lab:</label></td>
                          <td class="value ${hasErrors(bean: bpvBloodFormInstance, field: 'dateTimeBloodReceived', 'errors')}"><g:jqDateTimePicker LDSOverlay="${bodyclass ?: ''}" name="dateTimeBloodReceived" precision="day" value="${bpvBloodFormInstance?.dateTimeBloodReceived}" default="none" noSelection="['': '']" /></td>
                      </tr>
                      <tr class="subentry prop D2-draw depends-on bottomsection" data-id="bloodDraw2">
                          <td class="name"><label for="dateTimeBloodReceived2"> Date and time second blood draw was received in lab:</label></td>
                          <td class="value ${hasErrors(bean: bpvBloodFormInstance, field: 'dateTimeBloodReceived2', 'errors')}"><g:jqDateTimePicker LDSOverlay="${bodyclass ?: ''}" name="dateTimeBloodReceived2" precision="day" value="${bpvBloodFormInstance?.dateTimeBloodReceived2}" default="none" noSelection="['': '']" /></td>
                      </tr>
                      <tr class="prop bottomsection">
                          <td class="name"><label for="bloodReceiptTech">${labelNumber++}. Blood tubes received in lab by:</label></td>
                          <td class="value ${hasErrors(bean: bpvBloodFormInstance, field: 'bloodReceiptTech', 'errors')}"><g:textField name="bloodReceiptTech" value="${bpvBloodFormInstance?.bloodReceiptTech}" /></td>
                      </tr>
                      <tr class="subentry prop D2-draw depends-on bottomsection" data-id="bloodDraw2">
                          <td class="name"><label for="bloodReceiptTech2"> Blood tubes from second blood draw received in lab by:</label></td>
                          <td class="value ${hasErrors(bean: bpvBloodFormInstance, field: 'bloodReceiptTech2', 'errors')}"><g:textField name="bloodReceiptTech2" value="${bpvBloodFormInstance?.bloodReceiptTech2}" /></td>
                      </tr>
                      <tr class="prop bottomsection">
                          <td class="name"><label for="bloodReceiptTemp">${labelNumber++}. Temperature in lab when tubes received:</label></td>
                          <td class="value ${hasErrors(bean: bpvBloodFormInstance, field: 'bloodReceiptTemp', 'errors')}"><g:textField size="4" name="bloodReceiptTemp" value="${fieldValue(bean: bpvBloodFormInstance, field: 'bloodReceiptTemp')}" onkeyup="isNumericValidation(this)"/> ˚C</td>
                      </tr>
                      <tr class="subentry prop D2-draw depends-on bottomsection" data-id="bloodDraw2">
                          <td class="name"><label for="bloodReceiptTemp2"> Temperature in lab when tubes from second blood draw received:</label></td>
                          <td class="value ${hasErrors(bean: bpvBloodFormInstance, field: 'bloodReceiptTemp2', 'errors')}"><g:textField size="4" name="bloodReceiptTemp2" value="${fieldValue(bean: bpvBloodFormInstance, field: 'bloodReceiptTemp2')}" onkeyup="isNumericValidation(this)"/> ˚C</td>
                      </tr>
                      <tr class="prop bottomsection">
                          <td class="name"><label for="bloodReceiptHumidity">${labelNumber++}. Humidity in lab when tubes received:</label></td>
                          <td class="value ${hasErrors(bean: bpvBloodFormInstance, field: 'bloodReceiptHumidity', 'errors')}"><g:textField size="4" name="bloodReceiptHumidity" value="${fieldValue(bean: bpvBloodFormInstance, field: 'bloodReceiptHumidity')}" onkeyup="isNumericValidation(this)"/> %</td>
                      </tr>
                      <tr class="subentry prop D2-draw depends-on bottomsection" data-id="bloodDraw2">
                          <td class="name"><label for="bloodReceiptHumidity2"> Humidity in lab when tubes from second blood draw received:</label></td>
                          <td class="value ${hasErrors(bean: bpvBloodFormInstance, field: 'bloodReceiptHumidity2', 'errors')}"><g:textField size="4" name="bloodReceiptHumidity2" value="${fieldValue(bean: bpvBloodFormInstance, field: 'bloodReceiptHumidity2')}" onkeyup="isNumericValidation(this)"/> %</td>
                      </tr>
  <g:if test="${bpvBloodFormInstance?.version == 0}">
                            <tr class="mainSaveNContinue prop clearborder bottomsection">
                              <td class="name" colspan="2">
                                <div class="buttons">
                                   <span class="button"><input type="submit" name="_action_update" value="Save and Continue" class="save" /></span>
                                </div>
                              </td>
                            </tr>
                    </table>
                </div>
            </div>
      </div>
</g:if>
<g:else>
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
    <tr class="prop bottomsection"><td colspan="2" class="formheader">Blood Collection Tube Details: Enter information for each tube collected</td></tr>
      <tr class="prop subentry clearborder bottomsection">
          <td colspan="2">
              <div id="drawTimesKey">
                <h4>Blood Draw Times:</h4>
                <div id="drawTimesKey-d1">D1 - <span></span></div>
                <div id="drawTimesKey-d2" class="greentext"></div>
              </div>
              <div id="ParentTubes">
                  <table>
                     <tr><th></th><th class="name">Collection Tube Specimen Barcode ID</th><th class="name">Specimen Tube Type</th><th class="name">Processed for</th><th class="name textcenter">Volume Collected</th><th class="editOnly textcenter">Action</th></tr>
                      <tbody>
                        <g:render template="parentTable"/>
                      </tbody>
                </table>
              </div>
          </td></tr>
          <tr id="add1Row" class="subentry clearborder bottomsection"><td colspan="2" class="${hasErrors(bean: bpvBloodFormInstance, field: 'dnaParent', 'errors')} ${hasErrors(bean: bpvBloodFormInstance, field: 'rnaParent', 'errors')}"><button class="Btn" id="addParentBtn">Add</button></td></tr>

  
  
  
  
  
  
  
  
  
  
  
  
  
                  </table>
                </div>
                <div id="tabs-dna" class="tabbed-content">
                  <h3>DESIRABLE: (1) 8.5ml DNA PAXgene tube</h3>           
                  <table class="tab-table  dec12table">
                    <tr class="prop">
                      <td class="name"><label for="dnaParBarCode">${labelNumber++}. DNA PAXgene tube Specimen barcode ID:</label></td>
                      <td class="value ${hasErrors(bean: bpvBloodFormInstance, field: 'dnaParBarCode', 'errors')}">
                      <g:hiddenField name="dnaParBarCode"  value="${bpvBloodFormInstance?.dnaParBarCode}" />
                      <input type="text" class="showonly" id="pageloaddnaParBarCode" name="pageloaddnaParBarCode"  value="${bpvBloodFormInstance?.dnaParBarCode}" />
                        <div id="dnaParBarcodeDisp" class="barCodeSelect"></div>
                      </td>
                    </tr><tr class="prop">
                      <td class="name"><label for="dnaPaxFrozen">${labelNumber++}. Time DNA PAXgene tube was frozen at -20˚C ± 2˚C:</label></td>
                      <td class="value ${hasErrors(bean: bpvBloodFormInstance, field: 'dnaPaxFrozen', 'errors')} ${warningMap?.get('dnaPaxFrozen') ? 'warnings' : ''}"><g:jqDateTimePicker LDSOverlay="${bodyclass ?: ''}" name="dnaPaxFrozen" value="${bpvBloodFormInstance?.dnaPaxFrozen}" /></td>
                    </tr><tr class="prop">
                       <td class="name"><label for="dnaPaxStorage">${labelNumber++}. Time DNA PAXgene tube was transferred to storage at -75˚C ± 5˚C:</label></td>
                       <td class="value ${hasErrors(bean: bpvBloodFormInstance, field: 'dnaPaxStorage', 'errors')}" ><g:jqDateTimePicker LDSOverlay="${bodyclass ?: ''}" name="dnaPaxStorage" value="${bpvBloodFormInstance?.dnaPaxStorage}" /></td>
                    </tr><tr class="prop">
                       <td class="name"><label for="dnaPaxProcTech">${labelNumber++}. DNA PAXgene tube was stored by:</label></td>
                       <td class="value ${hasErrors(bean: bpvBloodFormInstance, field: 'dnaPaxProcTech', 'errors')}"><g:textField name="dnaPaxProcTech" value="${bpvBloodFormInstance?.dnaPaxProcTech}" /></td>
                    </tr>
                    <tr><td colspan="2" class="formheader">Note deviations from SOP, processing or storage issues</td></tr>
                    <tr class="prop">
                       <td class="name"><label for="dnaPaxProcSopDev">${labelNumber++}. DNA PAXgene tube was collected and stored in accordance with the specified SOP:</label></td>
                       <td class="value ${hasErrors(bean: bpvBloodFormInstance, field: 'dnaPaxProcSopDev', 'errors')}"><g:bpvYesNoRadioPicker checked="${(bpvBloodFormInstance?.dnaPaxProcSopDev)}"  name="dnaPaxProcSopDev" /></td>
                    </tr>
                    <tr class="prop">
                       <td colspan="2" class="name ${hasErrors(bean: bpvBloodFormInstance, field: 'dnaPaxProcComments', 'errors')}">
                         <label for="dnaPaxProcComments">${labelNumber++}. DNA PAXgene tube collection comments:</label><br />
                         <g:textArea class="textwide" name="dnaPaxProcComments" value="${bpvBloodFormInstance?.dnaPaxProcComments}" />
                        </td>
                    </tr>
                    <tr class="prop">
                       <td colspan="2" class="name ${hasErrors(bean: bpvBloodFormInstance, field: 'dnaPaxStorageIssues', 'errors')}">
                          <label for="dnaPaxStorageIssues">${labelNumber++}. DNA PAXgene tube storage comments:</label><br />
                          <g:textArea class="textwide" name="dnaPaxStorageIssues" value="${bpvBloodFormInstance?.dnaPaxStorageIssues}" />
                        </td>
                     </tr>
                  </table>
              </div>
              <div id="tabs-rna" class="tabbed-content">
              <h3>DESIRABLE: (1) 2.5ml RNA PAXgene tube</h3>
              <table class="tab-table  dec12table">
                <tr class="prop">
                  <td class="name"><label for="rnaParBarCode">${labelNumber++}. RNA PAXgene tube Specimen barcode ID:</label></td>
                  <td class="value ${hasErrors(bean: bpvBloodFormInstance, field: 'rnaParBarCode', 'errors')}">
                    <g:hiddenField name="rnaParBarCode"  value="${bpvBloodFormInstance?.rnaParBarCode}" />
                    <input type="text" class="showonly" id="pageloadrnaParBarCode" name="pageloadrnaParBarCode"  value="${bpvBloodFormInstance?.rnaParBarCode}" />
                      <div id="rnaParBarcodeDisp" class="barCodeSelect"></div>
                  </td>
                </tr>
                <tr class="prop">
                  <td class="name"><label for="rnaPaxFrozen">${labelNumber++}. Time RNA PAXgene tube was frozen at -20˚C ± 2˚C:</label></td>
                  <td class="value ${hasErrors(bean: bpvBloodFormInstance, field: 'rnaPaxFrozen', 'errors')} ${warningMap?.get('rnaPaxFrozen') ? 'warnings' : ''}">
                    <g:jqDateTimePicker LDSOverlay="${bodyclass ?: ''}" name="rnaPaxFrozen" value="${bpvBloodFormInstance?.rnaPaxFrozen}" class="timeEntry" />
                  </td>
                            </tr>
                            <tr class="prop">
                                <td class="name">
                                    <label for="rnaPaxStorage">${labelNumber++}. Time RNA PAXgene tube was transferred to storage at -75˚C ± 5˚C:</label>
                                </td>
                                <td class="value ${hasErrors(bean: bpvBloodFormInstance, field: 'rnaPaxStorage', 'errors')} ${warningMap?.get('rnaPaxStorage') ? 'warnings' : ''}">
                                    <g:jqDateTimePicker LDSOverlay="${bodyclass ?: ''}" name="rnaPaxStorage" value="${bpvBloodFormInstance?.rnaPaxStorage}" class="timeEntry" />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td class="name">
                                    <label for="rnaPaxProcTech">${labelNumber++}. RNA PAXgene tube was stored by:</label>
                                </td>
                                <td class="value ${hasErrors(bean: bpvBloodFormInstance, field: 'rnaPaxProcTech', 'errors')}">
                                    <g:textField name="rnaPaxProcTech" value="${bpvBloodFormInstance?.rnaPaxProcTech}" />
                                </td>
                            </tr>
           
                        <tr><td colspan="2" class="formheader">Note deviations from SOP, processing or storage issues</td></tr>
                            <tr class="prop">
                                <td class="name">
                                    <label for="rnaPaxProcSopDev">${labelNumber++}. RNA PAXgene tube was collected and stored in accordance with the specified SOP:</label>
                                </td>
                                <td class="value ${hasErrors(bean: bpvBloodFormInstance, field: 'rnaPaxProcSopDev', 'errors')}">
                                    <g:bpvYesNoRadioPicker checked="${(bpvBloodFormInstance?.rnaPaxProcSopDev)}"  name="rnaPaxProcSopDev" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td colspan="2" class="name ${hasErrors(bean: bpvBloodFormInstance, field: 'rnaPaxProcComments', 'errors')}">
                                    <label for="rnaPaxProcComments">${labelNumber++}. RNA PAXgene tube collection comments:</label><br />
                                    <g:textArea class="textwide" name="rnaPaxProcComments" value="${bpvBloodFormInstance?.rnaPaxProcComments}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td colspan="2" class="name ${hasErrors(bean: bpvBloodFormInstance, field: 'rnaPaxStorageIssues', 'errors')}">
                                    <label for="rnaPaxStorageIssues">${labelNumber++}. RNA PAXgene tube storage comments:</label><br />
                                    <g:textArea class="textwide" name="rnaPaxStorageIssues" value="${bpvBloodFormInstance?.rnaPaxStorageIssues}" />
                                </td>
                            </tr>
      </table>
    </div>
    <div id="tabs-plasma" class="tabbed-content">
      <h3>DESIRABLE: Plasma aliquots - (6) 0.5ml aliquots are desirable</h3>
      <table class="tab-table  dec12table">
                            <tr><td colspan="2" class="formheader">EDTA Tube Centrifugation</td></tr>
                            <tr class="prop">
                                <td class="name">
                                    <label for="plasmaParBarcode">${labelNumber++}. EDTA collection tube Specimen barcode ID:</label>
                                </td>
                                <td class="value ${hasErrors(bean: bpvBloodFormInstance, field: 'plasmaParBarcode', 'errors')}">
                                  <g:set var="plasmaPBCode" value="" />
                                  <g:each in="${bpvBloodFormInstance.caseRecord.specimens}" status="i" var="specimen">
                                    <g:if test="${specimen.parentSpecimen == null}">
                                    <g:if test="${specimen.tissueType.code == 'BLOODPLAS'}">
                                      <g:if test="${specimen.containerType.code == 'LAVEDTA'}">
                                        <g:set var="plasmaPBCode" value="${specimen.specimenId}" />
                                      </g:if> 
                                    </g:if>
                                   </g:if>
                                  </g:each>                                  
                                    <g:hiddenField name="plasmaParBarCode" value="${plasmaPBCode}" /> 
                                    <input type="text" class="showonly" id="pageloadplasmaParBarCode" name="pageloadplasmaParBarCode"  value="${plasmaPBCode}" />
                                    <div id="plasmaParBarcodeDisp" class="barCodeSelect readonly">${plasmaPBCode}</div>
                                </td>
                            </tr>
                            <tr class="prop">
                                <td class="name">
                                    <label for="plasmaProcStart">${labelNumber++}. Time Plasma processing began:</label>
                                </td>
                                <td class="value ${hasErrors(bean: bpvBloodFormInstance, field: 'plasmaProcStart', 'errors')}">
                                    <g:jqDateTimePicker LDSOverlay="${bodyclass ?: ''}" name="plasmaProcStart" value="${bpvBloodFormInstance?.plasmaProcStart}" class="timeEntry "/>
                                </td>
                            </tr> 
                            <tr class="prop">
                                <td class="name">
                                    <label for="plasmaCTBarcode">${labelNumber++}. Conical centrifuge tube code:</label>
                                </td>
                                  
                                      <g:each in="${bpvBloodFormInstance.caseRecord.specimens}" status="i" var="specimen">
                                        <g:if test="${specimen.parentSpecimen != null}">
                                        <g:if test="${specimen.tissueType.code == 'BLOODPLAS'}">
                                          <g:if test="${specimen.containerType.code == 'CONICT'}">
                                            <g:if test="${specimen.fixative.code == 'FRESH'}">
                                                    <g:set var="plasmaConicalTube" value="${specimen.specimenId}" />
                                                    <g:set var="plasmaConicalTubeId" value="${specimen.id}" />
                                                    <g:set var="plasmaConicalTubeVolume" value="${specimen.chpBloodRecord?.volume}" />
                                            </g:if>
                                          </g:if> 
                                        </g:if>
                                        </g:if>
                                      </g:each>
                                
                                <td class="value ${hasErrors(bean: bpvBloodFormInstance, field: 'plasmaCTBarcode', 'errors')}">
                                  
                                  <g:if test="${plasmaConicalTube == null}">
                                          <g:hiddenField name="plasmaCTBarcode" type="hidden" />
                                          <g:hiddenField name="origPlasmaCTBarcode" value="" /><button class="Btn subentry" id="addPlasmaCTBtn">Add</button>
                                  </g:if>
                                <g:else>
                                              <g:hiddenField name="origPlasmaCTBarcode" value="Yes" />
                                              <g:hiddenField name="plasmaCTBarcode" id="plasmaCTBarcode" value="Yes" /><span id="conTbId">${plasmaConicalTube}</span><a class="ui-button ui-state-default ui-corner-all removepadding plasmaBarcodeGroup" title="Delete" id="plasmaCTBarcodeDel" ><span class="ui-icon ui-icon-trash">Delete</span></a>
                                              <g:remoteLink class="plasmaCTBarcodeDel hide ui-button ui-state-default ui-corner-all removepadding" title="Delete" action="deleteSpecimen" value="Delete" update='[success:"ParentTubes",failure:"imgPlCTDel"]' params="'tube=PlasCT'" onSuccess="clearCT()" id="${plasmaConicalTubeId}" before="showWait('Deleting conical centrifuge tube code')" onComplete="plasmaCTBarcodeDel()"><span id='imgPlCTDel' class="ui-icon ui-icon-trash">Delete</span></g:remoteLink>
                                </g:else>   
                                </td>
                            </tr>
                            <tr class="prop plasmaBarcodeGroup clearborder">
                                <td class="name"><label for="plasmaCTVol">${labelNumber++}. Conical tube volume:</label></td>
                                <td class="value ${hasErrors(bean: bpvBloodFormInstance, field: 'plasmaCTVol', 'errors')}">
                                  <g:if test="${plasmaConicalTubeVolume == null}">
                                      <g:textField size="4" name="plasmaCTVol" disabled="true" /> ml
                                      <g:hiddenField name="origPlasmaCTVol" value="${fieldValue(bean: bpvBloodFormInstance, field: 'plasmaCTVol')}" />
                                  </g:if>
                                <g:else>
                                      <g:hiddenField name="plasmaCTVol" value="${bpvBloodFormInstance?.plasmaCTVol}" /><span id="conTbVol">${plasmaConicalTubeVolume} ml</span>
                                      <a title="Edit" href="" onClick="editPlasmaCT('${plasmaConicalTubeId}','${plasmaConicalTube.replace("'","\\'")}','${plasmaConicalTubeVolume}');return false;" class="editOnly button ui-button  ui-state-default ui-corner-all removepadding"><span class="ui-icon ui-icon-pencil">Edit</span></a>
                                </g:else>
                                </td>
                            </tr>
                            <tr class="saveNContinue prop clearborder">
                              <td class="name" colspan="2">
                                <div class="buttons">
                                   <span class="button"><input type="submit" name="_action_update" value="Save and Continue" class="save" /></span>
                                </div>
                              </td>
                            </tr>
                            <tr class="subentry clearborder plasmaBarcodeGroup plasma-tubes-section">
                                <td colspan="2">
                                  <div id="PlasmaTubes">
                                  <h4>Aliquot Details: Enter information for each aliquot derived from conical centrifuge tube</h4>
                                  <div class="redtext hide">To remove the conical centrifuge tube, you must delete its child tubes.</div>
                                  <table>
                                    <tbody>
                                      <tr>
                                        <th class="name">Plasma aliquot Specimen barcode ID</th>
                                        <th class="name textcenter">Plasma aliquot volume</th>
                                        <th class="editOnly textcenter">Action</th>                                          
                                      </tr>
                                          <g:each in="${bpvBloodFormInstance.caseRecord.specimens}" status="i" var="specimen">
                                           <g:if test="${specimen.parentSpecimen != null}"> 
                                            <g:if test="${specimen.tissueType.code == 'BLOODPLAS'}">
                                              <g:if test="${specimen.containerType.code == 'CRYOV'}">
                                              <tr class="gen3-plasma gen3" id="gen3-${specimen.id}">
                                                <td class="ui-state-default"><span class="ui-icon ui-icon-arrowreturnthick-1-e"></span><span class="redtext hide">*</span><span class="specimenIdAl">${specimen.specimenId}</span></td>
                                                <td class="volumeAl textcenter">${specimen.chpBloodRecord?.volume} ml</td>
                                                <td class="editOnly textcenter" >
                                                  <a title="Edit" href="" onClick="editPlasma('${specimen.id}','${specimen.specimenId.replace("'","\\'")}','${specimen.chpBloodRecord?.volume}');return false;" class="editOnly button ui-button  ui-state-default ui-corner-all removepadding"><span class="ui-icon ui-icon-pencil">Edit</span></a>
                                                  <g:remoteLink class="deleteOnly button ui-button ui-state-default ui-corner-all removepadding" title="Delete"  action="deleteSpecimen" value="Delete" update="PlasmaTubes"  params="'tube=Plasma'" id="${specimen.id}" onComplete="uiDelAliquot('${specimen.id}',3)" ><span class="ui-icon ui-icon-trash">Delete</span></g:remoteLink>
                                                </td>                                                
                                              </tr>
                                              </g:if> 
                                            </g:if>
                                           </g:if>
                                          </g:each>
                                    </tbody>
                                  </table></div>                                
                                </td></tr>
                            <tr id="add2Row" class="subentry plasmaBarcodeGroup"><td colspan="2">
                                <button class="Btn" id="addPlasmaBtn">Add</button>
                              </td></tr>
                            <tr class="prop plasmaBarcodeGroup">
                                <td class="name"><label for="plasmaProcEnd">${labelNumber++}. Time Plasma aliquot processing was completed:</label></td>
                                <td class="value ${hasErrors(bean: bpvBloodFormInstance, field: 'plasmaProcEnd', 'errors')}">
                                    <g:jqDateTimePicker LDSOverlay="${bodyclass ?: ''}" name="plasmaProcEnd" value="${bpvBloodFormInstance?.plasmaProcEnd}" class="timeEntry"  />
                                </td>
                            </tr>
                            <tr class="prop plasmaBarcodeGroup">           
                                <td class="name"><label for="plasmaProcFrozen">${labelNumber++}. Time Plasma aliquots were frozen:</label></td>
                                <td class="value ${hasErrors(bean: bpvBloodFormInstance, field: 'plasmaProcFrozen', 'errors')} ${warningMap?.get('plasmaProcFrozen') ? 'warnings' : ''}">
                                    <g:jqDateTimePicker LDSOverlay="${bodyclass ?: ''}" name="plasmaProcFrozen" value="${bpvBloodFormInstance?.plasmaProcFrozen}" class="timeEntry"  />
                                </td>
                            </tr>
                        
                            <tr class="prop plasmaBarcodeGroup">
                                <td class="name"><label for="plasmaProcStorage">${labelNumber++}. Time Plasma aliquots were transferred to storage:</label></td>
                                <td class="value ${hasErrors(bean: bpvBloodFormInstance, field: 'plasmaProcStorage', 'errors')}">
                                    <g:jqDateTimePicker LDSOverlay="${bodyclass ?: ''}" name="plasmaProcStorage" value="${bpvBloodFormInstance?.plasmaProcStorage}" class="timeEntry"  />
                                </td>
                            </tr>
                            <tr class="prop plasmaBarcodeGroup">
                                <td class="name"><label for="plasmaProcTech">${labelNumber++}. Plasma aliquots were processed by:</label></td>
                                <td class="value ${hasErrors(bean: bpvBloodFormInstance, field: 'plasmaProcTech', 'errors')}">
                                    <g:textField name="plasmaProcTech" value="${bpvBloodFormInstance?.plasmaProcTech}" />
                                </td>
                            </tr>
                          <tr class="plasmaBarcodeGroup"><td colspan="2" class="formheader">Note deviations from SOP, processing or storage issues</td></tr>
                            <tr class="prop plasmaBarcodeGroup">           
                                <td class="name"><label for="plasmaProcSopDev">${labelNumber++}. Plasma processing was performed in accordance with specified SOP:</label></td>
                                <td class="value ${hasErrors(bean: bpvBloodFormInstance, field: 'plasmaProcSopDev', 'errors')}">
                                    <g:bpvYesNoRadioPicker checked="${(bpvBloodFormInstance?.plasmaProcSopDev)}"  name="plasmaProcSopDev" />
                                </td>
                            </tr>
                        
                            <tr class="prop plasmaBarcodeGroup">
                                <td colspan="2" class="name ${hasErrors(bean: bpvBloodFormInstance, field: 'plasmaProcComments', 'errors')}">
                                    <label for="plasmaProcComments">${labelNumber++}. Plasma processing comments:</label><br />
                                    <g:textArea class="textwide" name="plasmaProcComments" value="${bpvBloodFormInstance?.plasmaProcComments}" />
                                </td>
                            </tr>
                        
                            <tr class="prop plasmaBarcodeGroup">
                                <td class="name"><label for="plasmaHemolysis">${labelNumber++}. Was presence of Gross Hemolysis of Plasma observed?</label></td>
                                <td class="value ${hasErrors(bean: bpvBloodFormInstance, field: 'plasmaHemolysis', 'errors')}">
                                    <g:bpvYesNoRadioPicker checked="${(bpvBloodFormInstance?.plasmaHemolysis)}"  name="plasmaHemolysis" />
                                </td>
                            </tr>
                        
                            <tr class="prop plasmaBarcodeGroup">
                                <td colspan="2" class="name ${hasErrors(bean: bpvBloodFormInstance, field: 'plasmaStorageIssues', 'errors')}">
                                    <label for="plasmaStorageIssues">${labelNumber++}. Plasma storage issues:</label><br />
                                    <g:textArea class="textwide" name="plasmaStorageIssues" value="${bpvBloodFormInstance?.plasmaStorageIssues}" />
                                </td>
                            </tr>
                  
      </table>
    </div>
<div id="tabs-serum" class="tabbed-content">
      <h3>DESIRABLE: Serum Aliquots - (3) 0.5ml aliquots are desirable</h3> 
      <table class="tab-table  dec12table">
                            <tr><td colspan="2" class="formheader">Serum Separator Tube (SST) Information</td></tr>  
                            <tr class="prop">
                                <td class="name"><label for="serumParBarcode">${labelNumber++}. Serum Separator Tube barcode:</label></td>
                                <td class="value ${hasErrors(bean: bpvBloodFormInstance, field: 'serumParBarcode', 'errors')}">              
                                   <g:set var="srmPBCode" value="" />
                                      <g:each in="${bpvBloodFormInstance.caseRecord.specimens}" status="i" var="specimen">
                                        <g:if test="${specimen.parentSpecimen == null}">
                                          <g:if test="${specimen.tissueType.code == 'BLOODSRM'}">
                                            <g:if test="${specimen.containerType.code == 'SST'}">
                                               <g:set var="srmPBCode" value="${specimen.specimenId}" />
                                            </g:if> 
                                          </g:if>
                                      </g:if>
                                    </g:each>

                              <g:hiddenField name="serumParBarCode" value="${srmPBCode}" />
                              <input type="text" class="showonly" id="pageloadserumParBarCode" name="pageloadserumParBarCode"  value="${srmPBCode}" />
                                    <div id="serumParBarcodeDisp" class="barCodeSelect readonly">${srmPBCode}</div>
                                </td>
                            </tr>
                            <tr class="prop clearborder">           
                                <td class="name"><label for="serumProcStart">${labelNumber++}. Time Serum processing began:</td>
                                <td class="value ${hasErrors(bean: bpvBloodFormInstance, field: 'serumProcStart', 'errors')}">
                                    <g:jqDateTimePicker LDSOverlay="${bodyclass ?: ''}" name="serumProcStart" precision="day" value="${bpvBloodFormInstance?.serumProcStart}" default="none" noSelection="['': '']" />
                                </td>
                            </tr>
                            <tr class="prop subentry clearborder serumBarcodeGroup">
                                <td class="name" colspan="2">Aliquot details: Enter information for each aliquot derived from SST collection tube</td>   
                            </tr>
                            <tr class="subentry clearborder serumBarcodeGroup">
                              <td colspan="2">
                                <div id="SerumTubes">
                                  <table>
                                    <tbody>
                                      <tr>
                                        <th class="name">Serum aliquot Specimen barcode ID</th>  
                                        <th class="name textcenter">Serum aliquot volume</th>  
                                        <th class="editOnly textcenter">Action</th>                                        
                                      </tr>
                                        <g:each in="${bpvBloodFormInstance.caseRecord.specimens}" status="i" var="specimen">
                                           <g:if test="${specimen.parentSpecimen != null}">                                           
                                          <g:if test="${specimen.tissueType.code == 'BLOODSRM'}">
                                            <g:if test="${specimen.containerType.code == 'CRYOV'}">
                                            <tr id="gen2-${specimen.id}" class="gen2 gen2-serum">
                                              <td class="ui-state-default"><span class="ui-icon ui-icon-arrowreturnthick-1-e"></span><span class="specimenIdAl">${specimen.specimenId}</span></td>
                                              <td class="volumeAl textcenter">${specimen.chpBloodRecord?.volume} ml</td>
                                                <td class="editOnly textcenter" >
                                                  <a title="Edit" href="" onClick="editSerum('${specimen.id}','${specimen.specimenId.replace("'","\\'")}','${specimen.chpBloodRecord?.volume}');return false;" class="editOnly button ui-button  ui-state-default ui-corner-all removepadding"><span class="ui-icon ui-icon-pencil">Edit</span></a>
                                                  <g:remoteLink class="deleteOnly button ui-button  ui-state-default ui-corner-all removepadding" title="Delete"  action="deleteSpecimen" value="Delete" update="SerumTubes"  params="'tube=Serum'" id="${specimen.id}"  onComplete="uiDelAliquot('${specimen.id}',2)"><span class="ui-icon ui-icon-trash">Delete</span></g:remoteLink>
                                                </td>                                              
                                            </tr>
                                            </g:if> 
                                          </g:if>  
                                         </g:if>    
                                        </g:each>                                          
                                    </tbody>
                                  </table>
                                </div>
                                </td></tr>           
                            <tr id="add3Row" class="subentry"><td colspan="2"><button class="Btn serumBarcodeGroup" id="addSerumBtn">Add</button></td></tr>
                            <tr class="prop">
                                <td class="name"><label for="serumProcEnd">${labelNumber++}. Time Serum aliquot processing was completed:</label></td>
                                <td class="value ${hasErrors(bean: bpvBloodFormInstance, field: 'serumProcEnd', 'errors')}">
                                    <g:jqDateTimePicker LDSOverlay="${bodyclass ?: ''}" name="serumProcEnd" value="${bpvBloodFormInstance?.serumProcEnd}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td class="name"><label for="serumProcFrozen">${labelNumber++}. Time Serum aliquots were frozen:</label></td>
                                <td class="value ${hasErrors(bean: bpvBloodFormInstance, field: 'serumProcFrozen', 'errors')} ${warningMap?.get('serumProcFrozen') ? 'warnings' : ''}"> 
                                    <g:jqDateTimePicker LDSOverlay="${bodyclass ?: ''}" name="serumProcFrozen" value="${bpvBloodFormInstance?.serumProcFrozen}" />
                                </td>
                            </tr>
                            <tr class="prop">           
                                <td class="name"><label for="serumProcStorage">${labelNumber++}. Time Serum aliquots were transferred to storage:</label></td>
                                <td class="value ${hasErrors(bean: bpvBloodFormInstance, field: 'serumProcStorage', 'errors')}">
                                    <g:jqDateTimePicker LDSOverlay="${bodyclass ?: ''}" name="serumProcStorage" value="${bpvBloodFormInstance?.serumProcStorage}" />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td class="name"><label for="serumProcTech">${labelNumber++}. Serum aliquots were processed by:</label></td>
                                <td class="value ${hasErrors(bean: bpvBloodFormInstance, field: 'serumProcTech', 'errors')}">
                                    <g:textField name="serumProcTech" value="${bpvBloodFormInstance?.serumProcTech}" />
                                </td>
                            </tr>
           
                            
                            <tr><td colspan="2" class="formheader">Note deviations from SOP, processing or storage issues</td></tr>
                        
                            <tr class="prop">
                                <td class="name">
                                  <label for="serumProcSopDev">${labelNumber++}. Serum processing was performed in accordance with the specified SOP:</label>
                               </td>
                                <td class="value ${hasErrors(bean: bpvBloodFormInstance, field: 'serumProcSopDev', 'errors')}">
                                    <g:bpvYesNoRadioPicker checked="${(bpvBloodFormInstance?.serumProcSopDev)}"  name="serumProcSopDev" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td colspan="2" class="name tdtop ${hasErrors(bean: bpvBloodFormInstance, field: 'serumProcComments', 'errors')}">
                                  <label for="serumProcComments">${labelNumber++}. Serum processing comments:</label><br />
                                    <g:textArea class="textwide" name="serumProcComments" value="${bpvBloodFormInstance?.serumProcComments}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td colspan="2" class="name tdtop ${hasErrors(bean: bpvBloodFormInstance, field: 'serumStorageIssues', 'errors')}">
                                    <label for="serumStorageIssues">${labelNumber++}. Serum storage issues:</label><br />
                                    <g:textArea class="textwide" name="serumStorageIssues" value="${bpvBloodFormInstance?.serumStorageIssues}" />
                                </td>
                            </tr>
                            
                  </table>
                </div>    
            </div>
        </div>
</g:else>