//
//  ViewController.swift
//  Example
//
//  Updated by Boking on 5/9/22.
//  Copyright © 2017 efremidze. All rights reserved.
//

import SpriteKit
import Magnetic

class ViewController: UIViewController {
    
    @IBOutlet weak var magneticView: MagneticView! {
        didSet {
            magnetic.magneticDelegate = self
            magnetic.removeNodeOnLongPress = true
            #if DEBUG
            magneticView.showsFPS = true
            magneticView.showsDrawCount = true
            magneticView.showsQuadCount = true
            magneticView.showsPhysics = true
            #endif
        }
    }
    
    var magnetic: Magnetic {
        return magneticView.magnetic
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        for _ in 0..<3 {
            add(nil)
        }
    }
    
    @IBAction func add(_ sender: UIControl?) {
        let name = UIImage.names.randomItem()
        let color = UIColor.colors.randomItem()
        let value = CGFloat(round(Double.random(in: 10.0 ... 100.0) * 10.0) / 10.0)
        let node = Node(value: value, title: name.capitalized, surfix: "%", color: color, radius: 40)
        node.value = value
        node.icon = UIImage(named: name)
        node.iconSize = 50
        node.scaleToFitContent = true
        node.selectedColor = UIColor.colors.randomItem()
        magnetic.addChild(node)
        
        // Image Node: image displayed by default
        // let node = ImageNode(text: name.capitalized, image: UIImage(named: name), color: color, radius: 40)
        // magnetic.addChild(node)
    }
    
//    @IBAction func reset(_ sender: UIControl?) {
//        magneticView.magnetic.reset()
//    }
    
}

// MARK: - MagneticDelegate
extension ViewController: MagneticDelegate {
    
    func magnetic(_ magnetic: Magnetic, didSelect node: Node) {
        print("didSelect -> \(node)")
    }
    
    func magnetic(_ magnetic: Magnetic, didDeselect node: Node) {
        print("didDeselect -> \(node)")
    }
    
    func magnetic(_ magnetic: Magnetic, didRemove node: Node) {
        print("didRemove -> \(node)")
    }
    
}

// MARK: - ImageNode
class ImageNode: Node {
    override var image: UIImage? {
        didSet {
            texture = image.map { SKTexture(image: $0) }
        }
    }
    override func selectedAnimation() {}
    override func deselectedAnimation() {}
}
