@isTest
private class AccountServiceTest {
    @isTest
    static void testUpdateAllCAWithOrders() {
        List<Account> accountList = TestDataFactory.createAccounts(2);
        List<Order> orders = TestDataFactory.createOrdersForAccounts(accountList, 2, 10, 1);
        
        Test.startTest();
        AccountService.updateAllCA(orders);
        Test.stopTest();
        
        // Vérification que les chiffres d'affaires des comptes sont mis à jour correctement
        accountList = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id IN :accountList];
        for (Account account : accountList) {
            Assert.areEqual(20, account.Chiffre_d_affaire__c);
        }
    }
    
    @isTest
    static void testUpdateAllCAWithEmptyOrderList() {
        List<Account> accountList = TestDataFactory.createAccounts(2);
        
        Test.startTest();
        AccountService.updateAllCA(new List<Order>());
        Test.stopTest();
        
        // Vérification que les chiffres d'affaires des comptes sont mis à 0 si il n'y a pas de commande
        accountList = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id IN :accountList];
        for (Account account : accountList) {
            Assert.areEqual(0, account.Chiffre_d_affaire__c);
        }
    }
    
    @isTest
    static void testUpdateAllCAWithAccounts() {
        List<Account> accountList = TestDataFactory.createAccounts(2);
        List<Order> orders = TestDataFactory.createOrdersForAccounts(accountList, 2, 10, 1);
        
        Test.startTest();
        AccountService.updateAllCA(accountList);
        Test.stopTest();
        
        // Vérification que les chiffres d'affaires des comptes sont mis à jour correctement
        accountList = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id IN :accountList];
        for (Account account : accountList) {
            Assert.areEqual(20, account.Chiffre_d_affaire__c);
        }
    }
    
    @isTest
    static void testUpdateAllCAWithEmptyAccountList() {
        List<Account> accountList = TestDataFactory.createAccounts(2);
        
        Test.startTest();
        AccountService.updateAllCA(new List<Account>());
        Test.stopTest();
        
        // Vérification que les chiffres d'affaires des comptes sont mis à 0 si il n'y a pas d'enregistrement de compte
        accountList = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id IN :accountList];
        for (Account account : accountList) {
            Assert.areEqual(0, account.Chiffre_d_affaire__c);
        }
    }
}



