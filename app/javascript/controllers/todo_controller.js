import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["title", "form", "display"]

  connect() {
  }

  edit() {
    this.displayTarget.classList.add("hidden")
    this.formTarget.classList.remove("hidden")
    this.titleTarget.focus()
  }

  cancel() {
    this.formTarget.classList.add("hidden")
    this.displayTarget.classList.remove("hidden")
  }

  submit(_) {
  }
}