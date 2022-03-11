//
//  Utils.swift
//  MARVEL_app
//
//  Created by Daniel Abad Jaraute on 10/03/2022.
//

import Foundation
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG

class Utils{
    
    enum MARVEL_COLORS: Int {
        case RED = 0xd41212
        case BLUE = 0x2A75B3
        case LIGHT_BLUE = 0x50c6ff
        case YELLOW = 0xfbc623
        case LIGHT_YELLOW = 0xfeff79
    }
    
    static func MD5(string: String) -> String {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        let messageData = string.data(using:.utf8)!
        var digestData = Data(count: length)

        _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
            messageData.withUnsafeBytes { messageBytes -> UInt8 in
                if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                    let messageLength = CC_LONG(messageData.count)
                    CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                }
                return 0
            }
        }
        let md5Hex = digestData.map { String(format: "%02hhx", $0) }.joined()
        
        return md5Hex;
    }
}
