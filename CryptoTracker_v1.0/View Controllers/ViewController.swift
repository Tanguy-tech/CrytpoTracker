import UIKit
import AVKit

class ViewController: UIViewController {

    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUpElements()
        view.layer.contents = UIImage(named: "blockchainbkg")?.cgImage
    }
    
    func setUpElements() {
        
       Utilities.styleFilledButton(signUpButton)
       Utilities.styleHollowButton(loginButton)
        
    }
}
