//  Created by Geoff Pado on 3/19/21.
//  Copyright © 2021 Wing Luke Memorial Foundation. All rights reserved.

import UIKit

private struct Pixel {
    let red: CGFloat
    let green: CGFloat
    let blue: CGFloat
    let alpha: CGFloat

    func distance(to pixel: Pixel) -> CGFloat {
        var distance = CGFloat.zero
        distance += abs(self.red - pixel.red)
        distance += abs(self.green - pixel.green)
        distance += abs(self.blue - pixel.blue)
        distance += abs(self.alpha - pixel.alpha)
        return distance
    }

    var color: UIColor {
        UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: alpha / 255)
    }
}

private struct Cluster {
    private(set) var pixels: [Pixel]
    private(set) var center: Pixel

    init(pixel: Pixel) {
        self.pixels = [pixel]
        self.center = pixel
    }

    mutating func add(_ pixel: Pixel) {
        updateCenter(with: pixel)
        pixels.append(pixel)
    }

    var weight: Int {
        return pixels.count
    }

    mutating func updateCenter(with newPixel: Pixel) {
        let weight = CGFloat(pixels.count)
        let red = ((center.red * weight) + newPixel.red) / (weight + 1)
        let green = ((center.green * weight) + newPixel.green) / (weight + 1)
        let blue = ((center.blue * weight) + newPixel.blue) / (weight + 1)
        let alpha = ((center.alpha * weight) + newPixel.alpha) / (weight + 1)

        let newCenter = Pixel(red: red, green: green, blue: blue, alpha: alpha)
        center = newCenter
    }
}

extension UIImage {
    func dominantColor(in rect: CGRect) -> UIColor {
        guard let imageRef = cgImage else { fatalError("Unable to get CGImage for image") }
        let width = imageRef.width
        let height = imageRef.height
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bytesPerPixel = 4
        var rawData = [UInt8](repeating: 0, count: height * width * bytesPerPixel)
        let bytesPerRow = bytesPerPixel * width
        let bitsPerComponent = 8

        let context = CGContext(data: &rawData, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Big.rawValue)
        context?.draw(imageRef, in: CGRect(origin: .zero, size: CGSize(width: width, height: height)))

        let dataCount = height * width * bytesPerPixel
        var clusterArray = [Cluster]()

        var byteIndex = 0
        while byteIndex * Self.inversePrecisionFactor < dataCount {
            let pixel = Pixel(
                red:   CGFloat(rawData[byteIndex + 0]),
                green: CGFloat(rawData[byteIndex + 1]),
                blue:  CGFloat(rawData[byteIndex + 2]),
                alpha: CGFloat(rawData[byteIndex + 3]))

            var clusterIndex = -1
            var closestDistance = CGFloat.greatestFiniteMagnitude

            clusterArray.enumerated().forEach { (index, cluster) in
                let distance = cluster.center.distance(to: pixel)
                if distance < Self.colorThreshold && distance < closestDistance {
                    closestDistance = distance
                    clusterIndex = index
                }
            }

            if clusterIndex >= 0 {
                clusterArray[clusterIndex].add(pixel)
            } else {
                let newCluster = Cluster(pixel: pixel)
                clusterArray.append(newCluster)
            }

            byteIndex += bytesPerPixel * Self.inversePrecisionFactor
        }

        let dominantClusters = clusterArray.sorted { lhs, rhs -> Bool in
            lhs.weight > rhs.weight
        }.prefix(5)

        let dominantColors = dominantClusters.map(\.center.color)
        let brightestColor = dominantColors.sorted { lhs, rhs -> Bool in
            var lhsB = CGFloat.zero
            var rhsB = CGFloat.zero

            lhs.getHue(nil, saturation: nil, brightness: &lhsB, alpha: nil)
            rhs.getHue(nil, saturation: nil, brightness: &rhsB, alpha: nil)

            return lhsB > rhsB
        }


        return brightestColor[0]
    }

    var dominantColor: UIColor {
        let fullRect = CGRect(origin: .zero, size: size)
        return dominantColor(in: fullRect)
    }

    private static let colorThreshold = CGFloat(80)
    private static let inversePrecisionFactor = 32
}
