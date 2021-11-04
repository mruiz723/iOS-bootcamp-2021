//
//  swift
//  mvc
//
//  Created by Jorge Benavides on 04/11/21.
//

import UIKit

class ScrollView: UIScrollView {
    
    override func layoutIfNeeded() {
        
        guard let superview = superview else { return }
        
        superview.layoutIfNeeded()
        
        guard superview.frame.size != frame.size else { return }
        
        frame = CGRect(origin: .zero, size: superview.frame.size)
        
        for (index, subview) in subviews.enumerated() {
            subview.frame.origin = CGPoint(x: frame.size.width * CGFloat(index), y: 0)
            subview.frame.size = CGSize(width: frame.size.width, height: frame.size.height)
        }
        
        contentSize = CGSize(width: frame.size.width * CGFloat(subviews.count), height: frame.size.height)
        contentOffset.x = 0
        
    }
    
}
