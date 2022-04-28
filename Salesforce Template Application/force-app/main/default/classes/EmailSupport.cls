/**
 * Copyright (c) 2021, Yogesh Bhosale 
 * All rights reserved.
 * 
 * @description       : Email Support Class is Support Class to Send Email functionality
 * @author            : Yogesh.Bhosale
 * @group             : 
 * @last modified on  : 11-19-2021
 * @last modified by  : Yogesh.Bhosale
 * 
**/

public with sharing class EmailSupport {

    /**
     * Send Email to Specified Users With given Subject and emailBody
     * 
     */
    public static void sendEmail(list<String> toAddresses, String emailSubject, String emailBody ) {
        //Check for valid Email Address
        if( isValidEmailAddress( toAddresses) ) {
            //Prepare for Sending Email
        // create the email
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                
         

        }else {
            throw new UtilityException('Cant send email with Invalid Address');
        }
    }

    /**
     * Utility Method to validate All email-address
     * 
    */
    private static Boolean isValidEmailAddress(list<String> temailAddresses ){
        Boolean isAllAddressValid = true;
        for( String emailAddress :temailAddresses ){
            if( !EmailUtility.isValisEmail(emailAddress) ) {
                isAllAddressValid = false;
                break;
            }
        }
        return isAllAddressValid;
    }
}
