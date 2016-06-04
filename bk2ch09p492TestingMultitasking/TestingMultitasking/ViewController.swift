
import UIKit


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("%@", #function)
    }
    
    override func viewWillAppear(_ animated:Bool) {
        super.viewWillAppear(animated)
        NSLog("%@", #function)
        if self.presenting != nil {
            self.view.backgroundColor = UIColor.yellow()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NSLog("%@", #function)
    }
    
    @IBAction func doButton(_ sender: AnyObject) {
        if self.presenting != nil {
            self.dismiss(animated:true)
        } else {
            print("window bounds are \(self.view.window!.bounds)")
            print("screen bounds are \(UIScreen.main().bounds)")
            let v = sender as! UIView
            let r = self.view.window?.convert(v.bounds, from: v)
            print("button in window is \(r)")
            let r2 = v.convert(v.bounds, to: UIScreen.main().coordinateSpace)
            print("button in screen is \(r2)")
        }
    }
    
    let which = 2
    
    @IBAction func doButton2(_ sender: AnyObject) {
        if self.presenting != nil {
            return
        }
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "VC") {
            switch which {
            case 1:
                vc.modalPresentationStyle = .formSheet
            case 2:
                vc.modalPresentationStyle = .popover
                if let pop = vc.popoverPresentationController {
                    let v = sender as! UIView
                    pop.sourceView = v
                    pop.sourceRect = v.bounds
                }
            default: break
            }
            vc.presentationController!.delegate = self
            self.present(vc, animated:true)

        }
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        print(#function, size, terminator:"\n\n")
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        print(#function, newCollection, terminator:"\n\n")
        super.willTransition(to: newCollection, with: coordinator)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        print(#function, self.traitCollection, terminator:"\n\n")
        super.traitCollectionDidChange(previousTraitCollection)
    }

}

extension ViewController : UIAdaptivePresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        print("adapt!")
        if traitCollection.horizontalSizeClass == .compact {
            return .fullScreen
        }
        return .none
    }

}

