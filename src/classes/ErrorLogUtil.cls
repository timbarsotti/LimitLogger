/*  Author: Tim Barsotti 
    Date 11/18/17
*/
public virtual class ErrorLogUtil {
    private static final String LINE_BREAK =  '\n\r';
    public static List<Error_Log__c> errorLogs = new List<Error_Log__c>();

    private static Error_Log__c generateLog(Exception e) {
        return new Error_Log__c(
            Error_Type__c = e.getTypeName(),
            Line_Number__c = e.getLineNumber(),
            Message__c = e.getMessage(),
            Stack_Trace__c = e.getStackTraceString(),
            Type_Name__c = e.getTypeName()
        );
    }
    private static Error_Log__c generateLog(AsyncException e) {
        return new Error_Log__c(
            Error_Type__c = e.getTypeName(),
            Line_Number__c = e.getLineNumber(),
            Message__c = e.getMessage(),
            Stack_Trace__c = e.getStackTraceString(),
            Type_Name__c = e.getTypeName()
        );
    }
    private static Error_Log__c generateLog(BigObjectException e) {
        return new Error_Log__c(
            Error_Type__c = e.getTypeName(),
            Line_Number__c = e.getLineNumber(),
            Message__c = e.getMessage(),
            Stack_Trace__c = e.getStackTraceString(),
            Type_Name__c = e.getTypeName()
        );
    }
    private static Error_Log__c generateLog(CalloutException e) {
        return new Error_Log__c(
            Error_Type__c = e.getTypeName(),
            Line_Number__c = e.getLineNumber(),
            Message__c = e.getMessage(),
            Stack_Trace__c = e.getStackTraceString(),
            Type_Name__c = e.getTypeName()
        );
    }
    private static Error_Log__c generateLog(EmailException e) {
        return new Error_Log__c(
            Error_Type__c = e.getTypeName(),
            Line_Number__c = e.getLineNumber(),
            Message__c = e.getMessage(),
            Stack_Trace__c = e.getStackTraceString(),
            Type_Name__c = e.getTypeName()
        );
    }
    private static Error_Log__c generateLog(ExternalObjectException e) {
        return new Error_Log__c(
            Error_Type__c = e.getTypeName(),
            Line_Number__c = e.getLineNumber(),
            Message__c = e.getMessage(),
            Stack_Trace__c = e.getStackTraceString(),
            Type_Name__c = e.getTypeName()
        );
    }
    private static Error_Log__c generateLog(InvalidParameterValueException e) {
        return new Error_Log__c(
            Error_Type__c = e.getTypeName(),
            Line_Number__c = e.getLineNumber(),
            Message__c = e.getMessage(),
            Stack_Trace__c = e.getStackTraceString(),
            Type_Name__c = e.getTypeName()
        );
    }
    //cant be caught yet
    //private static Error_Log__c generateLog(LimitException e) {
    //    return new Error_Log__c(
    //        Error_Type__c = e.getTypeName(),
    //        Line_Number__c = e.getLineNumber(),
    //        Message__c = e.getMessage(),
    //        Stack_Trace__c = e.getStackTraceString(),
    //        Type_Name__c = e.getTypeName()
    //    );
    //}
    private static Error_Log__c generateLog(JSONException e) {
        return new Error_Log__c(
            Error_Type__c = e.getTypeName(),
            Line_Number__c = e.getLineNumber(),
            Message__c = e.getMessage(),
            Stack_Trace__c = e.getStackTraceString(),
            Type_Name__c = e.getTypeName()
        );
    }
    private static Error_Log__c generateLog(ListException e) {
        return new Error_Log__c(
            Error_Type__c = e.getTypeName(),
            Line_Number__c = e.getLineNumber(),
            Message__c = e.getMessage(),
            Stack_Trace__c = e.getStackTraceString(),
            Type_Name__c = e.getTypeName()
        );
    }
    private static Error_Log__c generateLog(MathException e) {
        return new Error_Log__c(
            Error_Type__c = e.getTypeName(),
            Line_Number__c = e.getLineNumber(),
            Message__c = e.getMessage(),
            Stack_Trace__c = e.getStackTraceString(),
            Type_Name__c = e.getTypeName()
        );
    }
    private static Error_Log__c generateLog(NoAccessException e) {
        return new Error_Log__c(
            Error_Type__c = e.getTypeName(),
            Line_Number__c = e.getLineNumber(),
            Message__c = e.getMessage(),
            Stack_Trace__c = e.getStackTraceString(),
            Type_Name__c = e.getTypeName()
        );
    }
    private static Error_Log__c generateLog(NoDataFoundException e) {
        return new Error_Log__c(
            Error_Type__c = e.getTypeName(),
            Line_Number__c = e.getLineNumber(),
            Message__c = e.getMessage(),
            Stack_Trace__c = e.getStackTraceString(),
            Type_Name__c = e.getTypeName()
        );
    }
    private static Error_Log__c generateLog(NoSuchElementException e) {
        return new Error_Log__c(
            Error_Type__c = e.getTypeName(),
            Line_Number__c = e.getLineNumber(),
            Message__c = e.getMessage(),
            Stack_Trace__c = e.getStackTraceString(),
            Type_Name__c = e.getTypeName()
        );
    }
    private static Error_Log__c generateLog(NullPointerException e) {
        return new Error_Log__c(
            Error_Type__c = e.getTypeName(),
            Line_Number__c = e.getLineNumber(),
            Message__c = e.getMessage(),
            Stack_Trace__c = e.getStackTraceString(),
            Type_Name__c = e.getTypeName()
        );
    }
    private static Error_Log__c generateLog(QueryException e) {
        return new Error_Log__c(
            Error_Type__c = e.getTypeName(),
            Line_Number__c = e.getLineNumber(),
            Message__c = e.getMessage(),
            Stack_Trace__c = e.getStackTraceString(),
            Type_Name__c = e.getTypeName()
        );
    }
    private static Error_Log__c generateLog(RequiredFeatureMissingException e) {
        return new Error_Log__c(
            Error_Type__c = e.getTypeName(),
            Line_Number__c = e.getLineNumber(),
            Message__c = e.getMessage(),
            Stack_Trace__c = e.getStackTraceString(),
            Type_Name__c = e.getTypeName()
        );
    }
    
    private static Error_Log__c generateLog(SearchException e) {
        return new Error_Log__c(
            Error_Type__c = e.getTypeName(),
            Line_Number__c = e.getLineNumber(),
            Message__c = e.getMessage(),
            Stack_Trace__c = e.getStackTraceString(),
            Type_Name__c = e.getTypeName()
        );
    }
    private static Error_Log__c generateLog(SecurityException e) {
        return new Error_Log__c(
            Error_Type__c = e.getTypeName(),
            Line_Number__c = e.getLineNumber(),
            Message__c = e.getMessage(),
            Stack_Trace__c = e.getStackTraceString(),
            Type_Name__c = e.getTypeName()
        );
    }
    private static Error_Log__c generateLog(SerializationException e) {
        return new Error_Log__c(
            Error_Type__c = e.getTypeName(),
            Line_Number__c = e.getLineNumber(),
            Message__c = e.getMessage(),
            Stack_Trace__c = e.getStackTraceString(),
            Type_Name__c = e.getTypeName()
        );
    }
    private static Error_Log__c generateLog(SObjectException e) {
        return new Error_Log__c(
            Error_Type__c = e.getTypeName(),
            Line_Number__c = e.getLineNumber(),
            Message__c = e.getMessage(),
            Stack_Trace__c = e.getStackTraceString(),
            Type_Name__c = e.getTypeName()
        );
    }
    private static Error_Log__c generateLog(StringException e) {
        return new Error_Log__c(
            Error_Type__c = e.getTypeName(),
            Line_Number__c = e.getLineNumber(),
            Message__c = e.getMessage(),
            Stack_Trace__c = e.getStackTraceString(),
            Type_Name__c = e.getTypeName()
        );
    }
    private static Error_Log__c generateLog(TypeException e) {
        return new Error_Log__c(
            Error_Type__c = e.getTypeName(),
            Line_Number__c = e.getLineNumber(),
            Message__c = e.getMessage(),
            Stack_Trace__c = e.getStackTraceString(),
            Type_Name__c = e.getTypeName()
        );
    }
    private static Error_Log__c generateLog(VisualforceException e) {
        return new Error_Log__c(
            Error_Type__c = e.getTypeName(),
            Line_Number__c = e.getLineNumber(),
            Message__c = e.getMessage(),
            Stack_Trace__c = e.getStackTraceString(),
            Type_Name__c = e.getTypeName()
        );
    }
    private static Error_Log__c generateLog(XmlException e) {
        return new Error_Log__c(
            Error_Type__c = e.getTypeName(),
            Line_Number__c = e.getLineNumber(),
            Message__c = e.getMessage(),
            Stack_Trace__c = e.getStackTraceString(),
            Type_Name__c = e.getTypeName()
        );
    }
    private static Error_Log__c generateLog(DmlException e) {
        return new Error_Log__c(
            Error_Type__c = e.getTypeName(),
            Line_Number__c = e.getLineNumber(),
            Message__c = e.getMessage(),
            Stack_Trace__c = e.getStackTraceString(),
            Type_Name__c = e.getTypeName()
        );
    }

    private static Error_Log__c generateLog(HttpResponse response) {
        Error_Log__c log = new Error_Log__c();
        log.Error_Type__c = 'HttpResponse';
        if(response != null) {
            log.Message__c = response.getBody();
            log.Status__c = response.getStatus();
            log.Status_Code__c = response.getStatusCode();
            log.Header_Keys__c = String.valueOf(response.getHeaderKeys());
        } else {
            log.Message__c = 'HttpResponse was null';
        }
        return log;
    }
    private static Error_Log__c generateLog(HttpRequest request) {
        Error_Log__c log = new Error_Log__c();
        log.Error_Type__c = 'HttpRequest';
        if(request != null) {
            log.Message__c = request.getBody();
        } else {
            log.Message__c = 'HttpRequest was null';
        }
        return log;
    }

    private static Error_Log__c generateLog(Database.SaveResult sr) {
        Error_Log__c log = new Error_Log__c(Message__c = '', Error_Type__c = 'SaveResult');
        if(sr.getErrors() != null) {
            for(Database.Error err: sr.getErrors()) {
                log.Message__c += 'Id: '
                                 + sr.getId()
                                 + '; '
                                 + 'Message: '
                                 + err.getMessage()
                                 + '; Fields: '
                                 + err.getFields()
                                 + '; Status Code: '
                                 + err.getStatusCode()
                                 + LINE_BREAK;
            }
        }
        return log;
    }

    private static Error_Log__c generateLog(Database.UpsertResult ur) {
        Error_Log__c log = new Error_Log__c(Message__c = '', Error_Type__c = 'SaveResult');
        if(ur.getErrors() != null) {
            for(Database.Error err: ur.getErrors()) {
                log.Message__c += 
                                'Id: ' + ur.getId() + '; ' 
                                + 'Message: ' 
                                + err.getMessage() 
                                + '; Fields: ' 
                                + err.getFields() 
                                + '; Status Code: ' 
                                + err.getStatusCode() 
                                + LINE_BREAK;
            }
        }
        return log;
    }
    
    /* Custom */
    public static void log(String msg, List<String> messageList){
        if(messageList!= null && messageList.size() > 0){
            for(String s : messageList){
                msg = msg  + s;
            }
        }
        addLog(new Error_Log__c(
            Error_Type__c = 'Exception',
            Message__c = msg  
        ));
    }

    //method to insert into the data base
    public static void commitLogs() {
        try {
            insert errorLogs;
            errorLogs = new List<Error_Log__c>();
        } catch (Exception e) {
            System.debug('Failed to commit logs');
            System.debug(e);
            System.debug(e.getMessage());
        }
    }
    public static void log(Exception e) {
        addLog(generateLog(e));
    }
    public static void log(AsyncException e) {
        addLog(generateLog(e));
    }
    public static void log(BigObjectException e) {
        addLog(generateLog(e));
    }
    public static void log(CalloutException e) {
        addLog(generateLog(e));
    }
    public static void log(EmailException e) {
        addLog(generateLog(e));
    }
    public static void log(ExternalObjectException e) {
        addLog(generateLog(e));
    }
    public static void log(InvalidParameterValueException e) {
        addLog(generateLog(e));
    }
    //cant be caught yet
    //public static void log(LimitException e) {
    //    addLog(generateLog(e));
    //}
    public static void log(JSONException e) {
        addLog(generateLog(e));
    }
    public static void log(ListException e) {
        addLog(generateLog(e));
    }
    public static void log(MathException e) {
        addLog(generateLog(e));
    }
    public static void log(NoAccessException e) {
        addLog(generateLog(e));
    }
    public static void log(NoDataFoundException e) {
        addLog(generateLog(e));
    }
    public static void log(NoSuchElementException e) {
        addLog(generateLog(e));
    }
    public static void log(NullPointerException e) {
        addLog(generateLog(e));
    }
    public static void log(QueryException e) {
        addLog(generateLog(e));
    }
    public static void log(SearchException e) {
        addLog(generateLog(e));
    }
    public static void log(SecurityException e) {
        addLog(generateLog(e));
    }
    public static void log(SerializationException e) {
        addLog(generateLog(e));
    }
    public static void log(SObjectException e) {
        addLog(generateLog(e));
    }
    public static void log(StringException e) {
        addLog(generateLog(e));
    }
    public static void log(TypeException e) {
        addLog(generateLog(e));
    }
    public static void log(VisualforceException e) {
        addLog(generateLog(e));
    }
    public static void log(XmlException e) {
        addLog(generateLog(e));
    }
    public static void log(DmlException e) {
        addLog(generateLog(e));
    }
    public static void log(RequiredFeatureMissingException e) {
        addLog(generateLog(e));   
    }
    /* Exceptions */
    public static void log(String message, Exception e) {
        Error_Log__c log = generateLog(e);
        log.Developer_Message__c = message;
        errorLogs.add(log);
    }
    public static void log(String message, AsyncException e) {
        Error_Log__c log = generateLog(e);
        log.Developer_Message__c = message;
        errorLogs.add(log);
    }
    public static void log(String message, BigObjectException e) {
        Error_Log__c log = generateLog(e);
        log.Developer_Message__c = message;
        errorLogs.add(log);
    }
    public static void log(String message, CalloutException e) {
        Error_Log__c log = generateLog(e);
        log.Developer_Message__c = message;
        errorLogs.add(log);
    }
    public static void log(String message, EmailException e) {
        Error_Log__c log = generateLog(e);
        log.Developer_Message__c = message;
        errorLogs.add(log);
    }
    public static void log(String message, ExternalObjectException e) {
        Error_Log__c log = generateLog(e);
        log.Developer_Message__c = message;
        errorLogs.add(log);
    }
    public static void log(String message, InvalidParameterValueException e) {
        Error_Log__c log = generateLog(e);
        log.Developer_Message__c = message;
        errorLogs.add(log);
    }
    //Can't be caught yet
    //public static void log(String message, LimitException e) {
    //    Error_Log__c log = generateLog(e);
    //    log.Developer_Message__c = message;
    //    errorLogs.add(log);
    //}
    public static void log(String message, JSONException e) {
        Error_Log__c log = generateLog(e);
        log.Developer_Message__c = message;
        errorLogs.add(log);
    }
    public static void log(String message, ListException e) {
        Error_Log__c log = generateLog(e);
        log.Developer_Message__c = message;
        errorLogs.add(log);
    }
    public static void log(String message, MathException e) {
        Error_Log__c log = generateLog(e);
        log.Developer_Message__c = message;
        errorLogs.add(log);
    }
    public static void log(String message, NoAccessException e) {
        Error_Log__c log = generateLog(e);
        log.Developer_Message__c = message;
        errorLogs.add(log);
    }
    public static void log(String message, NoDataFoundException e) {
        Error_Log__c log = generateLog(e);
        log.Developer_Message__c = message;
        errorLogs.add(log);
    }
    public static void log(String message, NoSuchElementException e) {
        Error_Log__c log = generateLog(e);
        log.Developer_Message__c = message;
        errorLogs.add(log);
    }
    public static void log(String message, NullPointerException e) {
        Error_Log__c log = generateLog(e);
        log.Developer_Message__c = message;
        errorLogs.add(log);
    }
    public static void log(String message, QueryException e) {
        Error_Log__c log = generateLog(e);
        log.Developer_Message__c = message;
        errorLogs.add(log);
    }
    public static void log(String message, SearchException e) {
        Error_Log__c log = generateLog(e);
        log.Developer_Message__c = message;
        errorLogs.add(log);
    }
    public static void log(String message, SecurityException e) {
        Error_Log__c log = generateLog(e);
        log.Developer_Message__c = message;
        errorLogs.add(log);
    }
    public static void log(String message, SerializationException e) {
        Error_Log__c log = generateLog(e);
        log.Developer_Message__c = message;
        errorLogs.add(log);
    }
    public static void log(String message, SObjectException e) {
        Error_Log__c log = generateLog(e);
        log.Developer_Message__c = message;
        errorLogs.add(log);
    }
    public static void log(String message, StringException e) {
        Error_Log__c log = generateLog(e);
        log.Developer_Message__c = message;
        errorLogs.add(log);
    }
    public static void log(String message, TypeException e) {
        Error_Log__c log = generateLog(e);
        log.Developer_Message__c = message;
        errorLogs.add(log);
    }
    public static void log(String message, VisualforceException e) {
        Error_Log__c log = generateLog(e);
        log.Developer_Message__c = message;
        errorLogs.add(log);
    }
    public static void log(String message, XmlException e) {
        Error_Log__c log = generateLog(e);
        log.Developer_Message__c = message;
        errorLogs.add(log);
    }
    public static void log(String message, DmlException e) {
        Error_Log__c log = generateLog(e);
        log.Developer_Message__c = message;
        errorLogs.add(log);
    }
    public static void log(String message, RequiredFeatureMissingException e) {
        Error_Log__c log = generateLog(e);
        log.Developer_Message__c = message;
        errorLogs.add(log);
    }
    
    /* HTTP Response / Request */
    public static void log(HttpResponse response) {
        Error_Log__c log = generateLog(response);
        addLog(log);
    }
    public static void log(HttpRequest request) {
        Error_Log__c log = generateLog(request);
        errorLogs.add(log);
    }
    public static void log(String message, HttpResponse response) {
        Error_Log__c log = generateLog(response);
        log.Developer_Message__c = message;
        addLog(log);
    }
    public static void log(String message, HttpRequest request) {
        Error_Log__c log = generateLog(request);
        log.Developer_Message__c = message;
        errorLogs.add(log);
    }

    /* Save Results */
    public static void handleSaveResults(Database.SaveResult sr) {
        if(!sr.isSuccess()) {
            log(sr);
        }
    }
   
    public static void handleSaveResults(String message, Database.SaveResult sr) {
        if(!sr.isSuccess()) {
            log(message, sr);
        }
    }
    
    public static void handleSaveResults(List<Database.SaveResult> srList) {
        for(Database.SaveResult sr: srList) {
            if(!sr.isSuccess()) {
                log(sr);
            }
        }
    }
    
    public static void handleSaveResults(String errorMessage, List<Database.SaveResult> srList) {
        for(Database.SaveResult sr: srList) {
            if(!sr.isSuccess()) {
                log(errorMessage, sr);
            }
        }
    }

    public static void log(Database.SaveResult sr) {
        Error_Log__c log = generateLog(sr);
        addLog(log);
    }

    public static void log(List<Database.SaveResult> srList) {
        for(Database.SaveResult sr: srList) {
            if(!sr.isSuccess()) {
                Error_Log__c log = generateLog(sr);
                addLog(log);
            }
        }
    }
    
    public static void log(String message, Database.SaveResult sr) {
        if(!sr.isSuccess()) {
            Error_Log__c log = generateLog(sr);
            log.Message__c += ' Message: ' + message;
            addLog(log);
        }
    }

    public static void log(String message, List<Database.SaveResult> srList) {
        for(Database.SaveResult sr: srList) {
            if(!sr.isSuccess()) {
                Error_Log__c log = generateLog(sr);
                log.Message__c += ' Message: ' + message;
                addLog(log);
            }
        }
    }

    /* Upsert Results */
    public static void handleSaveResults(Database.UpsertResult ur) {
        if(!ur.isSuccess()) {
            log(ur);
        }
    }
    
    public static void handleSaveResults(String message, Database.UpsertResult ur) {
        if(!ur.isSuccess()) {
            log(message, ur);
        }
    }

    public static void handleSaveResults(List<Database.UpsertResult> urList) {
        for(Database.UpsertResult ur: urList) {
            if(!ur.isSuccess()) {
                log(ur);
            }
        }
    }
    
    public static void handleSaveResults(String message, List<Database.UpsertResult> urList) {
        for(Database.UpsertResult ur: urList) {
            log(message, ur);
        }
    }
    
    public static void log(Database.UpsertResult ur) {
        if(!ur.isSuccess()) {
            Error_Log__c log = generateLog(ur);
            addLog(log);
        }
    }

    public static void log(List<Database.UpsertResult> urList) {
        for(Database.UpsertResult ur: urList) {
            if(!ur.isSuccess()) {
                Error_Log__c log = generateLog(ur);
                addLog(log);
            }
        }
    }

    public static void log(String message, Database.UpsertResult ur) {
        if(!ur.isSuccess()) {
            Error_Log__c log = generateLog(ur);
            log.Message__c += ' Message: ' + message;
            addLog(log);
        }
    }

    public static void log(String message, List<Database.UpsertResult> urList) {
        for(Database.UpsertResult ur: urList) {
            if(!ur.isSuccess()) {
                Error_Log__c log = generateLog(ur);
                log.Message__c += ' Message: ' + message;
                addLog(log);
            }
        }
    }
    @TestVisible
    private static void addLog(Error_Log__c log) {
        if(String.isNotBlank(log.Message__c) && log.Message__c.length() > 131072) {
            log.Message__c = log.Message__c.left(131072);
        }
        if(String.isNotBlank(log.Stack_Trace__c) && log.Stack_Trace__c.length() > 131072) {
            log.Stack_Trace__c = log.Stack_Trace__c.left(131072);
        }
        if(String.isNotBlank(log.Status__c) && log.Status__c.length() > 131072) {
            log.Status__c = log.Status__c.left(131072);
        }
        if(String.isNotBlank(log.Type_Name__c) && log.Type_Name__c.length() > 131072) {
            log.Type_Name__c = log.Type_Name__c.left(131072);
        }
        if(String.isNotBlank(log.Header_Keys__c) && log.Header_Keys__c.length() > 131072) {
            log.Header_Keys__c = log.Header_Keys__c.left(131072);
        }
        if(String.isNotBlank(log.Cause__c) && log.Cause__c.length() > 131072) {
            log.Cause__c = log.Cause__c.left(131072);
        }
        if(String.isNotBlank(log.Body_Document__c) && log.Body_Document__c.length() > 131072) {
            log.Body_Document__c = log.Body_Document__c.left(131072);
        }
        errorLogs.add(log);
    }
}