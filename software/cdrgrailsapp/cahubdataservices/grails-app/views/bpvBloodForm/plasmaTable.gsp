                                  <g:hasErrors bean="${bpvBloodFormInstance}">
                                  <div class="errors"><g:renderErrors bean="${bpvBloodFormInstance}" as="list" /></div>
                                  </g:hasErrors>
                                  <h4>Aliquot Details: Enter information for each aliquot derived from Conical Centrifuge tube</h4>
                                  <div class="redtext hide">To remove the Conical Centrifuge tube, you must delete its child tubes.</div>
                                  <table>
                                    <tbody>
                                      <tr>
                                        <th class="name">Plasma aliquot Specimen barcode ID</th>   
                                        <th class="name">Plasma aliquot volume</th>
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
                                                  <g:remoteLink class="deleteOnly button ui-button ui-state-default ui-corner-all removepadding" title="Delete" action="deleteSpecimen" value="Delete" update="PlasmaTubes"  params="'tube=Plasma'" id="${specimen.id}"  onComplete="uiDelAliquot('${specimen.id}',3)"><span class="ui-icon ui-icon-trash">Delete</span></g:remoteLink>
                                                </td>                                                
                                              </tr>
                                              </g:if> 
                                            </g:if>
                                           </g:if>
                                          </g:each>
                                    </tbody>
                                  </table>