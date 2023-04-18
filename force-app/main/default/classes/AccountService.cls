public with sharing class AccountService {
    public AccountService() {

    }

    public static void updateAllCA(List<Account> accountList){
        // Use a map to store the total amount for each account  
        Map<Id, Decimal> accountCA = new Map<Id, Decimal>();

        for(Order order : [
            SELECT AccountId, SUM(TotalAmount) totalAmount 
            FROM Order 
            WHERE AccountId = :accountList 
            GROUP BY AccountId
        ]){
            accountCA.put(order.AccountId, order.totalAmount);
        }
        
        // use the map to update the account. If the account is not in the map, the total amount is 0
        for(Account acc : accountList){
            acc.Chiffre_d_affaire__c = accountCA.containsKey(acc.Id) ? accountCA.get(acc.Id) : 0;
        }
        
        update accountList;
    }    
}