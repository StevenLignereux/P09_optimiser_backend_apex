@isTest
public class AccountDataFactory {
    public static List<Account> createAccounts(Integer numRecords) {
        List<Account> accountsToCreate = new List<Account>();
        for (Integer i = 0; i < numRecords; i++) {
            accountsToCreate.add(new Account(Name = 'Test Account ' + i));
        }
        insert accountsToCreate;
        return accountsToCreate;
    }

    public static List<Product2> createProducts(Integer numRecords) {
        List<Product2> productsToCreate = new List<Product2>();
        for (Integer i = 0; i < numRecords; i++) {
            productsToCreate.add(new Product2(Name = 'Test Product ' + i, Family = 'Test Family ' + i));
        }
        insert productsToCreate;
        return productsToCreate;
    }

    public static List<PricebookEntry> createPricebookEntries(Id productId) {
        List<PricebookEntry> pricebookEntriesToCreate = new List<PricebookEntry>();

        Pricebook2 standardPricebook = [SELECT Id FROM Pricebook2 WHERE IsStandard = true];

        for (Integer i = 0; i < 1; i++) {
            pricebookEntriesToCreate.add(new PricebookEntry(
                    Pricebook2Id = standardPricebook.Id,
                    Product2Id = productId,
                    UnitPrice = 1020,
                    IsActive = true
                )
            );
        }
        insert pricebookEntriesToCreate;
        return pricebookEntriesToCreate;
    }

    public static List<Order> createOrders(Id accountId) {
        List<Order> ordersToCreate = new List<Order>();
        for (Integer i = 0; i < 1; i++) {
            ordersToCreate.add(new Order(AccountId = accountId, EffectiveDate = Date.today(), Status = 'Draft'));
        }
        insert ordersToCreate;
        return ordersToCreate;
    }

    public static List<OrderItem> createOrderItems(Id orderId, Id pricebookEntryId, List<decimal> quantities, List<decimal> unitPrices) {
        List<OrderItem> orderItemsToCreate = new List<OrderItem>();
        for (Integer i = 0; i < quantities.size(); i++) {
            orderItemsToCreate.add(new OrderItem(
                    OrderId              = orderId,
                    PricebookEntryId     = pricebookEntryId,
                    Quantity            = quantities[i],
                    UnitPrice           = unitPrices[i]
                )
            );
        }
        insert orderItemsToCreate;
        return orderItemsToCreate;
    }
}