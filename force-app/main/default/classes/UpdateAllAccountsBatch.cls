global class UpdateAllAccountsBatch extends Database.Batchable<sObject> {
    global Database.QueryLocator start(Database.BatchableContext info){ 
        // Requeter seulement les comptes qui ont au moins une commande avec le Status 'Ordered'
        return Database.getQueryLocator([
            SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id IN (
                SELECT AccountId FROM Order WHERE Status = 'Ordered'
            )
        ]);
    }
     
    global void execute(Database.BatchableContext info, List<Account> accountList){
        // Supress update accounts for call a static method. 
        AccountService.updateAllCA(accountList);
    }    
     
    global void finish(Database.BatchableContext info){     
        
    } 
}

