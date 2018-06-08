<a href="https://githubsfdeploy.herokuapp.com?owner=timbarsotti&repo=LimitLogger">
  <img alt="Deploy to Salesforce"
       src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/src/main/webapp/resources/img/deploy.png">
</a>

# LimitLogger
Problem Statement: ever had problems figuring out which methods or classes were eating up your governor limits? So you turn up the debug logs to see what's going on and it consume more CPU time. The more logs you have open the slower your browser gets. After 200-300 MBs of logs, the whole browser chokes up and takes forever to read or parse the logs. Out of the repeated pains of diagnosing CPU time limits was born a light weight utility for creating Limit Logs. Each limit log shows the their contribution towards governor limits, as well as the cumulative governor limits. 

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
    LimitLogger secondLog = new LimitLogger('My Seconc Log'); 
    //stop and commit - doesn't commit logs here because the inital wasn't stopped
    secondLog.stop();

    //if you have Auto Commit set to false - you will need to call commit all explicitly 
    //NOTE: this won't do anything because the initial log has has been stopped.
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
# TODO Improvement List
1) Add permission set for objects / fields
