/**
 * @description       : 
 * @author            : Yogesh.Bhosale
 * @group             : 
 * @last modified on  : 11-19-2021
 * @last modified by  : Yogesh.Bhosale
**/
@IsTest
private class LogTest {

	@IsTest
	private static void debug() {

		// Setup
		enableLogEvents(System.today());

		String message = '{0}=={1}:{2}';
		List<Object> values = new List<Object>{ 1, '2', false };


		// Execute
		Log.debug(message, values);


		// Verify
		Log__e log = Log.currentEvent;

		System.assertEquals('1==2:false', log.txl_Message__c);
		System.assertEquals(LoggingLevel.DEBUG.name(), log.txt_Level__c);
		System.assertEquals(Request.getCurrent().getRequestId() + '/' + Request.getCurrent().getQuiddity(), log.txt_Context__c);
		System.assertEquals(thisClassName(), log.txt_Class__c);
		System.assertEquals('debug', log.txt_Method__c);
		System.assertEquals(22, log.num_Line__c);
	}


	@IsTest
	private static void error() {

		// Setup
		enableLogEvents(System.today());


		// Execute
		Log.error('');


		// Verify
		System.assertEquals(LoggingLevel.ERROR.name(), Log.currentEvent.txt_Level__c);
	}


	@IsTest
	private static void timestampWhenNoContextId() {

		// Setup
		enableLogEvents(System.today());


		// Execute
		Log.debug('');


		// Verify
		System.assertNotEquals(null, Log.currentEvent.txt_Context__c);
	}


	// HELPER

	private static void enableLogEvents(Date day) {
		//REMOVE
	}


	private static Date yesterDay() {
		return System.today().addDays(-1);
	}


	private static String thisClassName() {
		String ns = [SELECT NamespacePrefix FROM Organization].NamespacePrefix + '.';
		return LogTest.class.getName().removeStart(ns);
	}
}