//
//  SuperCell.swift
//  AnimationBug
//
//  Created by Felipe Espinoza on 11/01/2018.
//  Copyright © 2018 Felipe Espinoza. All rights reserved.
//

import UIKit

class SuperCell: UITableViewCell {
  @IBOutlet weak var imageSwapperView: ImageSwapperView!
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var pageControl: UIPageControl!
  @IBOutlet weak var percentageLabel: UILabel!

  lazy var numberFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.maximumFractionDigits = 2
    return formatter
  }()

  var story: Story! {
    didSet {
      self.logic = ImageSwappingLogic(numberOfElements: story.tabs.count)
      self.logic.delegate = self

      let width = self.contentView.frame.width * CGFloat(story.tabs.count)
      self.scrollView.contentSize = CGSize(width: width, height: self.contentView.frame.height)

      pageControl.numberOfPages = story.tabs.count
      pageControl.currentPage = 0

//      self.imageSwapperView.prepareAnimation()
    }
  }
  var logic: ImageSwappingLogic!

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code

    scrollView.delegate = self
    scrollView.isPagingEnabled = true

    imageSwapperView.delta = 0.1 * self.contentView.frame.width
  }

  override func prepareForReuse() {
    imageSwapperView.cleanup()
    scrollView.setContentOffset(.zero, animated: false)

    super.prepareForReuse()
  }
}

extension SuperCell: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let horizontalPercentage: CGFloat = scrollView.contentOffset.x / scrollView.contentSize.width
    logic.transitionImages(forScrollPercentage: horizontalPercentage)

    let pageWidth = scrollView.bounds.width
    let pageFraction = scrollView.contentOffset.x / pageWidth

    pageControl.currentPage = Int(round(pageFraction))
  }
}

extension SuperCell: ImageSwappingLogicDelegate {
  func transitionImages(fromIndex: Int, toIndex: Int) {
    print(#function, fromIndex, toIndex)

    self.imageSwapperView.foregroundImage = story.tabs[fromIndex].background
    self.imageSwapperView.backgroundImage = story.tabs[toIndex].background
  }

  func animateImages(withFragmentCompletion percentage: CGFloat) {
    self.imageSwapperView.fractionComplete = percentage
    self.percentageLabel.text = numberFormatter.string(for: percentage * 100.0)
  }

  func areImagesEqual(fromIndex: Int, toIndex: Int) -> Bool {
    return false
  }
}
