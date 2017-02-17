//
//  Crypt.swift
//  Pods
//
//  Created by Victor Lesk on 21/12/2015.
//
//

import Foundation

open class Crypt {
    open class func encryptWithKey(_ key:String, plainText:String)->String?{

        var keyBytes   = [UInt8]();
        var plainBytes = [UInt8]();
        
        keyBytes   += key.utf8;
        plainBytes += plainText.utf8;
        
        let keylen   = keyBytes.count;
        let plainlen = plainBytes.count;
        
        var cipherByteData = [UInt8](repeating: 0, count: plainlen);
        
        for i in 0..<plainlen{
            let ptChar = plainBytes[i];
            
            let j:Int = i % keylen;
            
            let keyChar =  keyBytes[j];
            
            let cipherChar = ((((ptChar - 37) + (keyChar - 37 )) % 90 ) + 37 );
            
            cipherByteData[i] = cipherChar;
        }

        let cipherText = String(bytes: cipherByteData, encoding: String.Encoding.utf8);
        
        return cipherText;
    }

    open class func decryptWithKey(_ key:String, cipherText:String)->String?{

        var keyBytes    = [UInt8]();
        var cipherBytes = [UInt8]();
        
        keyBytes    += key.utf8;
        cipherBytes += cipherText.utf8;
        
        let keylen    = keyBytes.count;
        let cipherlen = cipherBytes.count;

        var plainByteData = [UInt8](repeating: 0, count: cipherlen);
        
        for i in 0..<cipherlen{
            let ctChar = cipherBytes[i];
            
            let j:Int = i % keylen;
            
            let keyChar =  keyBytes[j];
            
            let plainChar = (((90 + (ctChar - 37) - (keyChar - 37 )) % 90 ) + 37 );
            
            plainByteData[i] = plainChar;
        }

        let plainText = String(bytes: plainByteData, encoding: String.Encoding.utf8);
        
        return plainText;
    }
}
