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
//        let height: CGFloat = imageView.intrinsicContentSize.height + titleLabel.intrinsicContentSize.height  + altTextLabel.intrinsicContentSize.height
        let height: CGFloat = imageView.intrinsicContentSize.height
        return CGSize(width: width, height: height)
    }

    private func setupLayout() {
//        altTextContainer.addSubview(altTextLabel)
//        altTextLabel.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            NSLayoutConstraint(item: altTextLabel, attribute: .leading, relatedBy: .equal, toItem: altTextContainer, attribute: .leading, multiplier: 1.0, constant: 0.0),
//            NSLayoutConstraint(item: altTextLabel, attribute: .trailing, relatedBy: .equal, toItem: altTextContainer, attribute: .trailing, multiplier: 1.0, constant: 0.0),
//            NSLayoutConstraint(item: altTextLabel, attribute: .top, relatedBy: .equal, toItem: altTextContainer, attribute: .top, multiplier: 1.0, constant: 0.0),
//            NSLayoutConstraint(item: altTextLabel, attribute: .bottom, relatedBy: .equal, toItem: altTextContainer, attribute: .bottom, multiplier: 1.0, constant: 0.0)
//        ])
//
//        [dateLabel, titleLabel].forEach(infoStackView.addArrangedSubview)
//        [infoStackView, altTextContainer].forEach(headerStackView.addArrangedSubview)
//
//        verticalStackView.addArrangedSubview(imageView)
//        addSubview(verticalStackView)
//
//        dateLabel.setContentHuggingPriority(.required, for: .horizontal)
//
//        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            NSLayoutConstraint(item: verticalStackView, attribute: .leading, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: 5.0),
//            NSLayoutConstraint(item: verticalStackView, attribute: .trailing, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .trailing, multiplier: 1.0, constant: -5.0),
//            NSLayoutConstraint(item: verticalStackView, attribute: .top, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: 0.0),
//            NSLayoutConstraint(item: verticalStackView, attribute: .bottom, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 0.0)
//        ])
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: imageView, attribute: .leading, relatedBy: .equal, toItem: imageView.superview, attribute: .leading, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: imageView, attribute: .trailing, relatedBy: .equal, toItem: imageView.superview, attribute: .trailing, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: imageView.superview, attribute: .top, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: imageView, attribute: .bottom, relatedBy: .equal, toItem: imageView.superview, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        ])
    }

    func expand() {
//        verticalStackView.arrangedSubviews.forEach {
//            verticalStackView.removeArrangedSubview($0)
//            $0.removeFromSuperview()
//        }
//        [headerStackView, imageView].forEach(verticalStackView.addArrangedSubview)
    }

    func collapse() {
//        verticalStackView.arrangedSubviews.forEach {
//            verticalStackView.removeArrangedSubview($0)
//            $0.removeFromSuperview()
//        }
//        verticalStackView.addArrangedSubview(imageView)
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
