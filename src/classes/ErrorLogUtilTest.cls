/* 	Author: Tim Barsotti 
	Date 11/18/17
*/
@IsTest
public class ErrorLogUtilTest extends ErrorLogUtil {
	@IsTest
	public static void testErrorLogUtil(){
		Account a = new Account();
		Account a2 = new Account(Name = 'Test');
		try {
			insert a;
		} catch (DmlException dmlEx) {
			log('Custom Message', dmlEx);
			log(dmlEx);
		}
		System.assertEquals(2, ErrorLogUtil.errorLogs.size());

		try {
			insert a;
		} catch (Exception ex) {
			log('Custom Message', ex);
			log(ex);
		}
		System.assertEquals(4, ErrorLogUtil.errorLogs.size());

		List<String> messageList = new List<String>{'1', '2'};
		log('msg', messageList);
		System.assertEquals(5, ErrorLogUtil.errorLogs.size());

		HttpResponse response = new HttpResponse();
		log('msg', response);
		log(response);
		System.assertEquals(7, ErrorLogUtil.errorLogs.size());


		handleSaveResults(Database.insert(a, false));
		System.assertEquals(8, ErrorLogUtil.errorLogs.size());
		handleSaveResults(Database.upsert(a, false));
		System.assertEquals(9, ErrorLogUtil.errorLogs.size());

		handleSaveResults(Database.insert(new List<Account>{a, a2}, false));
		System.assertEquals(10, ErrorLogUtil.errorLogs.size());

		handleSaveResults(Database.upsert(new List<Account>{a, a2}, false));
		System.assertEquals(11, ErrorLogUtil.errorLogs.size());

		handleSaveResults('Custom Message', Database.insert(a, false));
		System.assertEquals(12, ErrorLogUtil.errorLogs.size());
		handleSaveResults('Custom Message', Database.upsert(a, false));
		System.assertEquals(13, ErrorLogUtil.errorLogs.size());

		handleSaveResults('Custom Message', Database.upsert(new List<Account>{a, a2}, false));
		System.assertEquals(14, ErrorLogUtil.errorLogs.size());

		handleSaveResults('Custom Message', Database.insert(new List<Account>{a, a2}, false));
		System.assertEquals(16, ErrorLogUtil.errorLogs.size());


		log(Database.insert(a, false));
		System.assertEquals(17, ErrorLogUtil.errorLogs.size());
		log('String message', Database.insert(new List<Account>{a, a2}, false));
		System.assertEquals(19, ErrorLogUtil.errorLogs.size());
		log(Database.upsert(new List<Account>{a, a2}, false));
		System.assertEquals(20, ErrorLogUtil.errorLogs.size());
		log('String message', Database.upsert(new List<Account>{a, a2}, false));
		System.assertEquals(21, ErrorLogUtil.errorLogs.size());
		commitLogs();

		System.assertEquals(0, ErrorLogUtil.errorLogs.size());		
		System.assertEquals(21, [SELECT Id FROM Error_Log__c].size());
	}
	@isTest
	private static void testException() {
		try {
			Account a;
			Contact c = a.Contacts[0];
		} catch (Exception e) {
			log(e);
			log('message', e);
		}
		System.assertEquals(2, ErrorLogUtil.errorLogs.size(), 'Failed to add log to stack');
	}
	@isTest
	private static void testAsyncException() {
		try {
			throw new AsyncException('failed');
		} catch (AsyncException e) {
			log(e);
			log('message', e);
		}
		System.assertEquals(2, ErrorLogUtil.errorLogs.size(), 'Failed to add log to stack');
	}
	@isTest
	private static void testBigObjectException() {
		try {
			throw new BigObjectException('failed');
		} catch (BigObjectException e) {
			log(e);
			log('message', e);
		}
		System.assertEquals(2, ErrorLogUtil.errorLogs.size(), 'Failed to add log to stack');
	}
	@isTest
	private static void testCalloutException() {
		try {
			throw new CalloutException('failed');
		} catch (CalloutException e) {
			log(e);
			log('message', e);
		}
		System.assertEquals(2, ErrorLogUtil.errorLogs.size(), 'Failed to add log to stack');
	}
	@isTest
	private static void testEmailException() {
		try {
			throw new EmailException('failed');
		} catch (EmailException e) {
			log(e);
			log('message', e);
		}
		System.assertEquals(2, ErrorLogUtil.errorLogs.size(), 'Failed to add log to stack');
	}
	@isTest
	private static void testExternalObjectException() {
		try {
			throw new ExternalObjectException('failed');
		} catch (ExternalObjectException e) {
			log(e);
			log('message', e);
		}
		System.assertEquals(2, ErrorLogUtil.errorLogs.size(), 'Failed to add log to stack');
	}
	@isTest
	private static void testInvalidParameterValueException() {
		try {
			throw new InvalidParameterValueException('someParam', 'failed');
		} catch (InvalidParameterValueException e) {
			log(e);
			log('message', e);
		}
		System.assertEquals(2, ErrorLogUtil.errorLogs.size(), 'Failed to add log to stack');
	}
	//cant be caught yet
	//@isTest
	//private static void testLimitException() {
	//	try {
	//		throw new LimitException('failed');
	//	} catch (LimitException e) {
	//		log(e);
	//		log('message', e);
	//	}
	//	System.assertEquals(2, ErrorLogUtil.errorLogs.size(), 'Failed to add log to stack');
	//}
	@isTest
	private static void testJSONException() {
		try {
			throw new JSONException('failed');
		} catch (JSONException e) {
			log(e);
			log('message', e);
		}
		System.assertEquals(2, ErrorLogUtil.errorLogs.size(), 'Failed to add log to stack');
	}
	@isTest
	private static void testListException() {
		try {
			throw new ListException('failed');
		} catch (ListException e) {
			log(e);
			log('message', e);
		}
		System.assertEquals(2, ErrorLogUtil.errorLogs.size(), 'Failed to add log to stack');
	}
	@isTest
	private static void testMathException() {
		try {
			throw new MathException('failed');
		} catch (MathException e) {
			log(e);
			log('message', e);
		}
		System.assertEquals(2, ErrorLogUtil.errorLogs.size(), 'Failed to add log to stack');
	}
	@isTest
	private static void testNoAccessException() {
		try {
			throw new NoAccessException();
		} catch (NoAccessException e) {
			log(e);
			log('message', e);
		}
		System.assertEquals(2, ErrorLogUtil.errorLogs.size(), 'Failed to add log to stack');
	}
	@isTest
	private static void testNoDataFoundException() {
		try {
			throw new NoDataFoundException();
		} catch (NoDataFoundException e) {
			log(e);
			log('message', e);
		}
		System.assertEquals(2, ErrorLogUtil.errorLogs.size(), 'Failed to add log to stack');
	}
	@isTest
	private static void testNoSuchElementException() {
		try {
			throw new NoSuchElementException('failed');
		} catch (NoSuchElementException e) {
			log(e);
			log('message', e);
		}
		System.assertEquals(2, ErrorLogUtil.errorLogs.size(), 'Failed to add log to stack');
	}
	@isTest
	private static void testNullPointerException() {
		try {
			Account a;
			Contact c = a.Contacts[0];
		} catch (NullPointerException e) {
			log(e);
			log('message', e);
		}
		System.assertEquals(2, ErrorLogUtil.errorLogs.size(), 'Failed to add log to stack');
	}
	@isTest
	private static void testQueryException() {
		try {
			throw new QueryException('failed');
		} catch (QueryException e) {
			log(e);
			log('message', e);
		}
		System.assertEquals(2, ErrorLogUtil.errorLogs.size(), 'Failed to add log to stack');
	}
	@isTest
	private static void testRequiredFeatureMissingException() {
		try {
			throw new RequiredFeatureMissingException('failed');
		} catch (RequiredFeatureMissingException e) {
			log(e);
			log('message', e);
		}
		System.assertEquals(2, ErrorLogUtil.errorLogs.size(), 'Failed to add log to stack');
	}
	@isTest
	private static void testSearchException() {
		try {
			throw new SearchException('failed');
		} catch (SearchException e) {
			log(e);
			log('message', e);
		}
		System.assertEquals(2, ErrorLogUtil.errorLogs.size(), 'Failed to add log to stack');
	}
	@isTest
	private static void testSecurityException() {
		try {
			throw new SecurityException('failed');
		} catch (SecurityException e) {
			log(e);
			log('message', e);
		}
		System.assertEquals(2, ErrorLogUtil.errorLogs.size(), 'Failed to add log to stack');
	}
	@isTest
	private static void testSerializationException() {
		try {
			throw new SerializationException('failed');
		} catch (SerializationException e) {
			log(e);
			log('message', e);
		}
		System.assertEquals(2, ErrorLogUtil.errorLogs.size(), 'Failed to add log to stack');
	}
	@isTest
	private static void testSObjectException() {
		try {
			throw new SObjectException('failed');
		} catch (SObjectException e) {
			log(e);
			log('message', e);
		}
		System.assertEquals(2, ErrorLogUtil.errorLogs.size(), 'Failed to add log to stack');
	}
	@isTest
	private static void testStringException() {
		try {
			throw new StringException('failed');
		} catch (StringException e) {
			log(e);
			log('message', e);
		}
		System.assertEquals(2, ErrorLogUtil.errorLogs.size(), 'Failed to add log to stack');
	}
	@isTest
	private static void testTypeException() {
		try {
			throw new TypeException('failed');
		} catch (TypeException e) {
			log(e);
			log('message', e);
		}
		System.assertEquals(2, ErrorLogUtil.errorLogs.size(), 'Failed to add log to stack');
	}
	@isTest
	private static void testVisualforceException() {
		try {
			throw new VisualforceException('failed');
		} catch (VisualforceException e) {
			log(e);
			log('message', e);
		}
		System.assertEquals(2, ErrorLogUtil.errorLogs.size(), 'Failed to add log to stack');
	}
	@isTest
	private static void testXmlException() {
		try {
			throw new XmlException('failed');
		} catch (XmlException e) {
			log(e);
			log('message', e);
		}
		System.assertEquals(2, ErrorLogUtil.errorLogs.size(), 'Failed to add log to stack');
	}
	@isTest
	private static void testDmlException() {
		try {
			throw new DmlException('failed');
		} catch (DmlException e) {
			log(e);
			log('message', e);
		}
		System.assertEquals(2, ErrorLogUtil.errorLogs.size(), 'Failed to add log to stack');
	}
	@isTest
	private static void exceedsMaxLength() {
		Error_Log__c log = new Error_Log__c();
		String msg = '54 character long string to exceed max length of field';
		//131072 / 54 = = 2427;
		for(Integer i = 0; i < 2800; i++) {
			log.Message__c += msg;
			log.Stack_Trace__c += msg;
			log.Status__c += msg;
			log.Type_Name__c += msg;
			log.Header_Keys__c += msg;
			log.Cause__c += msg;
			log.Body_Document__c += msg;
		}
		System.assert(log.Message__c.length() > 131072);
		System.assert(log.Stack_Trace__c.length() > 131072);
		System.assert(log.Status__c.length() > 131072);
		System.assert(log.Type_Name__c.length() > 131072);
		System.assert(log.Header_Keys__c.length() > 131072);
		System.assert(log.Cause__c.length() > 131072);
		System.assert(log.Body_Document__c.length() > 131072);
		ErrorLogUtil.addLog(log);
		ErrorLogUtil.commitLogs();

		System.assertEquals(1, [SELECT Id FROM Error_Log__c].size());
	}
	@isTest
	private static void testHttpRequest(){
		HttpRequest request = new HttpRequest();
		ErrorLogUtil.log('msg', request);
		ErrorLogUtil.log(request);
		ErrorLogUtil.commitLogs();
		System.assertEquals(2, [SELECT Id FROM Error_Log__c].size());
	}
	@isTest
	private static void testHttpRequestAsNull(){
		HttpRequest request;
		ErrorLogUtil.log('msg', request);
		ErrorLogUtil.log(request);
		ErrorLogUtil.commitLogs();
		System.assertEquals(2, [SELECT Id FROM Error_Log__c].size());
	}
	@isTest
	private static void testHttpResponse(){
		HttpResponse response = new HttpResponse();
		ErrorLogUtil.log('msg', response);
		ErrorLogUtil.log(response);
		ErrorLogUtil.commitLogs();
		System.assertEquals(2, [SELECT Id FROM Error_Log__c].size());
	}
	@isTest
	private static void testHttpResponseAsNull(){
		HttpResponse response;
		ErrorLogUtil.log('msg', response);
		ErrorLogUtil.log(response);
		ErrorLogUtil.commitLogs();
		System.assertEquals(2, [SELECT Id FROM Error_Log__c].size());
	}
}