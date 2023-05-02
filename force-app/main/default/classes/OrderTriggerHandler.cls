public without sharing class OrderTriggerHandler {
    public void onBeforeInsert(List<Order> newOrders) {

    }

    public void onBeforeUpdate(Map<Id, Order> oldOrders, List<Order> newOrders) {
        // créer un orderService pour appeler la méthode ici = triggerHandler design pattern
        orderService.netAmountCalculator(oldOrders, newOrders);
    }

    public void onAfterInsert(List<Order> newOrders) {

    }

    public void onAfterUpdate(Map<Id, Order> oldOrders, List<Order> newOrders) {
        // créer un orderService pour appeler la méthode ici = triggerHandler design pattern
        // utiliser le accountService 
    }

    public void onAfterDelete(Map<Id, Order> oldOrders) {

    }

    public void onAfterUndelete(List<Order> newOrders) {

    }

    public void onBeforeDelete(List<Order> newOrders){

    }
}

// Utiliser les agregate : AggregateResult groupedResults = [SELECT SUM(TotalAmount) total FROM Order WHERE Status = 'Ordered']
// On y accède comme cici : groupedResults.get('total');