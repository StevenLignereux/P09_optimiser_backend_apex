public without sharing class OrderTriggerHandler {
    public void onBeforeInsert(List<Order> newOrders) {

    }

    public void onBeforeUpdate(Map<Id, Order> oldOrders, List<Order> newOrders) {
        OrderService.netAmountCalculator(newOrders);
    }

    public void onAfterInsert(List<Order> newOrders) {

    }

    public void onAfterUpdate(Map<Id, Order> oldOrders, List<Order> newOrders) {
        AccountService.updateAllCA(newOrders);
    }

    public void onAfterDelete(Map<Id, Order> oldOrders) {

    }

    public void onAfterUndelete(List<Order> newOrders) {

    }

    public void onBeforeDelete(List<Order> newOrders){

    }
}

