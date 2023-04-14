global class Batch01AccountChiffreAffaire implements Database.Batchable<Account>{
    
    global Database.QueryLocator start(Database.BatchableContext info){ 
        //Requêter seulement les comptes qui ont au moins une commande avec le Status 'Ordered'
        return Database.getQueryLocator([
            SELECT Id 
            FROM Account 
            WHERE Id IN (SELECT AccountId FROM Order WHERE Status = 'Ordered')
        ]);
    }
     
    global void execute(Database.BatchableContext info, List<Account> scope){      
        Map<Id, Decimal> accountCA = new Map<Id, Decimal>();
        for(Order order : [
            SELECT AccountId, SUM(TotalAmount) totalAmount 
            FROM Order 
            WHERE AccountId = :scope 
            GROUP BY AccountId
        ]){
            accountCA.put(order.AccountId, order.totalAmount);
        }
        
        for(Account acc : scope){
            acc.Chiffre_d_affaire__c = accountCA.containsKey(acc.Id) ? accountCA.get(acc.Id) : 0;
        }
        
        update scope;
    }    
     
    global void finish(Database.BatchableContext info){     
        
    } 
 }
