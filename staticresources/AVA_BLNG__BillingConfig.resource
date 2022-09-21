<?xml version="1.0" encoding="UTF-8"?>
<avatax>
    <addressvalidation>
        <Account>
		<hooks>
		<avaconfig>AVA_BLNG.ConfigProviderForAddressValidation_blng</avaconfig>
		</hooks>
            <Billing>
                <query>select BillingStreet, BillingCity,BillingState,BillingCountry,BillingPostalCode from Account where id = '{AccountId}'</query>
                <parameters>
                    <AccountId>Id</AccountId>
                </parameters>
                <Mapping>
                    <line1>BillingStreet</line1>
                    <city>BillingCity</city>
                    <region>BillingState</region>
                    <country>BillingCountry</country>
                    <postalcode>BillingPostalCode</postalcode>
                </Mapping>
                <UpdateMapping>
                    <line1>BillingStreet</line1>
                    <city>BillingCity</city>
                    <region>BillingState</region>
                    <country>BillingCountry</country>
                    <postalcode>BillingPostalCode</postalcode>
                </UpdateMapping>
            </Billing>
            <Shipping>
                <query>select ShippingStreet, ShippingCity,ShippingState,ShippingCountry,ShippingPostalCode from Account where id = '{AccountId}'</query>
                <parameters>
                    <AccountId>Id</AccountId>
                </parameters>
                <Mapping>
                    <line1>ShippingStreet</line1>
                    <city>ShippingCity</city>
                    <region>ShippingState</region>
                    <country>ShippingCountry</country>
                    <postalcode>ShippingPostalCode</postalcode>
                </Mapping>
                <UpdateMapping>
                    <line1>ShippingStreet</line1>
                    <city>ShippingCity</city>
                    <region>ShippingState</region>
                    <country>ShippingCountry</country>
                    <postalcode>ShippingPostalCode</postalcode>
                </UpdateMapping>
            </Shipping>
        </Account>
        <blng__LegalEntity__c>
		<hooks>
		<avaconfig>AVA_BLNG.ConfigProviderForAddressValidation_blng</avaconfig>
		</hooks>
            <LegalEntity>
                <query>select blng__Street1__c, blng__Street2__c,blng__City__c,blng__State__c,blng__Country__c, blng__ZipPostalCode__c from blng__LegalEntity__c where id = '{LegalEnityId}'</query>
                <parameters>
                    <LegalEnityId>Id</LegalEnityId>
                </parameters>
                <Mapping>
                    <line1>blng__Street1__c</line1>
					<line2>blng__Street2__c</line2>
                    <city>blng__City__c</city>
                    <region>blng__State__c</region>
                    <country>blng__Country__c</country>
                    <postalcode>blng__ZipPostalCode__c</postalcode>
                </Mapping>
                <UpdateMapping>
                    <line1>blng__Street1__c</line1>
					<line2>blng__Street2__c</line2>
                    <city>blng__City__c</city>
                    <region>blng__State__c</region>
                    <country>blng__Country__c</country>
                    <postalcode>blng__ZipPostalCode__c</postalcode>
                </UpdateMapping>
            </LegalEntity>
        </blng__LegalEntity__c>
		<Contact>
		<hooks>
		<avaconfig>AVA_BLNG.ConfigProviderForAddressValidation_blng</avaconfig>
		</hooks>
            <Mailing>
                <query>select MailingStreet, MailingCity,MailingState,MailingCountry,MailingPostalCode from Contact where id = '{ContactId}'</query>
                <parameters>
                    <ContactId>Id</ContactId>
                </parameters>
                <Mapping>
                    <line1>MailingStreet</line1>
                    <city>MailingCity</city>
                    <region>MailingState</region>
                    <country>MailingCountry</country>
                    <postalcode>MailingPostalCode</postalcode>
                </Mapping>
                <UpdateMapping>
                    <line1>MailingStreet</line1>
                    <city>MailingCity</city>
                    <region>MailingState</region>
                    <country>MailingCountry</country>
                    <postalcode>MailingPostalCode</postalcode>
                </UpdateMapping>
            </Mailing>
            <Other>
                <query>select OtherStreet, OtherCity,OtherState,OtherCountry,OtherPostalCode from Contact where id = '{ContactId}'</query>
                <parameters>
                    <ContactId>Id</ContactId>
                </parameters>
                <Mapping>
                    <line1>OtherStreet</line1>
                    <city>OtherCity</city>
                    <region>OtherState</region>
                    <country>OtherCountry</country>
                    <postalcode>OtherPostalCode</postalcode>
                </Mapping>
                <UpdateMapping>
                    <line1>OtherStreet</line1>
                    <city>OtherCity</city>
                    <region>OtherState</region>
                    <country>OtherCountry</country>
                    <postalcode>OtherPostalCode</postalcode>
                </UpdateMapping>
            </Other>
        </Contact>
    </addressvalidation>
    <taxcalculation>
        <Order>
            <hooks>
                <overriderequestline></overriderequestline>
                <beforetaxcalculation></beforetaxcalculation>
                <beforeupdate></beforeupdate>
                <afterupdate></afterupdate>
            </hooks>
            <Header>
                <Queries>
                    <Order>
                        <query>SELECT OrderNumber, AccountId, blng__BillingAccount__r.BillingStreet,blng__BillingAccount__r.BillingCity,
                            blng__BillingAccount__r.BillingState,blng__BillingAccount__r.BillingCountry,
                            blng__BillingAccount__r.BillingPostalCode,BillToContact.MailingStreet,
                            BillToContact.MailingCity,BillToContact.MailingState,BillToContact.MailingCountry,
                            BillToContact.MailingPostalCode,ShipToContact.MailingStreet,
                            ShipToContact.MailingCity,ShipToContact.MailingState,ShipToContact.MailingCountry,
                            ShipToContact.MailingPostalCode,Account.BillingStreet,Account.BillingCity,
                            Account.BillingState,Account.BillingCountry,Account.BillingPostalCode,
                            Account.ShippingStreet,Account.ShippingCity,Account.ShippingState,
                            Account.ShippingCountry,Account.ShippingPostalCode,blng__BillingAccount__r.ShippingStreet,
                            blng__BillingAccount__r.ShippingCity,blng__BillingAccount__r.ShippingState,
                            blng__BillingAccount__r.ShippingCountry,blng__BillingAccount__r.ShippingPostalCode,
                            blng__BillingAccount__r.blng__BillToContact__r.MailingStreet,
                            blng__BillingAccount__r.blng__BillToContact__r.MailingCity,
                            blng__BillingAccount__r.blng__BillToContact__r.MailingState,
                            blng__BillingAccount__r.blng__BillToContact__r.MailingCountry,
                            blng__BillingAccount__r.blng__BillToContact__r.MailingPostalCode,
                            Account.blng__BillToContact__r.MailingStreet, Account.blng__BillToContact__r.MailingCity,
                            Account.blng__BillToContact__r.MailingState, Account.blng__BillToContact__r.MailingCountry,
                            Account.blng__BillToContact__r.MailingPostalCode  {CurrencyIsoCode} 
                            FROM Order WHERE Id IN ({ListofOrderIds})</query>
                        <parameters>
                            <ListofOrderIds>optionalParams.listOfSObjectIds</ListofOrderIds>
                            <CurrencyIsoCode>optionalParams.currencyIsoCode</CurrencyIsoCode>
                        </parameters>
                        <Mapping>
                            <code>OrderNumber</code>
                            <customerCode>AccountId</customerCode>
                        </Mapping>
                    </Order>
                </Queries>
            </Header>
            <Line>
                <Queries>
                    <OrderItem>
                        <query>SELECT Id, blng__TaxStreet__c,blng__TaxStreet2__c, blng__TaxCity__c,blng__TaxState__c, 		blng__TaxCountry__c,blng__TaxZipCode__c, blng__BillableUnitPrice__c, OrderItemNumber, Pricebookentry.product2.Name, Pricebookentry.product2.ProductCode, Pricebookentry.product2.Description, UnitPrice, 
                            Quantity,OrderId,Order.OrderNumber,Order.Account.Name,Order.Account.Id, blng__LegalEntity__c, 
                            blng__LegalEntity__r.Name,blng__LegalEntity__r.blng__City__c,blng__LegalEntity__r.blng__Country__c, 
                            blng__LegalEntity__r.blng__State__c,blng__LegalEntity__r.blng__Street1__c,
                            blng__LegalEntity__r.blng__Street2__c, blng__LegalEntity__r.blng__ZipPostalCode__c,
                            blng__LegalEntityReference__c,blng__TaxTreatment__c, blng__TaxTreatment__r.blng__TaxCode__c,
                            blng__TaxTreatment__r.blng__TaxIntegration__c, blng__TaxTreatment__r.blng__TaxRule__c,
                            blng__TaxTreatment__r.blng__TaxLegalEntity__c, blng__TaxTreatment__r.blng__TaxIntegration__r.AVA_BLNG__AvaTaxAccountNumber__c,
                            blng__TaxTreatment__r.blng__TaxIntegration__r.AVA_BLNG__AvaTaxLicenseKey__c, 
							blng__TaxTreatment__r.blng__TaxIntegration__r.AVA_BLNG__DocCode__c, 
							blng__TaxTreatment__r.blng__TaxIntegration__r.AVA_BLNG__Save_transactions_to_AvaTax__c,
							blng__TaxTreatment__r.blng__TaxIntegration__r.AVA_BLNG__CustomerCode__c,                            
							blng__TaxTreatment__r.blng__TaxIntegration__r.AVA_BLNG__TestMode__c, 
                            blng__TaxRule__c,blng__TaxRule__r.blng__TaxableYesNo__c, 
                            blng__BillingAccount__c,Order.blng__BillingAccount__c, 
							Order.Account.AVA_MAPPER__Exemption_Number__c, 
							Order.Account.AVA_MAPPER__Is_Seller_Importer_Of_Record__c, 
							Order.BillToContact.Account.AVA_MAPPER__Exemption_Number__c, 
							Order.BillToContact.Account.AVA_MAPPER__Is_Seller_Importer_Of_Record__c, 
                            Order.ShipToContact.Account.AVA_MAPPER__Exemption_Number__c,
							Order.ShipToContact.Account.AVA_MAPPER__Is_Seller_Importer_Of_Record__c, 
                            blng__BillingAccount__r.blng__BillToContact__r.Account.AVA_MAPPER__Exemption_Number__c, 
							Order.BillToContact.Account.AVA_MAPPER__Business_Identification_Number__c, 
							Order.ShipToContact.Account.AVA_MAPPER__Business_Identification_Number__c, 
							Order.Account.AVA_MAPPER__Business_Identification_Number__c, 
							blng__BillingAccount__r.AVA_MAPPER__Business_Identification_Number__c, 
							Order.blng__BillingAccount__r.AVA_MAPPER__Business_Identification_Number__c, 
							blng__BillingAccount__r.blng__BillToContact__r.Account.AVA_MAPPER__Business_Identification_Number__c, 
							Order.blng__BillingAccount__r.blng__BillToContact__r.Account.AVA_MAPPER__Business_Identification_Number__c, 
							Order.Account.blng__BillToContact__r.Account.AVA_MAPPER__Business_Identification_Number__c, 
                            Order.blng__BillingAccount__r.blng__BillToContact__r.Account.AVA_MAPPER__Exemption_Number__c,
							Order.Account.blng__BillToContact__r.Account.AVA_MAPPER__Exemption_Number__c,
							blng__BillingAccount__r.AVA_MAPPER__Exemption_Number__c,
							Order.blng__BillingAccount__r.AVA_MAPPER__Exemption_Number__c,
							Order.Account.AVA_MAPPER__Entity_Use_code__c, 
							Order.BillToContact.Account.AVA_MAPPER__Entity_Use_code__c, 
                            Order.ShipToContact.Account.AVA_MAPPER__Entity_Use_code__c,
							blng__BillingAccount__r.blng__BillToContact__r.Account.AVA_MAPPER__Entity_Use_code__c, 
                            Order.blng__BillingAccount__r.blng__BillToContact__r.Account.AVA_MAPPER__Entity_Use_code__c,
							Order.Account.blng__BillToContact__r.Account.AVA_MAPPER__Entity_Use_code__c,
							blng__BillingAccount__r.AVA_MAPPER__Entity_Use_code__c,
							Order.blng__BillingAccount__r.AVA_MAPPER__Entity_Use_code__c 
							FROM OrderItem WHERE {filterOn} IN ({filterValues}) 
                            and blng__TaxTreatment__c != NULL 
                            AND blng__TaxTreatment__r.blng__TaxIntegration__r.blng__TaxEngine__c = '{taxEngineName}' 
                            AND blng__TaxRule__r.blng__TaxableYesNo__c = '{isTaxable}'</query>
                        <parameters>
                            <filterOn>optionalParams.filterOn</filterOn>
                            <filterValues>optionalParams.filterValues</filterValues>
                            <taxEngineName>optionalParams.taxEngineName</taxEngineName>
                            <isTaxable>optionalParams.isTaxable</isTaxable> 
                        </parameters>
                        <Mapping>
                            <quantity>Quantity</quantity>
                            <itemCode>OrderItemNumber</itemCode>
                            <amount>UnitPrice</amount>
                            <addresses.shipTo.line1>blng__TaxStreet__c</addresses.shipTo.line1>
                            <addresses.shipTo.line2>blng__TaxStreet2__c</addresses.shipTo.line2>
                            <addresses.shipTo.line3 />
                            <addresses.shipTo.city>blng__TaxCity__c</addresses.shipTo.city>
                            <addresses.shipTo.region>blng__TaxState__c</addresses.shipTo.region>
                            <addresses.shipTo.country>blng__TaxCountry__c</addresses.shipTo.country>
                            <addresses.shipTo.postalCode>blng__TaxZipCode__c</addresses.shipTo.postalCode>
                            <addresses.shipTo.latitude></addresses.shipTo.latitude>
                            <addresses.shipTo.longitude></addresses.shipTo.longitude>       
                            <addresses.shipFrom.line1>blng__TaxStreet__c</addresses.shipFrom.line1>
                            <addresses.shipFrom.line2>blng__TaxStreet2__c</addresses.shipFrom.line2>
                            <addresses.shipFrom.line3 />
                            <addresses.shipFrom.city>blng__TaxCity__c</addresses.shipFrom.city>
                            <addresses.shipFrom.region>blng__TaxState__c</addresses.shipFrom.region>
                            <addresses.shipFrom.country>blng__TaxCountry__c</addresses.shipFrom.country>
                            <addresses.shipFrom.postalCode>blng__TaxZipCode__c</addresses.shipFrom.postalCode>
                            <addresses.shipFrom.latitude></addresses.shipFrom.latitude>
                            <addresses.shipFrom.longitude></addresses.shipFrom.longitude>
                        </Mapping>
                    </OrderItem>
                    <Account>
                        <query>SELECT Id,BillingStreet, BillingCity, BillingState, BillingPostalCode,
                            BillingCountry, ShippingStreet, ShippingCity, ShippingState,
                            ShippingPostalCode, ShippingCountry, blng__BillToContact__r.MailingStreet,
                            blng__BillToContact__r.MailingCity, blng__BillToContact__r.MailingState,
                            blng__BillToContact__r.MailingPostalCode, blng__BillToContact__r.MailingCountry
                            FROM Account WHERE Id IN {SetOfAccountIds}</query>
                        <parameters>
                            <SetOfAccountIds>AVA_BLNG.SetOfAccountIds</SetOfAccountIds>
                        </parameters>
                        <link>
                            <primarytable>OrderItem</primarytable>
                            <primaryfield>blng__BillingAccount__c</primaryfield>
                            <referencefield>Id</referencefield>
                        </link>
                    </Account>
                </Queries>
            </Line>
        </Order>
        <blng__Invoice__c>
            <hooks>
                <overriderequestline></overriderequestline>
                <beforetaxcalculation></beforetaxcalculation>
                <beforeupdate></beforeupdate>
                <afterupdate></afterupdate>
            </hooks>
            <Header>
                <Queries>
                    <blng__Invoice__c>
                        <query>SELECT Id, Name, blng__InvoiceDate__c,blng__InvoiceStatus__c, blng__Account__r.Name, blng__Account__c {CurrencyIsoCode} FROM blng__Invoice__c WHERE Id IN ({ListofInvoiceIds})</query>
                        <parameters>
                            <ListofInvoiceIds>optionalParams.listOfSObjectIds</ListofInvoiceIds>
                            <CurrencyIsoCode>optionalParams.currencyIsoCode</CurrencyIsoCode>
                        </parameters>
                        <Mapping>
                            <code>Name</code>
                        </Mapping>
                    </blng__Invoice__c>
                </Queries>
            </Header>
            <Line>
                <Queries>
                    <blng__InvoiceLine__c>
                        <query>SELECT Id, blng__TaxStreet__c, blng__TaxStreet2__c, blng__TaxCity__c, blng__TaxState__c, 
                            blng__TaxCountry__c, blng__TaxZipCode__c, blng__UnitPrice__c, blng__Subtotal__c, Name, 
                            blng__Quantity__c, blng__Product__r.Name, blng__Product__r.Description, blng__Product__r.ProductCode, blng__Invoice__c, blng__Invoice__r.Name, blng__Invoice__r.blng__InvoiceDate__c,
							blng__Invoice__r.blng__Account__r.Name, blng__Invoice__r.blng__Account__c, blng__LegalEntity__c,
                            blng__LegalEntity__r.Name, blng__LegalEntity__r.blng__City__c, 
                            blng__LegalEntity__r.blng__Country__c, blng__LegalEntity__r.blng__State__c, 
                            blng__LegalEntity__r.blng__Street1__c, blng__LegalEntity__r.blng__Street2__c, 
                            blng__LegalEntity__r.blng__ZipPostalCode__c, blng__LegalEntityReference__c, 
                            blng__TaxTreatment__c, blng__TaxTreatment__r.blng__TaxCode__c, 
                            blng__TaxTreatment__r.blng__TaxIntegration__c, blng__TaxTreatment__r.blng__TaxRule__c, 
                            blng__TaxTreatment__r.blng__TaxLegalEntity__c, blng__TaxTreatment__r.blng__TaxIntegration__r.AVA_BLNG__AvaTaxAccountNumber__c, 
                            blng__TaxTreatment__r.blng__TaxIntegration__r.AVA_BLNG__AvaTaxLicenseKey__c, 
                            blng__TaxTreatment__r.blng__TaxIntegration__r.AVA_BLNG__DocCode__c, 
							blng__TaxTreatment__r.blng__TaxIntegration__r.AVA_BLNG__Save_transactions_to_AvaTax__c,
                            blng__TaxTreatment__r.blng__TaxIntegration__r.AVA_BLNG__CustomerCode__c, 
                            blng__TaxTreatment__r.blng__TaxIntegration__r.AVA_BLNG__TestMode__c, blng__TaxRule__c, 
                            blng__TaxRule__r.blng__TaxableYesNo__c, 
							blng__OrderProduct__r.Order.blng__BillingAccount__c, blng__OrderProduct__r.blng__BillingAccount__c, 
							blng__Invoice__r.blng__Account__r.AVA_MAPPER__Exemption_Number__c, 
							blng__OrderProduct__r.Order.Account.AVA_MAPPER__Exemption_Number__c,
                            blng__OrderProduct__r.Order.BillToContact.Account.AVA_MAPPER__Exemption_Number__c, blng__OrderProduct__r.Order.ShipToContact.Account.AVA_MAPPER__Exemption_Number__c, 
                            blng__OrderProduct__r.blng__BillingAccount__r.AVA_MAPPER__Exemption_Number__c, 							
							blng__OrderProduct__r.Order.blng__BillingAccount__r.AVA_MAPPER__Exemption_Number__c,
							blng__OrderProduct__r.blng__BillingAccount__r.blng__BillToContact__r.Account.AVA_MAPPER__Exemption_Number__c, 
                            blng__OrderProduct__r.Order.blng__BillingAccount__r.blng__BillToContact__r.Account.AVA_MAPPER__Exemption_Number__c, 
							blng__OrderProduct__r.Order.Account.blng__BillToContact__r.Account.AVA_MAPPER__Exemption_Number__c, 
							blng__Invoice__r.blng__Account__r.AVA_MAPPER__Entity_Use_code__c, 
							blng__OrderProduct__r.Order.Account.AVA_MAPPER__Entity_Use_code__c,
                            blng__OrderProduct__r.Order.BillToContact.Account.AVA_MAPPER__Entity_Use_code__c, blng__OrderProduct__r.Order.ShipToContact.Account.AVA_MAPPER__Entity_Use_code__c, 
                            blng__OrderProduct__r.blng__BillingAccount__r.AVA_MAPPER__Entity_Use_code__c, 							
							blng__OrderProduct__r.Order.blng__BillingAccount__r.AVA_MAPPER__Entity_Use_code__c,
							blng__OrderProduct__r.blng__BillingAccount__r.blng__BillToContact__r.Account.AVA_MAPPER__Entity_Use_code__c, 
                            blng__OrderProduct__r.Order.blng__BillingAccount__r.blng__BillToContact__r.Account.AVA_MAPPER__Entity_Use_code__c, 
							blng__OrderProduct__r.Order.Account.blng__BillToContact__r.Account.AVA_MAPPER__Entity_Use_code__c ,
							blng__Invoice__r.blng__Account__r.AVA_MAPPER__Business_Identification_Number__c, 
							blng__OrderProduct__r.Order.Account.AVA_MAPPER__Business_Identification_Number__c,
                            blng__OrderProduct__r.Order.BillToContact.Account.AVA_MAPPER__Business_Identification_Number__c, blng__OrderProduct__r.Order.ShipToContact.Account.AVA_MAPPER__Business_Identification_Number__c, 
							blng__OrderProduct__r.Order.Account.AVA_MAPPER__Is_Seller_Importer_Of_Record__c,
                            blng__OrderProduct__r.Order.BillToContact.Account.AVA_MAPPER__Is_Seller_Importer_Of_Record__c, blng__OrderProduct__r.Order.ShipToContact.Account.AVA_MAPPER__Is_Seller_Importer_Of_Record__c, 
                            blng__OrderProduct__r.blng__BillingAccount__r.AVA_MAPPER__Business_Identification_Number__c, 							
							blng__OrderProduct__r.Order.blng__BillingAccount__r.AVA_MAPPER__Business_Identification_Number__c,
							blng__OrderProduct__r.blng__BillingAccount__r.blng__BillToContact__r.Account.AVA_MAPPER__Business_Identification_Number__c, 
                            blng__OrderProduct__r.Order.blng__BillingAccount__r.blng__BillToContact__r.Account.AVA_MAPPER__Business_Identification_Number__c, 
							blng__OrderProduct__r.Order.Account.blng__BillToContact__r.Account.AVA_MAPPER__Business_Identification_Number__c 
                            FROM blng__InvoiceLine__c WHERE {filterOn} IN ({filterValues}) AND blng__TaxTreatment__c != NULL 
                            AND blng__TaxTreatment__r.blng__TaxIntegration__r.blng__TaxEngine__c = '{taxEngineName}' 
                            AND blng__TaxRule__r.blng__TaxableYesNo__c = '{isTaxable}'</query>
                        <parameters>
                            <filterOn>optionalParams.filterOn</filterOn>
                            <filterValues>optionalParams.filterValues</filterValues>
                            <taxEngineName>optionalParams.taxEngineName</taxEngineName>
                            <isTaxable>optionalParams.isTaxable</isTaxable> 
                        </parameters>
                        <Mapping>
                            <quantity>blng__Quantity__c</quantity>
                            <itemCode>Id</itemCode>
                            <amount>blng__Subtotal__c</amount>
                            <addresses.shipTo.line1>blng__TaxStreet__c</addresses.shipTo.line1>
                            <addresses.shipTo.line2>blng__TaxStreet2__c</addresses.shipTo.line2>
                            <addresses.shipTo.line3 />
                            <addresses.shipTo.city>blng__TaxCity__c</addresses.shipTo.city>
                            <addresses.shipTo.region>blng__TaxState__c</addresses.shipTo.region>
                            <addresses.shipTo.country>blng__TaxCountry__c</addresses.shipTo.country>
                            <addresses.shipTo.postalCode>blng__TaxZipCode__c</addresses.shipTo.postalCode>
                            <addresses.shipTo.latitude></addresses.shipTo.latitude>
                            <addresses.shipTo.longitude></addresses.shipTo.longitude>       
                            <addresses.shipFrom.line1>blng__TaxStreet__c</addresses.shipFrom.line1>
                            <addresses.shipFrom.line2>blng__TaxStreet2__c</addresses.shipFrom.line2>
                            <addresses.shipFrom.line3 />
                            <addresses.shipFrom.city>blng__TaxCity__c</addresses.shipFrom.city>
                            <addresses.shipFrom.region>blng__TaxState__c</addresses.shipFrom.region>
                            <addresses.shipFrom.country>blng__TaxCountry__c</addresses.shipFrom.country>
                            <addresses.shipFrom.postalCode>blng__TaxZipCode__c</addresses.shipFrom.postalCode>
                            <addresses.shipFrom.latitude></addresses.shipFrom.latitude>
                            <addresses.shipFrom.longitude></addresses.shipFrom.longitude>
                        </Mapping>
                    </blng__InvoiceLine__c>
                </Queries>
            </Line>
        </blng__Invoice__c>
        <blng__CreditNote__c>
            <hooks>
                <overriderequestline></overriderequestline>
                <beforetaxcalculation></beforetaxcalculation>
                <beforeupdate></beforeupdate>
                <afterupdate></afterupdate>
            </hooks>
            <Header>
                <Queries>
                    <blng__CreditNote__c>
                        <query>SELECT Id, Name, blng__Account__r.Name, blng__Status__c {CurrencyIsoCode} FROM blng__CreditNote__c WHERE Id IN ({ListofInvoiceIds})</query>
                        <parameters>
                            <ListofInvoiceIds>optionalParams.listOfSObjectIds</ListofInvoiceIds>
                            <CurrencyIsoCode>optionalParams.currencyIsoCode</CurrencyIsoCode>
                        </parameters>
                        <Mapping>
                            <code>Name</code>
                        </Mapping>
                    </blng__CreditNote__c>
                </Queries>
            </Header>
            <Line>
                <Queries>
                    <blng__CreditNoteLine__c>
                        <query>SELECT Id, blng__TaxStreet__c, blng__TaxStreet2__c, blng__TaxCity__c, blng__TaxState__c, 
                            blng__TaxCountry__c, blng__TaxZipCode__c, blng__Subtotal__c, blng__CalculateTax__c, 
                            blng__EffectiveTaxDate__c, blng__Product__r.Name, blng__Product__r.Description, blng__Product__r.ProductCode, Name, blng__CreditNote__c, blng__CreditNote__r.Name, blng__CreditNote__r.blng__EffectiveTaxDate__c, blng__CreditNote__r.blng__CreditNoteDate__c, blng__CreditNote__r.blng__Account__r.AVA_MAPPER__Exemption_Number__c, 
							blng__CreditNote__r.blng__Account__r.AVA_MAPPER__Entity_Use_code__c,
							blng__CreditNote__r.blng__Account__r.AVA_MAPPER__Business_Identification_Number__c, 
							blng__CreditNote__r.blng__Account__r.AVA_MAPPER__Is_Seller_Importer_Of_Record__c,
							blng__CreditNote__r.blng__Account__r.ShippingStreet, 
							blng__CreditNote__r.blng__Account__r.ShippingCity,
							blng__CreditNote__r.blng__Account__r.ShippingState, 
							blng__CreditNote__r.blng__Account__r.ShippingCountry,
							blng__CreditNote__r.blng__Account__r.ShippingPostalCode,
							blng__CreditNote__r.blng__Account__r.Name, blng__CreditNote__r.blng__Account__c, 
                            blng__CreditNote__r.blng__TaxStreet__c, blng__CreditNote__r.blng__TaxStreet2__c, 
                            blng__CreditNote__r.blng__TaxCity__c, blng__CreditNote__r.blng__TaxState__c, 
                            blng__CreditNote__r.blng__TaxCountry__c, blng__CreditNote__r.blng__TaxZipCode__c, 
                            blng__LegalEntity__c, blng__LegalEntity__r.Name, blng__LegalEntity__r.blng__City__c, 
                            blng__LegalEntity__r.blng__Country__c, blng__LegalEntity__r.blng__State__c, 
                            blng__LegalEntity__r.blng__Street1__c, blng__LegalEntity__r.blng__Street2__c, 
                            blng__LegalEntity__r.blng__ZipPostalCode__c, blng__LegalEntityReference__c, blng__TaxTreatment__c, 
                            blng__TaxTreatment__r.blng__TaxCode__c, blng__TaxTreatment__r.blng__TaxIntegration__c, 
                            blng__TaxTreatment__r.blng__TaxRule__c, blng__TaxTreatment__r.blng__TaxLegalEntity__c, 
                            blng__TaxTreatment__r.blng__TaxIntegration__r.AVA_BLNG__AvaTaxAccountNumber__c, 
                            blng__TaxTreatment__r.blng__TaxIntegration__r.AVA_BLNG__AvaTaxLicenseKey__c, blng__TaxTreatment__r.blng__TaxIntegration__r.AVA_BLNG__DocCode__c, 
				            blng__TaxTreatment__r.blng__TaxIntegration__r.AVA_BLNG__Save_transactions_to_AvaTax__c,							
                            blng__TaxTreatment__r.blng__TaxIntegration__r.AVA_BLNG__CustomerCode__c, blng__TaxTreatment__r.blng__TaxIntegration__r.AVA_BLNG__TestMode__c,
                            blng__TaxRule__c, blng__TaxRule__r.blng__TaxableYesNo__c  
                            FROM blng__CreditNoteLine__c WHERE {filterOn} IN ({filterValues}) AND blng__TaxTreatment__c != NULL 
                            AND blng__TaxTreatment__r.blng__TaxIntegration__r.blng__TaxEngine__c = '{taxEngineName}' 
                            AND blng__TaxRule__r.blng__TaxableYesNo__c = '{isTaxable}' AND blng__CalculateTax__c = {isCalculateTax} </query>
                        <parameters>
                            <filterOn>optionalParams.filterOn</filterOn>
                            <filterValues>optionalParams.filterValues</filterValues>
                            <taxEngineName>optionalParams.taxEngineName</taxEngineName>
                            <isTaxable>optionalParams.isTaxable</isTaxable>
                            <isCalculateTax>optionalParams.isCalculateTax</isCalculateTax> 
                        </parameters>
                        <Mapping>
                            <itemCode>Id</itemCode>
                            <amount>blng__Subtotal__c</amount>
                            <addresses.shipTo.line1>blng__TaxStreet__c</addresses.shipTo.line1>
                            <addresses.shipTo.line2>blng__TaxStreet2__c</addresses.shipTo.line2>
                            <addresses.shipTo.line3 />
                            <addresses.shipTo.city>blng__TaxCity__c</addresses.shipTo.city>
                            <addresses.shipTo.region>blng__TaxState__c</addresses.shipTo.region>
                            <addresses.shipTo.country>blng__TaxCountry__c</addresses.shipTo.country>
                            <addresses.shipTo.postalCode>blng__TaxZipCode__c</addresses.shipTo.postalCode>
                            <addresses.shipTo.latitude></addresses.shipTo.latitude>
                            <addresses.shipTo.longitude></addresses.shipTo.longitude>       
                            <addresses.shipFrom.line1>blng__TaxStreet__c</addresses.shipFrom.line1>
                            <addresses.shipFrom.line2>blng__TaxStreet2__c</addresses.shipFrom.line2>
                            <addresses.shipFrom.line3 />
                            <addresses.shipFrom.city>blng__TaxCity__c</addresses.shipFrom.city>
                            <addresses.shipFrom.region>blng__TaxState__c</addresses.shipFrom.region>
                            <addresses.shipFrom.country>blng__TaxCountry__c</addresses.shipFrom.country>
                            <addresses.shipFrom.postalCode>blng__TaxZipCode__c</addresses.shipFrom.postalCode>
                            <addresses.shipFrom.latitude></addresses.shipFrom.latitude>
                            <addresses.shipFrom.longitude></addresses.shipFrom.longitude>
                        </Mapping>
                    </blng__CreditNoteLine__c>
                </Queries>
            </Line>
        </blng__CreditNote__c>
        <blng__DebitNote__c>
            <hooks>
                <overriderequestline></overriderequestline>
                <beforetaxcalculation></beforetaxcalculation>
                <beforeupdate></beforeupdate>
                <afterupdate></afterupdate>
            </hooks>
            <Header>
                <Queries>
                    <blng__DebitNote__c>
                        <query>SELECT Id, Name, blng__Account__r.Name, blng__Status__c {CurrencyIsoCode} FROM blng__DebitNote__c WHERE Id IN ({ListofInvoiceIds})</query>
                        <parameters>
                            <ListofInvoiceIds>optionalParams.listOfSObjectIds</ListofInvoiceIds>
                            <CurrencyIsoCode>optionalParams.currencyIsoCode</CurrencyIsoCode>
                        </parameters>
                        <Mapping>
                            <code>Name</code>
                        </Mapping>
                    </blng__DebitNote__c>
                </Queries>
            </Header>
            <Line>
                <Queries>
                    <blng__DebitNoteLine__c>
                        <query>SELECT Id, blng__TaxStreet__c, blng__TaxStreet2__c, blng__TaxCity__c, blng__TaxState__c, 
                            blng__TaxCountry__c, blng__TaxZipCode__c, blng__Subtotal__c, blng__CalculateTax__c, 
                            blng__Product__r.Name, blng__Product__r.Description, blng__Product__r.ProductCode, Name, blng__DebitNote__c, blng__DebitNote__r.Name, blng__DebitNote__r.blng__EffectiveTaxDate__c, blng__DebitNote__r.blng__Account__r.AVA_MAPPER__Exemption_Number__c, 
							blng__DebitNote__r.blng__Account__r.AVA_MAPPER__Entity_Use_code__c,
							blng__DebitNote__r.blng__Account__r.AVA_MAPPER__Business_Identification_Number__c, 
							blng__DebitNote__r.blng__Account__r.AVA_MAPPER__Is_Seller_Importer_Of_Record__c,
							blng__DebitNote__r.blng__Account__r.ShippingStreet, 
							blng__DebitNote__r.blng__Account__r.ShippingCity,
							blng__DebitNote__r.blng__Account__r.ShippingState, 
							blng__DebitNote__r.blng__Account__r.ShippingCountry,
							blng__DebitNote__r.blng__Account__r.ShippingPostalCode,
							blng__DebitNote__r.blng__DebitNoteDate__c,
                            blng__DebitNote__r.blng__Account__r.Name, blng__DebitNote__r.blng__Account__c, 
                            blng__DebitNote__r.blng__TaxStreet__c, blng__DebitNote__r.blng__TaxStreet2__c, 
                            blng__DebitNote__r.blng__TaxCity__c, blng__DebitNote__r.blng__TaxState__c, 
                            blng__DebitNote__r.blng__TaxCountry__c, blng__DebitNote__r.blng__TaxZipCode__c, 
                            blng__LegalEntity__c, blng__LegalEntity__r.Name, blng__LegalEntity__r.blng__City__c, 
                            blng__LegalEntity__r.blng__Country__c, blng__LegalEntity__r.blng__State__c, 
                            blng__LegalEntity__r.blng__Street1__c, blng__LegalEntity__r.blng__Street2__c, 
                            blng__LegalEntity__r.blng__ZipPostalCode__c, blng__LegalEntityReference__c, blng__TaxTreatment__c, 
                            blng__TaxTreatment__r.blng__TaxCode__c, blng__TaxTreatment__r.blng__TaxIntegration__c, 
                            blng__TaxTreatment__r.blng__TaxRule__c, blng__TaxTreatment__r.blng__TaxLegalEntity__c, 
                            blng__TaxTreatment__r.blng__TaxIntegration__r.AVA_BLNG__AvaTaxAccountNumber__c, 
                            blng__TaxTreatment__r.blng__TaxIntegration__r.AVA_BLNG__AvaTaxLicenseKey__c, blng__TaxTreatment__r.blng__TaxIntegration__r.AVA_BLNG__DocCode__c,
							blng__TaxTreatment__r.blng__TaxIntegration__r.AVA_BLNG__Save_transactions_to_AvaTax__c,
                            blng__TaxTreatment__r.blng__TaxIntegration__r.AVA_BLNG__CustomerCode__c, blng__TaxTreatment__r.blng__TaxIntegration__r.AVA_BLNG__TestMode__c,
                            blng__TaxRule__c, blng__TaxRule__r.blng__TaxableYesNo__c 
                            FROM blng__DebitNoteLine__c WHERE {filterOn} IN ({filterValues}) AND blng__TaxTreatment__c != NULL 
                            AND blng__TaxTreatment__r.blng__TaxIntegration__r.blng__TaxEngine__c = '{taxEngineName}' 
                            AND blng__TaxRule__r.blng__TaxableYesNo__c = '{isTaxable}' AND blng__CalculateTax__c = {isCalculateTax} </query>
                        <parameters>
                            <filterOn>optionalParams.filterOn</filterOn>
                            <filterValues>optionalParams.filterValues</filterValues>
                            <taxEngineName>optionalParams.taxEngineName</taxEngineName>
                            <isTaxable>optionalParams.isTaxable</isTaxable>
                            <isCalculateTax>optionalParams.isCalculateTax</isCalculateTax> 
                        </parameters>
                        <Mapping>
                            <itemCode>Id</itemCode>
                            <amount>blng__Subtotal__c</amount>
							<addresses.shipTo.line1>blng__TaxStreet__c</addresses.shipTo.line1>
                            <addresses.shipTo.line2>blng__TaxStreet2__c</addresses.shipTo.line2>
                            <addresses.shipTo.line3 />
                            <addresses.shipTo.city>blng__TaxCity__c</addresses.shipTo.city>
                            <addresses.shipTo.region>blng__TaxState__c</addresses.shipTo.region>
                            <addresses.shipTo.country>blng__TaxCountry__c</addresses.shipTo.country>
                            <addresses.shipTo.postalCode>blng__TaxZipCode__c</addresses.shipTo.postalCode>
                            <addresses.shipTo.latitude></addresses.shipTo.latitude>
                            <addresses.shipTo.longitude></addresses.shipTo.longitude>       
                            <addresses.shipFrom.line1>blng__TaxStreet__c</addresses.shipFrom.line1>
                            <addresses.shipFrom.line2>blng__TaxStreet2__c</addresses.shipFrom.line2>
                            <addresses.shipFrom.line3 />
                            <addresses.shipFrom.city>blng__TaxCity__c</addresses.shipFrom.city>
                            <addresses.shipFrom.region>blng__TaxState__c</addresses.shipFrom.region>
                            <addresses.shipFrom.country>blng__TaxCountry__c</addresses.shipFrom.country>
                            <addresses.shipFrom.postalCode>blng__TaxZipCode__c</addresses.shipFrom.postalCode>
                            <addresses.shipFrom.latitude></addresses.shipFrom.latitude>
                            <addresses.shipFrom.longitude></addresses.shipFrom.longitude>
                        </Mapping>
                    </blng__DebitNoteLine__c>
                </Queries>
            </Line>
        </blng__DebitNote__c>
    </taxcalculation>
    <posttaxcalculation>
        <blng__Invoice__c>
            <hooks>
            </hooks>
            <Queries>
                <blng__Invoice__c>
                    <query>SELECT Id, Name,blng__LegalEntityReference__c, blng__Invoice__c, blng__Invoice__r.Name, 
                        blng__Invoice__r.blng__Account__r.Name, 
                        blng__Invoice__r.blng__Account__c, blng__LegalEntity__c, blng__LegalEntity__r.Name,                              
                        blng__TaxTreatment__c, blng__TaxTreatment__r.blng__TaxCode__c, blng__TaxTreatment__r.blng__TaxIntegration__c,
                        blng__TaxTreatment__r.blng__TaxRule__c, blng__TaxTreatment__r.blng__TaxLegalEntity__c, 
                        blng__TaxTreatment__r.blng__TaxIntegration__r.AVA_BLNG__AvaTaxAccountNumber__c, 
                        blng__TaxTreatment__r.blng__TaxIntegration__r.AVA_BLNG__AvaTaxLicenseKey__c,
                        blng__TaxTreatment__r.blng__TaxIntegration__r.AVA_BLNG__DocCode__c,
						blng__TaxTreatment__r.blng__TaxIntegration__r.AVA_BLNG__Save_transactions_to_AvaTax__c,						
                        blng__TaxTreatment__r.blng__TaxIntegration__r.AVA_BLNG__TestMode__c
                        FROM blng__InvoiceLine__c 
                        WHERE {filterOn} IN ({filterValues}) AND blng__TaxTreatment__c != NULL 
                        AND blng__TaxTreatment__r.blng__TaxIntegration__r.blng__TaxEngine__c = '{taxEngineName}' 
                        AND blng__TaxRule__r.blng__TaxableYesNo__c = '{isTaxable}' </query>
                    <parameters>
                        <filterOn>optionalParams.filterOn</filterOn>
                        <filterValues>optionalParams.filterValues</filterValues>
                        <taxEngineName>optionalParams.taxEngineName</taxEngineName>
                        <isTaxable>optionalParams.isTaxable</isTaxable>
                    </parameters>
                    <Mapping>
                        <transactionCode>AVA_BLNG.PostTaxTransactionCodeMappingHelper</transactionCode>
                    </Mapping>
                </blng__Invoice__c>
            </Queries>
        </blng__Invoice__c>
        <blng__CreditNote__c>
            <hooks>
            </hooks>
            <Queries>
                <blng__CreditNote__c>
                    <query>SELECT Id, Name, blng__LegalEntityReference__c, blng__CreditNote__c, blng__CreditNote__r.Name, 
                        blng__CreditNote__r.blng__EffectiveTaxDate__c, blng__CreditNote__r.blng__Account__r.Name, 
                        blng__CreditNote__r.blng__Account__c, blng__LegalEntity__c, blng__LegalEntity__r.Name, 
                        blng__TaxTreatment__c, blng__TaxTreatment__r.blng__TaxIntegration__c, blng__TaxTreatment__r.blng__TaxRule__c, 
                        blng__TaxTreatment__r.blng__TaxLegalEntity__c, blng__TaxTreatment__r.blng__TaxIntegration__r.AVA_BLNG__AvaTaxAccountNumber__c, 
                        blng__TaxTreatment__r.blng__TaxIntegration__r.AVA_BLNG__AvaTaxLicenseKey__c, 
                        blng__TaxTreatment__r.blng__TaxIntegration__r.AVA_BLNG__DocCode__c, 
						blng__TaxTreatment__r.blng__TaxIntegration__r.AVA_BLNG__Save_transactions_to_AvaTax__c,
						blng__TaxTreatment__r.blng__TaxIntegration__r.AVA_BLNG__TestMode__c 
                        FROM blng__CreditNoteLine__c WHERE {filterOn} IN ({filterValues}) AND blng__TaxTreatment__c != NULL 
                        AND blng__TaxTreatment__r.blng__TaxIntegration__r.blng__TaxEngine__c = '{taxEngineName}' 
                        AND blng__TaxRule__r.blng__TaxableYesNo__c = '{isTaxable}' </query>
                    <parameters>
                        <filterOn>optionalParams.filterOn</filterOn>
                        <filterValues>optionalParams.filterValues</filterValues>
                        <taxEngineName>optionalParams.taxEngineName</taxEngineName>
                        <isTaxable>optionalParams.isTaxable</isTaxable>
                    </parameters>
                    <Mapping>
                        <transactionCode></transactionCode>
                    </Mapping>
                </blng__CreditNote__c>
            </Queries>
        </blng__CreditNote__c>
        <blng__DebitNote__c>
            <hooks>
            </hooks>
            <Queries>
                <blng__DebitNote__c>
                    <query>SELECT Id, Name, blng__LegalEntityReference__c, blng__DebitNote__c, blng__DebitNote__r.Name, 
                        blng__DebitNote__r.blng__EffectiveTaxDate__c, blng__DebitNote__r.blng__Account__r.Name, 
                        blng__DebitNote__r.blng__Account__c, blng__LegalEntity__c, blng__LegalEntity__r.Name, 
                        blng__TaxTreatment__c, blng__TaxTreatment__r.blng__TaxIntegration__c, blng__TaxTreatment__r.blng__TaxRule__c, 
                        blng__TaxTreatment__r.blng__TaxLegalEntity__c, blng__TaxTreatment__r.blng__TaxIntegration__r.AVA_BLNG__AvaTaxAccountNumber__c, 
                        blng__TaxTreatment__r.blng__TaxIntegration__r.AVA_BLNG__AvaTaxLicenseKey__c, 
                        blng__TaxTreatment__r.blng__TaxIntegration__r.AVA_BLNG__DocCode__c, 
						blng__TaxTreatment__r.blng__TaxIntegration__r.AVA_BLNG__Save_transactions_to_AvaTax__c,
						blng__TaxTreatment__r.blng__TaxIntegration__r.AVA_BLNG__TestMode__c 
                        FROM blng__DebitNoteLine__c WHERE {filterOn} IN ({filterValues}) AND blng__TaxTreatment__c != NULL 
                        AND blng__TaxTreatment__r.blng__TaxIntegration__r.blng__TaxEngine__c = '{taxEngineName}' 
                        AND blng__TaxRule__r.blng__TaxableYesNo__c = '{isTaxable}' </query>
                    <parameters>
                        <filterOn>optionalParams.filterOn</filterOn>
                        <filterValues>optionalParams.filterValues</filterValues>
                        <taxEngineName>optionalParams.taxEngineName</taxEngineName>
                        <isTaxable>optionalParams.isTaxable</isTaxable>
                    </parameters>
                    <Mapping>
                        <transactionCode></transactionCode>
                    </Mapping>
                </blng__DebitNote__c>
            </Queries>
        </blng__DebitNote__c>
    </posttaxcalculation>
    <canceltaxcalculation>
        <blng__Invoice__c>
            <hooks>
            </hooks>
            <Queries>
                <blng__Invoice__c>
                    <query>SELECT Id, Name,blng__LegalEntityReference__c, blng__Invoice__c, blng__Invoice__r.Name, 
                        blng__Invoice__r.blng__Account__r.Name, 
                        blng__Invoice__r.blng__Account__c, blng__LegalEntity__c, blng__LegalEntity__r.Name,                              
                        blng__TaxTreatment__c, blng__TaxTreatment__r.blng__TaxCode__c, blng__TaxTreatment__r.blng__TaxIntegration__c,
                        blng__TaxTreatment__r.blng__TaxRule__c, blng__TaxTreatment__r.blng__TaxLegalEntity__c, 
                        blng__TaxTreatment__r.blng__TaxIntegration__r.AVA_BLNG__AvaTaxAccountNumber__c, 
                        blng__TaxTreatment__r.blng__TaxIntegration__r.AVA_BLNG__AvaTaxLicenseKey__c,
                        blng__TaxTreatment__r.blng__TaxIntegration__r.AVA_BLNG__DocCode__c,
						blng__TaxTreatment__r.blng__TaxIntegration__r.AVA_BLNG__Save_transactions_to_AvaTax__c,						
                        blng__TaxTreatment__r.blng__TaxIntegration__r.AVA_BLNG__TestMode__c
                        FROM blng__InvoiceLine__c 
                        WHERE {filterOn} IN ({filterValues}) AND blng__TaxTreatment__c != NULL 
                        AND blng__TaxTreatment__r.blng__TaxIntegration__r.blng__TaxEngine__c = '{taxEngineName}' 
                        AND blng__TaxRule__r.blng__TaxableYesNo__c = '{isTaxable}' </query>
                    <parameters>
                        <filterOn>optionalParams.filterOn</filterOn>
                        <filterValues>optionalParams.filterValues</filterValues>
                        <taxEngineName>optionalParams.taxEngineName</taxEngineName>
                        <isTaxable>optionalParams.isTaxable</isTaxable>
                    </parameters>
                    <Mapping>
                        <transactionCode>AVA_BLNG.PostTaxTransactionCodeMappingHelper</transactionCode>
                    </Mapping>
                </blng__Invoice__c>
            </Queries>
        </blng__Invoice__c>
        <blng__CreditNote__c>
            <hooks>
            </hooks>
            <Queries>
                <blng__CreditNote__c>
                    <query>SELECT Id, Name, blng__LegalEntityReference__c, blng__CreditNote__c, blng__CreditNote__r.Name, 
                        blng__CreditNote__r.blng__EffectiveTaxDate__c, blng__CreditNote__r.blng__Account__r.Name, 
                        blng__CreditNote__r.blng__Account__c, blng__LegalEntity__c, blng__LegalEntity__r.Name, 
                        blng__TaxTreatment__c, blng__TaxTreatment__r.blng__TaxIntegration__c, blng__TaxTreatment__r.blng__TaxRule__c, 
                        blng__TaxTreatment__r.blng__TaxLegalEntity__c, blng__TaxTreatment__r.blng__TaxIntegration__r.AVA_BLNG__AvaTaxAccountNumber__c, 
                        blng__TaxTreatment__r.blng__TaxIntegration__r.AVA_BLNG__AvaTaxLicenseKey__c, 
                        blng__TaxTreatment__r.blng__TaxIntegration__r.AVA_BLNG__DocCode__c, blng__TaxTreatment__r.blng__TaxIntegration__r.AVA_BLNG__TestMode__c, blng__TaxTreatment__r.blng__TaxIntegration__r.AVA_BLNG__Save_transactions_to_AvaTax__c 
                        FROM blng__CreditNoteLine__c WHERE {filterOn} IN ({filterValues}) AND blng__TaxTreatment__c != NULL 
                        AND blng__TaxTreatment__r.blng__TaxIntegration__r.blng__TaxEngine__c = '{taxEngineName}' 
                        AND blng__TaxRule__r.blng__TaxableYesNo__c = '{isTaxable}' </query>
                    <parameters>
                        <filterOn>optionalParams.filterOn</filterOn>
                        <filterValues>optionalParams.filterValues</filterValues>
                        <taxEngineName>optionalParams.taxEngineName</taxEngineName>
                        <isTaxable>optionalParams.isTaxable</isTaxable>
                    </parameters>
                    <Mapping>
                        <transactionCode></transactionCode>
                    </Mapping>
                </blng__CreditNote__c>
            </Queries>
        </blng__CreditNote__c>
        <blng__DebitNote__c>
            <hooks>
            </hooks>
            <Queries>
                <blng__DebitNote__c>
                    <query>SELECT Id, Name, blng__LegalEntityReference__c, blng__DebitNote__c, blng__DebitNote__r.Name, 
                        blng__DebitNote__r.blng__EffectiveTaxDate__c, blng__DebitNote__r.blng__Account__r.Name, 
                        blng__DebitNote__r.blng__Account__c, blng__LegalEntity__c, blng__LegalEntity__r.Name, 
                        blng__TaxTreatment__c, blng__TaxTreatment__r.blng__TaxIntegration__c, blng__TaxTreatment__r.blng__TaxRule__c, 
                        blng__TaxTreatment__r.blng__TaxLegalEntity__c, blng__TaxTreatment__r.blng__TaxIntegration__r.AVA_BLNG__AvaTaxAccountNumber__c, 
                        blng__TaxTreatment__r.blng__TaxIntegration__r.AVA_BLNG__AvaTaxLicenseKey__c, 
                        blng__TaxTreatment__r.blng__TaxIntegration__r.AVA_BLNG__DocCode__c, 
						blng__TaxTreatment__r.blng__TaxIntegration__r.AVA_BLNG__Save_transactions_to_AvaTax__c,
						blng__TaxTreatment__r.blng__TaxIntegration__r.AVA_BLNG__TestMode__c 
                        FROM blng__DebitNoteLine__c WHERE {filterOn} IN ({filterValues}) AND blng__TaxTreatment__c != NULL 
                        AND blng__TaxTreatment__r.blng__TaxIntegration__r.blng__TaxEngine__c = '{taxEngineName}' 
                        AND blng__TaxRule__r.blng__TaxableYesNo__c = '{isTaxable}' </query>
                    <parameters>
                        <filterOn>optionalParams.filterOn</filterOn>
                        <filterValues>optionalParams.filterValues</filterValues>
                        <taxEngineName>optionalParams.taxEngineName</taxEngineName>
                        <isTaxable>optionalParams.isTaxable</isTaxable>
                    </parameters>
                    <Mapping>
                        <transactionCode></transactionCode>
                    </Mapping>
                </blng__DebitNote__c>
            </Queries>
        </blng__DebitNote__c>
    </canceltaxcalculation>
</avatax>