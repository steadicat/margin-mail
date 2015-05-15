//
//  Animation.swift
//  MarginMail
//
//  Created by Stefano J. Attardi on 5/15/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class Animation {

    static func forLayer(layer: CALayer, property: String) -> POPSpringAnimation {
        var anim = layer.pop_animationForKey(property) as! POPSpringAnimation?
        if anim == nil {
            anim = POPSpringAnimation(propertyNamed: property)
            layer.pop_addAnimation(anim, forKey: property)
        }
        return anim!
    }

}
