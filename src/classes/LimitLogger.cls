/**
 * Copyright (c) 2018, Tim Barsotti
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 *   are permitted provided that the following conditions are met:
 *
 * - Redistributions of source code must retain the above copyright notice,
 *		this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright notice,
 *		this list of conditions and the following disclaimer in the documentation
 *		and/or other materials provided with the distribution.
 * - Neither the name of the Tim Barsotti, inc nor the names of its contributors
 *		may be used to endorse or promote products derived from this software without
 *		specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
 * THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 * OR SERVICES;LOSS OF USE, DATA, OR PROFITS;OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
 * OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
**/
public class LimitLogger {
	/* Constructors */
	/**
	* Constructs a new LimitLogger
	*
	* @param sObjectList A list of objects - the size gets logged in the Limit_Log__c object
	* @param eventName the friendly name for the log - saved in the Limit_Log__c.Event_Name__c
	*/
	public LimitLogger(List<sObject> sObjectList, String eventName) {
		if(limitLoggerEnabled) {
			this(eventName);
			this.sObjectList = sObjectList;
		}
	}
	/**
	* Constructs a new LimitLogger
	*
	* @param eventName the friendly name for the log - saved in the Limit_Log__c.Event_Name__c
	*/

	public LimitLogger(String eventName) {
		if(limitLoggerEnabled) {
			logStartOrder++;
			this.eventName = eventName;
			initializeLimitLogRecord();
			initialLog = this;
			start();
		}
	}

	public LimitLogger() {
		if(limitLoggerEnabled) {
			this(String.valueOf(transactionNumber));
			initializeLimitLogRecord();
		}
	}

	/* inner classes */
	public class LimitLoggerException extends Exception {}
	
	//if the Debug_Limits__c is true, then the logs are printed in the debug logs
	//custom setter allows programmatic overrides
	public static Boolean debugLogs { get {
		if(debugLogs == null) {
			debugLogs = limitLoggerSettings.Debug_Limits__c;
		}
		return debugLogs;
	} set;}

	//if the Commit_Logs_To_Database__c is true, then the logs are saved to the database when the initially constructed limit log is stopped
	//custom setter allows programmatic overrides
	public static Boolean commitLogs { get {
		if(commitLogs == null) {
			commitLogs = limitLoggerSettings.Commit_Logs_To_Database__c;
		}
		return commitLogs;
	} set;}

	/* Attributes */ 
	//if log has stopped already, then don't allow stopping again
	private Boolean stopped {
		get { 
			if(stopped == null) {
				return false;
			} 
			return stopped;
		}
		set { 
			if(stopped != null && stopped) {
				throw new LimitLoggerException(Label.LIMIT_LOG_MAX_ONCE_STOP_EXCEPTION);
			} else if (value) {
				logStopOrder++;
				this.stopped = value;
				this.record.Log_Stop_Order__c = logStopOrder;
			}
		}
	}

	//if this is being processed with a list of sObjects, then the size of the list will be logged to Limit_Log__c.Records_Processed__c
	private List<sObject> sObjectList;

	//the friendly name for the event that this was generated from
	private String eventName;

	//the limit log that is being worked with
	@TestVisible private Limit_Log__c record {get; set;}

