# DML that Chunks

Chunking is where a list of mixed sobject types are [saved](https://developer.salesforce.com/docs/atlas.en-us.206.0.api.meta/api/sforce_api_calls_create.htm#MixedSaveTitle). Each grouped set of objects is called a chunk. The runtime iterates through the list and each time the type changes, that subset of sobject instances is saved. For instance: 

    [
        Account1,
        Account2,
        Account3,  // <-- chunk 1 containing Account1, Account2, Account3
        Contact1,
        Contact2,  // <-- chunk 2 containing Contact1, Contact2
        Account4,
        Account5,  // <-- chunk 3 containing Account4, Account5
        Contact3,
        Contact4, 
        Contact5   // <-- chunk 4 containing Contact1, Contact2, Contact3
    ]

## Chunking Benefits

There is an advantage to be gained as far as the DML statements governor limit of 150 per transaction. Consider the following: 

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

This operation, although creating 4 chunks still consists of only a single DML statement. 

There are, of course, some limits. 

## Chunking Limitations

### Max Chunx

First off, a single DML can have a maximum of 10 chunks. So consider this snippet. 

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

Here there will be 20 chunks in created by this operation. This produces an uncatchable exception killing the transaction. 

The moral of the story: sort and group like sobject types in your list before saving. 

### Max SObject Types

In addition to maximum of 10 chunks, there is also a maximum of 10 different sobject types allowed in a single save operation. This follows on pretty naturally from the first limit. By definition, an 11th sobject type will breach the 10-chunks-per-operation rule. 

### Relations in Chunks

There is some good news here. According to the docs, you can save parent/child relationships in a single chunked list. I'm guessing this would require an external ID exist in the parent and be referenced in the related child record. 

    Account acct = new Account(Name='Chunked Account',Customer_Id__c='chunked1');
    Contact cont = new Contact(LastName='Chunked Contact',Account=new Account());

    cont.Account.Customer_Id__c = acct.Customer_Id__c;

    List<SObject> objs = new List<SObject>{acct,cont};

    insert objs; 

Above you can see how a contact and an account are created. In the account record, the `Customer_Id__c` field is a unique External Id. Then, in the contact, we assign that value to its Account relationship field. This allows us to save both the contact and the account simultaneously. 

> Note: I was not able to make this work without use of the external Id, for instance assigning `acct` to the `cont.Account` field. 

However this falls down when we attempt to store parent/child records of the same type. For instance, the `ParentId` field in account. 