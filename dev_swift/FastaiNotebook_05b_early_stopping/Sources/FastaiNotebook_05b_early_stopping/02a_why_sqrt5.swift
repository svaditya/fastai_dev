/*
THIS FILE WAS AUTOGENERATED! DO NOT EDIT!
file to edit: 02a_why_sqrt5.ipynb

*/
        
import Foundation
import TensorFlow
import Path

extension Tensor where Scalar: TensorFlowFloatingPoint {
    init(kaimingNormal shape: TensorShape, negativeSlope: Double = 1.0) {
        // Assumes Leaky ReLU nonlinearity
        let gain = Scalar(sqrt(2.0 / (1.0 + pow(negativeSlope, 2))))
        let spatialDimCount = shape.count - 2
        let receptiveField = shape[0..<spatialDimCount].contiguousSize
        let fanIn = shape[shape.count - 2] * receptiveField
        self.init(
            randomNormal: shape,
            stddev: gain / sqrt(Scalar(fanIn)),
            generator: &PhiloxRandomNumberGenerator.global
        )
    }
}

func leakyRelu<T: TensorFlowFloatingPoint>(
    _ x: Tensor<T>,
    negativeSlope: Double = 0.0
) -> Tensor<T> {
    return max(0, x) + T(negativeSlope) * min(0, x)
}

extension Tensor where Scalar: TensorFlowFloatingPoint {
    init(kaimingUniform shape: TensorShape, negativeSlope: Double = 1.0) {
        // Assumes Leaky ReLU nonlinearity
        let gain = Scalar(sqrt(2.0 / (1.0 + pow(negativeSlope, 2))))
        let spatialDimCount = shape.count - 2
        let receptiveField = shape[0..<spatialDimCount].contiguousSize
        let fanIn = shape[shape.count - 2] * receptiveField
        let bound = sqrt(Scalar(3.0)) * gain / sqrt(Scalar(fanIn))
        self = bound * (2 * Tensor(
            randomUniform: shape,
            generator: &PhiloxRandomNumberGenerator.global
        ) - 1)
    }
}