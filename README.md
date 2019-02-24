# LimitLogger
<p float="left">
    <a href="https://githubsfdeploy.herokuapp.com?owner=timbarsotti&repo=LimitLogger">
  <img alt="Deploy to Salesforce"
       src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/src/main/webapp/resources/img/deploy.png" width="100">
</a> 
       <!-- <img alt='Build Status' 
             src='http://ec2-18-221-14-184.us-east-2.compute.amazonaws.com:8080/buildStatus/icon?job=limitlogger' width="100" /> -->

  </p>
 

# Summary
Problem Statement: ever had problems figuring out which methods or classes were eating up your governor limits? So you turn up the debug logs to see what's going on and it consume more CPU time. The more logs you have open the slower your browser gets. After 200-300 MBs of logs, the whole browser chokes up and takes forever to read or parse the logs. Out of the repeated pains of diagnosing CPU time limits was born a light weight utility for creating Limit Logs. Each limit log shows the their contribution towards governor limits, as well as the cumulative governor limits. 

Wouldn’t it be nice to see where your limits are? What each operation took from your available resources? Well now you can with this lightweight utility.

# Notes 
Also includes nested into trigger framework and error handling util

<img src=http://timbarsotti.com/wp-content/uploads/2018/12/Limit_Log__LL-0000124___Salesforce_-_Developer_Edition-2-1024x976.png />

If LimitLogger is enabled, each LimitLogger that is constructed will create a Limit_Log__c record. 

# Custom Settings
<strong>Limit Logger Settings</strong><br/>
"Commit Logs To Database" -> determines if the Limit Logs get committed to the database<br/>
"Debug Limits" -> determines if the Limit Logs are printed in the debug logs<br/>
If neither is set to true, limit logger doesn't do anything. <br/>
"Auto Commit When Initial Is Stopped" - Auto commit the logs when the initial log is stopped. Without this being set to true, you must call the "commitAll" method in order to commit the logs. This might be helpful to disable when you are using certain trigger architectures that would initalize multiple initial logs for a single execution context.<br/>
"Set Wrapper Relationships Between Logs" - The wrapper relationship sets parent child relationships between the log limits. This will consume an extra DML statement and the corresponding number of DML rows. <br/>


# Usage
You can add multiple limit logs by constructing them
```javascript
    LimitLogger ll = new LimitLogger('My Friendly Event Name');
```

To stop the log call the stop method. Stopping prints the log limits immediately to the debug log.
```javascript
    ll.stop();
    
    //if you have Auto Commit set to false - you will need to call commit all explicitly 
    ll.commitAll(); 
```

    
Only when the initial log is stopped will the logs be to the database. This allows you to not worry about stopping too many logs and flooding the DML statements.


# Nested Limit Logs
```javascript
public void methodOne() {
    //construct first log
    LimitLogger intialLog = new LimitLogger('My Initial Log');
    methodTwo();
    //stop and commit - commits logs here because the initial was stopped
    intialLog.stop();
    //if you have Auto Commit set to false - you will need to call commit all explicitly 
    intialLog.commitAll(); 
}

public void methodTwo() {
    //construct second log
    LimitLogger secondLog = new LimitLogger('My Second Log'); 
    //stop and commit - doesn't commit logs here because the inital wasn't stopped
    secondLog.stop();

    //if you have Auto Commit set to false - you will need to call commit all explicitly 
    //NOTE: this won't do anything because the initial log has not been stopped.
    secondLog.commitAll(); 
}
```

# Programmatic Enabling / Logging
If you want to execute a block of code and have it generate the logs without enabling the custom settings (e.g. for an execute anonymous script) it can be done as follows: 
```javascript
  LimitLogger.commitLogs = true; //commit logs sets the flag to insert records into the database
  LimitLogger.debugLogs = true; //debug logs sets the flag to print out the debug log statements
  LimitLogger log = new LimitLogger('My Log');
  //do something
  intialLog.stop();

  //if you have Auto Commit set to false - you will need to call commit all explicitly 
  intialLog.commitAll(); 
```

