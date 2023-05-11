public class AccountService {
    public static void updateAllCA(List<Account> accountList){
        // Use a map to store the total amount for each account  
        Map<Id, Decimal> accountCA = new Map<Id, Decimal>();

        for(AggregateResult order : [
            SELECT AccountId, SUM(TotalAmount) totalAmount 
            FROM Order 
            WHERE AccountId = :accountList 
            GROUP BY AccountId
        ]){
            accountCA.put((Id)order.get('AccountId'), (Decimal)order.get('TotalAmount'));
        }
        
        // use the map to update the account. If the account is not in the map, the total amount is 0
        for(Account acc : accountList){
            acc.Chiffre_d_affaire__c = accountCA.containsKey(acc.Id) ? accountCA.get(acc.Id) : 0;
        }
        
        update accountList;
    }


    public static void updateAllCA(List<Order> ordersToUpdate) {
        // Création d'un set contenant les IDs des comptes à mettre à jour
        Set<Id> accountIds = new Set<Id>();
        
        // Ajout des IDs de compte pour tous les ordres à mettre à jour
        for (Order updatedOrder : ordersToUpdate) {
            accountIds.add(updatedOrder.AccountId);
        }
        
        // Récupération des totaux de commandes par compte
        List<Account> accountsToUpdate = new List<Account>();
        for (AggregateResult result : [SELECT AccountId, SUM(TotalAmount) total FROM Order WHERE AccountId IN :accountIds GROUP BY AccountId]) {
            accountsToUpdate.add(new Account(Id = (Id)result.get('AccountId'), Chiffre_d_affaire__c = (Decimal)result.get('total')));
        }
        
        // Mise à jour des enregistrements de compte
        update accountsToUpdate;
    }
}

// Penser à générer la doc 
