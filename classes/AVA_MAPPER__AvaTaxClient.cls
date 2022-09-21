/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class AvaTaxClient {
    global AvaTaxClient(String appName, String appVersion, String machineName, AVA_MAPPER.AvaTaxEnvironment environment) {

    }
    global AVA_MAPPER.FetchResultTransactionModel FetchTransactionsByFilter(String companyCode, String filter) {
        return null;
    }
    global AVA_MAPPER.TransactionModel commitTransaction(String companyCode, String transactionCode, AVA_MAPPER.DocumentType documentType, AVA_MAPPER.CommitTransactionModel model) {
        return null;
    }
    global AVA_MAPPER.FetchResultCertificateModel createCertificates(Integer companyId, Boolean preValidatedExemptionReason, List<AVA_MAPPER.CertificateModel> model) {
        return null;
    }
    global AVA_MAPPER.FetchResultCustomerModel createCustomers(Integer companyId, List<AVA_MAPPER.CustomerModel> model) {
        return null;
    }
    global AVA_MAPPER.TransactionModel createOrAdjustTransaction(String include, AVA_MAPPER.CreateOrAdjustTransactionModel model) {
        return null;
    }
    global AVA_MAPPER.TransactionModel createTransaction(String include, AVA_MAPPER.CreateTransactionModel model) {
        return null;
    }
    global AVA_MAPPER.FileResult downloadCertificateImage(Integer companyId, Integer id, Integer page, AVA_MAPPER.CertificatePreviewType type) {
        return null;
    }
    global AVA_MAPPER.CertificateModel getCertificate(Integer companyId, Integer id, String include) {
        return null;
    }
    global AVA_MAPPER.CustomerModel getCustomer(Integer companyId, String customerCode, String include) {
        return null;
    }
    global AVA_MAPPER.FetchResultSubscriptionModel getMySubscription() {
        return null;
    }
    global AVA_MAPPER.FetchResultTaxCodeModel getTaxCodeByCompanyIdTaxCodeId(Integer taxCodeId, Integer companyId, String filter, String include, Integer top, Integer skip, String orderBy) {
        return null;
    }
    global AVA_MAPPER.TransactionModel getTransactionByCode(String companyCode, String transactionCode, String include) {
        return null;
    }
    global AVA_MAPPER.FetchResultCustomerModel linkCustomersToCertificate(Integer companyId, Integer id, AVA_MAPPER.LinkCustomersModel model) {
        return null;
    }
    global AVA_MAPPER.FetchResultExemptionReasonModel listCertificateExemptReasons(String filter, Integer top, Integer skip, String orderBy) {
        return null;
    }
    global AVA_MAPPER.FetchResultExposureZoneModel listCertificateExposureZones(String filter, Integer top, Integer skip, String orderBy) {
        return null;
    }
    global AVA_MAPPER.FetchResultIsoCountryModel listCountries() {
        return null;
    }
    global AVA_MAPPER.FetchResultEntityUseCodeModel listEntityUseCodes() {
        return null;
    }
    global AVA_MAPPER.FetchResultTaxCodeModel listTaxCodes(String filter, Integer top, Integer skip, String orderBy) {
        return null;
    }
    global AVA_MAPPER.FetchResultTaxCodeModel listTaxCodesByCompanyId(Integer companyId, String filter, String include, Integer top, Integer skip, String orderBy) {
        return null;
    }
    global AVA_MAPPER.FetchResultCompanyModel queryCompanies(String include, String filter, Integer top, Integer skip, String orderBy) {
        return null;
    }
    global AVA_MAPPER.AddressResolutionModel resolveAddressPost(AVA_MAPPER.AddressValidationInfo model) {
        return null;
    }
    global AVA_MAPPER.FileResult restCallForFile(String method, String relativePath, Object model) {
        return null;
    }
    global System.HttpResponse restCallForList(String method, String relativePath, Object model) {
        return null;
    }
    global AVA_MAPPER.CertificateModel updateCertificate(Integer companyId, Integer id, AVA_MAPPER.CertificateModel model) {
        return null;
    }
    global AVA_MAPPER.CustomerModel updateCustomer(Integer companyId, String customerCode, AVA_MAPPER.CustomerModel model) {
        return null;
    }
    global String uploadCertificateImage(Integer companyId, Integer id, AVA_MAPPER.FileResult file) {
        return null;
    }
    global AVA_MAPPER.TransactionModel voidTransaction(String companyCode, String transactionCode, AVA_MAPPER.DocumentType documentType, AVA_MAPPER.VoidTransactionModel model) {
        return null;
    }
    global AVA_MAPPER.AvaTaxClient withSecurity(Integer accountId, String licenseKey) {
        return null;
    }
    global AVA_MAPPER.AvaTaxClient withSecurity(String username, String password) {
        return null;
    }
}
