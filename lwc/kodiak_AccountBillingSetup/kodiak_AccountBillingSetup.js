import { LightningElement, api, track } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import showAlert from "@salesforce/apex/Kodiak_AccountBillingSetupController.showAlert";
import getLegalEntities from "@salesforce/apex/Kodiak_AccountBillingSetupController.getLegalEntities";
import getFinanceBooks from "@salesforce/apex/Kodiak_AccountBillingSetupController.getFinanceBooks"; 
import getAccountDetails from "@salesforce/apex/Kodiak_AccountBillingSetupController.getAccountDetails";
import getBillToContacts from "@salesforce/apex/Kodiak_AccountBillingSetupController.getBillToContacts";
import saveAccountBilling from "@salesforce/apex/Kodiak_AccountBillingSetupController.saveAccountBilling";
export default class Kodiak_AccountBillingSetup extends LightningElement {
  @api recordId;
  @api show() {
    this.showModal = true;
  }
  @api hide() {
    this.showModal = false;
  }

  @track showSpinner = false;
  @track showModal = false;
  @track selectedLegalEntity = "";
  @track selectedFinanceBook = "";
  @track selectedBillToContact = "";
  @track legalEntityOptions = [];
  @track financeBookOptions = [];
  @track billToContactOptions = [];
  @track trackAccountId = "";

  renderAlert = false;

  get saveButtonDisabled() {
    return !(this.selectedFinanceBook && this.selectedLegalEntity && this.selectedBillToContact);
  }

  connectedCallback() {
    //console.log('Alex Debug:' +this.recordId);
    getAccountDetails({ recordId: this.recordId })
      .then(account => {
        if (account.hasOwnProperty("Legal_Entity__c")) {
          this.selectedLegalEntity = account.Legal_Entity__c;
        }
        if (account.hasOwnProperty("Accounting_Finance_Book__c")) {
          this.selectedFinanceBook = account.Accounting_Finance_Book__c;
        }
        if (account.hasOwnProperty("blng__BillToContact__c")) {
          this.selectedBillToContact = account.blng__BillToContact__c;
        }
        this.trackAccountId = account.Id;
        return getFinanceBooks();
      })
      .then(res => {
        this.financeBookOptions = res.map(fb => {
          return { label: fb.Name, value: fb.Id };
        });
        return getLegalEntities();
      })
      .then(res => {
        this.legalEntityOptions = res.map(le => {
          return { label: le.Name, value: le.Id };
        });
        console.log('Alex Debug:' + this.trackAccountId);
        return getBillToContacts({ recordId: this.trackAccountId }); //sent in record id
      })
      .then(res => {
        this.billToContactOptions = res.map(le => {
          return { label: le.Name, value: le.Id };
        });
      })
      .catch(err => {
        // eslint-disable-next-line
        console.log(err);
        this.dispatchEvent(
          new ShowToastEvent({
            title: "Error",
            message: err.message,
            variant: "error"
          })
        );
      });
  }

  renderedCallback() {
    showAlert({ recordId: this.recordId })
      .then(res => {
        let oldRender = this.renderAlert;
        this.renderAlert = res;
        if (oldRender != res) {
          this.animateCss(res);
        }
      })
      .catch(err => {
        // eslint-disable-next-line
        console.log(err);
        this.dispatchEvent(
          new ShowToastEvent({
            title: "Error",
            message: err.message,
            variant: "error"
          })
        );
      });
  }

  handleLegalEntityChange(event) {
    this.selectedLegalEntity = event.target.value;
  }
  handleFinanceBookChange(event) {
    this.selectedFinanceBook = event.target.value;
  }
  handleBillToContactChange(event) {
    this.selectedBillToContact = event.target.value;
  }

  handleSave() {
    this.showSpinner = true;
    saveAccountBilling({
      recordId: this.recordId,
      legalEntityId: this.selectedLegalEntity,
      financeBookId: this.selectedFinanceBook,
      billToContactId: this.selectedBillToContact
    })
      .then(() => {
        this.showSpinner = false;
        // eslint-disable-next-line
        eval("$A.get('e.force:refreshView').fire();"); // trick to use Aura refresh event
        this.hide();
      })
      .catch(err => {
        // eslint-disable-next-line
        console.log(err);
        this.showSpinner = false;
        this.dispatchEvent(
          new ShowToastEvent({
            title: "Error",
            message: err.message,
            variant: "error"
          })
        );
      });
  }

  animateCss(showAlert) {
    const elm = this.template.querySelector(".custom-alert");
    if (elm) {
      if (showAlert) {
        elm.classList.toggle("slds-hide");
        elm.classList.add("animate-content_in");
        setTimeout(() => {
          elm.classList.remove("animate-content_in");
        }, 2000);
      } else {
        elm.classList.add("animate-content_out");
        setTimeout(() => {
          elm.classList.remove("animate-content_out");
        }, 1500);
        setTimeout(() => {
          elm.classList.toggle("slds-hide"); // toggle the hide class back on before the animation ends fully
        }, 1200);
      }
    }
  }
}