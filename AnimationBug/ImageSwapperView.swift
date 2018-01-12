import UIKit

public class ImageSwapperView: UIView {
  // MARK: - Public Vars
  public var fractionComplete: CGFloat = 0.0 {
    didSet {
      self.animator?.fractionComplete = fractionComplete
      if let animator = self.animator {
        print(animator.state, animator.debugDescription, animator.fractionComplete)
        print(
          self.foregroundImageView.layer.presentation()?.opacity,
          self.backgroundImageView.layer.presentation()?.opacity
        )
      }
    }
  }
  public var delta: CGFloat = 0.0 {
    didSet {
      prepareAnimation()
    }
  }
  public var foregroundImage: UIImage? {
    didSet {
      self.foregroundImageView.image = foregroundImage
    }
  }
  public var backgroundImage: UIImage? {
    didSet {
      self.backgroundImageView.image = backgroundImage
    }
  }

  /// represents if the swapping is happening or not
  public var isActive: Bool = false

  public let foregroundImageView = GradientImageView.tabBackgroundImageView()
  public let backgroundImageView = GradientImageView.tabBackgroundImageView()

  // MARK: - Private variables
  private var animator: UIViewPropertyAnimator?

  // MARK: - Initializers
  public override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

  // MARK: - Public functions
  public func clearImages() {
    self.foregroundImage = nil
    self.backgroundImage = nil
  }

  var observation1: NSKeyValueObservation?
  var observation2: NSKeyValueObservation?

  // MARK: - Private functions
  private func setup() {
    configure(imageView: backgroundImageView)
    configure(imageView: foregroundImageView)
    prepareAnimation()

    //    observation1 = foregroundImageView.observe(\GradientImageView.image, changeHandler: { (_, change) in
    //      print("foreground image view changed \(change)")
    //    })
    //
    //    observation2 = backgroundImageView.observe(\GradientImageView.image, changeHandler: { (_, change) in
    //      print("background image view changed \(change)")
    //    })
  }

  private func configure(imageView: UIImageView) {
    self.addSubview(imageView)

    NSLayoutConstraint.activate([
      imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.2),
      imageView.heightAnchor.constraint(equalTo: self.heightAnchor),
      imageView.topAnchor.constraint(equalTo: self.topAnchor),
      imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      ])
  }

  public func cleanup() {
    print(">>>>>>", #function)
    self.foregroundImageView.alpha = 1.0
    self.foregroundImageView.transform = CGAffineTransform.identity

    self.backgroundImageView.alpha = 0.0
    self.backgroundImageView.transform = CGAffineTransform(translationX: delta, y: 0)
  }

  public func prepareAnimation() {
    print(#function)
    backgroundImageView.alpha = 0.0
    backgroundImageView.transform = CGAffineTransform(translationX: delta, y: 0)

    if let animator = animator {
      animator.stopAnimation(true)
    }

    animator = UIViewPropertyAnimator(duration: 0.5, curve: .linear, animations: { [unowned self] in
      self.foregroundImageView.alpha = 0.0
      self.backgroundImageView.alpha = 1.0
      self.foregroundImageView.transform = CGAffineTransform(translationX: -self.delta, y: 0)
      self.backgroundImageView.transform = CGAffineTransform.identity
    })

    // wont be executed because `pausesOnCompletion` is true
    animator?.addCompletion({ [weak self] (position) in
      print("""
        >>>>>>>>>>>>>>> \
        finish animation at position \(position) of \(self?.foregroundImage?.description ?? "") and \
        \(self?.backgroundImage?.description ?? "")
        """
      )
    })
    if #available(iOS 11.0, *) {
      animator?.pausesOnCompletion = true
    } else {
      // Fallback on earlier versions
    }
    //    animator?.pauseAnimation()
  }
}
