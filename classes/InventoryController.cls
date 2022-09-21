public class InventoryController {
    public List<Inventory__c> invs { get; set; }
    public String productCodeParam = ApexPages.currentPage().getParameters().get('r');
    public Integer invTotal = 0;
    public String hardware = 'false';
    
    
    // Return a list of data points for a chart
    public List<Data> getData() {
        return InventoryController.getChartData();
    }
  
    public InventoryController(){
    	invs = [select Manufacturing_Site__c, Quantity_Allocated__c, Quantity_Assigned__c, Quantity_Available__c, Quantity_On_Hand__c, Inventory_Status__c, Unit_Cost__c, Unit_Price__c, Product_Code__c, Product__c FROM Inventory__c where Product_Code__c  =: productCodeParam];
        invTotal = invs.size();
        if(invTotal > 0) {
            hardware = 'true';
        }
        System.debug('Inventory Total:' + invTotal);
        System.debug('Inventory:' + invs);
    }
    
    // Make the chart data available via JavaScript remoting
    //@RemoteAction
    //public static List<Data> getRemoteData() {
    //    return InventoryController.getChartData();
   // }

    // The actual chart data; needs to be static to be
    // called by a @RemoteAction method

		public static List<Data> getChartData()
        {
        List<Data> data = new List<Data>();
				data.add(new Data('Jan', 'Chicago', 5, 'Fort Lauderdale', 10, 'Los Angeles', 20, 'New York', 10, 'Pittsburgh', 10));
				data.add(new Data('Feb', 'Chicago', 15, 'Fort Lauderdale', 5, 'Los Angeles', 5, 'New York', 10, 'Pittsburgh', 25));
				data.add(new Data('Mar', 'Chicago', 15, 'Fort Lauderdale', 5, 'Los Angeles', 5, 'New York', 15, 'Pittsburgh', 5));
				data.add(new Data('Apr', 'Chicago', 20, 'Fort Lauderdale', 5, 'Los Angeles', 5, 'New York', 10, 'Pittsburgh', 10));

				return data;
        }


    // Wrapper class
    public class Data
    {
        public String mon { get; set; }
        public String c_chi { get; set; }
        public String c_ftl { get; set; }
        public String c_lax { get; set; }
        public String c_nyc { get; set; }
        public String c_ptb { get; set; }

        public Integer chi { get; set; }
        public Integer ftl { get; set; }
        public Integer lax { get; set; }
        public Integer nyc { get; set; }
        public Integer ptb { get; set; }

        public Data(String mon, String c_chi, Integer chi, String c_ftl, Integer ftl, String c_lax, Integer lax, String c_nyc, Integer nyc, String c_ptb, Integer ptb)
        {
            this.mon = mon;
            this.c_chi = c_chi;
			this.chi = chi;

            this.c_ftl = c_ftl;
            this.ftl = ftl;

            this.c_lax = c_lax;
            this.lax = lax;

            this.c_nyc = c_nyc;
            this.nyc = nyc;

            this.c_ptb = c_ptb;
            this.ptb = ptb;
        }
    }
}