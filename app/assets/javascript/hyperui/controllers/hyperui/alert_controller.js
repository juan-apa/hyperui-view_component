import { Controller } from "@hotwired/stimulus"

export default class AlertController extends Controller {
  timeout = null

  static values = {
    dismissable: { type: Boolean, default: true }
  }

  connect() {
    if (!this.dismissableValue) return

    this.timeout = setTimeout(() => {
      this.dismiss()
    }, 5000)
  }

  pause() {
    if (!this.dismissableValue) return

    clearTimeout(this.timeout)
  }

  resume() {
    if (!this.dismissableValue) return

    this.timeout = setTimeout(() => {
      this.dismiss()
    }, 5000)
  }

  dismiss() {
    this.element.remove()
  }
}
