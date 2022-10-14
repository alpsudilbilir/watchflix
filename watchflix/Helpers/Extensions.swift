//
//  Extensions.swift
//  watchflix
//
//  Created by Alpsu Dilbilir on 25.09.2022.
//

import Foundation
import UIKit

extension UIView {
    var width: CGFloat {
        return frame.size.width
    }
    
    var heigth: CGFloat {
        return frame.size.height
    }
    
    var left: CGFloat {
        return frame.origin.x
    }
    var rigth: CGFloat {
        return left + width
    }
    
    var top: CGFloat {
        return frame.origin.y
    }
    var bottom: CGFloat {
        return top + heigth
    }
}


