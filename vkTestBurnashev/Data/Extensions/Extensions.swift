import Foundation
import UIKit

private var kAssociationKeyMaxLength: Int = 0
var isTapAnimation = false
var touch: UITouch = UITouch()
var timer: Timer = Timer()
var timerOff: Timer = Timer()
var timerDelayTouch: Timer = Timer()
var arrayUIViewAnimated: [UIView] = []

enum Theme: Int, CaseIterable {
    case system = 0
    case light
    case dark
}

@propertyWrapper
struct Persist<T> {
    let key: String
    let defaultValue: T
    
    var wrappedValue: T {
        get { UserDefaults.standard.object(forKey: key) as? T ?? defaultValue }
        set { UserDefaults.standard.set(newValue, forKey: key) }
    }
    
    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
}

extension Date {
    
    var toDate: String {
        
        var calendar = Calendar.current

        let timeZoneIdentifier = TimeZone.current.identifier
        if let timeZone = TimeZone(identifier: timeZoneIdentifier) {
           calendar.timeZone = timeZone
        }
        
        if calendar.isDateInToday(self) {
            return NSLocalizedString("Today", comment: "")
        } else if calendar.isDateInYesterday(self) {
            return NSLocalizedString("Yesterday", comment: "")
        } else {
            let day = String(calendar.component(.day, from: self))
            let month = String(calendar.component(.month, from: self))
            let year = String(calendar.component(.year, from: self))
            
            var monthString = ""
            if month == "1" {
                monthString = NSLocalizedString("January", comment: "")
            } else if month == "2" {
                monthString = NSLocalizedString("February", comment: "")
            } else if month == "3" {
                monthString = NSLocalizedString("March", comment: "")
            } else if month == "4" {
                monthString = NSLocalizedString("April", comment: "")
            } else if month == "5" {
                monthString = NSLocalizedString("May", comment: "")
            } else if month == "6" {
                monthString = NSLocalizedString("June", comment: "")
            } else if month == "7" {
                monthString = NSLocalizedString("July", comment: "")
            } else if month == "8" {
                monthString = NSLocalizedString("August", comment: "")
            } else if month == "9" {
                monthString = NSLocalizedString("September", comment: "")
            } else if month == "10" {
                monthString = NSLocalizedString("October", comment: "")
            } else if month == "11" {
                monthString = NSLocalizedString("November", comment: "")
            } else if month == "12" {
                monthString = NSLocalizedString("December", comment: "")
            }
            
            return ("\(day) \(monthString) \(year)")
        }

    }
    
}

extension StringProtocol {
    var firstUppercased: String { return prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { return prefix(1).capitalized + dropFirst() }
}

extension Int {
    var toString: String {
        if self == 0 {
            return ""
        } else {
            return "\(self)"
        }
    }
    var toStringPercent: String {
        if self == 0 {
            return "0"
        } else {
            return "\(self)"
        }
    }
}

extension UIView {
    
    func rotate() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi)
        rotation.duration = 0.3
        rotation.isCumulative = true
        rotation.repeatCount = 1
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    // In order to create computed properties for extensions, we need a key to
        // store and access the stored property
        fileprivate struct AssociatedObjectKeys {
            static var tapGestureRecognizer = "MediaViewerAssociatedObjectKey_mediaViewer"
        }
        
        fileprivate typealias Action = (() -> Void)?
        
