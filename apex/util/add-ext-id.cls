List<Account> accts = [SELECT Id FROM Account WHERE Customer_Id__c = NULL];
Integer i = 50; 

for (Account acct: accts) {
    acct.Customer_Id__c = String.valueof(i++); 
}

update accts; 