public class TestDataFactory {
    
    public static List<Account> createAccounts(Integer numAccounts) {
        List<Account> accountsToCreate = new List<Account>();
        for (Integer i = 0; i < numAccounts; i++) {
            accountsToCreate.add(new Account(Name = 'Test Account ' + i));
        }
        Database.insert(accountsToCreate);
        return accountsToCreate;
    }
    
    
    public static List<Order> createOrdersForAccounts(List<Account> accounts, Integer numOrders, Integer unitPrice, Integer quantity) {
        List<Order> ordersToCreate = new List<Order>();
        List<OrderItem> orderItemsToCreate = new List<OrderItem>();
        Id standardPricebookId = Test.getStandardPricebookId();

        for (Account account : accounts) {
            Contract contract = new Contract(
                AccountId=account.Id, 
                Status='Draft',
                ContractTerm=5
            );
            insert contract;

            for (Integer k = 0; k < numOrders; k++) {
                Order order = new Order(
                    AccountId=account.Id,
                    ContractId=contract.Id,
                    Status='Draft',
                    EffectiveDate=Date.today(),
                    Pricebook2Id=standardPricebookId
                );
                ordersToCreate.add(order);
            }
        }

        

        Database.insert(ordersToCreate);

        for (Order order : ordersToCreate) {
            OrderItem orderItem = new OrderItem (
                OrderId=order.Id,
                PricebookEntryId=createPricebookEntries(unitPrice).get(0).Id,
                Quantity=quantity,
                UnitPrice=unitPrice
            );
            orderItemsToCreate.add(orderItem);
        }

        Database.insert(orderItemsToCreate);

        return ordersToCreate;
    }

    private static List<PricebookEntry> createPricebookEntries(Integer unitPrice) {
        List<PricebookEntry> pricebookEntriesToCreate = new List<PricebookEntry>();
        Product2 product = new Product2(Name = 'Chemise Verte longue XYX', Family = 'Chemise');
        insert product;

        PricebookEntry pbe = new PricebookEntry(
            Pricebook2Id = Test.getStandardPricebookId(),
            Product2Id = product.Id,
            UnitPrice = unitPrice,
            IsActive = true
        );
        
        pricebookEntriesToCreate.add(pbe);
        Database.insert(pricebookEntriesToCreate);
        return pricebookEntriesToCreate;
    }
}