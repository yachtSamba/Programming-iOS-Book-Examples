

import UIKit

class ViewController: UIViewController {
    @IBOutlet var scrollView : UIScrollView!
    // var fr : UIView?
    var oldContentInset = UIEdgeInsetsZero
    var oldIndicatorInset = UIEdgeInsetsZero
    var oldOffset = CGPoint.zero
    var keyboardShowing = false

    override func viewDidLoad() {
        super.viewDidLoad()

        NSNotificationCenter.default().addObserver(self, selector: #selector(keyboardShow), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.default().addObserver(self, selector: #selector(keyboardHide), name: UIKeyboardWillHideNotification, object: nil)
        
        let contentView = self.scrollView.subviews[0]
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraintEqual(to:self.scrollView.widthAnchor),
            contentView.heightAnchor.constraintEqual(to:self.scrollView.heightAnchor),
        ])
        
        self.scrollView.keyboardDismissMode = .interactive
        
    }
    
//    func textFieldDidBeginEditing(tf: UITextField) {
//        self.fr = tf // keep track of first responder
//    }
    
    func textFieldShouldReturn(_ tf: UITextField) -> Bool {
        print("return")
        tf.resignFirstResponder()
        // self.fr = nil
        return true
    }
    
    override func shouldAutorotate() -> Bool {
        return !self.keyboardShowing
    }

    func keyboardShow(_ n:NSNotification) {
        self.oldContentInset = self.scrollView.contentInset
        self.oldIndicatorInset = self.scrollView.scrollIndicatorInsets
        self.oldOffset = self.scrollView.contentOffset
        
        let d = n.userInfo as! [String:AnyObject]
        var r = (d[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue()
        r = self.scrollView.convert(r, from:nil)
        // no need to scroll, as the scroll view will do it for us
        // so all we have to do is adjust the inset
        self.scrollView.contentInset.bottom = r.size.height
        self.scrollView.scrollIndicatorInsets.bottom = r.size.height
        
        self.keyboardShowing = true
    }
    
    func keyboardHide(_ n:NSNotification) {
        print("hide")
        self.scrollView.bounds.origin = self.oldOffset
        self.scrollView.scrollIndicatorInsets = self.oldIndicatorInset
        self.scrollView.contentInset = self.oldContentInset
//        self.fr?.resignFirstResponder()
//        self.fr = nil
        self.keyboardShowing = false

    }

    
    
}
