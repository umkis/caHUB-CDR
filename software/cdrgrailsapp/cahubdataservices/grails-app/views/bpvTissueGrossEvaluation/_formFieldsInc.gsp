<%@ page import="nci.obbr.cahub.staticmembers.SOP" %>

<script type="text/javascript">
    $(document).ready(function() {
      
    $("#tissueReceived_no").click(function() {
<%  if (version53 == true) { %>
        $('#restOfTheForm').hide();
<%  } %>
        $("#excessReleased_no").prop('checked', true);
        $("#excessReleased_no").change();
        $('#tissueNotReceivedReasonTr').show();
    });
    $("#tissueReceived_yes").click(function() {
         $('#restOfTheForm').show();
         $('#tissueNotReceivedReason').val('');
         $('#tissueNotReceivedReasonTr').hide();
    });
      
        $("#transportPerformed_yes").change(function() {
            $("#transportCommentsRow").hide()    
            $("#transportComments").val('')
        });

        $("#transportPerformed_no").change(function() {
            $("#transportCommentsRow").show()
        });
        
        $("#photoTaken_yes").change(function() {
            $("#photosRow").show()
            $("#reasonNoPhotoRow").hide()
            $("#reasonNoPhoto").val("")
        });

        $("#photoTaken_no").change(function() {
            if (${!bpvTissueGrossEvaluationInstance.photos}) {
                $("#reasonNoPhotoRow").show()
                $("#photosRow").hide()
            } else {
                alert('Please remove every uploaded photos and save the form')
                $("#photoTaken_yes").attr('checked', true)
            }
        });
        
        $("#inkUsed_yes").change(function() {
            $("#inkTypeRow").show()
        });

        $("#inkUsed_no").change(function() {
            $("#inkTypeRow").hide()
            $("#inkType").val('')
        });
        
        $("#excessReleased_yes").change(function() {
            $("#noReleaseReasonRow").hide()
            $("#noReleaseReason").val('')
            $("#parentSpecimenRow").show()
            $("#excessHRow").show()
            $("#areaPercentageRow").show()
            $("#contentPercentageRow").show()
            $("#appearanceRow").show()
            $("#normalAdjHeaderRow").show()
            $("#normalAdjReleasedRow").show()
            if ($("#normalAdjReleased_yes").attr('checked'))
            {
                $("#normalAdjHRow").show()
            }
            else
            {
                $("#normalAdjHRow").hide()
                $("#normalAdjH").val('0')
                $("#normalAdjW").val('0')
                $("#normalAdjD").val('0')
            }
            $("#transferHeaderRow").show()
            $("#timeTransferredRow").show()
        });

        $("#excessReleased_no").change(function() {
            $("#noReleaseReasonRow").show()
            $("#parentSpecimenRow").hide()
            $("#excessHRow").hide()
            $("#excessH").val('0')
            $("#excessW").val('0')
            $("#excessD").val('0')
            $("#areaPercentageRow").hide()
            $("#areaPercentage").val('')
            $("#contentPercentageRow").hide()
            $("#contentPercentage").val('')
            $("#appearanceRow").hide()
            $("#appearance5").attr('checked', true) // This radio button's value is blank. By checking it, the appearance field will be set to blank.
            $("#normalAdjHeaderRow").hide()
            $("#normalAdjReleasedRow").hide()
            $("#normalAdjReleasedBlank").attr('checked', true) // This radio button's value is blank. By checking it, the normalAdjReleased field will be set to blank.
            $("#normalAdjHRow").hide()
            $("#normalAdjH").val('0')
            $("#normalAdjW").val('0')
            $("#normalAdjD").val('0')
            $("#transferHeaderRow").hide()
            $("#timeTransferredRow").hide()
            $("#timeTransferred").val('')
        });
        
        $("#normalAdjReleased_yes").change(function() {
            
            $("#normalAdjHRow").show()
        });

        $("#normalAdjReleased_no").change(function() {
            
            $("#normalAdjHRow").hide()
            
            $("#normalAdjH").val('0')
            $("#normalAdjW").val('0')
            $("#normalAdjD").val('0')
        });
        
        $('.saveAction').click(function() {
            var val = $('#roomTemperature').val()
            val = val.replace(/,/g, '')
//            if (isNaN(val)) {
//                alert('Question #5 must be a number')
//                $('#roomTemperature').focus()
//                return false
//            }
//            
            val = $('#roomHumidity').val()
            val = val.replace(/,/g, '')
//            if (isNaN(val)) {
//                alert('Question #6 must be a number')
//                $('#roomHumidity').focus()
//                return false
//            }
            if (val < 0 || val > 100) {
                alert("Question #6 must be between 0 and 100")
                $('#roomHumidity').focus()
                return false
            }
            
/*            val = $('#resectionH').val()
            val = val.replace(/,/g, '')
            if (val == '' || isNaN(val)) {
                alert('The height of resected tissue must be a number and cannot be empty.')
                $('#resectionH').focus()
                $('#resectionH').val('0')
                return false
            }
            
            val = $('#resectionW').val()
            val = val.replace(/,/g, '')
            if (val == '' || isNaN(val)) {
                alert('The width of resected tissue must be a number and cannot be empty.')
                $('#resectionW').focus()
                $('#resectionW').val('0')
                return false
            }
            
            val = $('#resectionD').val()
            val = val.replace(/,/g, '')
            if (val == '' || isNaN(val)) {
                alert('The depth of resected tissue must be a number and cannot be empty.')
                $('#resectionD').focus()
                $('#resectionD').val('0')
                return false
            }   */
            
/*            val = $('#resectionWeight').val()
            val = val.replace(/,/g, '')
            if (val == '' || isNaN(val)) {
                alert('Question #9 must be a number and cannot be empty.')
                $('#resectionWeight').focus()
                $('#resectionWeight').val('0')
                return false
            }

            
            val = $('#excessH').val()
            val = val.replace(/,/g, '')
            if (val == '' || isNaN(val)) {
                alert('The height of tumor tissue must be a number')
                $('#excessH').focus()
                return false
            }
            
            val = $('#excessW').val()
            val = val.replace(/,/g, '')
            if (val == '' || isNaN(val)) {
                alert('The width of tumor tissue must be a number')
                $('#excessW').focus()
                return false
            }
            
            val = $('#excessD').val()
            val = val.replace(/,/g, '')
            if (val == '' || isNaN(val)) {
                alert('The depth of tumor tissue must be a number')
                $('#excessD').focus()
                return false
            } */
            
            val = $('#areaPercentage').val()
            val = val.replace(/,/g, '')
/*            if (isNaN(val)) {
                alert('Question #17 must be a number')
                $('#areaPercentage').focus()
                return false
            }*/
            if (val < 0 || val > 100) {
                alert("Question #17 must be between 0 and 100")
                $('#areaPercentage').focus()
                return false
            }
            
            val = $('#contentPercentage').val()
            val = val.replace(/,/g, '')
/*            if (isNaN(val)) {
                alert('Question #18 must be a number')
                $('#contentPercentage').focus()
                return false
            }*/
            if (val < 0 || val > 100) {
                alert("Question #18 must be between 0 and 100")
                $('#contentPercentage').focus()
                return false
            }
            
/*            val = $('#normalAdjH').val()
            val = val.replace(/,/g, '')
            if (val == '' || isNaN(val)) {
                alert('The height of normal adjacent tissue must be a number')
                $('#normalAdjH').focus()
                return false
            }
            
            val = $('#normalAdjW').val()
            val = val.replace(/,/g, '')
            if (val == '' || isNaN(val)) {
                alert('The width of normal adjacent tissue must be a number')
                $('#normalAdjW').focus()
                return false
            }
            
            val = $('#normalAdjD').val()
            val = val.replace(/,/g, '')
            if (val == '' || isNaN(val)) {
                alert('The depth of normal adjacent tissue must be a number')
                $('#normalAdjD').focus()
                return false
            } */
        });
    });
