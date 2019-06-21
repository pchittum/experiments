/*
This is to test the dml limits effects of chunking. 

10 records
4 chunks
2 sobject types (Account and Contact)

In this instance, the limits meter out as follows: 
  Number of DML statements: 1 out of 150
  Number of DML rows: 10 out of 10000

So from a standpoint of optimizing DML statements, there can be some 
benefit to using chunking. As long as the <10 chunks limit can be controlled for. 
*/

List<sobject> objs = new List<sobject>();
Integer i = 0; 

objs.add(new Account(Name='account' + i++));
objs.add(new Account(Name='account' + i++));
objs.add(new Account(Name='account' + i++));
objs.add(new Contact(LastName='contact' + i++));
objs.add(new Contact(LastName='contact' + i++));
objs.add(new Account(Name='account' + i++));
objs.add(new Account(Name='account' + i++));
objs.add(new Contact(LastName='contact' + i++));
objs.add(new Contact(LastName='contact' + i++));
objs.add(new Contact(LastName='contact' + i++));

insert objs; 