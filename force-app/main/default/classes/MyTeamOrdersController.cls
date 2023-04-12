public without sharing class VFC01_Team {
    public decimal SumOrders {
        get {
            Decimal totalAmount = 0;
            try {
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

