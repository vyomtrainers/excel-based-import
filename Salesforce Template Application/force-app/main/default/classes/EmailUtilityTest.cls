/**
 * @description       : 
 * @author            : Yogesh.Bhosale
 * @group             : 
 * @last modified on  : 11-18-2021
 * @last modified by  : Yogesh.Bhosale
**/
@isTest public with sharing class EmailUtilityTest {


    @IsTest static void validateEmailAddress(){
        
        Test.startTest();
            Boolean result = EmailUtility.isValisEmail('ybbhosale@gmail.com');
            System.Assert(result ,true);
            result = EmailUtility.isValisEmail('a@gmail.com');
            System.Assert(result ,true);
            result = EmailUtility.isValisEmail('ybbhosale@.com');
            System.Assert(result == false);
            result = EmailUtility.isValisEmail('ybbhosale@gmail');
            System.Assert(result == false);
        Test.stopTest();
        
    }
}
