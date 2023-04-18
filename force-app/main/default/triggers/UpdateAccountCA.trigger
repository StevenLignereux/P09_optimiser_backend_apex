trigger UpdateAccountCA on Order (after update) {
	
    Set<Id> accountIds = new Set<Id>();
    
    for (Order updatedOrder : Trigger.new) {
        
        Order oldOrder = Trigger.oldMap.get(updatedOrder.Id);
        if (oldOrder.TotalAmount != updatedOrder.TotalAmount) {
            accountIds.add(updatedOrder.AccountId);
        }
    }
    
    if (!accountIds.isEmpty()) {
        List<Account> accountsToUpdate = new List<Account>();
        for (AggregateResult result : [SELECT AccountId, SUM(TotalAmount) total FROM Order WHERE AccountId IN :accountIds GROUP BY AccountId]) {
            accountsToUpdate.add(new Account(Id = (Id)result.get('AccountId'), Chiffre_d_affaire__c = (Decimal)result.get('total')));
        }
        update accountsToUpdate;
    }
}
