import UIKit

extension ProductSummaryViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.layer.borderColor = UIColor.primary.cgColor
        if textView.textColor == UIColor.lightGreySecondary {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.layer.borderColor = UIColor.lightGreyPrimary.cgColor
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = "Please fill in address..."
            textView.textColor = UIColor.lightGreySecondary
            enableNextButton(false)
            return
        }
        enableNextButton(true)
    }
}
