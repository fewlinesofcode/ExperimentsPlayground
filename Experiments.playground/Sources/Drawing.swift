//
//  Drawing.swift
//  MarchingSquares
//
//  Created by Oleksandr Glagoliev on 1/16/19.
//  Copyright © 2019 Oleksandr Glagoliev. All rights reserved.
//

import UIKit

// MARK: - Set of not-efficient drawing helpers -
// TODO: Rewrite
public struct Draw {
    public static func drawDot(in context: CGContext, at location: CGPoint, color: UIColor = .black) {
        let dot = UIBezierPath(
            arcCenter: location,
            radius: 2, startAngle: 0,
            endAngle: .pi * 2,
            clockwise: true
        )

        context.saveGState()
        color.setFill()

        context.addPath(dot.cgPath)
        context.fillPath()

        context.restoreGState()
    }

    public static func drawLine(in context: CGContext, from: CGPoint, to: CGPoint, color: UIColor = .lightGray) {
        context.saveGState()
        context.setLineWidth(1)
        context.setLineCap(.round)
        color.setStroke()
        context.move(to: from)
        context.addLine(to: to)
        context.strokePath()
        context.restoreGState()
    }
}
