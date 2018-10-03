import UIKit
import NotificationCenter
import Networking

@objc (TodayViewController)

class TodayViewController: UIViewController, NCWidgetProviding {

    let minSize = CGSize(width: 320, height: 50)

    // MARK: Dependecies

    private let apiClient = XKCDApiClient()

    // MARK: Lifecycle
        
    override func viewDidLoad() {
        super.viewDidLoad()
        extensionContext?.widgetLargestAvailableDisplayMode = .expanded
    }

    override func loadView() {
        let view = XKCDWidgetView()
        self.view = view
    }

    // MARK: View

    private var xkcdWidgetView: XKCDWidgetView! {
        return view as? XKCDWidgetView
    }

    // MARK: Privates

    private var currentImgLink: String?

    private func updateInfo(with info: XKCDInfo) {
        xkcdWidgetView.titleLabel.text = info.title
        currentImgLink = info.img
    }

    private func updateComic(_ image: UIImage) {
        xkcdWidgetView.imageView.image = image
    }

    // MARK: NCWidgetProviding

    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        apiClient.getComic { [weak self] result in
            switch result {
            case .error: completionHandler(.failed)
            case .success(let comic):
                if self?.currentImgLink != comic.info.img {
                    self?.updateInfo(with: comic.info)
                    self?.updateComic(comic.comicImage)
                    completionHandler(.newData)
                } else {
                    completionHandler(.noData)
                }
            }
        }
    }

    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        let expanded = activeDisplayMode == .expanded
        if expanded {
            preferredContentSize = CGSize(
                width: maxSize.width,
                height: fmin(xkcdWidgetView.intrinsicContentSize.height, maxSize.height)
            )
        } else {
            preferredContentSize = maxSize
        }
    }

}
