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
    let imageView = Factory.imageView()
    private let infoStackView = Factory.infoStackView()
    private let verticalStackView = Factory.verticalStackView()

    // MARK: Layout

    private func setupLayout() {
        [dateLabel, titleLabel].forEach(infoStackView.addArrangedSubview)
        [infoStackView, imageView].forEach(verticalStackView.addArrangedSubview)
        addSubview(verticalStackView)

        dateLabel.setContentHuggingPriority(.required, for: .horizontal)

        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: verticalStackView, attribute: .leading, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: verticalStackView, attribute: .trailing, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .trailing, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: verticalStackView, attribute: .top, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: verticalStackView, attribute: .bottom, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        ])
    }

}

private extension XKCDWidgetView {
    struct Factory {
        static func dateLabel() -> UILabel {
            let label = UILabel(frame: .zero)
            label.text = "DATE"
            label.layer.borderColor = UIColor.red.cgColor
            label.layer.borderWidth = 1.0
            return label
        }

        static func titleLabel() -> UILabel {
            let label = UILabel(frame: .zero)
            label.text = "TiTLE"
            label.layer.borderColor = UIColor.green.cgColor
            label.layer.borderWidth = 1.0
            return label
        }

        static func infoStackView() -> UIStackView {
            let stackView = UIStackView(frame: .zero)
            stackView.distribution = .fillProportionally
            stackView.axis = .horizontal
            return stackView
        }

        static func imageView() -> UIImageView {
            let imageView = UIImageView(frame: .zero)
            imageView.image = #imageLiteral(resourceName: "imageimage")
            imageView.contentMode = .scaleAspectFit
            return imageView
        }

        static func verticalStackView() -> UIStackView {
            let stackView = UIStackView(frame: .zero)
            stackView.axis = .vertical
            return stackView
        }
    }
}
