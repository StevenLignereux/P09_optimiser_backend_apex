trigger OrderAmountCalculator on Order (before update) {
    /** Modify the for loop to iterate order objects in the Trigger.new list.
     *  Use trigger.new to access the new values of the order object.
     **/
    for (Order newOrder : Trigger.new) {
        newOrder.NetAmount__c = newOrder.TotalAmount - newOrder.ShipmentCost__c;
    }
}
