import UIKit

public protocol ImageSwappingLogicDelegate: class {
  func transitionImages(fromIndex: Int, toIndex: Int)
  func animateImages(withFragmentCompletion: CGFloat)
  func areImagesEqual(fromIndex: Int, toIndex: Int) -> Bool
}

/// Given the story tabs with multiple tabs, this class implements the logic of the image transition between the tab
/// images according to the scroll
public class ImageSwappingLogic {
  public weak var delegate: ImageSwappingLogicDelegate?

  private let numberOfElements: Int
  private let intervalLength: CGFloat
  private var lastPercentageValue: CGFloat = 0.0

  public init(numberOfElements: Int) {
    precondition(numberOfElements > 0, "This should be more than 0")
    self.numberOfElements = numberOfElements
    self.intervalLength = 1 / CGFloat(numberOfElements)
  }

  public func transitionImages(forScrollPercentage percentage: CGFloat) {
    let lastIndexes = indexInterval(forPercentage: self.lastPercentageValue)
    let newIndexes = indexInterval(forPercentage: percentage)

    if newIndexes != lastIndexes && lastIndexes.min != lastIndexes.max && newIndexes.min != newIndexes.max {
      delegate?.transitionImages(fromIndex: newIndexes.min, toIndex: newIndexes.max)
    }

    let areImagesEqual = self.delegate?.areImagesEqual(fromIndex: newIndexes.min, toIndex: newIndexes.max) ?? false
    if newIndexes.min != newIndexes.max && !areImagesEqual {
      let fragmentCompletion = self.animationCompletion(forScrollPercentage: percentage)
      delegate?.animateImages(withFragmentCompletion: fragmentCompletion)
    }

    self.lastPercentageValue = percentage
  }

  public func animationCompletion(forScrollPercentage percentage: CGFloat) -> CGFloat {
    var fractionComplete: CGFloat = 0.0
    let newIndexes = indexInterval(forPercentage: percentage)

    fractionComplete = percentage / self.intervalLength - CGFloat(newIndexes.min)

    assert(fractionComplete >= 0 && fractionComplete <= 1.0)

    return fractionComplete
  }

  private func indexInterval(forPercentage percentage: CGFloat) -> (min: Int, max: Int) {
    let range = (0..<numberOfElements)

    let minIndex = range.filter({ CGFloat($0) * self.intervalLength <= percentage }).last ?? 0
    let maxIndex = range.filter({ CGFloat($0) * self.intervalLength > percentage }).first ?? numberOfElements - 1

    return (min: minIndex, max: maxIndex)
  }
}

