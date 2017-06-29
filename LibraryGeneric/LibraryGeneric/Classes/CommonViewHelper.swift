//
//  CommonViewHelper.swift
//  Pods
//
//  Created by COCOMSYS One on 6/29/17.
//
//

import UIKit

enum PositionIcon: String {
    case right
    case left
}

public enum UIButtonBorderSide {
    case top
    case bottom
    case left
    case right
}

public struct LayoutSpacing {
    
    public static let defVerticalSpace: CGFloat   = 6
    public static let defHorizontalSpace: CGFloat = 10
    
    let top: CGFloat?
    let right: CGFloat?
    let bottom: CGFloat?
    let left: CGFloat?
    
    public init(top: CGFloat?, right: CGFloat?, bottom: CGFloat?, left: CGFloat?){
        self.top    = top
        self.right  = right
        self.bottom = bottom
        self.left   = left
    }
    
    public static var defaultValue: LayoutSpacing {
        get {
            return LayoutSpacing(top: defVerticalSpace, right: defHorizontalSpace, bottom: defVerticalSpace, left: defHorizontalSpace)
        }
    }
    
    public static var defaultHorizontalValue: LayoutSpacing {
        get {
            return LayoutSpacing(top: nil, right: defHorizontalSpace, bottom: nil, left: defHorizontalSpace)
        }
    }
}

public struct SpacingConstraint {
    public let constraint: NSLayoutConstraint
    public let originalValue: CGFloat
}

public class CommonViewHelper {
    public static func hideCellSeparator(cell: UITableViewCell) {
        cell.separatorInset = UIEdgeInsetsMake(0.0, cell.bounds.size.width, 0.0, 0.0)
    }
    
    public static func setupNavBarDefaultStyle(navigationBar: UINavigationBar?,
                                               barTintColor: UIColor = AppColors.primary,
                                               tintColor: UIColor = AppColors.white,
                                               titleColor: UIColor = AppColors.white,
                                               titleFontSize: CGFloat = AppFonts.bigSize,
                                               
                                               isTranslucent: Bool = true,
                                               backBtnText: String = "") {
        guard let navigationBar = navigationBar else {
            return
        }
        UIApplication.shared.statusBarStyle = .lightContent
        navigationBar.isTranslucent       = isTranslucent
        navigationBar.barTintColor        = barTintColor
        navigationBar.tintColor           = tintColor
        navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: titleColor
        ]
        
