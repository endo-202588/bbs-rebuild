import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "counter"]

  update() {
    const length = this.inputTarget.value.length
    this.counterTarget.textContent = `${length} / 200`
  }
}