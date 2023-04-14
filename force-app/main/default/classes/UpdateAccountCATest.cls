@isTest
private class UpdateAccountCATest {
    @isTest static void testUpdateAccount() {
        // Create a test account
        Account acc1 = new Account(Name = 'Test Account 1');
        insert acc1;

        // Create a test product
        Product2 pd1 = new Product2(Name = 'Chemise Verte longue XYX', Family = 'Chemise');
        Insert pd1;

        // Create a test pricebook entry for the product
        Pricebook2 standardPricebook = [SELECT Id FROM Pricebook2 WHERE IsStandard = true LIMIT 1];
        PricebookEntry pbe = new PricebookEntry(
            Pricebook2Id = standardPricebook.Id,
            Product2Id = pd1.Id,
            UnitPrice = 1020,
            IsActive = true
        );
        Insert pbe;

        // Create a test order associated with the account
        Order o1 = new Order(AccountId = acc1.Id);
        insert o1;

        // Create test order items for the order
        OrderItem oi1 = new OrderItem(
            OrderId = o1.Id,
            PricebookEntryId = pbe.Id,
            Quantity = 10,
            UnitPrice = 150
        );
        insert oi1;
        OrderItem oi2 = new OrderItem(
            OrderId = o1.Id,
            PricebookEntryId = pbe.Id,
            Quantity = 20,
            UnitPrice = 1000
        );
        insert oi2;        
    }
}
