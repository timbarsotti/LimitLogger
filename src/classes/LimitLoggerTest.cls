@isTest
public class LimitLoggerTest {
	@isTest
	public static void testNestedStops() {
		LimitLogger.commitLogs = true;
		LimitLogger outerLL = new LimitLogger('outer');
		LimitLogger innerLL = new LimitLogger('inner');
		innerLL.stop();
		outerLL.stop();
		outerLL.commitAll();
		List<Limit_Log__c> limitLogs = [SELECT Id, DML_Statements_Used__c, DML_Rows_Used__c FROM Limit_Log__c];

		System.assert(limitlogs.size() == 2, limitlogs.size());
		for(Limit_Log__c ll: limitlogs) {
			System.assert(ll.DML_Statements_Used__c == 0);
			System.assert(ll.DML_Rows_Used__c == 0);
		}
		System.assert(LIMITS.getDMLRows() == 3, LIMITS.getDMLRows());  //2 logs, 1 savepoint
		System.assert(LIMITS.getDMLStatements() == 2, LIMITS.getDMLStatements()); //1 for insert, 1 for savepoint
	}

	//TODO - unit test for hieracrhy 

	//TODO - unit test for custom setting driven Auto_Commit_When_Initial_Is_Stopped__c
	@isTest
	public static void testMultipleStops() {
		LimitLogger.debugLogs = true;
		Boolean stopError, startError;
		LimitLogger ll = new LimitLogger(null) ;
		ll.stop();

		try {

		} catch (LimitLogger.LimitLoggerException lle) {
			startError = true;
		}

		try {
			ll.stop();
		} catch (LimitLogger.LimitLoggerException lle) {
			stopError = true;
		}
		System.assert(stopError == true, 'Failed to throw exception of multiple stops');
	}
	@isTest 
	public static void testLimits() { 
		LimitLogger.commitLogs = true;
		LimitLogger outerLL = new LimitLogger(null);

		LimitLogger ll = new LimitLogger(null);
		System.assertEquals(ll.initialAggregateQueries, 0, 'initialAggregateQueries is incorrect value. ');
		System.assertEquals(ll.initialAsyncCalls, 0, 'initialAsyncCalls is incorrect value. ');
		System.assertEquals(ll.initialCallouts, 0, 'initialCallouts is incorrect value. ');
		System.assertEquals(ll.initialDMLRows, 0, 'initialDMLRows is incorrect value. ');
		System.assertEquals(ll.initialDMLStatements, 0, 'initialDMLStatements is incorrect value. ');
		System.assertEquals(ll.initialEmailInvocations, 0, 'initialEmailInvocations is incorrect value. ');
		System.assertEquals(ll.initialFutureCalls, 0, 'initialFutureCalls is incorrect value. ');
		System.assertEquals(ll.initialMobilePushApexCalls, 0, 'initialMobilePushApexCalls is incorrect value. ');
		System.assertEquals(ll.initialQueries, 0, 'initialQueries is incorrect value. ');
		System.assertEquals(ll.initialQueryLocatorRows, 0, 'initialQueryLocatorRows is incorrect value. ');
		System.assertEquals(ll.initialQueryRows, 0, 'initialQueryRows is incorrect value. ');
		System.assertEquals(ll.initialQueueableJobs, 0, 'initialQueueableJobs is incorrect value. ');
		System.assertEquals(ll.initialSoslQueries, 0, 'initialSoslQueries is incorrect value. ');
		ll.stop();

		//TODO - implement something to consume one of these and update the asserts
		System.assertEquals(0, ll.record.Aggregate_Queries_Used__c, 'Incorrect value for Aggregate_Queries_Used__c');
		//TODO - implement something to consume one of these and update the asserts
		System.assertEquals(0, ll.record.Async_Calls_Used__c, 'Incorrect value for Async_Calls_Used__c');
		//TODO - implement something to consume one of these and update the asserts
		System.assertEquals(0, ll.record.Callouts_Used__c, 'Incorrect value for Callouts_Used__c');
		//TODO - implement something to consume one of these and update the asserts
		System.assertEquals(0, ll.record.Email_Invocations_Used__c, 'Incorrect value for Email_Invocations_Used__c');
		//TODO - implement something to consume one of these and update the asserts
		System.assertEquals(0, ll.record.Mobile_Push_Apex_Calls_Used__c, 'Incorrect value for Mobile_Push_Apex_Calls_Used__c');
		//TODO - implement something to consume one of these and update the asserts
		System.assertEquals(0, ll.record.Query_Locator_Rows_Used__c, 'Incorrect value for Query_Locator_Rows_Used__c');
		//TODO - implement something to consume one of these and update the asserts
		System.assertEquals(0, ll.record.Queueable_Jobs_Used__c, 'Incorrect value for Queueable_Jobs_Used__c');
		//TODO - implement something to consume one of these and update the asserts
		System.assertEquals(0, ll.record.Sosl_Queries_Used__c, 'Incorrect value for Sosl_Queries_Used__c');
		
		System.assertEquals(0, ll.record.DML_Rows_Used__c, 'Incorrect value for DML_Rows_Used__c');
		System.assertEquals(0, ll.record.DML_Statements_Used__c, 'Incorrect value for DML_Statements_Used__c');
		System.assertEquals(null, ll.record.Records_Processed__c, 'Incorrect value for Records_Processed__c');
		System.assertEquals(0, ll.record.Query_Rows_Used__c, 'Incorrect value for Query_Rows_Used__c');
		System.assertEquals(0, ll.record.Future_Calls_Used__c, 'Incorrect value for Future_Calls_Used__c');
		System.assertEquals(0, ll.record.Queries_Used__c, 'Incorrect value for Queries_Used__c');

		futureMethod(); //consume async
		insert new Limit_Log__c(); //consume DML
		List<Limit_Log__c> aList = [SELECT Id FROM Limit_Log__c LIMIT 1]; //consume SOQL
		
		outerLL.stop();

		consumeCPU(5);
		System.assertEquals(1, outerLL.record.DML_Rows_Used__c, 'Incorrect value for DML_Rows_Used__c');
		System.assertEquals(1, outerLL.record.Cumulative_DML_Rows_Used__c, 'Incorrect value for DML_Rows_Used__c');
		System.assertEquals(1, outerLL.record.DML_Statements_Used__c, 'Incorrect value for DML_Statements_Used__c');
		System.assertEquals(null, outerLL.record.Records_Processed__c, 'Incorrect value for Records_Processed__c');
		System.assertEquals(1, outerLL.record.Query_Rows_Used__c, 'Incorrect value for Query_Rows_Used__c');
		System.assertEquals(1, outerLL.record.Future_Calls_Used__c, 'Incorrect value for Future_Calls_Used__c');
		System.assertEquals(1, outerLL.record.Queries_Used__c, 'Incorrect value for Queries_Used__c');
		
		System.assert(outerLL.record.CPU_Time_Used__c >= 5, 'Incorrect value for CPU_Time_Used__c');
		System.assert(outerLL.record.Heap_Size_Used__c > 0, 'Incorrect value for Heap_Size_Used__c:' + ll.record.Heap_Size_Used__c);
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