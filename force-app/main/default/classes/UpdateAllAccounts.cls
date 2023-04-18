global class UpdateAllAccounts implements Database.Batchable<sObject>{
    
    global Database.QueryLocator start(Database.BatchableContext info){ 
        // Requeter seulement les comptes qui ont au moins une commande avec le Status 'Ordered'
        return Database.getQueryLocator([
            SELECT Id FROM Account WHERE Id IN (
                SELECT AccountId FROM Order WHERE Status = 'Ordered'
            )
        ]);
    }
     
    global void execute(Database.BatchableContext info, List<Account> scope){
        // Use a set id storage to avoid duplicate id
        Set<Id> setAccountIds = new Set<Id>();
        for (Account acc : scope) {
            setAccountIds.add(acc.Id);
        }
        // Supress update accounts for call a static method. 
        AP01Account.updateChiffreAffaire(setAccountIds);
    }    
     
    
 }
 