	//the initial / cumulativenumber of aggregate queries that have been processed with any SOQL query statement.
	@TestVisible private Integer initialAggregateQueries = 0;
	@TestVisible private Integer cumulativeAggregateQueries {
		get { 
			return LIMITS.getAggregateQueries();
		}
	}
	//Reserved for future use.
	@TestVisible private Integer initialAsyncCalls = 0;
	@TestVisible private Integer cumulativeAsyncCalls {
		get {
			return LIMITS.getAsyncCalls();
		}
	}
	//the initial / cumulative number of Web service statements that have been processed.
	@TestVisible private Integer initialCallouts = 0;
	@TestVisible private Integer cumulativeCallouts {
		get {
			return LIMITS.getCallouts();
		}
	}
	//the initial / cumulative CPU time in milliseconds accumulated on the Salesforce servers in the current transaction.
	@TestVisible private Integer initialCpuTime = 0;
	@TestVisible private Integer cumulativeCpuTime {
		get {
			return LIMITS.getCpuTime();
		}
	}
	//the initial / cumulative number of records that have been processed with any statement that counts against DML limits, such as DML statements, the Database.emptyRecycleBin method, and other methods.
	@TestVisible private Integer initialDMLRows = 0;
	@TestVisible private Integer cumulativeDMLRows {
		get {
			return LIMITS.getDMLRows();
		}
	}
	//the initial / cumulative number of DML statements such as insert, update or the database.EmptyRecycleBin method that have been called.
	@TestVisible private Integer initialDMLStatements = 0;
	@TestVisible private Integer cumulativeDMLStatements {
		get {
			return LIMITS.getDMLStatements();
		}
	}
	//the initial / cumulative number of email invocations such as sendEmail that have been called.
	@TestVisible private Integer initialEmailInvocations = 0;
	@TestVisible private Integer cumulativeEmailInvocations {
		get {
			return LIMITS.getEmailInvocations();
		}
	}
	//the initial / cumulative number of methods with the future annotation that have been executed not necessarily completed.
	@TestVisible private Integer initialFutureCalls = 0;
	@TestVisible private Integer cumulativeFutureCalls {
		get {
			return LIMITS.getFutureCalls();
		}
	}
	//the initial / cumulative approximate amount of memory in bytes that has been used for the heap.
	@TestVisible private Integer initialHeapSize = 0;
	@TestVisible private Integer cumulativeHeapSize {
		get {
			return LIMITS.getHeapSize();
		}
	}
	//the initial / cumulative number of Apex calls that have been used by mobile push notifications during the current metering interval.
	@TestVisible private Integer initialMobilePushApexCalls = 0;
	@TestVisible private Integer cumulativeMobilePushApexCalls {
		get {
			return LIMITS.getMobilePushApexCalls();
		}
	}
	//the cumulative number of SOQL queries that have been issued.
	@TestVisible private Integer initialQueries = 0;
	@TestVisible private Integer cumulativeQueries {
		get {
			return LIMITS.getQueries();
		}
	}
	//the initial / cumulative number of records that have been returned by the Database.getQueryLocator method.
	@TestVisible private Integer initialQueryLocatorRows = 0;
	@TestVisible private Integer cumulativeQueryLocatorRows {
		get {
			return LIMITS.getQueryLocatorRows();
		}
	}
	//the initial / cumulative number of records that have been returned by issuing SOQL queries.
	@TestVisible private Integer initialQueryRows = 0;
	@TestVisible private Integer cumulativeQueryRows {
		get {
			return LIMITS.getQueryRows();
		}
	}
	//the initial / cumulative number of queueable jobs that have been added to the queue per transaction. A queueable job corresponds to a class that implements the Queueable interface.
	@TestVisible private Integer initialQueueableJobs = 0;
	@TestVisible private Integer cumulativeQueueableJobs {
		get {
			return LIMITS.getQueueableJobs();
		}
	}
	//the initial / cumulative number of SOSL queries that have been issued.
	@TestVisible private Integer initialSoslQueries = 0;
	@TestVisible private Integer cumulativeSoslQueries {
		get {
			return LIMITS.getSoslQueries();
		}
	}
	private Boolean triggerIsExecuting {get; set;}
	private Integer triggerSize {get; set;}
	private Set<String> triggerContext {get; set;}
	private Long startTime;
	private Integer endTime;

	/* Statics */
	//running list of Limit_Logs__c to commit later
	private static List<Limit_Log__c> uncommittedRecords = new List<Limit_Log__c>();
	private static List<Limit_Log__c> allWorkingRecords = new List<Limit_Log__c>();

	// static variable used to keep track of whether or not the initial log is the one being stopped or not
	private static LimitLogger initialLog {get; set{
		if(value == null) {
			initialLog = null;
		} else {
			if(initialLog == null) {
				initialLog = value;
			}
		}
	}}

	/** Custom setting derives if the limit logger is enabled. 
	 * if neither checkbox is enabled, nothing happens. 
	 * if the Debug_Limits__c is true, then the logs are printed in the debug logs
	 * if the Commit_Logs_To_Database__c is true, then the logs are saved to the database when the initially constructed limit log is stopped
	 */
	private static Limit_Logger_Settings__c limitLoggerSettings = Limit_Logger_Settings__c.getInstance();
	
