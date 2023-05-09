public with sharing class OrderService {
    public static void netAmountCalculator(List<Order> orders){
        for(Order order : orders){
            // Créer les champs dans l'org 
            //order.NetAmount__c = order.TotalAmount - order.ShipmentCost__c;
        }
        update orders;
    }
}


