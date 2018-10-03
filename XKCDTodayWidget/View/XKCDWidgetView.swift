import UIKit

class XKCDWidgetView: UIView {

    init() {
        super.init(frame: .zero)
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) { return nil }

    // MARK: Subviews

    let dateLabel = Factory.dateLabel()
    let titleLabel = Factory.titleLabel()
    let altTextLabel = Factory.altTextLabel()
    let imageView = Factory.imageView()
    private let altTextContainer = UIView(frame: .zero)
    private let infoStackView = Factory.infoStackView()
    private let headerStackView = Factory.headerStackView()
    private let verticalStackView = Factory.verticalStackView()

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
        static func dateLabel() -> UILabel {
            let label = UILabel(frame: .zero)
            label.font = UIFont.init(name: "AmericanTypewriter", size: 11.0)
//            label.layer.borderColor = UIColor.red.cgColor
//            label.layer.borderWidth = 1.0
            return label
        }

        static func titleLabel() -> UILabel {
            let label = UILabel(frame: .zero)
            label.font = UIFont.init(name: "AmericanTypewriter", size: 14.0)
            label.textAlignment = .center
//            label.layer.borderColor = UIColor.red.cgColor
//            label.layer.borderWidth = 1.0
            return label
        }

        static func altTextLabel() -> UILabel {
            let label = UILabel(frame: .zero)
            label.font = UIFont.init(name: "AmericanTypewriter", size: 14.0)
            label.lineBreakMode = .byWordWrapping
            label.numberOfLines = 0
//            label.layer.borderColor = UIColor.red.cgColor
//            label.layer.borderWidth = 1.0
            return label
        }

        static func imageView() -> UIImageView {
            let imageView = UIImageView(frame: .zero)
            imageView.contentMode = .scaleAspectFit
//            imageView.layer.borderColor = UIColor.red.cgColor
//            imageView.layer.borderWidth = 1.0
            return imageView
        }

        static func infoStackView() -> UIStackView {
            let stackView = UIStackView(frame: .zero)
            stackView.distribution = .fillProportionally
            stackView.axis = .horizontal
            stackView.spacing = 5.0
            return stackView
        }

        static func headerStackView() -> UIStackView {
            let stackView = UIStackView(frame: .zero)
            stackView.axis = .vertical
            return stackView
        }

        static func verticalStackView() -> UIStackView {
            let stackView = UIStackView(frame: .zero)
            stackView.axis = .vertical
            stackView.spacing = 5.0
            stackView.distribution = .fillProportionally
            return stackView
        }
    }
}
