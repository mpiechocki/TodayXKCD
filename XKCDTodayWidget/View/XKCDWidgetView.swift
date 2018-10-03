import UIKit

class XKCDWidgetView: UIView {

    init() {
        super.init(frame: .zero)
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) { return nil }

    // MARK: Subviews

    let titleLabel = Factory.titleLabel()
    let imageView = Factory.imageView()

    // MARK: Layout

    override var intrinsicContentSize: CGSize {
        let width: CGFloat = 320
        let height: CGFloat = imageView.intrinsicContentSize.height + titleLabel.intrinsicContentSize.height
        return CGSize(width: width, height: height)
    }

    private func setupLayout() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 5.0),
            NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -5.0),
            NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0)
        ])

        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: imageView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 5.0),
            NSLayoutConstraint(item: imageView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -5.0),
            NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1.0, constant: 1.0),
            NSLayoutConstraint(item: imageView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        ])
    }

}

private extension XKCDWidgetView {
    struct Factory {
        static func titleLabel() -> UILabel {
            let label = UILabel(frame: .zero)
            label.font = UIFont.init(name: "AmericanTypewriter", size: 14.0)
            label.textAlignment = .center
            return label
        }

        static func imageView() -> UIImageView {
            let imageView = UIImageView(frame: .zero)
            imageView.contentMode = .scaleAspectFit
            return imageView
        }
    }
}
