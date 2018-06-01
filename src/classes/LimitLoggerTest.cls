@isTest
public class LimitLoggerTest {
	@isTest
	public static void testMultipleStartStop() {
		Boolean stopError, startError;
		LimitLogger ll = new LimitLogger(null, null, null);
		ll.start();
		ll.stop();

		try {
			ll.start();
		} catch (LimitLogger.LimitLoggerException lle) {
			startError = true;
		}

		try {
			ll.stop();
		} catch (LimitLogger.LimitLoggerException lle) {
			stopError = true;
		}
		System.assert(stopError == true, 'Failed to throw exception of multiple stops');
		System.assert(startError == true, 'Failed to throw exception of multiple starts');
	}
	@isTest 
	public static void testLimits() {
		insert new Limit_Log__c();
		List<Limit_Log__c> aList = [SELECT Id FROM Limit_Log__c LIMIT 1];
		futureMethod();
		LimitLogger ll = new LimitLogger(null, null, null);
		System.assertEquals(ll.initialAggregateQueries, 0, 'initialAggregateQueries is incorrect value. ');
		System.assertEquals(ll.initialAsyncCalls, 0, 'initialAsyncCalls is incorrect value. ');
		System.assertEquals(ll.initialCallouts, 0, 'initialCallouts is incorrect value. ');
		System.assertEquals(ll.initialCpuTime, 0, 'initialCpuTime is incorrect value. ');
		System.assertEquals(ll.initialDMLRows, 0, 'initialDMLRows is incorrect value. ');
		System.assertEquals(ll.initialDMLStatements, 0, 'initialDMLStatements is incorrect value. ');
		System.assertEquals(ll.initialEmailInvocations, 0, 'initialEmailInvocations is incorrect value. ');
		System.assertEquals(ll.initialFutureCalls, 0, 'initialFutureCalls is incorrect value. ');
		System.assertEquals(ll.initialHeapSize, 0, 'initialHeapSize is incorrect value. ');
		System.assertEquals(ll.initialMobilePushApexCalls, 0, 'initialMobilePushApexCalls is incorrect value. ');
		System.assertEquals(ll.initialQueries, 0, 'initialQueries is incorrect value. ');
		System.assertEquals(ll.initialQueryLocatorRows, 0, 'initialQueryLocatorRows is incorrect value. ');
		System.assertEquals(ll.initialQueryRows, 0, 'initialQueryRows is incorrect value. ');
		System.assertEquals(ll.initialQueueableJobs, 0, 'initialQueueableJobs is incorrect value. ');
		System.assertEquals(ll.initialSoslQueries, 0, 'initialSoslQueries is incorrect value. ');
		
		ll.start();
		ll.stop();
		//TODO - implement something to consume one of these and update the asserts
		System.assertEquals(0, ll.limitLog.Aggregate_Queries_Used__c, 'Incorrect value for Aggregate_Queries_Used__c');
		//TODO - implement something to consume one of these and update the asserts
		System.assertEquals(0, ll.limitLog.Async_Calls_Used__c, 'Incorrect value for Async_Calls_Used__c');
		//TODO - implement something to consume one of these and update the asserts
		System.assertEquals(0, ll.limitLog.Callouts_Used__c, 'Incorrect value for Callouts_Used__c');
		//TODO - implement something to consume one of these and update the asserts
		System.assertEquals(0, ll.limitLog.Email_Invocations_Used__c, 'Incorrect value for Email_Invocations_Used__c');
		//TODO - implement something to consume one of these and update the asserts
		System.assertEquals(0, ll.limitLog.Mobile_Push_Apex_Calls_Used__c, 'Incorrect value for Mobile_Push_Apex_Calls_Used__c');
		//TODO - implement something to consume one of these and update the asserts
		System.assertEquals(0, ll.limitLog.Query_Locator_Rows_Used__c, 'Incorrect value for Query_Locator_Rows_Used__c');
		//TODO - implement something to consume one of these and update the asserts
		System.assertEquals(0, ll.limitLog.Queueable_Jobs_Used__c, 'Incorrect value for Queueable_Jobs_Used__c');
		//TODO - implement something to consume one of these and update the asserts
		System.assertEquals(0, ll.limitLog.Sosl_Queries_Used__c, 'Incorrect value for Sosl_Queries_Used__c');
		
		System.assertEquals(0, ll.limitLog.DML_Rows_Used__c, 'Incorrect value for DML_Rows_Used__c');
		System.assertEquals(0, ll.limitLog.DML_Statements_Used__c, 'Incorrect value for DML_Statements_Used__c');
		System.assertEquals(null, ll.limitLog.Records_Processed__c, 'Incorrect value for Records_Processed__c');
		System.assertEquals(0, ll.limitLog.Query_Rows__c, 'Incorrect value for Query_Rows__c');
		System.assertEquals(0, ll.limitLog.Future_Calls_Used__c, 'Incorrect value for Future_Calls_Used__c');
		System.assertEquals(0, ll.limitLog.Queries_Used__c, 'Incorrect value for Queries_Used__c');

		LimitLogger llWithoutStart = new LimitLogger(null, null, null);
		llWithoutStart.stop();
		consumeCPU(5);
		System.assertEquals(1, llWithoutStart.limitLog.DML_Rows_Used__c, 'Incorrect value for DML_Rows_Used__c');
		System.assertEquals(1, llWithoutStart.limitLog.DML_Statements_Used__c, 'Incorrect value for DML_Statements_Used__c');
		System.assertEquals(null, llWithoutStart.limitLog.Records_Processed__c, 'Incorrect value for Records_Processed__c');
		System.assertEquals(1, llWithoutStart.limitLog.Query_Rows__c, 'Incorrect value for Query_Rows__c');
		System.assertEquals(1, llWithoutStart.limitLog.Future_Calls_Used__c, 'Incorrect value for Future_Calls_Used__c');
		System.assertEquals(1, llWithoutStart.limitLog.Queries_Used__c, 'Incorrect value for Queries_Used__c');
		
		System.assert(llWithoutStart.limitLog.CPU_Time_Used__c >= 5, 'Incorrect value for CPU_Time_Used__c');
		System.assert(llWithoutStart.limitLog.Heap_Size_Used__c > 0, 'Incorrect value for Heap_Size_Used__c:' + ll.limitlog.Heap_Size_Used__c);
	}
	@future
	private static void futureMethod() {

	}
	private static void consumeCPU(Integer ms) {
        Integer startTime = LIMITS.getCpuTime();
        while((LIMITS.getCpuTime() - startTime) < ms) {
	        Double random = math.random();
        }
    }
}