public class Q2C_DataCannon {

    /**
    Known Limitations
    -No amendments/renewals
    -opp stages is not dynamic
    -not using discounts
    Use lookup field from object that looks up to quote
	Public Opportunity Opp {get;set;}
    **/

    public static void copyQuote(String quotetocopy, Date startDate, Date endDate, Integer numRecords, Decimal AverageDisc) {
        //get accounts up to number needed (limit numRecords)
        List<Account> acc = new List<Account>();
        acc = [SELECT Id FROM Account LIMIT :numRecords];
        //Create Opportunities
        //SBQQ.TriggerControl.disable();
        List<Opportunity> newOpps = new List<Opportunity>();
        for (Integer i = 0; i < numRecords; i++) {
            Opportunity Opp = new Opportunity(Name = 'Opp Cannon ' + String.valueOf(i + 1));    // Set new Opps
            Integer myInt = Math.floor(Math.random() * startDate.daysBetween(endDate)).intValue();
            Opp.StageName = stagePicker(i, 3, 2, 1, 1, 1, 1, 2, 3);
            Opp.CloseDate = startDate.addDays(myInt);
            Integer a = Math.mod(i, acc.size());
            Opp.AccountId = acc.get(a).Id;
            newOpps.add(Opp);
        }
        Database.insert(newOpps);

        //SBQQ.TriggerControl.enable();
        List<SBQQ__Quote__c> Myquote = new List <SBQQ__Quote__c>();
        List<SBQQ__Quote__c> newQuotes = new List<SBQQ__Quote__c>();

        SObjectType objToken = Schema.getGlobalDescribe().get('SBQQ__Quote__c');
        DescribeSObjectResult objDef = objToken.getDescribe();
        Map<String, SObjectField> fields = objDef.fields.getMap();
        List<String> fieldslist = new List<String>();
        for (String s : fields.keySet()) {
            fieldslist.add(s);
        }
        String qq = 'SELECT ' + String.join(fieldslist, ',') + ' FROM SBQQ__Quote__c WHERE Id=:quotetocopy';
        System.debug(qq);
        Myquote = Database.query(qq);


        for (Integer i = 0; i < numRecords; i++) {
            SBQQ__Quote__c Quote = Myquote.get(0).clone(false, true); //set new quotes
            Quote.SBQQ__StartDate__c = newOpps.get(i).CloseDate.addDays(1);
            Quote.SBQQ__Opportunity2__c = newOpps.get(i).Id;
            Quote.SBQQ__Account__c = newOpps.get(i).Account.Id;
            Quote.SBQQ__Primary__c = false;
            newQuotes.add(Quote);
        }

        Database.insert(newQuotes);
        //SBQQ.TriggerControl.disable();

        List<SBQQ__QuoteLine__c> QLtoCopy = new List<SBQQ__QuoteLine__c>();

        SObjectType objToken1 = Schema.getGlobalDescribe().get('SBQQ__QuoteLine__c');
        DescribeSObjectResult objDef1 = objToken1.getDescribe();
        Map<String, SObjectField> fields1 = objDef1.fields.getMap();
        List<String> fieldslist1 = new List<String>();
        for (String s1 : fields1.keySet()) {
            fieldslist1.add(s1);
        }
        String q = 'SELECT ' + String.join(fieldslist1, ',') + ' FROM SBQQ__QuoteLine__c WHERE SBQQ__Quote__c=:quotetocopy';
        System.debug(q);
        QLtoCopy = Database.query(q);

        List<SBQQ__QuoteLine__c> newQuoteLines = new List<SBQQ__QuoteLine__c>();

        for (Integer i = 0; i < numRecords; i++) { //through each quote (i)
            for (Integer j = 0; j < QLtoCopy.size(); j++) { //through each quoteline (j)
                SBQQ__QuoteLine__c QuoteLine = QLtoCopy.get(j).clone(false, true);
                //Decimal origDiscount=QLtoCopy.get(j).SBQQ__Discount__c*(1+0.25)*(2*Math.random()-1);
                QuoteLine.SBQQ__Discount__c = Math.abs(AverageDisc * (2 * Math.random()));
                QuoteLine.SBQQ__Quote__c = newQuotes.get(i).Id;
                QuoteLine.SBQQ__Incomplete__c = true;

                newQuoteLines.add(QuoteLine);
            }
        }

        Database.insert(newQuoteLines);
        // SBQQ.TriggerControl.enable();


        for (Integer i = 0; i < numRecords; i++) {
            newQuotes.get(i).SBQQ__Primary__c = true;
        }

        update newQuotes;


        List <Opportunity> ClosedOpps = new List<Opportunity>();
        ClosedOpps = [SELECT Id, StageName FROM Opportunity WHERE StageName = 'Finalizing Closure'];
        for (Integer i = 0; i < ClosedOpps.size(); i++) {
            ClosedOpps.get(i).StageName = 'Closed Won';
        }

        update ClosedOpps;

        //update newOpps;

        /**for(integer i =0; i<numRecords;i++){
             // Set new Opps
            NewOpps.get(i).StageName=randomizer.getRandomPicklistValue(NewOpps.get(i),'StageName',true);
        }
        database.update(newOpps);**/
    }

    public static String stagePicker(Integer numi, Integer num1, Integer num2, Integer num3, Integer num4, Integer num5, Integer num6, Integer num7, Integer num8) {
        Integer sumNum = num1 + num2 + num3 + num4 + num5 + num6 + num7 + num8;
        if (Math.mod(numi + 1, sumNum) >= 0 && Math.mod(numi, sumNum) < num1) {
            return 'Qualification';
        } else if (Math.mod(numi + 1, sumNum) >= num1 && Math.mod(numi, sumNum) < num1 + num2) {
            return 'Needs Analysis';
        } else if (Math.mod(numi + 1, sumNum) >= num2 && Math.mod(numi, sumNum) < num1 + num2 + num3) {
            return 'Value Proposition';
        } else if (Math.mod(numi + 1, sumNum) >= num3 && Math.mod(numi, sumNum) < num1 + num2 + num3 + num4) {
            return 'Proposal/Price Quote';
        } else if (Math.mod(numi + 1, sumNum) >= num4 && Math.mod(numi, sumNum) < num1 + num2 + num3 + num4 + num5) {
            return 'Negotiation/Review';
        } else if (Math.mod(numi + 1, sumNum) >= num5 && Math.mod(numi, sumNum) < num1 + num2 + num3 + num4 + num5 + num6) {
            return 'Finalizing Closure';
        } else if (Math.mod(numi + 1, sumNum) >= num6 && Math.mod(numi, sumNum) < num1 + num2 + num3 + num4 + num5 + num6 + num7) {
            return 'Finalizing Closure';
        } else if (Math.mod(numi + 1, sumNum) >= num7 && Math.mod(numi, sumNum) < sumNum) {
            return 'Closed Lost';
        } else {
            return'Qualification';
        }
    }
}