	private static Integer limitAggregateQueries = LIMITS.getLimitAggregateQueries();
	private static Integer limitAsyncCalls = LIMITS.getLimitAsyncCalls();
	private static Integer limitCallouts = LIMITS.getLimitCallouts();
	private static Integer limitCpuTime = LIMITS.getLimitCpuTime();
	private static Integer limitDMLRows = LIMITS.getLimitDMLRows();
	private static Integer limitDMLStatements = LIMITS.getLimitDMLStatements();
	private static Integer limitEmailInvocations = LIMITS.getLimitEmailInvocations();
	private static Integer limitFutureCalls = LIMITS.getLimitFutureCalls();
	private static Integer limitHeapSize = LIMITS.getLimitHeapSize();
	private static Integer limitMobilePushApexCalls = LIMITS.getLimitMobilePushApexCalls();
	private static Integer limitQueries = LIMITS.getLimitQueries();
	private static Integer limitQueryLocatorRows = LIMITS.getLimitQueryLocatorRows();
	private static Integer limitQueryRows = LIMITS.getLimitQueryRows();
	private static Integer limitQueueableJobs = LIMITS.getLimitQueueableJobs();
	private static Integer limitSoslQueries = LIMITS.getLimitSoslQueries();
	private static Boolean queueable = System.isQueueable();
	private static Boolean future = System.isFuture();
	private static Boolean scheduled = System.isScheduled();
	private static Boolean batchable = System.isBatch();
	//if limit logger is not set to debugLogs or commitLogs, nothing happens. 
	private static Boolean limitLoggerEnabled { get{ 
		return (commitLogs || debugLogs);
	}}

	// transaction number will be shared by all records of the same execution context
	private static Double transactionNumber = Math.random() * 10000000;
	private static Integer logStartOrder = 0;
	private static Integer logStopOrder = 0;

	/* Methods */

	/**
	* Stops the current log. If it is the initial log that was constructed, then the logs are committed to the database
	*/
	public void stop() {
		if(!limitLoggerEnabled) { return;}
		stopped = true;
		updateLog();

		printLimits();
		addLogToList();
		if(limitLoggerSettings.Auto_Commit_When_Initial_Is_Stopped__c) {
			commitAll();
		}
	}

	/**
	*  Saves the log: either adds to the static variable to commit later or if it is the initial log in the stack it will commit all of them.
	*/
	public void commitAll() {
		if(commitLogs && initialLog.stopped == true) {
			Savepoint sp = Database.setSavepoint();

			try {
				insert uncommittedRecords;
				if(limitLoggerSettings.Set_Wrapper_Relationships_Between_Logs__c) {
					allWorkingRecords.addAll(uncommittedRecords);
					List<Limit_Log__c> toUpdate = setParentChildRelations(allWorkingRecords);
					update toUpdate;
				}

				uncommittedRecords = new List<Limit_Log__c>();

				//establish parent child relationship
				//sort by max spread
				

				initialLog = null;
			} catch (exception e) {
				System.debug(e);
				Database.rollback(sp);
			}
		} else {
			if(!commitLogs) {
				System.debug('Did not commit logs. CommitLogs set to: ' + commitLogs);
			}
			if(initialLog != null && initialLog.stopped == false) {
				System.debug(Label.STOP_INITIAL_LOG_BEFORE_COMMIT);
			}
		}
	}

	/**
	* Starts the current log and resets the initial values to zero
	*/
	private void start() {
		if(!limitLoggerEnabled) { return;}
		this.startTime 						= System.now().getTime();
		this.initialAggregateQueries 		= LIMITS.getAggregateQueries();
		this.initialAsyncCalls 				= LIMITS.getAsyncCalls();
		this.initialCallouts 				= LIMITS.getCallouts();
		this.initialCpuTime 				= LIMITS.getCpuTime();
		this.initialDMLRows 				= LIMITS.getDMLRows();
		this.initialDMLStatements 			= LIMITS.getDMLStatements();
		this.initialEmailInvocations 		= LIMITS.getEmailInvocations();
		this.initialFutureCalls 			= LIMITS.getFutureCalls();
		this.initialHeapSize 				= LIMITS.getHeapSize();
		this.initialMobilePushApexCalls 	= LIMITS.getMobilePushApexCalls();
		this.initialQueries 				= LIMITS.getQueries();
		this.initialQueryLocatorRows 		= LIMITS.getQueryLocatorRows();
		this.initialQueryRows 				= LIMITS.getQueryRows();
		this.initialQueueableJobs 			= LIMITS.getQueueableJobs();
		this.initialSoslQueries 			= LIMITS.getSoslQueries();
		this.triggerIsExecuting				= Trigger.isExecuting;
		if(Trigger.isExecuting) {
			this.triggerSize 				= Trigger.size;
			this.triggerContext				= new Set<String>{String.valueOf(trigger.operationType)};
		}
	}

