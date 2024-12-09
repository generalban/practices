//
//  UIImage+Extensions.swift
//  PokemonContacts
//
//  Created by 반성준 on 12/9/24.
//

import UIKit

extension UIImage {
    /// Resizes the image to the specified width while maintaining the aspect ratio.
    func resized(toWidth width: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }

    /// Converts a base64 string to UIImage.
    static func fromBase64(_ base64String: String) -> UIImage? {
        guard let data = Data(base64Encoded: base64String) else { return nil }
        return UIImage(data: data)
    }

    /// Converts UIImage to a base64 string.
    func toBase64() -> String? {
        return self.jpegData(compressionQuality: 0.8)?.base64EncodedString()
    }
}
