@isTest
private class AccountServiceTest {
    @isTest static void test() {
        List<Account> accounts = AccountDataFactory.createAccounts(1);
        List<Product2> products = AccountDataFactory.createProducts(1);
        List<PricebookEntry> pricebookEntries = AccountDataFactory.createPricebookEntries(products[0].Id);
        List<Order> orders = AccountDataFactory.createOrders(accounts[0].Id);
        List<OrderItem> orderItems = AccountDataFactory.createOrderItems(orders[0].Id, pricebookEntries[0].Id, new decimal[]{10, 20}, new decimal[]{150, 1000});
    }
}