	private List<Limit_Log__c> setParentChildRelations(List<Limit_Log__c> records) {
		Map<Id, Limit_Log__c> toUpdateMap = new Map<Id, Limit_Log__c>();
		Map<Integer, List<Limit_Log__c>> limitLogBySpread = new Map<Integer, List<Limit_Log__c>>();
		for(Limit_Log__c ll: records) {
			if(ll.Id == initialLog.record.Id) { continue; }
			if(ll.Wrapper_Limit_Log__c == null) {
				ll.Wrapper_Limit_Log__c = initialLog.record.Id;
				toUpdateMap.put(ll.Id, ll);
			}
			Integer spread = (Integer)(ll.Log_Stop_Order__c - ll.Log_Start_Order__c);
			List<Limit_Log__c> spreadList = limitLogBySpread.get(spread);
			if(spreadList == null) { 
				spreadList = new List<Limit_Log__c>(); 
			}
			spreadList.add(ll);
			limitLogBySpread.put(spread, spreadList);
		}
		List<Integer> spreadKeyList = new List<Integer>(limitLogBySpread.keySet());
		spreadKeyList.sort();

		for(Integer i = spreadKeyList.size() -1; i >= 0; i--) { //loop through super sets in reverse, maximum first
			Integer superSetLogKey = spreadKeyList[i];
			List<Limit_Log__c> superSetLogs = limitLogBySpread.get(superSetLogKey);
			for(Limit_Log__c superLog: superSetLogs) {
				for(Integer subsetLogKey: spreadKeyList) { //loop through subset from smallest first
					if(superSetLogKey < subsetLogKey) { continue; }
					List<Limit_Log__c> subSetLogs = limitLogBySpread.get(subsetLogKey);
					for(Limit_Log__c subLog: subSetLogs) {
						if(superLog.Log_Start_Order__c >= subLog.Log_Start_Order__c) {
							continue;
						} 
						if(superLog.Log_Stop_Order__c <= subLog.Log_Stop_Order__c) {
							continue; //
						}
						//TODO - known issue - will update even if it doesn't need to due to the way it loops through the super / sub set
						if(subLog.Wrapper_Limit_Log__c != superLog.Id) { 
							subLog.Wrapper_Limit_Log__c = superLog.Id;
							toUpdateMap.put(subLog.Id, subLog);
						}
					}
				}
			}
		}
		return toUpdateMap.values();
	}
	/**
	*  Initializes the limit log record
	*/
	private void initializeLimitLogRecord() {
		this.record = new Limit_Log__c(
			Log_Start_Order__c 				= logStartOrder,
			Event_Name__c 					= eventName,
			Transaction__c 					= transactionNumber,
			Aggregate_Queries_Limit__c 		= limitAggregateQueries,
			Async_Calls_Limit__c			= limitAsyncCalls,
			Callouts_Limit__c				= limitCallouts,
			CPU_Time_Limit__c				= limitCpuTime,
			DML_Rows_Limit__c				= limitDMLRows,
			DML_Statements_Limit__c			= limitDMLStatements,
			Email_Invocations_Limit__c		= limitEmailInvocations,
			Future_Calls_Limit__c			= limitFutureCalls,
			Heap_Size_Limit__c				= limitHeapSize,
			Mobile_Push_Apex_Calls_Limit__c	= limitMobilePushApexCalls,
			Queries_Limit__c				= limitQueries,
			Query_Locator_Rows_Limit__c		= limitQueryLocatorRows,
			Query_Rows_Limit__c				= limitQueryRows,
			Queueable_Jobs_Limit__c			= limitQueueableJobs,
			Sosl_Queries_Limit__c			= limitSoslQueries,
			Queueable__c					= queueable,
			Future__c						= future,
			Scheduled__c					= scheduled,
			Batchable__c					= batchable
		);
	}

