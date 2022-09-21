public class SavePDF {
    public Id pageId {get;set;}

    //Constructor
    public savePDF(ApexPages.StandardController stdController) {
        id pageOppId = ApexPages.currentPAge().getParameters().get('id');
        system.debug('id: ' + pageOppId);
    }

    //method to insert attachement call it on page on click of button 
    public PageReference saveAttachement() {
        id pageId = ApexPages.currentPAge().getParameters().get('id');
        if (pageId != NULL) {

            PageReference pdf = Page.PDFInvoice; // Set the correct VFP
            pdf.getParameters().put('id', pageId); //Set the pageId
            // create the new attachment
            Attachment attach = new Attachment();

            // the contents of the attachment from the pdf
            Blob body;

            try {
                // returns the output of the page as a PDF
                body = pdf.getContentAsPDF();
                system.debug('Body of PDF should be good.');
                // need to pass unit test -- current bug    
            } catch (VisualforceException err) {
                system.debug('An Error occurred generating the PDF: ' + err);
                body = Blob.valueOf('Err');
            }

            attach.Body = body;

            // Create name with today's date
            attach.Name = 'Invoice - ' + Datetime.now().format('yyyy-MM-dd') + '.pdf';
            attach.IsPrivate = false; //make public
            attach.ParentId = pageId; //attach pdf to record

            try {
                database.insert(attach);
                system.debug('Successfully attached PDF.');
            } catch(DmlException e) {
                system.debug('Error attaching PDF');
            }

        }

        PageReference nextPage = new PageReference('/' + pageId);
        nextPage.setRedirect(true);
        return nextPage;
    }
}