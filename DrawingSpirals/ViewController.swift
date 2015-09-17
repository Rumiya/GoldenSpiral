//
//  ViewController.swift
//  DrawingSpirals
//
//  Created by Rumiya Murtazina on 9/16/15.
//  Copyright (c) 2015 abearablecode. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let spiralShape1 = CAShapeLayer()
    let spiralShape2 = CAShapeLayer()
    let π = CGFloat(M_PI)
    var bounds = CGRect()
    var center = CGPoint()
    var radius = CGFloat()

    override func viewDidLoad() {
        super.viewDidLoad()

        bounds = view.bounds

        clockwiseSpiral()
        counterclockwiseSpiral()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Setup the clockwise spiral settings
    func clockwiseSpiral(){

        var startAngle:CGFloat = 3*π/2
        var endAngle:CGFloat = 0

        center = CGPoint(x:bounds.width/3, y: bounds.height/3)

        // Setup the initial radius
        radius = bounds.width/90

        // Use UIBezierPath to create the CGPath for the layer
        // The path should be the entire spiral

        // 1st arc
        let linePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)

        // 2 - 9 arcs
        for i in 2..<10 {

            startAngle = endAngle

            switch startAngle {
            case 0, 2*π:
                center = CGPoint(x: center.x - radius/2, y: center.y)
                endAngle = π/2
            case π:
                center = CGPoint(x: center.x + radius/2, y: center.y)
                endAngle = 3*π/2
            case π/2:
                center = CGPoint(x: center.x  , y: center.y - radius/2)
                endAngle = π
            case 3*π/2:
                center = CGPoint(x: center.x, y: center.y + radius/2)
                endAngle = 2*π
            default:
                center = CGPoint(x:bounds.width/3, y: bounds.height/3)
            }

            radius = 1.5 * radius
            linePath.addArcWithCenter(center, radius: radius, startAngle: startAngle, endAngle: endAngle,clockwise: true)
        }

        // Setup the CAShapeLayer with the path, line width and stroke color
        spiralShape1.position = center
        spiralShape1.path = linePath.CGPath
        spiralShape1.lineWidth = 6.0
        spiralShape1.strokeColor = UIColor.yellowColor().CGColor
        spiralShape1.bounds = CGPathGetBoundingBox(spiralShape1.path)
        spiralShape1.fillColor = UIColor.clearColor().CGColor

        // Add the CAShapeLayer to the view's layer's sublayers
        view.layer.addSublayer(spiralShape1)

        // Animate drawing
        drawLayerAnimation(spiralShape1)

    }

    // Setup the ounterclockwise spiral settings
    func counterclockwiseSpiral(){

        var startAngle:CGFloat = 3*π/2
        var endAngle:CGFloat = π

        center = CGPoint(x:bounds.width/3 + bounds.width/3, y: bounds.height/3)

        // Setup the initial radius
        radius = bounds.width/90

        // Use UIBezierPath to create the CGPath for the layer
        // The path should be the entire spiral

        // 1st arc
        let linePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)

        // 2 - 9 arcs
        for i in 2..<10 {

            startAngle = endAngle

            switch startAngle {
            case 0:
                center = CGPoint(x: center.x - radius/2, y: center.y)
                endAngle = 3*π/2
            case π:
                center = CGPoint(x: center.x + radius/2, y: center.y)
                endAngle = π/2
            case π/2:
                center = CGPoint(x: center.x , y: center.y - radius/2)
                endAngle = 0
            case 3*π/2:
                center = CGPoint(x: center.x, y: center.y + radius/2)
                endAngle = π
            default:
                center = CGPoint(x:bounds.width/3 + bounds.width/3, y: bounds.height/3)
            }

            radius = 1.5 * radius
            linePath.addArcWithCenter(center, radius: radius, startAngle: startAngle, endAngle: endAngle,clockwise: false)
        }

        // Setup the CAShapeLayer with the position, path, line width and stroke color
        spiralShape2.position = center
        spiralShape2.path = linePath.CGPath
        spiralShape2.lineWidth = 6.0
        spiralShape2.strokeColor = UIColor(red:0.99, green:0.57, blue:0.18, alpha:1.0).CGColor
        spiralShape2.bounds = CGPathGetBoundingBox(spiralShape2.path)
        spiralShape2.fillColor = UIColor.clearColor().CGColor

        // Add the CAShapeLayer to the view's layer's sublayers
        view.layer.addSublayer(spiralShape2)

        // Animate drawing
        drawLayerAnimation(spiralShape2)

    }

    func drawLayerAnimation(layer: CAShapeLayer!){

        var layerShape = layer

        // The starting point
        layerShape.strokeStart = 0.0

        // Don't draw the spiral initially
        layerShape.strokeEnd = 0.0

        // Animate from 0 (no spiral stroke) to 1 (full spiral path)
        var drawAnimation: CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        drawAnimation.fromValue = 0.0
        drawAnimation.toValue = 1.0
        drawAnimation.duration = 1.6
        drawAnimation.fillMode = kCAFillModeForwards
        drawAnimation.removedOnCompletion = false
        layerShape.addAnimation(drawAnimation, forKey: nil)

    }
}