	/**
	*  Updates the log with the current and cumulative usage
	*/
	private void updateLog() {
		record.Aggregate_Queries_Used__c				= this.cumulativeAggregateQueries 		- this.initialAggregateQueries;
		record.Cumulative_Aggregate_Queries_Used__c		= this.cumulativeAggregateQueries;
		
		record.Async_Calls_Used__c						= this.cumulativeAsyncCalls 			- this.initialAsyncCalls;
		record.Cumulative_Async_Calls_Used__c			= this.cumulativeAsyncCalls;
		
		record.Callouts_Used__c							= this.cumulativeCallouts 				- this.initialCallouts;
		record.Cumulative_Callouts_Used__c				= this.cumulativeCallouts;
		
		record.CPU_Time_Used__c							= this.cumulativeCpuTime 				- this.initialCpuTime;
		record.Cumulative_CPU_Time_Used__c				= this.cumulativeCpuTime;
		
		record.DML_Rows_Used__c							= this.cumulativeDMLRows 				- this.initialDMLRows;
		record.Cumulative_DML_Rows_Used__c				= this.cumulativeDMLRows;
		
		record.DML_Statements_Used__c					= this.cumulativeDMLStatements 			- this.initialDMLStatements;
		record.Cumulative_DML_Statements_Used__c		= this.cumulativeDMLStatements;
		
		record.Email_Invocations_Used__c				= this.cumulativeEmailInvocations 		- this.initialEmailInvocations;
		record.Cumulative_Email_Invocations_Used__c		= this.cumulativeEmailInvocations;
		
		record.Future_Calls_Used__c						= this.cumulativeFutureCalls 			- this.initialFutureCalls;
		record.Cumulative_Future_Calls_Used__c			= this.cumulativeFutureCalls;
		
		record.Heap_Size_Used__c						= this.cumulativeHeapSize 				- this.initialHeapSize;
		record.Cumulative_Heap_Size_Used__c				= this.cumulativeHeapSize;
		
		record.Mobile_Push_Apex_Calls_Used__c			= this.cumulativeMobilePushApexCalls 	- this.initialMobilePushApexCalls;
		record.Cumulative_Mobile_Push_Apex_Calls_Used__c= this.cumulativeMobilePushApexCalls;
		
		record.Queries_Used__c							= this.cumulativeQueries 				- this.initialQueries;
		record.Cumulative_Queries_Used__c				= this.cumulativeQueries;
		
		record.Query_Locator_Rows_Used__c				= this.cumulativeQueryLocatorRows 		- this.initialQueryLocatorRows;
		record.Cumulative_Query_Locator_Rows_Used__c	= this.cumulativeQueryLocatorRows;
		
		record.Query_Rows_Used__c 						= this.cumulativeQueryRows 				- this.initialQueryRows;
		record.Cumulative_Query_Rows_Used__c 			= this.cumulativeQueryRows;
		
		record.Queueable_Jobs_Used__c					= this.cumulativeQueueableJobs 			- this.initialQueueableJobs;
		record.Cumulative_Queueable_Jobs_Used__c		= this.cumulativeQueueableJobs;
		
		record.Sosl_Queries_Used__c						= this.cumulativeSoslQueries 			- this.initialSoslQueries;
		record.Cumulative_Sosl_Queries_Used__c			= this.cumulativeSoslQueries;
		
		record.Records_Processed__c 					= sObjectList != null ? sObjectList.size() : null;
		record.Time__c 									= System.now().getTime() - startTime;

		record.Trigger_Is_Executing__c 					= triggerIsExecuting;
		if(Trigger.isExecuting) {
			triggerContext.add(String.valueOf(Trigger.operationType));
			record.Trigger_Size__c						= triggerSize;
			for(String context: triggerContext) {
				record.Trigger_Contexts__c = context + ';';	
			}
		}

	}
	/**
	*  Prints the record fields in the debug log
	*/
	private void printLimits() {
		if(debugLogs) {
			for(String fieldName: this.record.getPopulatedFieldsAsMap().keySet()) {
				if(!fieldName.contains('Used__c')) { continue; }
				System.debug(this.eventName + ': ' + fieldName.replace('__c', '').replace('_', ' ') + ':' + this.record.get(fieldName));
			}
		}
	}
	/**
	*  Adds log to the list for saving later
	*/
	private void addLogToList() {
		if(commitLogs) {
			uncommittedRecords.add(record);
		}
	}
}