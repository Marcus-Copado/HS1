/**
 * Created by scheck on 12/18/18.
 */

global with sharing class QTC_CancelContractCallback implements SBQQ.CalculateCallback {
    global void callback(String quoteJSON) {
        SBQQ.ServiceRouter.save('SBQQ.QuoteAPI.QuoteSaver', quoteJSON);
    }
}