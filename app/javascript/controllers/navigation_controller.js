import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("Hello, Stimulus!")
  }

  static targets = ['loading', 'form'];

  displayLoading(event) {
    this.loadingTarget.classList.remove('hidden');
    this.formTarget.classList.add('hidden');
  }
}