        navigationBar.backItem?.backBarButtonItem?.title = backBtnText
    }
    
    public static func setupTabBarDefaultStyle(tabBar: UITabBar?,
                                               barTintColor: UIColor = AppColors.white,
                                               tintColor: UIColor = AppColors.primary,
                                               isTranslucent: Bool = true) {
        guard let tabBar = tabBar else {
            return
        }
        
        tabBar.isTranslucent       = isTranslucent
        tabBar.barTintColor        = barTintColor
        tabBar.tintColor           = tintColor
    }
    
    public static func setTabViewTitles(controller: UIViewController, navTitle: String, tabTitle: String){
        controller.title = tabTitle
        setNavTitle(ctrl: controller, title: navTitle)
    }
    
    public static func setNavTitle(ctrl: UIViewController, title: String){
        ctrl.navigationItem.title = title
    }
    
    public static func addButtonLeft(navigationItem: UINavigationItem, button: UIBarButtonItem){
        navigationItem.leftBarButtonItem = button
    }
    
    public static func addButtonRight(navigationItem: UINavigationItem, button: UIBarButtonItem){
        navigationItem.rightBarButtonItem = button
    }
    
    public static func addPickerViewToolbar(view: UITextField, target: AnyObject?, action: Selector){
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.tintColor = AppColors.blue
        toolbar.sizeToFit()
        
        let doneButton  = UIBarButtonItem(title: "OK", style: .plain, target: target, action: action)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([spaceButton, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        view.inputAccessoryView = toolbar
    }
    
    public static func setupTabChildControllers(tabController: UITabBarController, handler: (UIViewController) -> Void) {
        guard let ctrls = tabController.viewControllers else {
            return
        }
        
        for item in ctrls {
            guard let navCtrl = item as? UINavigationController else {
                continue
            }
            guard let ctrl = navCtrl.viewControllers.first else {
                continue
            }
            
            handler(ctrl)
        }
    }
    
    static func setDefaultSelectedBackgroundView(cell: UITableViewCell, backgroundColor: UIColor       = AppColors.cardBackground) {
        let backgroundView             = UIView()
        backgroundView.backgroundColor = AppColors.white
        cell.selectedBackgroundView    = backgroundView
        
    }
    
    static func dismissKeyboard(view: UIView) {
        view.endEditing(true)
    }
    
    public static func setCardViewDefaultLayout(view: UIView, relatedView: UIView, spacing nSpacing: LayoutSpacing? = nil) -> [SpacingConstraint] {
        
        let spacing = nSpacing != nil ? nSpacing! : LayoutSpacing.defaultValue
        var constraints = [NSLayoutConstraint]()
        
        if let topVal = spacing.top {
            let topConst = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: relatedView, attribute: .top, multiplier: 1, constant: topVal)
            constraints.append(topConst)
        }
        if let bottomVal = spacing.bottom {
            let bottomConst = NSLayoutConstraint(item: relatedView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: bottomVal)
            constraints.append(bottomConst)
        }
        
        if let rightVal = spacing.right {
            let trailingConst = NSLayoutConstraint(item: relatedView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: rightVal)
            constraints.append(trailingConst)
        }
        
        if let leftVal = spacing.left {
            let leadingConst  = NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: relatedView, attribute: .leading, multiplier: 1, constant: leftVal)
            constraints.append(leadingConst)
        }
        
        NSLayoutConstraint.activate(constraints)
        
        return constraints.map({ SpacingConstraint(constraint: $0, originalValue: $0.constant) })
    }
    
    public static func setCardView(view: UIView, backgroundColor: UIColor? = nil, cornerRadius: CGFloat = 4,
                                   shadowRadius: CGFloat = 2, shadowOpacity: CGFloat = 0.2, shadowOffset: CGSize = CGSize(width: 0, height: 1)) {
        
        if view.backgroundColor == AppColors.transparent {
            let bgColor = backgroundColor != nil ? backgroundColor! : UIColor.white
            view.backgroundColor = bgColor
        }
        
        view.layer.borderWidth = 1
        view.layer.borderColor = AppColors.cardBackground.cgColor
        
        view.layer.masksToBounds = false
        view.layer.shadowOffset  = shadowOffset
        view.layer.cornerRadius  = cornerRadius
        view.layer.shadowRadius  = shadowRadius
        view.layer.shadowOpacity = Float(shadowOpacity)
    }
    
    public static func addReadMoreLinkToAttributedText(view: UILabel, text readMoreText: String) {
        guard let viewText = view.attributedText else { return }
        let rangeStart = viewText.string.characters.count + 1
        let newText = NSMutableAttributedString(attributedString: viewText)
        newText.append(NSAttributedString(string: " \(readMoreText)"))
        
        view.attributedText = newText
        let length = readMoreText.characters.count
        view.setTextColor(color: AppColors.primary, range: NSMakeRange(rangeStart, length))
    }
    
    public static func buildSpacingFrom(text: String, spacing: CGFloat) -> NSMutableAttributedString {
        let attText = NSMutableAttributedString(string: text)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = spacing
        attText.addAttribute(NSParagraphStyleAttributeName, value: style, range: NSMakeRange(0, attText.length))
        return attText
    }
    
    static func setIconTextField(textField: UITextField, image: String? = nil, position: PositionIcon? = PositionIcon.right ) {
        
        let imageName = image ?? "pickerViewPeak"
        
        let imageView = UIImageView()
        let image = UIImage(named: imageName)
        imageView.image = image
        
        if position == PositionIcon.right {
            
            imageView.frame = CGRect(x: 5, y: 0, width: textField.frame.height, height: textField.frame.height)
            textField.rightView = imageView
            
        } else {
            let paddingView = UIView(frame: CGRect(x: 5, y: 0, width: textField.frame.height - 30, height: textField.frame.height - 35 ))
            imageView.frame = CGRect(x: 5, y: 0, width: textField.frame.height - 30, height: textField.frame.height - 35)
            paddingView.addSubview(imageView)
            textField.leftView = paddingView
            
        }
        
        if textField.leftView != nil && imageView.image != nil {
            textField.leftViewMode = .always
        }
        
        if textField.rightView != nil && imageView.image != nil {
            textField.rightViewMode = .always
        }
    }
    
    
    public static func setTextColorByRange(view: UILabel, color: UIColor, range: NSRange?) {
        guard let range = range else { return }
        let text = mutableAttributedString(view: view)
        text.addAttribute(NSForegroundColorAttributeName, value: color, range: range)
        view.attributedText = text
    }
    
    public static func setTextColorByRange(view: UILabel, color: UIColor, text: String) {
        setTextColorByRange(view: view, color: color, range: rangeOf(view: view, string: text))
    }
    
    //TODO: Create class helper
    private static func mutableAttributedString(view: UILabel) -> NSMutableAttributedString {
        if view.attributedText != nil {
            return NSMutableAttributedString(attributedString: view.attributedText!)
        } else {
            return NSMutableAttributedString(string: view.text ?? "")
        }
    }
    
    private static func rangeOf(view: UILabel, string: String) -> NSRange? {
        let range = NSString(string: view.text ?? "").range(of: string)
        return range.location != NSNotFound ? range : nil
    }
    
    
}

