@isTest
public class SArwaUtilityClsTest {
    @isTest
    static void testRwlCheckAudit() {
        // Set up mock data for Restricted_Word__c records
        List<SA_Restricted_Word__c> restrictedWords = new List<SA_Restricted_Word__c>();
        restrictedWords.add(new SA_Restricted_Word__c(
            //Name = 'Test Word 1',
            Word__c = 'SSN',
            RegexValue__c = '\b[0-9]{3}[0-9]{2}[0-9]{4}\b',
            Substitution__c = '*****',
            Designation_Type__c = 'Confidential',
            isActive__c = true
        ));
        insert restrictedWords;
        
        // Input string to test the rwlCheckAudit method
        String inputPrompt = '333224444';
        
        // Start the test context
        Test.startTest();        
        // Call the method you want to test
        String result = SArwaUtilityCls.rwlCheckAudit(inputPrompt);        
        // Stop the test context
        Test.stopTest();
        
        // Verify that the returned result is correct
        System.assertNotEquals(null, result);
        System.assert(result.contains('*****'), 'The result should contain the substitution string');
        
        // Verify that the Restricted_Word_Audit__c records were created
        List<SA_Restricted_Word_Audit__c> auditRecords = [SELECT Id, Unmasked_Text__c, Masked_Text__c, Matching_Restricted_Word__c 
                                                       FROM SA_Restricted_Word_Audit__c];
        System.assertEquals(2, auditRecords.size(), 'Two audit records should have been created');
        System.assertEquals('SSN', auditRecords[0].Matching_Restricted_Word__c, 'The restricted word should be logged correctly');
        System.assertEquals('*****', auditRecords[0].Masked_Text__c, 'The masked text should be correctly substituted');
    }
}