

import UIKit


class MainViewController: UIViewController {
    
    @IBOutlet weak var viewContain: UIView!
    @IBOutlet weak var heightOfScr: NSLayoutConstraint!
    
    var btnGenerate = UIBarButtonItem()
    
    var numberOfBtn : Int = 0   ///  Value Assign in Previous Screen View Controller
    var btnGap : Int = 10   ///  We Can change any int Value
    var numberOfBtnInRow : Int = 3 /// Number of button in 1 row
    
    var arrbtn = [btnModel]()
    var arrUsed = [Int]() ///  Save Index for Genreate a random 3 Int Value
    var arrBlueBtnIdx = [Int]()
    
     // Button Width and Height
    var btnWidth : Float{
        let scrWidth = Float(UIScreen.main.bounds.width)
        let btnW = (scrWidth - Float(((numberOfBtnInRow + 1) * btnGap))) / Float(numberOfBtnInRow)
        return btnW
    }
     //Total Number of Row display in View
    var numberOfRowForBtn : Int{
        let quotientbtn = numberOfBtn / numberOfBtnInRow
        let reminderbtn = (numberOfBtn % numberOfBtnInRow) == 0 ? 0 : 1
        return quotientbtn + reminderbtn
    }
      /// Total Height of Scroll View
    var totalHeightOfScroll : CGFloat{
        let height = CGFloat(Float(numberOfRowForBtn) * btnWidth) + CGFloat((numberOfRowForBtn + 1) * btnGap)
        return height
    }
    
     /// Get a Current ViewController Object
    class func instanceViewController() -> MainViewController{
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        return vc
    }
    //MARK:- View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        numberOfBtnInRow = UIScreen.main.bounds.width >= 320 ? 3 : 2
        self.setTotalHeightOfScrView()
        self.addNavigationBtn()
        self.addButton()
    }
    func addNavigationBtn(){
        btnGenerate = UIBarButtonItem(title: "Generate", style: .plain, target: self, action: #selector(btnGenerateRandomIdTap))
        self.navigationItem.rightBarButtonItem = btnGenerate
    }
    @objc func btnGenerateRandomIdTap(){
        if arrBlueBtnIdx.count == 0{
            self.randomNumberGenrator()
        }else{
            self.showInfoAlert(strMessage: MessageTxt.firstSelectAllBlueBtn)
        }
        
    }
    func setTotalHeightOfScrView(){
        self.heightOfScr.constant = totalHeightOfScroll
    }
    //MARK: Create a button random
    
    func addButton(){
        let bWidth = btnWidth
        for i in 0...numberOfBtn - 1{
            let currentRow = i / numberOfBtnInRow
            let btnPositionReminder = i % numberOfBtnInRow

            let x = btnPositionReminder == 0 ? Float(btnGap) : ((Float(btnPositionReminder) * (Float(btnGap) + bWidth)) + Float(btnGap))
            let y = currentRow == 0 ? Float(btnGap) : Float(currentRow) * (Float(btnGap) + bWidth) + Float(8)
            
             let btn = UIButton(frame: CGRect(x: CGFloat(x), y: CGFloat(y), width: CGFloat(bWidth), height: CGFloat(bWidth)))
            print("btnPositionReminder :- \(btnPositionReminder) currentRow : \(currentRow)" )
            btn.backgroundColor = .white
            btn.tag = i
            btn.setLightShedow()
//            btn.addTarget(self, action: #selector(btnClickButton), for: .touchUpInside)
            let model = btnModel.init(Btn: btn)
            arrbtn.append(model)
            self.viewContain.addSubview(btn)
        }
    }
    //MARK:- Button Click Event after click remove this target
    @objc func btnClickButton(sender : UIButton) {
        sender.backgroundColor = .red
        sender.removeTarget(nil, action: nil, for: .allEvents)
        if let index = arrBlueBtnIdx.firstIndex(of: sender.tag) {
            arrBlueBtnIdx.remove(at: index)
        }
        
    }
}
//MARK:- Generate a Random Number and Change button background color
extension MainViewController{
    func randomNumberGenrator(){
        var arrNumber = [Int]()
        for i in 0...numberOfBtn - 1{
            if !arrUsed.contains(i){
                arrNumber.append(i)
            }
        }
        var arrChoose = [Int]()
        if arrNumber.count > 3{
            let arr = arrNumber.choose(3)
            arrUsed.append(contentsOf: arr)
            arrChoose.append(contentsOf: arr)
        }else{
            arrUsed.append(contentsOf: arrNumber)
            arrChoose = arrNumber;
            btnGenerate.isEnabled = false
            arrChoose.append(contentsOf: arrNumber)
        }
        self.changeABackGroundColorForRandomButton(arrIndex: arrChoose)
    }
    func changeABackGroundColorForRandomButton(arrIndex : [Int]){
        arrBlueBtnIdx = arrIndex
        for i in arrIndex{
            let btn = arrbtn[i].btn
            btn.backgroundColor = .blue
            btn.addTarget(self, action: #selector(btnClickButton), for: .touchUpInside)
        }
    }
}

//MARK:- Generate Randon number for N
extension Collection {
    func choose(_ n: Int) -> ArraySlice<Element> { shuffled().prefix(n) }
}
