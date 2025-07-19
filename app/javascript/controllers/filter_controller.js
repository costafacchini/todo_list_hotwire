import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["select"]

  connect() {
    const urlParams = new URLSearchParams(window.location.search)
    const filter = urlParams.get('filter') || 'all'
    this.selectTarget.value = filter
  }

  filter() {
    const filter = this.selectTarget.value
    const url = new URL(window.location)

    if (filter === 'all') {
      url.searchParams.delete('filter')
    } else {
      url.searchParams.set('filter', filter)
    }

    window.location.href = url.toString()
  }
}