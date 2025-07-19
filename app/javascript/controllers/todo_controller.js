import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["title", "form", "display", "checkbox", "completeForm"]
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

  toggleComplete(_) {
    const filterSelect = document.getElementById('filter-select')
    const filter = filterSelect ? filterSelect.value : null

    if (filter && filter !== 'all') {
      const hiddenInput = document.createElement('input')
      hiddenInput.type = 'hidden'
      hiddenInput.name = 'filter'
      hiddenInput.value = filter
      this.completeFormTarget.appendChild(hiddenInput)
    }

    this.completeFormTarget.requestSubmit()
  }
}