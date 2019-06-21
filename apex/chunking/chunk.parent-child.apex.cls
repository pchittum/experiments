Account acct = new Account(Name='Chunked Account',Customer_Id__c='chunked1');
Contact cont = new Contact(LastName='Chunked Contact',Account=new Account());

cont.Account.Customer_Id__c = acct.Customer_Id__c;

List<SObject> objs = new List<SObject>{acct,cont};

insert objs; 