
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtNumber: UITextField!
    @IBOutlet weak var btnSumbit: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnSumbit.setCorner()
    }
}
//MARK:- UIButton Action
extension ViewController{
    @IBAction func btnSumbitAction(_ sender: UIButton) {
        
        let numberOfBtn = self.txtNumber.getText().getInt()
        
        if numberOfBtn <= 0{
            self.showInfoAlert(strMessage: MessageTxt.enterNumber)
        }else{
            self.goToNextScreen(numberOfBtn: numberOfBtn)
        }
    }
    func goToNextScreen(numberOfBtn : Int){
        let vc = MainViewController.instanceViewController()
        vc.numberOfBtn = numberOfBtn
        self.navigationController?.pushViewController(vc, animated: true)

    }
}

//MARK:- UITextField Delegate Method
extension ViewController : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
          let allowedCharacters = CharacterSet(charactersIn:"0123456789")
          let characterSet = CharacterSet(charactersIn: string)
          return allowedCharacters.isSuperset(of: characterSet)
    }
}
