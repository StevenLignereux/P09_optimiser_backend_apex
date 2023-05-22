@isTest
private class OrderServiceTest {
    @isTest
    static void testNetAmountCalculatorPositive() {
        // Create some test orders with shipment costs
        List<Order> orders = new List<Order> {
            new Order(TotalAmount = 100, ShipmentCost__c = 10),
            new Order(TotalAmount = 50, ShipmentCost__c = 5),
            new Order(TotalAmount = 75, ShipmentCost__c = 20)
        };
        insert orders;

        // Call the netAmountCalculator method
        OrderService.netAmountCalculator(orders);

        // Check that the net amount was calculated correctly
        List<Order> updatedOrders = [SELECT Id, NetAmount__c FROM Order WHERE Id IN :orders];
        for (Order order : updatedOrders) {
            System.assertEquals(order.NetAmount__c, order.TotalAmount - order.ShipmentCost__c);
        }
    }

    @isTest
    static void testNetAmountCalculatorZeroCost() {
        // Create some test orders with zero shipment costs
        List<Order> orders = new List<Order> {
            new Order(TotalAmount = 100, ShipmentCost__c = 0),
            new Order(TotalAmount = 50, ShipmentCost__c = 0),
            new Order(TotalAmount = 75, ShipmentCost__c = 0)
        };
        insert orders;

        // Call the netAmountCalculator method
        OrderService.netAmountCalculator(orders);

        // Check that the net amount was calculated correctly
        List<Order> updatedOrders = [SELECT Id, NetAmount__c FROM Order WHERE Id IN :orders];
        for (Order order : updatedOrders) {
            System.assertEquals(order.NetAmount__c, order.TotalAmount);
        }
    }

    @isTest
    static void testNetAmountCalculatorNegativeCost() {
        // Create some test orders with negative shipment costs
        List<Order> orders = new List<Order> {
            new Order(TotalAmount = 100, ShipmentCost__c = -50),
            new Order(TotalAmount = 50, ShipmentCost__c = -20),
            new Order(TotalAmount = 75, ShipmentCost__c = -10)
        };
        insert orders;

        // Call the netAmountCalculator method
        OrderService.netAmountCalculator(orders);

        // Check that the net amount was calculated correctly
        List<Order> updatedOrders = [SELECT Id, NetAmount__c FROM Order WHERE Id IN :orders];
        for (Order order : updatedOrders) {
            System.assertEquals(order.NetAmount__c, order.TotalAmount + order.ShipmentCost__c);
        }
    }
}