public without sharing class SArwaUtilityCls {
    @AuraEnabled
    public static String rwlCheckAudit(String prompt) {
        System.debug('#### input prompt: ' + prompt);
        String auditReqString = prompt;
        String auditRespString = '';
        auditRespString = SArwaCustomModelAPI.createGeneration(auditReqString);
        
        String auditedReqString = auditReqString;
        String auditedRespString = auditRespString;
        Map<String, String> retMap = new Map<String, String>();
        List<SA_Restricted_Word_Audit__c> newRwaList = new List<SA_Restricted_Word_Audit__c>();
        Map<Id, SA_Restricted_Word__c> rwMap = new Map<Id, SA_Restricted_Word__c>();
        rwMap = new Map<Id, SA_Restricted_Word__c>([SELECT Id, Name, Word__c, RegexValue__c, ReplacementRegexValue__c, Substitution__c, Designation_Type__c, Override_Substitution__c
         											FROM SA_Restricted_Word__c
         											WHERE isActive__c = :true]);
        SA_Restricted_Word_Audit__c newRwa = null;
        Matcher mtr;
        Pattern ptr;
        for(Id eachId : rwmap.keySet()){
            ptr = Pattern.compile(rwMap.get(eachId).RegexValue__c);
            mtr = ptr.Matcher(auditedReqString);
            if(mtr.find()){
                auditedReqString = auditedReqString.replaceAll(rwMap.get(eachId).RegexValue__c, rwMap.get(eachId).Substitution__c);
                newRwa = new SA_Restricted_Word_Audit__c(Breached_By__c=System.UserInfo.getName(), Unmasked_Text__c=auditReqString, Designation_Type__c=rwMap.get(eachId).Designation_Type__c,
                                                        Masked_Text__c=auditedReqString, Matching_Restricted_Word__c=rwMap.get(eachId).Word__c);
                newRwaList.add(newRwa);
            }
            mtr = ptr.Matcher(auditedRespString);
            if(mtr.find()){
                auditedRespString = auditedRespString.replaceAll(rwMap.get(eachId).RegexValue__c, rwMap.get(eachId).Substitution__c);
                newRwa = new SA_Restricted_Word_Audit__c(Breached_By__c='Agentforce Agent', Unmasked_Text__c=auditRespString, Designation_Type__c=rwMap.get(eachId).Designation_Type__c,
                                                        Masked_Text__c=auditedRespString, Matching_Restricted_Word__c=rwMap.get(eachId).Word__c);
                newRwaList.add(newRwa);
            }
        }
        if(!newRwaList.isEmpty()){
            try{
                System.debug('#### size of list: ' + newRwaList.size());
                Database.SaveResult[] saveList = Database.insert(newRwaList);
            }catch(DmlException e){
                System.debug('#### Exception occured while inserting restricted word audit records' + e.getMessage());
            }catch(Exception e){
                System.debug('#### An unexpected error has occured: ' + e.getMessage());
            }
        }
        System.debug('#### Req String: ' + auditReqString + ' ReqAudit String: ' + auditedReqString);
        System.debug('#### Resp String: ' + auditRespString + ' RespAudit String: ' + auditedRespString);
        retMap.put('auditedReqString', auditedReqString);
        retMap.put('auditedRespString', auditedRespString);
        return auditedRespString;
    }
}