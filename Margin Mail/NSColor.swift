//
//  NSColor.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/15/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

extension NSColor {

    // Polar version of CIELUV color space
    convenience init(hue h: CGFloat, chroma c: CGFloat, lightness l: CGFloat, alpha: CGFloat = 1) {
        let hRad = h * 2 * Util.π
        let u = cos(hRad) * c * 100
        let v = sin(hRad) * c * 100
        let (x, y, z) = Util.luvToXyz(l * 100, u, v)
        let (r, g, b) = Util.xyzToRgb(x, y, z)
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }

    // “HUSL”, i.e. same as Polar CIELUV but with a normalized chroma/saturation scale (see husl-colors.org)
    convenience init(hue h: CGFloat, saturation s: CGFloat, lightness l: CGFloat, alpha: CGFloat = 1) {
        if l > 0.999999999 {
            self.init(hue: h, chroma: 0, lightness: 1, alpha: alpha)
        } else if l <  0.0000000001 {
            self.init(hue: h, chroma: 0, lightness: 0, alpha: alpha)
        } else {
            let max = Util.maxChromaForLH(l, h)
            self.init(hue: h, chroma: max * s, lightness: l, alpha: alpha)
        }
    }
    
    struct Util {
        
        static let π = CGFloat(M_PI)
        static let refY = 1.0 as CGFloat
        static let refU = 0.19783000664283 as CGFloat
        static let refV = 0.46831999493879 as CGFloat
        static let kappa = 903.2962962 as CGFloat
        static let epsilon = 0.0088564516 as CGFloat
        static let mR = (3.240969941904521, -1.537383177570093, -0.498610760293) as (CGFloat, CGFloat, CGFloat)
        static let mG = (-0.96924363628087, 1.87596750150772, 0.041555057407175) as (CGFloat, CGFloat, CGFloat)
        static let mB = (0.055630079696993, -0.20397695888897, 1.056971514242878) as (CGFloat, CGFloat, CGFloat)
        
        static func product(a: (CGFloat, CGFloat, CGFloat), _ b: (CGFloat, CGFloat, CGFloat)) -> CGFloat {
            return a.0 * b.0 + a.1 * b.1 + a.2 * b.2
        }
        
        static func fromLinear(c: CGFloat) -> CGFloat {
            if c <= 0.0031308 {
                return 12.92 * c
            } else {
                return 1.055 * pow(c, 1 / 2.4) - 0.055
            }
        }
        
        static func lToY(l: CGFloat) -> CGFloat {
            if l <= 8 {
                return refY * l / kappa
            } else {
                return refY * pow((l + 16) / 116, 3)
            }
        }
        
        static func luvToXyz(l: CGFloat, _ u: CGFloat, _ v: CGFloat) -> (CGFloat, CGFloat, CGFloat) {
            if (l == 0) {
                return (0, 0, 0)
            }
            let varU = u / (13 * l) + refU
            let varV = v / (13 * l) + refV
            let y = lToY(l)
            let x = 0 - (9 * y * varU) / ((varU - 4) * varV - varU * varV)
            let z = (9 * y - (15 * varV * y) - (varV * x)) / (3 * varV)
            return (x, y, z)
        }
        
        static func xyzToRgb(x: CGFloat, _ y: CGFloat, _ z: CGFloat) -> (CGFloat, CGFloat, CGFloat) {
            let r = fromLinear(product(mR, (x, y, z)))
            let g = fromLinear(product(mG, (x, y, z)))
            let b = fromLinear(product(mB, (x, y, z)))
            return (r, g, b)
        }
        
        static func lengthOfRayUntilIntersect(theta: CGFloat, _ line: (m1: CGFloat, b1: CGFloat)) -> CGFloat {
            let len = (line.b1 / (sin(theta) - line.m1 * cos(theta))) as CGFloat
            return len < 0 ? CGFloat.max : len
        }
        
        static func getBounds(l: CGFloat) -> [(CGFloat, CGFloat)] {
            let sub1 = pow(l + 16, 3) / 1560896.0
            let sub2 = sub1 > epsilon ? sub1 : (l / kappa)
            var res: [(CGFloat, CGFloat)] = []
            for channel in [mR, mG, mB] {
                let (m1, m2, m3) = channel
                for t in [CGFloat(0), CGFloat(1)] {
                    let top1 = (284517.0 * m1 - 94839.0 * m3) * sub2
                    let top2a = (838422.0 * m3 + 769860.0 * m2 + 731718 * m1) * l * sub2
                    let top2 = top2a - (769860.0 * t * l)
                    let bottom = (632260.0 * m3 - 126452.0 * m2) * sub2 + 126452.0 * t
                    res.append((CGFloat(top1 / bottom), CGFloat(top2 / bottom)))
                }
            }
            return res
        }
        
        static func maxChromaForLH(l: CGFloat, _ h: CGFloat) -> CGFloat {
            let hRad = h * Util.π * 2
            return getBounds(l).map({ Util.lengthOfRayUntilIntersect(hRad, $0) }).reduce(CGFloat.max, combine: { min($0, $1) })
        }

    }
    
}
