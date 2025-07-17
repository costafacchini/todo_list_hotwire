import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["title"]

  connect() {
    this.titleTarget.focus()
  }

  submit(event) {
    if (event.detail.success) {
      this.titleTarget.value = ""
      this.titleTarget.focus()
    }
  }
}