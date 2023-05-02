trigger OrderAmountCalculator on Order (before update) {
    /** Modify the for loop to iterate order objects in the Trigger.new list.
     *  Use trigger.new to access the new values of the order object.
     **/
    for (Order newOrder : Trigger.new) {
        newOrder.NetAmount__c = newOrder.TotalAmount - newOrder.ShipmentCost__c;
    }

    
}

// utiliser el design pattern trigger handler : avoir un trigger par objet 
// on fait toutes les actions possibles sur l'objet 
// nom générique : OrderTrigger 
// on créer des conditions par exemple if before update et dans ces if on fait appel aux méthodes (déléguer au trigger comme le service).