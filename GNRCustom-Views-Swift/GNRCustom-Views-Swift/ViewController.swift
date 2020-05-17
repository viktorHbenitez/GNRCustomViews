//
//  ViewController.swift
//  GNRCustom-Views-Swift
//
//  Created by Victor Hugo Benitez Bosques on 5/17/20.
//  Copyright © 2020 Victor Hugo Benitez Bosques. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var stkMainView : UIStackView!
//  var gnrView : GNRTargetView?
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    let customView = GNRTargetView(self.view,
                                   [bsModellabel(strDescription: "Primero Vikt nuevo", iIdentifier: 1)!,
                                    bsModellabel(strDescription: "Segundo Vikt nuevo nuevo", iIdentifier: 2)!,
                                    bsModellabel(strDescription: "tercero Vikt", iIdentifier: 3)!, bsModellabel(strDescription: "cuarto Vikt", iIdentifier: 4)!,
                                    bsModellabel(strDescription: "quinto Vikt", iIdentifier: 5)!,
                                    bsModellabel(strDescription: "sexto Vikt", iIdentifier: 6)!, bsModellabel(strDescription: "septimo Vikt", iIdentifier: 4)!,
                                    bsModellabel(strDescription: "octavo Vikt", iIdentifier: 5)!,
                                    bsModellabel(strDescription: "noveno Vikt", iIdentifier: 6)!])
    stkMainView.addArrangedSubview(customView)
  }
  
  
  
}


protocol GNRLabelDelegate : class{
  func getModel(_ model : bsModellabel?)
}

@IBDesignable class GNRLabel: UILabel {
  
  @IBInspectable var dbtopInset: CGFloat = 3.0
  @IBInspectable var dbbottomInset: CGFloat = 3.0
  @IBInspectable var dbleftInset: CGFloat = 5.0
  @IBInspectable var dbrightInset: CGFloat = 5.0
  var model : bsModellabel?
  var enumType : enumStateLabel = .isOff
  weak var delegate : GNRLabelDelegate?
  
  // programmatic initialization
  override init(frame: CGRect) {
    super.init(frame: frame)
    // Note: We do not need to call our fun here casuse this for programmatic created UIView object
//    setupInit()
  }
  
  convenience init(_ model : bsModellabel) {
    self.init()
    setupInit()
    text = model.strDescription
    tag = model.iIdentifier
    font = UIFont.systemFont(ofSize: model.getLongDescription())
    self.model = model
  }
  
  override func drawText(in rect: CGRect) {
      let insets = UIEdgeInsets.init(top: dbtopInset,
                                     left: dbleftInset,
                                     bottom: dbbottomInset,
                                     right: dbrightInset)
    
      super.drawText(in: rect.inset(by: insets))
  }

  override var intrinsicContentSize: CGSize {
      let size = super.intrinsicContentSize
      return CGSize(width: size.width + dbleftInset + dbrightInset,
                    height: size.height + dbtopInset + dbbottomInset)

  }
  
  // story board initialization
  required init?(coder: NSCoder) {
    super.init(coder: coder)
//    setupInit()
  }
  
  func setupInit(){
    self.isUserInteractionEnabled = true
    self.adjustsFontSizeToFitWidth = true
//    self.font = UIFont.boldSystemFont(ofSize: 16)
    updateCustomValue()
  }
  
  func updateCustomValue(){
    layer.borderColor =  enumType.value ? UIColor.green.cgColor : UIColor.gray.cgColor
    layer.borderWidth = enumType.value ? 1.0 : 1.0
    layer.cornerRadius = 3.0
    textColor = enumType.value ? UIColor.white : UIColor.black
    backgroundColor = enumType.value ? UIColor.green : UIColor.white
    font = enumType.value ? UIFont.boldSystemFont(ofSize: model?.getLongDescription() ?? 0.0) : UIFont.systemFont(ofSize: model?.getLongDescription() ?? 0.0)
    enumType.switchStatus()
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    delegate?.getModel( bsModellabel(strDescription: text,
                                     iIdentifier: tag,
                                     statuslabel: enumType))
    updateCustomValue()
    
  }
}

enum enumStateLabel {
  case isOn
  case isOff
  
  var bOn : Bool{
    return self == .isOn
  }
  
  var bOff : Bool{
    return self == .isOff
  }
  
  mutating func switchStatus(){
    switch self {
    case .isOn:
      self = .isOff
    case .isOff:
      self = .isOn
    }
  }
  
  var value : Bool{
    switch self {
    case .isOn:
      return true
    case .isOff:
      return false
    }
  }
  
}

struct bsModellabel {
  var strDescription : String?
  var iIdentifier : Int
  var statuslabel : enumStateLabel
}

extension bsModellabel{
  init?(strDescription : String?,
        iIdentifier : Int,
        status : enumStateLabel = .isOff) {
    self.strDescription = strDescription
    self.iIdentifier = iIdentifier
    self.statuslabel = status
  }
  
  func getLongDescription() -> CGFloat{
    if strDescription?.count ?? 0 < 15{
      return 15.0
    }else if strDescription?.count ?? 0 >= 15 && strDescription?.count ?? 0 <= 17  {
      return 13.0
    }else{
      return 11.0
    }
    
    
  }
}


struct ViewModelCheckAsesor {
  let bsModel : [bsModellabel]
}
