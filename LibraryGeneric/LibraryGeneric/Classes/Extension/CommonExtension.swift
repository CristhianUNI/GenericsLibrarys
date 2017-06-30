//
//  CommonExtension.swift
//  Pods
//
//  Created by COCOMSYS One on 6/29/17.
//
//

import Foundation
import UIKit

public extension UIColor {
    
    ///### UIColor from Hexadecimal code.
    convenience init(hex: String){
        
        var cString: String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines as CharacterSet).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString = cString.substring(from: cString.startIndex.advance(1, string: cString) )
        }
        
        var rgbValue: UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

public extension UITableView {
    public func setRefreshControl(title: String, target: AnyObject, action: Selector, height: CGFloat = 30) -> UIRefreshControl {
        let refreshControl: UIRefreshControl = {
            let refreshControl = UIRefreshControl()
            refreshControl.attributedTitle = NSAttributedString(string: title, attributes: [NSForegroundColorAttributeName: AppColors.black])
            
            refreshControl.frame           = CGRect(x: 0, y: 0, width: self.frame.width , height: height)
            
            refreshControl.backgroundColor = AppColors.transparent
            refreshControl.tintColor       = AppColors.primary
            
            refreshControl.addTarget(target, action: action, for: UIControlEvents.valueChanged)
            
            return refreshControl
        }()
        self.addSubview(refreshControl)
        return refreshControl
    }
}

public extension UIViewController {
    
    public func buildAlertController( title: String?, message: String?, style: UIAlertControllerStyle? = UIAlertControllerStyle.alert, titleAction: String? = "Si", cancelAction: String? = "No", cancelActionHandler: ((UIAlertAction) -> Void)? = nil, okActionHandler: @escaping (UIAlertAction) -> Void) {
        
        guard let style = style else {
            return
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        
        // build buttons
        alert.addAction( UIAlertAction(title: titleAction, style: .default, handler: okActionHandler  ) )
        alert.addAction( UIAlertAction(title: cancelAction, style: .destructive, handler: cancelActionHandler ) )
        
        self.present(alert, animated: true, completion: nil)
    }
}

public extension UITableView {
    
    public func moveToTop() {
        self.scrollRectToVisible( CGRect(x: 0, y: 0, width: 1, height: 1) , animated: true)
    }
}


public extension Double {
    
    public func toDecimalUS() -> String{
        let formatter                   =  NumberFormatter()
        formatter.numberStyle           = .decimal
        formatter.locale                =  Locale(identifier: "en_US")
        formatter.maximumFractionDigits = 2
        let number                      = formatter.string(from: NSNumber(value: self ))
        return number ?? ""
    }
    
    public func toString(decimalPlaces val: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = val
        formatter.maximumFractionDigits = val
        formatter.decimalSeparator  = "."
        formatter.groupingSeparator = ","
        let result = formatter.string(for: self) ?? ""
        
        return result
    }
    
}

public extension UILabel {
    
    public func setTextColor(color: UIColor, range: NSRange?) {
        CommonViewHelper.setTextColorByRange(view: self, color: color, range: range)
    }
    
    public func setTextColor(color: UIColor, text: String) {
        CommonViewHelper.setTextColorByRange(view: self, color: color, text: text)
    }
    
    public func setSpacing(_ spacing: CGFloat) {
        guard let text = self.text else { return }
        let newText = CommonViewHelper.buildSpacingFrom(text: text, spacing: spacing)
        self.attributedText = newText
    }
    
}

public extension String {
    
    public func truncate(max: Int, trailing: String? = "...") -> String {
        return StringHelper.truncate(str: self, length: max, trailing: trailing)
    }
    
    public func hasToTruncate(max: Int) -> Bool {
        return StringHelper.hasToTruncate(str: self, length: max)
    }
    
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        
        var dateResult = dateFormatter.date(from: self)
        
        if dateResult == nil {
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateResult = dateFormatter.date(from: self)
        }
        
        return dateResult
    }
    
}

public extension Date {
    
    public var date: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: self)
    }
    
    public var time: String {
        let dateFormatter = DateFormatter()
        //dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: self)
    }
    
    public func toStringWithFormat(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

public extension String.Index {
    public func advance(_ offset: Int, string: String) -> String.Index {
        return string.index(self, offsetBy: offset)
    }
}

public extension Array {
    
    public func isInvalidIndex(index: Int) -> Bool {
        return self.isEmpty || self.count <= index
    }
    
    public func randomize() -> Element {
        let index = TypeHelper.random(max: self.count)
        return self[index]
    }
    
}

public extension UIViewController {
    
    public func showAlert(title: String?, content: String?, cancelTitle: String = "OK") {
        return MessageView.show(controller: self, title: title, message: content, cancelTitle: cancelTitle)
    }
    
}

public extension UITextField {
    
    public func addPickerViewToolbar( target: AnyObject?, action: Selector)  {
        CommonViewHelper.addPickerViewToolbar(view: self, target: target, action: action)
    }
    
    public func addDropdownAccesory(imageName: String? = nil, position: PositionIcon? = PositionIcon.right) {
        CommonViewHelper.setIconTextField(textField: self, image: imageName, position: position)
    }
    
}

public extension UIButton {
    public func addBorder(side: UIButtonBorderSide, color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        
        switch side {
        case .top:
            border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: width)
        case .bottom:
            border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        case .left:
            border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        case .right:
            border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
        }
        
        self.layer.addSublayer(border)
    }
    
}

public extension UIView {
    
    public func addBorderTop(size: CGFloat, color: UIColor) {
        addBorderUtility(x: 0, y: 0, width: frame.width, height: size, color: color)
    }
    
    public func addBorderBottom(size: CGFloat, color: UIColor, width: CGFloat = 0.0) {
        
        //  let width1 = width != 0.0 ? width: frame.width
        addBorderUtility(x: 0, y: frame.height - size, width: frame.width, height: size, color: color)
    }
    public func addBorderUtility(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, color: UIColor) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: x, y: y, width: width, height: height)
        layer.addSublayer(border)
    }
    public func toCard() {
        CommonViewHelper.setCardView(view: self)
    }
    
}
