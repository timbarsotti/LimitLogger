public with sharing class LimitLogger {
	/* Constructors */
	public LimitLogger(List<sObject> sObjectList, String dmlOperation, String objectName, String eventName) {
		constructLimitLog();
		this.sObjectList 	= sObjectList;
		this.eventName 		= eventName;
		this.dmlOperation 	= dmlOperation;
		this.objectName 	= objectName;
	}
	public LimitLogger(String dmlOperation, String objectName, String eventName) {
		constructLimitLog();
		this.eventName 		= eventName;
		this.dmlOperation 	= dmlOperation;
		this.objectName 	= objectName;
	}
	/* inner classes */
	public class LimitLoggerException extends Exception {}
	/* public methods */
	public void start() {
		if(started) {
			throw new LimitLoggerException(Constants.LIMIT_LOGGER_MAX_ONCE_START_EXCEPTION);
		} else {
			started = true;
		}
		this.initialAggregateQueries 			= LIMITS.getAggregateQueries();
		this.initialAsyncCalls 					= LIMITS.getAsyncCalls();
		this.initialCallouts 					= LIMITS.getCallouts();
		this.initialCpuTime 					= LIMITS.getCpuTime();
		this.initialDMLRows 					= LIMITS.getDMLRows();
		this.initialDMLStatements 				= LIMITS.getDMLStatements();
		this.initialEmailInvocations 			= LIMITS.getEmailInvocations();
		this.initialFutureCalls 				= LIMITS.getFutureCalls();
		this.initialHeapSize 					= LIMITS.getHeapSize();
		this.initialMobilePushApexCalls 		= LIMITS.getMobilePushApexCalls();
		this.initialQueries 					= LIMITS.getQueries();
		this.initialQueryLocatorRows 			= LIMITS.getQueryLocatorRows();
		this.initialQueryRows 					= LIMITS.getQueryRows();
		this.initialQueueableJobs 				= LIMITS.getQueueableJobs();
		this.initialSoslQueries 				= LIMITS.getSoslQueries();
	}

	public void debugSinceStart() {
		updateLog();
		printLimits();
	}
	
	public void stop() {
		stop(true, true);
	}

	public void stop(Boolean printDebug, Boolean addLogToStack) {
		if(finished) {
			throw new LimitLoggerException(Constants.LIMIT_LOGGER_MAX_ONCE_STOP_EXCEPTION);
		} else {
			finished = true;
		}
		updateLog();
		if(printDebug) {
			printLimits();
		}
		if(addLogToStack) {
			addLogToStack();
		}
	}
	public static void saveAllLogs() {
		insert limitLogs;
		limitLogs = new List<Limit_Log__c>();
	}
	/* private methods */
	private static List<Limit_Log__c> limitLogs = new List<Limit_Log__c>();
	private Boolean finished = false;
	private Boolean started = false;
	@TestVisible private Integer initialAggregateQueries = 0; 		//the initial number of aggregate queries that have been processed with any SOQL query statement.
	//private Integer limitAggregateQueries {get; set;} 			//the total number of aggregate queries that can be processed with SOQL query statements.
	@TestVisible private Integer initialAsyncCalls = 0; 				//Reserved for future use.
	//private Integer limitAsyncCalls {get; set;} 				//Reserved future use.
	@TestVisible private Integer initialCallouts = 0; 				//the initial number of Web service statements that have been processed.
	//private Integer limitCallouts {get; set;} 					//the total number of Web service statements that can be processed.
	@TestVisible private Integer initialCpuTime = 0; 					//the initial CPU time in milliseconds accumulated on the Salesforce servers in the current transaction.
	//private Integer limitCpuTime {get; set;} 					//the time limit in milliseconds of CPU usage in the current transaction.
	@TestVisible private Integer initialDMLRows = 0; 					//the initial number of records that have been processed with any statement that counts against DML limits, such as DML statements, the Database.emptyRecycleBin method, and other methods.
	//private Integer limitDMLRows {get; set;} 					//the total number of records that can be processed with any statement that counts against DML limits, such as DML statements, the database.EmptyRecycleBin method, and other methods.
	@TestVisible private Integer initialDMLStatements = 0; 			//the initial number of DML statements such as insert, update or the database.EmptyRecycleBin method that have been called.
	//private Integer limitDMLStatements {get; set;} 				//the total number of DML statements or the database.EmptyRecycleBin methods that can be called.
	@TestVisible private Integer initialEmailInvocations = 0; 		//the initial number of email invocations such as sendEmail that have been called.
	//private Integer limitEmailInvocations {get; set;} 			//the total number of email invocation such as sendEmail that can be called.
	@TestVisible private Integer initialFutureCalls = 0; 				//the initial number of methods with the future annotation that have been executed not necessarily completed.
	//private Integer limitFutureCalls {get; set;} 				//the total number of methods with the future annotation that can be executed not necessarily completed.
	@TestVisible private Integer initialHeapSize = 0; 				//the initial approximate amount of memory in bytes that has been used for the heap.
	//private Integer limitHeapSize {get; set;} 					//the total amount of memory in bytes that can be used for the heap.
	@TestVisible private Integer initialMobilePushApexCalls = 0; 		//the initial number of Apex calls that have been used by mobile push notifications during the current metering interval.
	//private Integer limitMobilePushApexCalls {get; set;} 		//the total number of Apex calls that are allowed per transaction for mobile push notifications.
	@TestVisible private Integer initialQueries = 0; 					//the initial number of SOQL queries that have been issued.
	//private Integer limitQueries {get; set;} 					//the total number of SOQL queries that can be issued.
	@TestVisible private Integer initialQueryLocatorRows = 0; 		//the initial number of records that have been returned by the Database.getQueryLocator method.
	//private Integer limitQueryLocatorRows {get; set;} 			//the total number of records that have been returned by the Database.getQueryLocator method.
	@TestVisible private Integer initialQueryRows = 0; 				//the initial number of records that have been returned by issuing SOQL queries.
	//private Integer limitQueryRows {get; set;} 					//the total number of records that can be returned by issuing SOQL queries.
	@TestVisible private Integer initialQueueableJobs = 0; 			//the initial number of queueable jobs that have been added to the queue per transaction. A queueable job corresponds to a class that implements the Queueable interface.
	//private Integer limitQueueableJobs {get; set;} 				//the maximum number of queueable jobs that can be added to the queue per transaction. A queueable job corresponds to a class that implements the Queueable interface.
	@TestVisible private Integer initialSoslQueries = 0; 				//the initial number of SOSL queries that have been issued.
	//private Integer limitSoslQueries {get; set;} 				//the total number of SOSL queries that can be issued.

	private List<sObject> sObjectList {get; set;}
	private String dmlOperation {get; set;}
	private String objectName {get; set;}
	private String eventName {get; set;}
	@TestVisible private Limit_Log__c limitLog {get; set;}
	
	private void constructLimitLog() {
		this.limitLog = new Limit_Log__c();
		limitLog.Event_Name__c 	= eventName;
		limitLog.Aggregate_Queries_Limit__c		= LIMITS.getLimitAggregateQueries();
		limitLog.Async_Calls_Limit__c			= LIMITS.getLimitAsyncCalls();
		limitLog.Callouts_Limit__c				= LIMITS.getLimitCallouts();
		limitLog.CPU_Time_Limit__c				= LIMITS.getLimitCpuTime();
		limitLog.DML_Rows_Limit__c				= LIMITS.getLimitDMLRows();
		limitLog.DML_Statements_Limit__c		= LIMITS.getLimitDMLStatements();
		limitLog.Email_Invocations_Limit__c		= LIMITS.getLimitEmailInvocations();
		limitLog.Future_Calls_Limit__c			= LIMITS.getLimitFutureCalls();
		limitLog.Heap_Size_Limit__c				= LIMITS.getLimitHeapSize();
		limitLog.Mobile_Push_Apex_Calls_Limit__c= LIMITS.getLimitMobilePushApexCalls();
		limitLog.Queries_Limit__c				= LIMITS.getLimitQueries();
		limitLog.Query_Locator_Rows_Limit__c	= LIMITS.getLimitQueryLocatorRows();
		limitLog.Query_Limit__c					= LIMITS.getLimitQueryRows();
		limitLog.Queueable_Jobs_Limit__c		= LIMITS.getLimitQueueableJobs();
		limitLog.Sosl_Queries_Limit__c			= LIMITS.getLimitSoslQueries();

	}

	private void updateLog() {
		limitLog.Aggregate_Queries_Used__c		= LIMITS.getAggregateQueries() 		- this.initialAggregateQueries;
		limitLog.Async_Calls_Used__c			= LIMITS.getAsyncCalls() 			- this.initialAsyncCalls;
		limitLog.Callouts_Used__c				= LIMITS.getCallouts() 				- this.initialCallouts;
		limitLog.CPU_Time_Used__c				= LIMITS.getCpuTime() 				- this.initialCpuTime;
		limitLog.DML_Rows_Used__c				= LIMITS.getDMLRows() 				- this.initialDMLRows;
		limitLog.DML_Statements_Used__c			= LIMITS.getDMLStatements() 		- this.initialDMLStatements;
		limitLog.Email_Invocations_Used__c		= LIMITS.getEmailInvocations() 		- this.initialEmailInvocations;
		limitLog.Future_Calls_Used__c			= LIMITS.getFutureCalls() 			- this.initialFutureCalls;
		limitLog.Heap_Size_Used__c				= LIMITS.getHeapSize() 				- this.initialHeapSize;
		limitLog.Mobile_Push_Apex_Calls_Used__c	= LIMITS.getMobilePushApexCalls() 	- this.initialMobilePushApexCalls;
		limitLog.Queries_Used__c				= LIMITS.getQueries() 				- this.initialQueries;
		limitLog.Query_Locator_Rows_Used__c		= LIMITS.getQueryLocatorRows() 		- this.initialQueryLocatorRows;
		limitLog.Query_Rows__c 					= LIMITS.getQueryRows() 			- this.initialQueryRows;
		limitLog.Queueable_Jobs_Used__c			= LIMITS.getQueueableJobs() 		- this.initialQueueableJobs;
		limitLog.Sosl_Queries_Used__c			= LIMITS.getSoslQueries() 			- this.initialSoslQueries;
		limitLog.Records_Processed__c 			= sObjectList != null ? sObjectList.size() : null;
		//record count
		
		//add record snapshot?

		//add total values including performance framework? 
	}
	private void printLimits() {
		for(String fieldName: limitLog.getPopulatedFieldsAsMap().keySet()) {
			System.debug(fieldName.replace('__c', '').replace('_', ' ') + ':' + limitLog.get(fieldName));
		}
	}
	private void addLogToStack() {
		limitLogs.add(limitLog);
	}

}