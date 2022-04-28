/**
 * @description       : 
 * @author            : Yogesh.Bhosale
 * @group             : 
 * @last modified on  : 11-18-2021
 * @last modified by  : Yogesh.Bhosale
**/
@isTest 
public with sharing class StringUtilityTest {

    @IsTest
    static void containsIgnoreCaseTest(){
        Test.startTest();
            String sourceString = 'Pune is in Maharastra and Maharastra in India';
            //Search Pune
            Boolean result = StringUtility.containsIgnoreCase(sourceString , 'pune');
            System.assert(result ,true );
            //Search Full Capital Word
            result = StringUtility.containsIgnoreCase(sourceString , 'INDIA');
            System.assert(result ,true );
            //Search With null
            result = StringUtility.containsIgnoreCase(sourceString ,null);
            System.assert(result == false );

            result = StringUtility.containsIgnoreCase(null ,'India' );
            System.assert(result == false );
        Test.stopTest();        
    }
    @isTest
    static void containsIgnoreCaseNegativeTest(){
        String sourceString = 'Pune is in Maharastra and Maharastra in India';
        //Search Pune
        Boolean result = StringUtility.containsIgnoreCase(sourceString , '123');
        System.assert(result == false );

    }
    @IsTest
    static void  identifyIDIsValidTest(){
        //create Account
        Account newAccount = new Account();
        newAccount.name = 'New Account';
        insert newAccount; 
            
        Test.startTest();
        Boolean result = StringUtility.isValidAndExists(newAccount.id);    
        System.assert(Result ,true );
        Test.stopTest();
        
    }
    
}