</script>
<g:render template="/formMetadata/timeConstraint" bean="${bpvTissueGrossEvaluationInstance.formMetadata}" var="formMetadata"/>
<g:render template="/caseRecord/caseDetails" bean="${bpvTissueGrossEvaluationInstance.caseRecord}" var="caseRecord" />    

<div class="list">
    <table id ="bpvtissuegrosseval" class="tdwrap">
        <tbody>

            <tr><td colspan="2" class="formheader">Receipt of Tissue in Pathology Gross Room</td></tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="tissueReceived">Tissue received in Gross Room from OR?</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: bpvTissueGrossEvaluationInstance, field: 'tissueReceived', 'errors')}">
		    <g:bpvYesNoRadioPicker name="tissueReceived" checked="${bpvTissueGrossEvaluationInstance?.tissueReceived}" />
                </td>                
            </tr>    
            <tr id="tissueNotReceivedReasonTr" class="prop ${bpvTissueGrossEvaluationInstance?.tissueReceived == 'No'?'':'hide'}" >
                <td colspan="2" class="name ${hasErrors(bean: bpvTissueGrossEvaluationInstance, field: 'tissueNotReceivedReason', 'errors')}">
                    <label for="tissueNotReceivedReason">Explain why:</label><br />
                    <g:textArea class="textwide" name="tissueNotReceivedReason" cols="40" rows="5" value="${bpvTissueGrossEvaluationInstance?.tissueNotReceivedReason}" />
                </td>
            </tr>
        </tbody>     
        <tbody id="restOfTheForm" class="${bpvTissueGrossEvaluationInstance?.tissueReceived == 'Yes' || version53 == false ?'':'hide'}">
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="dateTimeArrived">1. Date and time Specimen arrived in pathology gross room from OR:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: bpvTissueGrossEvaluationInstance, field: 'dateTimeArrived', 'errors')}">
		    <g:jqDateTimePicker LDSOverlay="${bodyclass ?: ''}" name="dateTimeArrived" value="${bpvTissueGrossEvaluationInstance?.dateTimeArrived}" />
                </td>                
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="nameReceived">2. Specimen was received in gross room by:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: bpvTissueGrossEvaluationInstance, field: 'nameReceived', 'errors')}">
                    <g:textField name="nameReceived" value="${bpvTissueGrossEvaluationInstance?.nameReceived}" />
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="transport">3. BPV SOP governing transport of tissue from OR to pathology gross room:</label>
                </td>
                <td valign="top" class="value">
                    <g:if test="${params.action == 'create'}">
                        ${bpvTissueGrossEvaluationInstance?.formMetadata?.sops?.get(0)?.sopNumber}
                        ${bpvTissueGrossEvaluationInstance?.formMetadata?.sops?.get(0)?.sopName}  
                        ${bpvTissueGrossEvaluationInstance?.formMetadata?.sops?.get(0)?.activeSopVer}
                    </g:if>
                    <g:else>
                        ${bpvTissueGrossEvaluationInstance?.transportSOP?.sopNumber}
                        ${SOP.get(bpvTissueGrossEvaluationInstance?.transportSOP?.sopId)?.sopName}  
                        ${bpvTissueGrossEvaluationInstance?.transportSOP?.sopVersion}
                    </g:else>
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="transportPerformed">4. Transport of tissue was performed per BPV Surgical Tissue Collection and Fixation SOP:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: bpvTissueGrossEvaluationInstance, field: 'transportPerformed', 'errors')}">
                    <g:bpvYesNoRadioPicker name="transportPerformed" checked="${bpvTissueGrossEvaluationInstance?.transportPerformed}" />
                </td>
            </tr>

            <g:if test="${bpvTissueGrossEvaluationInstance?.transportPerformed == 'No'}">
                <tr class="prop" id="transportCommentsRow" style="display:display">
                    <td valign="top" class="name">
                        <label for="transportComments">&nbsp;&nbsp;&nbsp;&nbsp;Tissue transport comments:</label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: bpvTissueGrossEvaluationInstance, field: 'transportComments', 'errors')}">
                        <g:textArea name="transportComments" cols="40" rows="5" value="${bpvTissueGrossEvaluationInstance?.transportComments}" />
                    </td>
                </tr>
            </g:if>
            <g:else>
                <tr class="prop" id="transportCommentsRow" style="display:none">
                    <td valign="top" class="name">
                        <label for="transportComments">&nbsp;&nbsp;&nbsp;&nbsp;Tissue transport comments:</label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: bpvTissueGrossEvaluationInstance, field: 'transportComments', 'errors')}">
                        <g:textArea name="transportComments" cols="40" rows="5" value="${bpvTissueGrossEvaluationInstance?.transportComments}" />
                    </td>
                </tr>
            </g:else>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="roomTemperature">5. Temperature of pathology gross room when specimen arrived from OR:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: bpvTissueGrossEvaluationInstance, field: 'roomTemperature', 'errors')}">
                    <g:textField class="numNegFloat" name="roomTemperature" size="5" value="${fieldValue(bean: bpvTissueGrossEvaluationInstance, field: 'roomTemperature')}" />&nbsp;&nbsp;
                    <g:select name="roomTemperatureUnit" value="${bpvTissueGrossEvaluationInstance?.roomTemperatureUnit}" keys="${['Fahrenheit']}" from="${['°F']}" noSelection="['Celsius':'°C']"/>
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="roomHumidity">6. Humidity of pathology gross room when specimen arrived from OR:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: bpvTissueGrossEvaluationInstance, field: 'roomHumidity', 'errors')}">
                    <g:textField class="numFloat" name="roomHumidity" size="5" value="${fieldValue(bean: bpvTissueGrossEvaluationInstance, field: 'roomHumidity')}" /> %
                </td>
            </tr>
            
            <tr><td colspan="2" class="formheader">Gross Evaluation of Resected Tissue</td></tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="nameEvaluated">7. Gross evaluation of resected tissue was performed by:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: bpvTissueGrossEvaluationInstance, field: 'nameEvaluated', 'errors')}">
                    <g:textField name="nameEvaluated" value="${bpvTissueGrossEvaluationInstance?.nameEvaluated}" />
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="resectionH">8. Dimensions of resection:</label>
                </td>
                <td valign="top" class="value">
                    <g:textField name="resectionH" size="5" value="${fieldValue(bean: bpvTissueGrossEvaluationInstance, field: 'resectionH')}" class="${hasErrors(bean: bpvTissueGrossEvaluationInstance, field: 'resectionH', 'errors')} numFloat" /> cm x
                    <g:textField name="resectionW" size="5" value="${fieldValue(bean: bpvTissueGrossEvaluationInstance, field: 'resectionW')}" class="${hasErrors(bean: bpvTissueGrossEvaluationInstance, field: 'resectionW', 'errors')} numFloat" /> cm x
                    <g:textField name="resectionD" size="5" value="${fieldValue(bean: bpvTissueGrossEvaluationInstance, field: 'resectionD')}" class="${hasErrors(bean: bpvTissueGrossEvaluationInstance, field: 'resectionD', 'errors')} numFloat" /> cm
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="resectionWeight">9. Weight of resection:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: bpvTissueGrossEvaluationInstance, field: 'resectionWeight', 'errors')}">
                    <g:textField name="resectionWeight" class="numFloat" size="5" value="${fieldValue(bean: bpvTissueGrossEvaluationInstance, field: 'resectionWeight')}" /> Grams
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="diseaseObserved">10. Gross appearance of disease was observed in resected tissue:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: bpvTissueGrossEvaluationInstance, field: 'diseaseObserved', 'errors')}">
                    <g:bpvYesNoRadioPicker name="diseaseObserved" checked="${bpvTissueGrossEvaluationInstance?.diseaseObserved}" />
                </td>
            </tr>

            <tr class="prop">
                <td colspan="2" class="name ${hasErrors(bean: bpvTissueGrossEvaluationInstance, field: 'diseaseComments', 'errors')}">
                    <label for="diseaseComments">11. Comments:</label><br />
                    <g:textArea class="textwide" name="diseaseComments" cols="40" rows="5" value="${bpvTissueGrossEvaluationInstance?.diseaseComments}" />
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="diagnosis">12. Gross diagnosis of resected tissue:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: bpvTissueGrossEvaluationInstance, field: 'diagnosis', 'errors')}">
                    <g:textField name="diagnosis" value="${bpvTissueGrossEvaluationInstance?.diagnosis}" />
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="photoTaken">13. Photograph(s) of tissue was/were taken in pathology gross room?</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: bpvTissueGrossEvaluationInstance, field: 'photoTaken', 'errors')}">
                    <g:bpvYesNoRadioPicker name="photoTaken" checked="${bpvTissueGrossEvaluationInstance?.photoTaken}" />
                </td>
            </tr>

            <tr class="prop subentry" id="photosRow" style="display:${bpvTissueGrossEvaluationInstance.photoTaken=='Yes'?'display':'none'}">
                <td colspan="2" class="name ${hasErrors(bean: bpvTissueGrossEvaluationInstance, field: 'photos', 'errors')}">
                    <label for="photos">Tissue photographs:</label><br />
                    <g:render template="photoTable" bean="${bpvTissueGrossEvaluationInstance}" var="bpvTissueGrossEvaluationInstance" />
                    <g:if test="${params.action != 'create'}">
                      <div>
                        <g:link class="photoLink uibutton" controller="bpvTissueGrossEvaluation" action="upload" id="${bpvTissueGrossEvaluationInstance.id}" onclick="return confirm('Unsaved data will be lost. Are you sure to proceed?')">
                          <span class="ui-icon ui-icon-circle-arrow-n"></span>Upload
                        </g:link>
                      </div>
                    </g:if>
                    <g:else>
                        <span style="color:red">Form needs to be saved before photos can be uploaded</span>
                    </g:else>
                </td>
            </tr>

            <tr class="prop subentry" id="reasonNoPhotoRow" style="display:${bpvTissueGrossEvaluationInstance?.photoTaken == 'No' ? 'display' : 'none'}">
                <td colspan="2" class="name ${hasErrors(bean: bpvTissueGrossEvaluationInstance, field: 'reasonNoPhoto', 'errors')}">
                    <label for="reasonNoPhoto">Explain why:</label><br />
                    <g:textArea class="textwide" name="reasonNoPhoto" cols="40" rows="5" value="${bpvTissueGrossEvaluationInstance?.reasonNoPhoto}" />
                </td>
            </tr>
            
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="inkUsed">14. Pathology ink used?</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: bpvTissueGrossEvaluationInstance, field: 'inkUsed', 'errors')}">
                    <g:bpvYesNoRadioPicker name="inkUsed" checked="${bpvTissueGrossEvaluationInstance?.inkUsed}" />
                </td>
            </tr>

            <g:if test="${bpvTissueGrossEvaluationInstance?.inkUsed == 'Yes'}">
                <tr class="prop subentry" id="inkTypeRow" style="display:display">
                    <td valign="top" class="name">
                        <label for="inkType">Specify the type of ink:</label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: bpvTissueGrossEvaluationInstance, field: 'inkType', 'errors')}">
                        <g:textField name="inkType" value="${bpvTissueGrossEvaluationInstance?.inkType}" />
                    </td>
                </tr>
            </g:if>
            <g:else>
                <tr class="prop subentry" id="inkTypeRow" style="display:none">
                    <td valign="top" class="name">
                        <label for="inkType">Specify the type of ink:</label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: bpvTissueGrossEvaluationInstance, field: 'inkType', 'errors')}">
                        <g:textField name="inkType" value="${bpvTissueGrossEvaluationInstance?.inkType}" />
                    </td>
                </tr>
            </g:else>
            
            <tr><td colspan="2" class="formheader">Gross Evaluation of Tumor Tissue</td></tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="excessReleased">15. Tumor tissue was released to the tissue bank?</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: bpvTissueGrossEvaluationInstance, field: 'excessReleased', 'errors')}">
                    <g:bpvYesNoRadioPicker name="excessReleased" checked="${bpvTissueGrossEvaluationInstance?.excessReleased}" />
                </td>
            </tr>
            
            <g:if test="${bpvTissueGrossEvaluationInstance?.excessReleased == 'No'}">
                <tr class="prop subentry" id="noReleaseReasonRow" style="display:display">
                    <td colspan="2" class="name ${hasErrors(bean: bpvTissueGrossEvaluationInstance, field: 'noReleaseReason', 'errors')}">
                        <label for="noReleaseReason">Specify reason:</label><br />
                        <g:textArea class="textwide" class="textwide" name="noReleaseReason" cols="40" rows="5" value="${bpvTissueGrossEvaluationInstance?.noReleaseReason}" />
                    </td>
                </tr>
            </g:if>
            <g:else>
                <tr class="prop subentry" id="noReleaseReasonRow" style="display:none">
                    <td colspan="2" class="name ${hasErrors(bean: bpvTissueGrossEvaluationInstance, field: 'noReleaseReason', 'errors')}">
                        <label for="noReleaseReason">Specify reason:</label><br />
                        <g:textArea class="textwide" name="noReleaseReason" cols="40" rows="5" value="${bpvTissueGrossEvaluationInstance?.noReleaseReason}" />
                    </td>
                </tr>
            </g:else>
            
            <tr class="prop" id="parentSpecimenRow" style="display:${bpvTissueGrossEvaluationInstance?.excessReleased == 'Yes' ? 'display' : 'none'}">
                <td valign="top" class="name">
                    <label for="parentSpecimen">16. Parent tissue Specimen ID:</label>
                </td>
                <td valign="top" class="value">
            
                  <%-- Auto populated manaully or read.  This is to match the gross/module specimen created later on the FFPE worksheet main.--%>
                  
                  <g:if test="${bpvTissueGrossEvaluationInstance.caseRecord.bpvWorkSheet?.parentSampleId}">
                      ${bpvTissueGrossEvaluationInstance.caseRecord.bpvWorkSheet.parentSampleId}
                  </g:if>
                  <g:else>
                      ${bpvTissueGrossEvaluationInstance.caseRecord.caseId}-00
                  </g:else>                   
                </td>
            </tr>            
            
            <tr class="prop" id="excessHRow" style="display:${bpvTissueGrossEvaluationInstance?.excessReleased == 'Yes' ? 'display' : 'none'}">
                <td valign="top" class="name">
                    <label for="excessH">17. Dimensions of tissue:</label>
                </td>
                <td valign="top" class="value ${(warningMap?.get('excessH') || warningMap?.get('excessW') || warningMap?.get('excessD'))? 'warnings' : ''}"> 
                    <g:textField name="excessH" size="5" value="${fieldValue(bean: bpvTissueGrossEvaluationInstance, field: 'excessH')}" class="${hasErrors(bean: bpvTissueGrossEvaluationInstance, field: 'excessH', 'errors')} numFloat" onChange="displayWarningForNumberValue('excessH', '', '', 'Tissue Height')"/> cm x
                    <g:textField name="excessW" size="5" value="${fieldValue(bean: bpvTissueGrossEvaluationInstance, field: 'excessW')}" class="${hasErrors(bean: bpvTissueGrossEvaluationInstance, field: 'excessW', 'errors')} numFloat" onChange="displayWarningForNumberValue('excessW', '', '', 'Tissue Width')"/> cm x
                    <g:textField name="excessD" size="5" value="${fieldValue(bean: bpvTissueGrossEvaluationInstance, field: 'excessD')}" class="${hasErrors(bean: bpvTissueGrossEvaluationInstance, field: 'excessD', 'errors')} numFloat" onChange="displayWarningForNumberValue('excessD', '', '', 'Tissue Depth')"/> cm
                </td>
            </tr>

            <tr class="prop" id="areaPercentageRow" style="display:${bpvTissueGrossEvaluationInstance?.excessReleased == 'Yes' ? 'display' : 'none'}">
                <td valign="top" class="name">
                    <label for="areaPercentage">18. Percentage of gross area of necrosis of material sent to tissue bank:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: bpvTissueGrossEvaluationInstance, field: 'areaPercentage', 'errors')} ${warningMap?.get('areaPercentage') ? 'warnings' : ''}">
                    <g:textField class="numFloat" name="areaPercentage" size="5" value="${fieldValue(bean: bpvTissueGrossEvaluationInstance, field: 'areaPercentage')}" onChange="displayWarningForNumberValue('areaPercentage', '', '20', 'Area Percentage')"/> %
                </td>
            </tr>

            <tr class="prop" id="contentPercentageRow" style="display:${bpvTissueGrossEvaluationInstance?.excessReleased == 'Yes' ? 'display' : 'none'}">
                <td valign="top" class="name">
                    <label for="contentPercentage">19. Percentage of tumor content of material sent to tissue bank:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: bpvTissueGrossEvaluationInstance, field: 'contentPercentage', 'errors')} ${warningMap?.get('contentPercentage') ? 'warnings' : ''}">
                    <g:textField class="numFloat" name="contentPercentage" size="5" value="${fieldValue(bean: bpvTissueGrossEvaluationInstance, field: 'contentPercentage')}" onChange="displayWarningForNumberValue('contentPercentage', '50', '', 'Content Percentage')"/> %
                </td>
            </tr>

            <tr class="prop" id="appearanceRow" style="display:${bpvTissueGrossEvaluationInstance?.excessReleased == 'Yes' ? 'display' : 'none'}">
                <td valign="top" class="name">
                    <label for="appearance">20. Gross appearance of material sent to tissue bank:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: bpvTissueGrossEvaluationInstance, field: 'appearance', 'errors')}">
                    <div>
                        <g:radio name="appearance" id="appearance1" value="Metastatic" checked="${bpvTissueGrossEvaluationInstance?.appearance == 'Metastatic'}"/>&nbsp;<label for="appearance1">Metastatic</label><br/>
                        <g:radio name="appearance" id="appearance2" value="Tumor" checked="${bpvTissueGrossEvaluationInstance?.appearance == 'Tumor'}"/>&nbsp;<label for="appearance2">Tumor</label><br/>
                        <g:radio name="appearance" id="appearance3" value="Tumor Center" checked="${bpvTissueGrossEvaluationInstance?.appearance == 'Tumor Center'}"/>&nbsp;<label for="appearance3">Tumor Center</label><br/>
                        <g:radio name="appearance" id="appearance4" value="Tumor Edge" checked="${bpvTissueGrossEvaluationInstance?.appearance == 'Tumor Edge'}"/>&nbsp;<label for="appearance4">Tumor Edge</label><br/>
                        <g:radio name="appearance" id="appearance5" class="hide" value="" checked="${bpvTissueGrossEvaluationInstance?.appearance == ''}"/>
                    </div>
                </td>
            </tr>
            
            <tr id="normalAdjHeaderRow" style="display:${bpvTissueGrossEvaluationInstance?.excessReleased == 'Yes' ? 'display' : 'none'}">
                <td colspan="2" class="formheader">Normal Adjacent Tissue Information (if applicable)</td>
            </tr>
            
            <tr class="prop" id="normalAdjReleasedRow" style="display:${bpvTissueGrossEvaluationInstance?.excessReleased == 'Yes' ? 'display' : 'none'}">
                <td valign="top" class="name">
                    <label for="normalAdjReleased">21. Normal adjacent tissue was released to the tissue bank in addition to tumor tissue?</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: bpvTissueGrossEvaluationInstance, field: 'normalAdjReleased', 'errors')}">
                    <g:bpvYesNoRadioPicker name="normalAdjReleased" checked="${bpvTissueGrossEvaluationInstance?.normalAdjReleased}" />
                    <g:radio name="normalAdjReleased" id="normalAdjReleasedBlank" class="hide" value="" checked="${bpvTissueGrossEvaluationInstance?.normalAdjReleased == ''}"/>
                </td>
            </tr>
            
            <tr class="prop" id="normalAdjHRow" style="display:${(bpvTissueGrossEvaluationInstance?.excessReleased == 'Yes')&&(bpvTissueGrossEvaluationInstance?.normalAdjReleased == 'Yes') ? 'display' : 'none'}">
                <td valign="top" class="name">
                    <label for="normalAdjH">22. Dimensions of tissue:</label>
                </td>
                <td valign="top" class="value ${(warningMap?.get('normalAdjH') || warningMap?.get('normalAdjW') || warningMap?.get('normalAdjD'))? 'warnings' : ''}">
                    <g:textField name="normalAdjH" size="5" value="${fieldValue(bean: bpvTissueGrossEvaluationInstance, field: 'normalAdjH')}" class="${hasErrors(bean: bpvTissueGrossEvaluationInstance, field: 'normalAdjH', 'errors')} numFloat" onChange="displayWarningForNumberValue('normalAdjH', '1', '', 'Tissue Height')"/> cm x
                    <g:textField name="normalAdjW" size="5" value="${fieldValue(bean: bpvTissueGrossEvaluationInstance, field: 'normalAdjW')}" class="${hasErrors(bean: bpvTissueGrossEvaluationInstance, field: 'normalAdjW', 'errors')} numFloat" onChange="displayWarningForNumberValue('normalAdjW', '1', '', 'Tissue Width')"/> cm x
                    <g:textField name="normalAdjD" size="5" value="${fieldValue(bean: bpvTissueGrossEvaluationInstance, field: 'normalAdjD')}" class="${hasErrors(bean: bpvTissueGrossEvaluationInstance, field: 'normalAdjD', 'errors')} numFloat" onChange="displayWarningForNumberValue('normalAdjD', '1', '', 'Tissue Depth')"/> cm
                </td>
            </tr>
            
            <tr id="transferHeaderRow" style="display:${bpvTissueGrossEvaluationInstance?.excessReleased == 'Yes' ? 'display' : 'none'}">
                <td colspan="2" class="formheader">Transfer of Tissue to Tissue Bank</td>
            </tr>

            <tr class="prop" id="timeTransferredRow" style="display:${bpvTissueGrossEvaluationInstance?.excessReleased == 'Yes' ? 'display' : 'none'}">
                <td valign="top" class="name">
                    <label for="timeTransferred">23. Time specimen was transferred from the pathology gross room to the tissue bank:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: bpvTissueGrossEvaluationInstance, field: 'timeTransferred', 'errors')}">
                    <g:textField name="timeTransferred" value="${bpvTissueGrossEvaluationInstance?.timeTransferred}" class="timeEntry" />
                </td>
            </tr>

        </tbody>
    </table>
</div>