# ErrorLogUtil
A lightweight class to commit errors to the database. All errors will be persisted to the database by invoking ErrorLog.commitLogs();

# Public methods available 
ErrorLogUtil.commitLogs()  // this method commits the logs to the database. Call it after webservice callouts or after triggers have run.

# Logging Webservice Callouts
ErrorLogUtil.log(HttpResponse response) 
ErrorLogUtil.log(String message, HttpResponse response) 

# Logging Exceptions 
ErrorLogUtil.log(Exception e) 
ErrorLogUtil.log(String message, Exception e) 
ErrorLogUtil.log(DmlException e) 
ErrorLogUtil.log(String message, DmlException e)

# Logging Save Results 
ErrorLogUtil.log(Database.SaveResult sr) 
ErrorLogUtil.log(List<Database.SaveResult> srList) 
ErrorLogUtil.log(String message, Database.SaveResult sr) 
ErrorLogUtil.log(String message, List<Database.SaveResult> srList) 

ErrorLogUtil.handleSaveResults(Database.SaveResult sr) 
ErrorLogUtil.handleSaveResults(String message, Database.SaveResult sr) 
ErrorLogUtil.handleSaveResults(List<Database.SaveResult> srList) 
ErrorLogUtil.handleSaveResults(String errorMessage, List<Database.SaveResult> srList) 

# Logging Upsert Results
ErrorLogUtil.handleSaveResults(Database.UpsertResult ur) 
ErrorLogUtil.handleSaveResults(String message, Database.UpsertResult ur) 
ErrorLogUtil.handleSaveResults(List<Database.UpsertResult> urList) 
ErrorLogUtil.handleSaveResults(String message, List<Database.UpsertResult> urList) 

ErrorLogUtil.log(Database.UpsertResult ur) 
ErrorLogUtil.log(List<Database.UpsertResult> urList) 
ErrorLogUtil.log(String message, Database.UpsertResult ur) 
ErrorLogUtil.log(String message, List<Database.UpsertResult> urList) 

# Example Implementation of Error Logger  
try {

} catch (AsyncException e) {
  log(e); //OR log('developer message', e);
} catch (BigObjectException e) {
  log(e); //OR log('developer message', e);
} catch (CalloutException e) {
  log(e); //OR log('developer message', e);
} catch (EmailException e) {
  log(e); //OR log('developer message', e);
} catch (ExternalObjectException e) {
  log(e); //OR log('developer message', e);
} catch (InvalidParameterValueException e) {
  log(e); //OR log('developer message', e);
} catch (LimitException e) {
  log(e); //OR log('developer message', e);
} catch (JSONException e) {
  log(e); //OR log('developer message', e);
} catch (ListException e) {
  log(e); //OR log('developer message', e);
} catch (MathException e) {
  log(e); //OR log('developer message', e);
} catch (NoAccessException e) {
  log(e); //OR log('developer message', e);
} catch (NoDataFoundException e) {
  log(e); //OR log('developer message', e);
} catch (NoSuchElementException e) {
  log(e); //OR log('developer message', e);
} catch (NullPointerException e) {
  log(e); //OR log('developer message', e);
} catch (QueryException e) {
  log(e); //OR log('developer message', e);
} catch (RequiredFeatureMissingException e) {
  log(e); //OR log('developer message', e);
} catch (SearchException e) {
  log(e); //OR log('developer message', e);
} catch (SecurityException e) {
  log(e); //OR log('developer message', e);
} catch (SerializationException e) {
  log(e); //OR log('developer message', e);
} catch (SObjectException e) {
  log(e); //OR log('developer message', e);
} catch (StringException e) {
  log(e); //OR log('developer message', e);
} catch (TypeException e) {
  log(e); //OR log('developer message', e);
} catch (VisualforceException e) {
  log(e); //OR log('developer message', e);
} catch (XmlException e) {
  log(e); //OR log('developer message', e);
} catch (Exception e) {
  log(e); //OR log('developer message', e);
}


# TODO Improvement List
- [ ] Add permission set for objects / fields
- [ ] Add Delete Result methods
