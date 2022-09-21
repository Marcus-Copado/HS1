import { LightningElement, api, track } from "lwc";
import getFieldValue from "@salesforce/apex/Kodiak_PlayerController.getFieldValue";

export default class KodiakPlayer extends LightningElement {
  @api recordId;
  @api sourceType = "File";
  @api fileId;
  @api inputUrl;
  @api recordField;
  @api showControls = false;
  @api shouldLoop = false; // can access directly
  @api shouldAutoPlay = false; // can access directly

  @track recordSource = null;
  // for some reason the controls seem to need a custom getter
  get controls() {
    if (this.showControls) {
      return true;
    }
    return null;
  }

  get iframeUrl() {
    if (this.inputUrl && this.sourceType === "URL") {
      return this.inputUrl;
    }
    if (this.recordSource && this.sourceType === "Record Field") {
      return this.recordSource;
    }
    return false;
  }

  get hasVideo() {
    return (
      (this.fileId && this.sourceType === "File") ||
      (this.inputUrl && this.sourceType === "URL") ||
      (this.recordSource && this.sourceType === "Record Field")
    );
  }

  get videoUrl() {
    if (this.fileId) {
      return `${window.location.origin}/sfc/servlet.shepherd/document/download/${this.fileId}`;
    }
    return null;
  }

  connectedCallback() {
    if (this.recordField && this.sourceType === "Record Field") {
      getFieldValue({
        recordId: this.recordId,
        targetField: this.recordField
      })
        .then(res => {
          this.recordSource = res;
        })
        .catch(e => {
          this.dispatchEvent(
            new ShowToastEvent({
              title: "Error",
              message: e.message,
              variant: "error"
            })
          );
        });
    }
  }
}