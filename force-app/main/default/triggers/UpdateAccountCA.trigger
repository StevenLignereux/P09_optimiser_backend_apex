trigger UpdateAccountCA on Order (after update) {
	
    Set<Id> accountIds = new Set<Id>();
    
    // Use a for each loop to avoid using an iteration variable
    for (Order updatedOrder : Trigger.new) {
        
        Order oldOrder = Trigger.oldMap.get(updatedOrder.Id);
        if (oldOrder.TotalAmount != updatedOrder.TotalAmount) {
            accountIds.add(updatedOrder.AccountId);
        }
    }
    
    if (!accountIds.isEmpty()) {
        List<Account> accountsToUpdate = new List<Account>();
        // use an agregate query to have sum of total amount by account and update the account
        for (AggregateResult result : [SELECT AccountId, SUM(TotalAmount) total FROM Order WHERE AccountId IN :accountIds GROUP BY AccountId]) {
            accountsToUpdate.add(new Account(Id = (Id)result.get('AccountId'), Chiffre_d_affaire__c = (Decimal)result.get('total')));
        }
        update accountsToUpdate;
    }
}