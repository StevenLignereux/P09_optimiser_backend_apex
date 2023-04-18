public without sharing class MyTeamOrdersController {
    public decimal SumOrders {
        get {
            // Use a query variable to get the value of the aggregate function
            Decimal totalAmount = 0;
            
            // use a try-catch block to handle the exception
            try {
                // use a where clause to improve the query effiency
                List<AggregateResult> groupedResults = [SELECT SUM(TotalAmount) total FROM Order WHERE Status = 'Completed'];
                if (groupedResults != null && !groupedResults.isEmpty()) {
                    
                    totalAmount = (Decimal)groupedResults[0].get('total');
                }
            } catch (Exception ex) {
                // Handle the exception here, e.g. log the error or throw a custom exception
            }
            return totalAmount;
        }
        set;
    }
}