        // Set our computed property type to a closure
        fileprivate var tapGestureRecognizerAction: Action? {
            set {
                if let newValue = newValue {
                    // Computed properties get stored as associated objects
                    objc_setAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
                }
            }
            get {
                let tapGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer) as? Action
                return tapGestureRecognizerActionInstance
            }
        }
        
        // This is the meat of the sauce, here we create the tap gesture recognizer and
        // store the closure the user passed to us in the associated object we declared above
        public func addTapGestureRecognizer(isTapAnimation: Bool, action: (() -> Void)?) {
            self.isUserInteractionEnabled = true
            self.tapGestureRecognizerAction = action
//            let arrTap = (self.gestureRecognizers?.filter{ $0.isKind(of: TapGestureRecognizer.self) })
//            arrTap?.forEach{ self.removeGestureRecognizer($0) }
            let tapGestureRecognizer = TapGestureRecognizer(target: self, action: #selector(handleTapGesture))
            //tapGestureRecognizer.isTapAnimation = isTapAnimation
            self.isMultipleTouchEnabled = false
            self.addGestureRecognizer(tapGestureRecognizer)
        }
        
        // Every time the user taps on the UIImageView, this function gets called,
        // which triggers the closure we stored
        @objc fileprivate func handleTapGesture(sender: UITapGestureRecognizer) {
            if let action = self.tapGestureRecognizerAction {
                action?()
            } else {
                print("no action")
            }
        }
    
    func showAnimation(isTapAnimation: Bool, _ completionBlock: @escaping () -> Void) {
        isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.05,
                         delay: 0,
                         options: .curveLinear,
                         animations: { [weak self] in
                              self?.transform = CGAffineTransform.init(scaleX: 0.95, y: 0.95)
          }) {  (done) in
              UIView.animate(withDuration: 0.05,
                             delay: 0,
                             options: .curveLinear,
                             animations: { [weak self] in
                                  self?.transform = CGAffineTransform.init(scaleX: 1, y: 1)
              }) { [weak self] (_) in
                  self?.isUserInteractionEnabled = true
                  completionBlock()
              }
          }
      }
    
    func drawCurveLineShadow() {
           
        let W : CGFloat = self.frame.width
        let H : CGFloat = self.frame.height
        var pathArray = [UIBezierPath]()
        let R : CGFloat = 16
        
        let lines = 10
        
        for i in 0 ... lines {
            
            let path = UIBezierPath()
            
            path.move(to: CGPoint(x: 0 - CGFloat(i), y: H - R))
            path.addArc(
                withCenter: CGPoint(x: R, y: H - R),
                radius: R + CGFloat(i),
                startAngle: CGFloat.pi,
                endAngle: 0.5 * CGFloat.pi,
                clockwise: false)
            path.addLine(to: CGPoint(x: W - R, y: H + CGFloat(i)))
            path.addArc(
                withCenter: CGPoint(x: W - R, y: H - R),
                radius: R + CGFloat(i),
                startAngle: 0.5 * CGFloat.pi,
                endAngle: 0,
                clockwise: false)
            
            pathArray.append(path)
            
        }
        
        var i : CGFloat = 0
        pathArray.forEach{ path in
            
            let alpha : CGFloat = (CGFloat(lines) - i) / CGFloat(lines * 2)
            print ("alpha = \(alpha)")
            
            let semiCircleLayer = CAShapeLayer()
            semiCircleLayer.path = path.cgPath
            semiCircleLayer.strokeColor = .init(
                red: 0,
                green: 0,
                blue: 0,
                alpha: alpha)
            semiCircleLayer.fillColor = UIColor.clear.cgColor
            semiCircleLayer.lineWidth = 1
            self.layer.addSublayer(semiCircleLayer)
            i += 1
        }
        
    }
    
}

class TapGestureRecognizer: UITapGestureRecognizer {
    
    var timer_off: Timer = Timer()
    var views: UIView = UIView()
    //MARK:- Events
    
    func removeAllAnimation() {
        print ("removeAllAnimation")
        timer.invalidate()
        arrayUIViewAnimated.forEach({v in
            v.transform = .identity
        })
        arrayUIViewAnimated.removeAll()
        isTapAnimation = false
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        print ("-------------")
        print ("isTapAnimation 1 = \(isTapAnimation)")
        if isTapAnimation {
            removeAllAnimation()
        } else {
            timer.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { timer in
                print ("isTapAnimation 2 = \(isTapAnimation)")
                if isTapAnimation {
                    self.removeAllAnimation()
                } else {
                    if let touch = touches.first {
                        print ("touch = \(touch)")
                        if touch.window != nil {
                            self.animate(isHighlighted: true)
                        }
                    }
                }
                
            }
        }
        
        timerOff.invalidate()
        timerOff = Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { timer in
            self.removeAllAnimation()
        }
        
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesEnded(touches, with: event)
        print ("touchesEnded")
        timer.invalidate()
        animate(isHighlighted: false)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)
        print ("touchesMoved")
        timer.invalidate()
        removeAllAnimation()
        //animate(isHighlighted: false)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesCancelled(touches, with: event)
        print ("touchesCancelled")
        timer.invalidate()
        removeAllAnimation()
        //animate(isHighlighted: false)
    }
    
    //MARK:- Private functions
    private func animate(isHighlighted: Bool, completion: ((Bool) -> Void)?=nil) {
        //if !isTapAnimation { completion?(true); return }
        print ("isHighlighted = \(isHighlighted)")
        if isHighlighted {
            isTapAnimation = true
            if let view = self.view {
                print ("view.isFocused = \(view)")
                arrayUIViewAnimated.append(view)
                UIView.animate(withDuration: 0.4,
                               delay: 0,
                               usingSpringWithDamping: 0.5,
                               initialSpringVelocity: 3,
                               options: [.curveEaseInOut],
                               animations: {
                                view.transform = CGAffineTransform.identity.scaledBy(x: 0.98, y: 0.98)
                }, completion: completion)
            }
        } else {
            isTapAnimation = false
            UIView.animate(withDuration: 0.4,
                           delay: 0,
                           usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 3,
                           options: [.curveEaseInOut],
                           animations: {
                            self.view?.transform = .identity
            }, completion: completion)
        }
    }
}

@IBDesignable public class PaddingLabel: UILabel {
    
    var insets = UIEdgeInsets.zero
    
    @IBInspectable var topInset: CGFloat = 0
    @IBInspectable var bottomInset: CGFloat = 0
    @IBInspectable var leftInset: CGFloat = 0
    @IBInspectable var rightInset: CGFloat = 0
    
    public override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    public override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset, height: size.height + bottomInset + topInset)
    }
    
    func padding(_ top: CGFloat, _ bottom: CGFloat, _ left: CGFloat, _ right: CGFloat) {
            self.frame = CGRect(x: 0, y: 0, width: self.frame.width + left + right, height: self.frame.height + top + bottom)
            insets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        }
    
}
