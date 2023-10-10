import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="hide-spinner-on-error"
export default class extends Controller {
  static targets = ["spinner"]

  hideSpinnerIfInvalid() {
    const textarea = this.element.querySelector('#prompt_description')
    const isAriaInvalid = textarea.getAttribute("aria-invalid") === "true";
    if (isAriaInvalid) {
      this.spinnerTarget.classList.add("hidden")
    }
  }
}
