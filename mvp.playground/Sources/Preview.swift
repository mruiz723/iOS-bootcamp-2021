import PlaygroundSupport
import UIKit

public struct PreviewWindow {

    let windowSize: CGSize
    let window: UIView

    public init(_ window: UIView, windowSize: CGSize = CGSize(width: 320, height: 480)) {
        self.windowSize = windowSize
        self.window = window
        window.frame.origin = .zero
        window.frame.size = windowSize
        PlaygroundPage.current.liveView = window
    }
}
