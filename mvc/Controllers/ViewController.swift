//
//  ViewController.swift
//  mvc
//
//  Created by Jorge Benavides on 01/11/21.
//

import UIKit

protocol UserModelHandler {
    var userModel: User? { get set }
}

class ViewController: UIViewController {

    let userModel = User()
    
    // An outlet is a property of an object that references another object.
    // The reference is archived through Interface Builder.
    // The connections between the containing object and its outlets are reestablished every time the containing object is unarchived from its nib file.
    // The containing object holds an outlet declared as a property with the type qualifier of IBOutlet and a weak option.
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    // The IBAction return type is a special keyword indicating that the instance method can be connected to your user interface file.
    // Xcode sets the target of the control to an instance of your class,
    // and sets the action of the control to the action method selector.
    // At runtime, when the specified event occurs, the action message is set to your object.
    
    @IBAction func previousButtonPressed(_ sender: Any) {
        scroll(to: pageControl.currentPage - 1)
    }
    
    @IBAction func nextButtonPressed() {
        scroll(to: pageControl.currentPage + 1)
    }
    
}

extension ViewController {
    
    // MARK: Layout
    
    var numberOfPages: Int {
        scrollView.subviews.count
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        updateScrollView()
    }
    
    func updateScrollView() {
        guard let superview = scrollView.superview else { return }
        
        superview.layoutIfNeeded()
        
        guard superview.frame.size != scrollView.frame.size else { return }
        
        scrollView.frame = CGRect(origin: .zero, size: superview.frame.size)
        
        for (index, subview) in scrollView.subviews.enumerated() {
            subview.frame.origin = CGPoint(x: scrollView.frame.size.width * CGFloat(index), y: 0)
            subview.frame.size = CGSize(width: scrollView.frame.size.width, height: scrollView.frame.size.height)
        }
        
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width * CGFloat(scrollView.subviews.count), height: scrollView.frame.size.height)
        scrollView.contentOffset.x = 0
        pageControl.numberOfPages = scrollView.subviews.count
        pageControl.currentPage = 0
    }
    

    // MARK: Callbacks
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if var userHandler = segue.destination as? UserModelHandler {
            userHandler.userModel = userModel
        }
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        updateScrollView()
    }
    
    // MARK: Scroll Pagination
    
    func scroll(to page: Int) {
        guard page >= 0, page < numberOfPages else { return }
        let rect = scrollView.subviews[page].frame
        scrollView.scrollRectToVisible(rect, animated: true)
    }
    
}

extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x/scrollView.frame.width + 0.5)
    }
    
}

@IBDesignable class CustomView: UIView {
    
    @IBInspectable var customProperty: Bool = true
    
}

@IBDesignable extension UIView {
    
    @IBInspectable var cornerRadiusRatio: CGFloat {
        
        get {
            layer.cornerRadius
        }
        
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = true
        }
        
    }
    
}

