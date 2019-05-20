/*:
 # Cicular DNA by [fewlinesofcode](https://fewlinesofcode.com)
 
 
 */

  
import UIKit
import PlaygroundSupport


class CircularDNA: UIView {
    
    // Display refreshing timer
    private var displayLink: CADisplayLink?
    private var startTime: CFAbsoluteTime?
    
    // Contains points that will be displayed
    private var dotPairs: [(CGPoint, CGPoint)] = []
    
    // Parametric variable
    private var t: CGFloat = 0
        
    let guideRadius: CGFloat = 140
    let numberOfPoints: Int = 300
    let rotationSpeed: CGFloat = 0.0005
    let amplitude: CGFloat = 40
    let numberOfPeriods: CGFloat = 10
    
    
    // MARK: - Construction -
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        startDisplayLink()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Destruction
    deinit {
        stopDisplayLink()
    }
    
    
    /// Subscribe to screen refresh events
    private func startDisplayLink() {
        startTime = CFAbsoluteTimeGetCurrent()
        displayLink?.invalidate()
        displayLink = CADisplayLink(target: self, selector:#selector(handleDisplayLink(_:)))
        displayLink?.add(to: .current, forMode: .common)
    }
    
    /// Unsubscribe from sreen refrashing events
    private func stopDisplayLink() {
        displayLink?.invalidate()
        displayLink = nil
    }
    
    /// Handle display link timer to update graphics each frame
    ///
    /// - Parameter displayLink: The display link.
    @objc
    func handleDisplayLink(_ displayLink: CADisplayLink) {
        t -= rotationSpeed
        
        dotPairs = []
        
        let step = 2 * .pi / CGFloat(numberOfPoints)
        
        for i in 0..<numberOfPoints {
            let curStep = step * CGFloat(i)
            let a = circularWave(a: amplitude, c: center, r: guideRadius, t: t, step: curStep, n: numberOfPeriods)
            let b = circularWave(a: amplitude, c: center, r: guideRadius, t: t, shift: .pi, step: curStep, n: numberOfPeriods)
            dotPairs.append((a, b))
        }
        
        setNeedsDisplay()
    }
    
    
    
    /// Draws the receiver’s image within the passed-in rectangle.
    ///
    /// - Parameter rect: The portion of the view’s bounds that needs to be updated
    override func draw(_ rect: CGRect) {
        guard let ctx = UIGraphicsGetCurrentContext() else {
            return
        }
        
        for i in 0..<dotPairs.count {
            Draw.drawLine(in: ctx, from: dotPairs[i].0, to: dotPairs[i].1)
            Draw.drawDot(in: ctx, at: dotPairs[i].0)
            Draw.drawDot(in: ctx, at: dotPairs[i].1)
        }
    }
}

// Prepare view
let view = CircularDNA()
view.frame.size = CGSize(width: 500, height: 500) // View size

// Present live view
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = view
