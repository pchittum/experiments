/**
This example is to demonstrate an exception-causing operation related 
to "chunking" in Apex. Chunking exceptions do not appear to be catchable. 
*/

List<sobject> objs = new List<sobject>();

for (Integer i = 0; i < 10; i++){
    objs.add(new Account(Name='acct' + i));
    objs.add(new Contact(LastName='Contact' + i));
}

try {

    insert objs; 

} catch (Exception e) { 
  
    System.debug(e);

}

/* The above produced the following debug log: 

45.0 APEX_CODE,DEBUG;APEX_PROFILING,INFO
Execute Anonymous: /**
Execute Anonymous: This example is to demonstrate an exception-causing operation related 
Execute Anonymous: to "chunking" in Apex. 
Execute Anonymous: */
Execute Anonymous: 
Execute Anonymous: List<sobject> objs = new List<sobject>();
Execute Anonymous: 
Execute Anonymous: for (Integer i = 0; i < 10; i++){
Execute Anonymous:     objs.add(new Account(Name='acct' + i));
Execute Anonymous:     objs.add(new Contact(LastName='Contact' + i));
Execute Anonymous: }
Execute Anonymous: 
Execute Anonymous: try {
Execute Anonymous: 
Execute Anonymous:     insert objs; 
Execute Anonymous: 
Execute Anonymous: } catch (Exception e) { 
Execute Anonymous:   
Execute Anonymous:     System.debug(e);
Execute Anonymous: 
Execute Anonymous: }
10:17:25.36 (36437117)|USER_INFO|[EXTERNAL]|00524000000l7Th|peter@blixtar.demo|(GMT+01:00) British Summer Time (Europe/London)|GMT+01:00
10:17:25.36 (36459669)|EXECUTION_STARTED
10:17:25.36 (36463879)|CODE_UNIT_STARTED|[EXTERNAL]|execute_anonymous_apex
10:17:25.36 (40018927)|EXCEPTION_THROWN|[15]|System.TypeException: Cannot have more than 10 chunks in a single operation. Please rearrange the data to reduce chunking.
10:17:25.36 (95410485)|USER_DEBUG|[19]|DEBUG|System.TypeException: Cannot have more than 10 chunks in a single operation. Please rearrange the data to reduce chunking.
10:17:25.99 (99052253)|CUMULATIVE_LIMIT_USAGE
10:17:25.99 (99052253)|LIMIT_USAGE_FOR_NS|(default)|
  Number of SOQL queries: 0 out of 100
  Number of query rows: 0 out of 50000
  Number of SOSL queries: 0 out of 20
  Number of DML statements: 1 out of 150
  Number of DML rows: 20 out of 10000
  Maximum CPU time: 0 out of 10000
  Maximum heap size: 0 out of 6000000
  Number of callouts: 0 out of 100
  Number of Email Invocations: 0 out of 10
  Number of future calls: 0 out of 50
  Number of queueable jobs added to the queue: 0 out of 50
  Number of Mobile Apex push calls: 0 out of 10

10:17:25.99 (99052253)|CUMULATIVE_LIMIT_USAGE_END

10:17:25.36 (99136565)|CODE_UNIT_FINISHED|execute_anonymous_apex
10:17:25.36 (100923713)|EXECUTION_FINISHED

*/
