/**
 * @description       : 
 * @author            : Yogesh.Bhosale
 * @group             : 
 * @last modified on  : 11-30-2021
 * @last modified by  : Yogesh.Bhosale
**/
public with sharing class SObjectUtility {

    /**
     * Provides a list of all fields in a Custom Object
     *
     * @param sObjName - custom object name in string format e.g. 'Account'
     * @return - Returns List of all fields in a custom object
     */
    public static List<String> getAllFieldsForSObject(String sObjName){
        if(String.isBlank(sObjName)){
            throw new UtilityException('Argument \'sObjName\' missing. '
                    + 'Custom Object Name is required');
        }
        List<String> fieldList = 
                new List<String>(Schema.getGlobalDescribe()
                                .get(sObjName)
                                .getDescribe()
                                .fields.getMap()
                                .keySet());
        return fieldList;
    }
    
    /**
     * Provides a SOQL equivalent of the SQL 'SELECT * FROM ..' statement.
     *
     * @param sObjName - custom object name in string format e.g. 'Account'
     * @return - Returns 'SELECT <field1>, <field2>,... FROM sObjName'
     */
    public String getAllFieldsInSOQLSelect(String sObjName) {
        if(String.isBlank(sObjName)){
            throw new UtilityException('Argument \'sObjName\' missing. ' 
                    + 'Custom Object Name is required');
        }
        List<String> fieldList = getAllFieldsForSObject(sObjName);
        String fields = String.join(fieldList,',');
        String soqlQuery = 'SELECT ' + fields + ' FROM ' + sObjName;
        return soqlQuery;
    }
    /**
     * Provides the type of a field on a custom object. 
     * 
     * @param sObjName - custom object name in string format e.g. 'Opportunity'
     * @param fieldName - custom object field name in string format e.g. 'Area__c'
     * 
     * @return - Returns 'STRING' or 'DATE' or 'DATETIME' or 'NUMBER'
     */ 
    public static String getFieldType(String sObjName, String fieldName){
        String fieldType = '';
        
        if(String.isBlank(sObjName)){
            throw new UtilityException('Argument \'sObjName\' missing. ' 
                        + 'Custom Object Name is required');
        }
        if(String.isBlank(fieldName)){
            throw new UtilityException('Argument \'fieldName\' missing. ' 
                + 'Custom Object Field Name is required');
        }
        
        Schema.SObjectType objType = Schema.getGlobalDescribe().get(sObjName);
        Schema.DescribeSObjectResult descObjResult = objType.getDescribe();
        Schema.DescribeFieldResult field = descObjResult.fields.getMap()
                                            .get(fieldName)
                                            .getDescribe();
        
        if(field.getType() == Schema.DisplayType.DATE){
            fieldType = 'DATE';
        } else if(field.getType() == Schema.DisplayType.DATETIME){
            fieldType = 'DATETIME';
        } else if(field.getType() == Schema.DisplayType.DOUBLE || 
                field.getType() == Schema.DisplayType.INTEGER){
            fieldType = 'NUMBER';
        } else if(field.getType() == Schema.DisplayType.ADDRESS || 
                field.getType() == Schema.DisplayType.STRING || 
                field.getType() == Schema.DisplayType.PHONE ||
                field.getType() == Schema.DisplayType.TEXTAREA ||
                field.getType() == Schema.DisplayType.PICKLIST){
                    fieldType = 'STRING';
                }
        return fieldType;
    }
    /**
     * 
     * get SObject API Name from Label
     */
    public static String getObjectNameFromLabel (String objectLabel) {
		
        String sObjectName = objectLabel.toUpperCase();
        List<Schema.SObjectType> gd = Schema.getGlobalDescribe().Values();    
        Map<String,String> objectNames = new Map<String,String>();
        for(Schema.SObjectType f : gd)
        {
            String objectName = f.getDescribe().getLabel();
            objectNames.put( objectName.toUppercase(),f.getDescribe().getName());
        }
       return objectNames.get( sObjectName );
    }
}
