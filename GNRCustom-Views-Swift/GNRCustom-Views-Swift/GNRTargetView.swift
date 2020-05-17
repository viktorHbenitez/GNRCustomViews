//
//  GNRTargetView.swift
//  GNRCustom-Views-Swift
//
//  Created by Victor Hugo Benitez Bosques on 5/17/20.
//  Copyright © 2020 Victor Hugo Benitez Bosques. All rights reserved.
//

import UIKit

class GNRTargetView: UIView {
  
  @IBOutlet weak var stkTopOptions: UIStackView!
  @IBOutlet weak var stkMiddleOptions : UIStackView!
  @IBOutlet weak var stkBottomOptions : UIStackView!
  
  // needs de number of label to create
  // create label
  // add targer and description
  
  var vwParentView : UIView?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupInit()
  }
  
  
  convenience init(_ parentView : UIView? = nil,  _ bsmModel : [bsModellabel]) {
    self.init()
    
    setupInit()
    self.vwParentView = parentView
    createlabel(bsmModel)
  }
  var labelWidth : CGFloat = 0.0
  
  func createlabel(_ model : [bsModellabel]){
    for (index, label) in model.enumerated(){
      
      if label.strDescription?.count != 0{
        let customLabel = GNRLabel(label)
            customLabel.delegate = self
            appendlabelIntoStack(iPostion: index, customLabel: customLabel)
      }
    
    }
   
    
    print("ancho de la pantalla",self.vwParentView?.frame.width, "ancho del label", stkTopOptions)
  }
  
  func appendlabelIntoStack(iPostion : Int,
                            customLabel : GNRLabel){
    if iPostion < 3{
      stkTopOptions.isHidden = false
      stkTopOptions.addArrangedSubview(customLabel)
    }
    else if iPostion >=  3 && iPostion <= 5 {
      stkMiddleOptions.isHidden = false
      stkMiddleOptions.addArrangedSubview(customLabel)
    }
    else{
      stkBottomOptions.isHidden = false
      stkBottomOptions.addArrangedSubview(customLabel)
    }
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupInit()
  }
  
  func setupInit(){
    if let contentView = initXIB(){
      addSubview(contentView)
    }
  }
}

extension GNRTargetView: GNRLabelDelegate{
  
  func getModel(_ model: bsModellabel?) {
    
    if model!.statuslabel.bOn{
      // add to the array
      print("Description", model?.strDescription, "identifier", model?.iIdentifier)
    }
    else{
      // delete to the array
      print("se apago el label ", model?.strDescription , "tiene estatus", model?.statuslabel.value)
    }
    
  }
  
}

extension UIView{
  public func initXIB() -> UIView? {
      guard let name = type(of: self).description().components(separatedBy: ".").last,
          let view = UINib(nibName: name,
                           bundle : nil).instantiate(withOwner: self,
                                                     options  : nil).first as? UIView else { return nil }
      view.frame = bounds
      view.autoresizingMask = [.flexibleWidth,
                               .flexibleHeight]
      return view
  }
}
