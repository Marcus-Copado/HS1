global class Q2CDocumentStorePlugin implements SBQQ.DocumentStorePlugin, SBQQ.DocumentStorePlugin2 {
    
    /**
    *Called First
    */
    public void storeDocument(SObject quote, SObject quoteDocument, Blob b, String s) {
        System.debug('METHOD CALLED storeDocument');
        System.debug('PARAM 1 PASSED SOBJECT');
        System.debug(quote);
        System.debug('PARAM 2 PASSED SOBJECT');
        System.debug(quoteDocument);
        System.debug('PARAM 3 PASSED BLOB');
        System.debug(b);
        System.debug('PARAM 4 PASSED STRING');
        System.debug(s);
    }

    public Boolean isQuoteDocumentSaved() {
        System.debug('METHOD CALLED isQuoteDocumentSaved');
        return false;
    
    }
    
    public List<SObject> listDocuments(SObject sob) {
        System.debug('METHOD CALLED listDocuments');
        System.debug('PARAM 1 PASSED SOBJECT');
        System.debug(sob);
        return new List<SObject>();
    }
    
    public void storeDocument(SObject sob1, SObject sob2, Blob b) {
        System.debug('METHOD CALLED storeDocument');
        System.debug('PARAM 1 PASSED SOBJECT');
        System.debug(sob1);
        System.debug('PARAM 2 PASSED SOBJECT');
        System.debug(sob2);
        System.debug('PARAM 3 PASSED BLOB');
        System.debug(b);
    }
}