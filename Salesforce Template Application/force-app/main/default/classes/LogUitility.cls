/**
 * @description       : 
 * @author            : Yogesh.Bhosale
 * @group             : 
 * @last modified on  : 11-30-2021
 * @last modified by  : Yogesh.Bhosale
**/
public with sharing class LogUitility {

        private static final String DEFAULT_LOGLEVEL ='DEBUG';
        private static final String ORG_NAMESPACE = [SELECT NamespacePrefix FROM Organization].NamespacePrefix;
        private static final String CLASSNAME = LogUitility.class.getName();
        private static final Pattern STACK_LINE = Pattern.compile('^(?:Class\\.)?([^.]+)\\.?([^\\.\\:]+)?[\\.\\:]?([^\\.\\:]*): line (\\d+), column (\\d+)$');
    
        // PUBLIC
        /**
         * debug log 
         */
        public static void debug() {
            debug('', new List<Object>());
        }

        /**
         * Debug log message 
         */
        public static void debug(String message) {
            debug(message, new List<Object>());
        }

        /**
         * Log List of Values
         */
        public static void debug(List<Object> values) {
            debug(' List :', values);
        }

        /**
         * Log message With List of values
         */
        public static void debug(String message, List<Object> values) {
            //emit(message, values, LoggingLevel.DEBUG);
            createLogEvent(message, values, LoggingLevel.DEBUG);
        }

        /**
         * Log Error
         * 
         */
        public static void error() {
            error('', new List<Object>());
        }

        /**
         * Log error list of Values
         */
        public static void error(List<Object> values) {
            error('List : ', values);
        }

        /**
         * Log Error Message
         */
        public static void error(String message) {
            error(message, new List<Object>());
        }

        /**
         * log Error with message and List 
         */
        public static void error(String message, List<Object> values) {
            //emit(message, values, LoggingLevel.ERROR);
            createLogEvent(message, values, LoggingLevel.ERROR);
        }


        public static void logMessage(String message){
            logMessage(message,LoggingLevel.INFO);
        }
        
        public static void logDebug(String message){
            logMessage(message,LoggingLevel.DEBUG);
        }
        /**
         * Generic Method to log diffrent messages 
         */
        public static void logMessage(String message , LoggingLevel level){
            createLogEvent(message, new List<Object>(), level);
        }
    
    
       /**
        * Create and Publish the Logmeessage  
        *
        */ 
        private static LogMessageEvent__e createLogEvent(String message,List<Object> values, LoggingLevel level ){
            message = String.format(message, cast(values));

            LogMessageEvent__e newMessage = new LogMessageEvent__e();
            //Add Basic Information
            newMessage.UserId__c = UserInfo.getUserId();
            newMessage.UserName__c = UserInfo.getName();
            newMessage.Message__c = message;
            newMessage.LogLevel__c = level.name();
            newMessage.Context__c = Request.getCurrent().getRequestId() + '/' + Request.getCurrent().getQuiddity();

            //Populate Source of Log
            populateLogLocation(newMessage);

            EventBus.publish(newMessage);

            return newMessage;
        }
    /**
     * convert List of Object into String
     */
	private static List<String> cast(List<Object> values) {
		List<String> result = new List<String>();

		for(Object value : values) {
			result.add('' + value);
		}

		return result;
	}

    /**
     * Populate ClassName , Method Name and Line Number for Log
     * 
     */
    private static void populateLogLocation(LogMessageEvent__e logEvent) {
		// Note: Idea taken from https://salesforce.stackexchange.com/questions/153835
		List<String> stacktrace = new DmlException().getStackTraceString().split('\n');

		for(String line : stacktrace) {
			Matcher matcher = STACK_LINE.matcher(line);

			if(matcher.find() && !line.startsWith('Class.' + CLASSNAME + '.')) {
				Boolean hasNamespace = String.isNotBlank(matcher.group(3));

				if(hasNamespace) {
					logEvent.className__c = (matcher.group(1).equals(ORG_NAMESPACE)) ? matcher.group(2) : matcher.group(1) + '.' + matcher.group(2);
					logEvent.methodName__c = prettyMethod(matcher.group(3));
				}
				else {
					logEvent.className__c = matcher.group(1);
					logEvent.methodName__c = prettyMethod(matcher.group(2));
				}

				logEvent.lineNumber__c = Integer.valueOf(matcher.group(4));
 
				return;
			}
		}
	}

    /**
     * Define source of Method
     * 
     */
	private static String prettyMethod(String method) {
		String result = (method == null) ? 'anonymous' : method;
		return (result.contains('init')) ? 'ctor' : result;
	}

}
