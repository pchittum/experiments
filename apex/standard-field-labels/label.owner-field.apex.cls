/*
sample taken from SFSE question here: 
https://salesforce.stackexchange.com/questions/266636/apex-lightning-component-how-to-access-owner-field-label-using-getdescribe
*/

Boolean foundField = false;

for(Schema.SobjectField strFld: Account.SobjectType.getDescribe().fields.getMap().Values()){
    Schema.DescribeFieldResult dfield = strFld.getDescribe();   
    if( dfield.getName()=='Owner'){
        foundField = true; 
        system.debug('API Name='+dfield.getName()+ ' ,label= ' + dfield.getLabel());// API Name=OwnerId ,label= Owner ID
        system.debug('Relationshipname = '+ dField.getRelationshipName()); // Relationshipname = Owner
    } 
}

System.debug( foundField ? 'Found the field' : 'Field not found');

// Easier for one off label
System.debug(Schema.SObjectType.Account.label);
System.debug(Schema.SObjectType.Contact.fields.AccountId.label);