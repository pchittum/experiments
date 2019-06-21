Account acctParent = new Account(Name='Chunked Account',Customer_Id__c='chunked1');
Account acctChild = new Account(Name='Child Chunked',Parent=new Account());
Contact cont = new Contact(LastName='Chunked Contact',Account=new Account());

acctChild.Parent.Customer_Id__c = acctParent.Customer_Id__c;
cont.Account.Customer_Id__c = acctParent.Customer_Id__c;

List<SObject> objs = new List<SObject>{acctParent,acctChild,cont};

insert objs; 