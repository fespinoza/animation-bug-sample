import UIKit

public class GradientImageView: UIImageView {
  public var gradientColors: [UIColor] = [] {
    didSet {
      self.updateGradientLayer()
    }
  }

  public var gradientLocations: [Float] = [] {
    didSet {
      self.updateGradientLayer()
    }
  }

  private var gradientLayer = CAGradientLayer()

  public override init(frame: CGRect) {
    super.init(frame: frame)
    self.setup()
  }

  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.setup()
  }

  public override init(image: UIImage?) {
    super.init(image: image)
    self.setup()
  }

  public override init(image: UIImage?, highlightedImage: UIImage?) {
    super.init(image: image, highlightedImage: highlightedImage)
    self.setup()
  }

  public override func layoutSubviews() {
    super.layoutSubviews()
    self.gradientLayer.frame = self.layer.bounds
  }

  private func setup() {
    self.contentMode = .scaleAspectFill
    setupGradientLayer()
  }

  private func setupGradientLayer() {
    self.gradientLayer.frame = self.layer.bounds
    self.layer.addSublayer(self.gradientLayer)
  }

  private func updateGradientLayer() {
    self.gradientLayer.colors = self.gradientColors.map { $0.cgColor }
    self.gradientLayer.locations = self.gradientLocations.map { NSNumber(value: $0) }
  }

  static func tabBackgroundImageView() -> GradientImageView {
    let backgroundImageView = GradientImageView()
    configureForTabBackground(backgroundImageView)

    return backgroundImageView
  }

  static func configureForTabBackground(_ gradientImageView: GradientImageView) {
    gradientImageView.translatesAutoresizingMaskIntoConstraints = false
    gradientImageView.gradientColors = [
      UIColor.black.withAlphaComponent(0.2),
      .clear,
      .clear,
      UIColor.black.withAlphaComponent(0.9),
    ]
    gradientImageView.gradientLocations = [0, 0.21, 0.5, 1]
  }
}
