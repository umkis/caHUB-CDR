package nci.obbr.cahub.datawarehouse

import nci.obbr.cahub.staticmembers.*
import nci.obbr.cahub.datarecords.DataRecordBaseClass
import nci.obbr.cahub.datarecords.CaseRecord

class CaseDw extends DataRecordBaseClass {
    
    CaseRecord caseRecord
    String caseId
    CaseCollectionType caseCollectionType
    String brain
    Double PMI
    Double minFixTime
    Double avgFixTime
    Double maxFixTime
    Double procedureDuration
    
    static auditable = false

    static hasMany = [specimens:SpecimenDw]
    
    String toString(){"$caseId"}

    static mapping = {
        table 'dw_case'
        id generator:'sequence', params:[sequence:'dw_case_pk']
        specimenId column:'case_id', index:'dw_caseId_idx'
    }
    static constraints = {
        caseRecord(blank:false,nullable:false)
        caseId(blank:false,nullable:false,unique:true)
        caseCollectionType(blank:false,nullable:false)
        brain(blank:true,nullable:true)
        PMI(blank:true,nullable:true)
        minFixTime(blank:true,nullable:true)
        avgFixTime(blank:true,nullable:true)
        maxFixTime(blank:true,nullable:true)
        procedureDuration(blank:true,nullable:true)
    }
}
