@isTest
private class UpdateAllAccountsBatchTest {
    @isTest
    static void testStart() {
        // Create some test accounts and orders
        List<Account> accounts = new List<Account> {
            new Account(Name = 'TestAccount1'),
            new Account(Name = 'TestAccount2'),
            new Account(Name = 'TestAccount3')
        };
        insert accounts;
        List<Order> orders = new List<Order> {
            new Order(AccountId = accounts[0].Id, Status = 'Ordered'),
            new Order(AccountId = accounts[1].Id, Status = 'Pending'),
            new Order(AccountId = accounts[2].Id, Status = 'Completed')
        };
        insert orders;

        // Call start method
        UpdateAllAccountsBatch batch = new UpdateAllAccountsBatch();
        Database.QueryLocator ql = batch.start(null);
        List<Account> queriedAccounts = ql.getRecords();

        // Check that the query locator only returns the accounts with orders in the 'Ordered' status
        Assert.areEqual(1, queriedAccounts.size());
        System.assertEquals(accounts[0].Id, queriedAccounts[0].Id);
    }

    @isTest
    static void testExecute() {
        // Create some test accounts
        List<Account> accounts = new List<Account> {
            new Account(Name = 'TestAccount1', Chiffre_d_affaire__c = 100),
            new Account(Name = 'TestAccount2', Chiffre_d_affaire__c = 50),
            new Account(Name = 'TestAccount3', Chiffre_d_affaire__c = 75)
        };
        insert accounts;

        // Call execute method
        UpdateAllAccountsBatch batch = new UpdateAllAccountsBatch();
        batch.execute(null, accounts);

        // Check that the account CA is updated correctly
        List<Account> updatedAccounts = [SELECT Chiffre_d_affaire__c FROM Account];
        Assert.areEqual(accounts.size(), updatedAccounts.size());
        for (Account a : updatedAccounts) {
            Assert.areEqual(a.Chiffre_d_affaire__c, AccountService.UPDATE_CA_VALUE);
        }
    }
}