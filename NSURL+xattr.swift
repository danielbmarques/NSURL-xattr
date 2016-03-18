//
//  NSURL+xattr.swift
//
//  Created by Daniel Marques on 18/03/16.
//  Copyright © 2016 Daniel Ballester Marques. All rights reserved.
//

import Foundation

extension NSURL {

    func setAttribute(name: String, value: String) {
        let data = value.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
        setxattr(self.path!, name, data.bytes, data.length, 0, 0)
    }

    func removeAttribute(name: String) {
        removexattr(self.path!, name, 0)
        return
    }

    func getAttribute(name: String) -> String? {
        let length = getxattr(self.path!, name, nil, 0, 0, 0)
        if length == -1 {
            return nil
        }
        let bytes = malloc(length)
        if getxattr(self.path!, name, bytes, length, 0, 0) == -1 {
            return nil
        }
        return (String(data: NSData(bytes: bytes, length: length),
            encoding: NSUTF8StringEncoding))
    }

    func attributes() -> [String : String?]? {
        let length = listxattr(self.path!, nil, 0, 0)
        if length == -1 {
            return nil
        }
        let bytes = UnsafeMutablePointer<Int8>(malloc(length))
        if listxattr(self.path!, bytes, length, 0) == -1 {
            return nil
        }
        if var names = NSString(bytes: bytes, length: length,
            encoding: NSUTF8StringEncoding)?.componentsSeparatedByString("\0") {
                names.removeLast()
                var attributes: [String : String?] = [:]
                for name in names {
                    attributes[name] = getAttribute(name)
                }
                return attributes
        }
        return nil
    }

}
