import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["title", "form", "display"]
  static values = { originalTitle: String }

  connect() {
  }

  edit() {
    this.editingTitle = this.originalTitleValue
    this.displayTarget.classList.add("hidden")
    this.formTarget.classList.remove("hidden")
    this.titleTarget.value = this.editingTitle
    this.titleTarget.focus()
  }

  cancel() {
    this.titleTarget.value = this.editingTitle || this.originalTitleValue
    this.formTarget.classList.add("hidden")
    this.displayTarget.classList.remove("hidden")
  }

  submit(_) {
  }
}