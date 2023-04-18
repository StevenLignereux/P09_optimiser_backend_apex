// Imoplements database batchable account for optimize the performance
global class UpdateAccounts implements Database.Batchable<Account>{
    
    global Database.QueryLocator start(Database.BatchableContext info){ 
        // Requêter seulement les comptes qui ont au moins une commande avec le Status 'Ordered'
        return Database.getQueryLocator([
            SELECT Id 
            FROM Account 
            WHERE Id IN (SELECT AccountId FROM Order WHERE Status = 'Ordered')
        ]);
    }
     
    global void execute(Database.BatchableContext info, List<Account> scope){    
        // Use a map to store the total amount for each account  
        Map<Id, Decimal> accountCA = new Map<Id, Decimal>();

        for(Order order : [
            SELECT AccountId, SUM(TotalAmount) totalAmount 
            FROM Order 
            WHERE AccountId = :scope 
            GROUP BY AccountId
        ]){
            accountCA.put(order.AccountId, order.totalAmount);
        }
        
        // use the map to update the account. If the account is not in the map, the total amount is 0
        for(Account acc : scope){
            acc.Chiffre_d_affaire__c = accountCA.containsKey(acc.Id) ? accountCA.get(acc.Id) : 0;
        }
        
        update scope;
    }    
     
    global void finish(Database.BatchableContext info){     
        
    } 
 }
