import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['modal', 'modalContent', 'modalTitle']

  async generateSummary(event) {
    const button = event.currentTarget
    const articleId = button.dataset.articleId

    // Disable button and show loading state
    button.disabled = true
    const originalText = button.textContent
    button.textContent = 'Generating...'

    try {
      const response = await fetch(`/articles/${articleId}/summary`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]')
            .content
        }
      })

      if (!response.ok) {
        throw new Error('Network response was not ok')
      }

      const data = await response.json()

      alert(data.summary) // TODO - Replace with a modal
    } catch (error) {
      console.error('Error:', error)
      alert('Failed to generate summary. Please try again.')
    } finally {
      // Reset button state
      button.disabled = false
      button.textContent = originalText
    }
  }

  closeModal() {
    this.modalTarget.classList.add('hidden')
  }
}
