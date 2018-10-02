import UIKit
import NotificationCenter
import Networking

@objc (TodayViewController)

class TodayViewController: UIViewController, NCWidgetProviding {

    let maxSize = CGSize(width: 320, height: 400)
    let minSize = CGSize(width: 320, height: 50)

    // MARK: Dependecies

    private let apiClient = XKCDApiClient()

    // MARK: Lifecycle
        
    override func viewDidLoad() {
        super.viewDidLoad()
        extensionContext?.widgetLargestAvailableDisplayMode = .expanded
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        update()
    }

    override func loadView() {
        let view = XKCDWidgetView()
        self.view = view
    }

    // MARK: View

    private var xkcdWidgetView: XKCDWidgetView! {
        return view as? XKCDWidgetView
    }

    private func updateInfo() {
        guard let current = currentXkcdInfo else { return }
        xkcdWidgetView.dateLabel.text = "\(current.year)-\(current.month)-\(current.day)/\(current.num)"
        xkcdWidgetView.titleLabel.text = current.title
    }

    private func updateComic(_ image: UIImage) {
        xkcdWidgetView.imageView.image = image
    }

    // MARK: Privates

    private var currentXkcdInfo: XKCDInfo? {
        didSet {
            if currentXkcdInfo != nil { updateInfo() }
        }
    }

    private func getImage(with url: String) {
        print("calling ... getImage")
        apiClient.getComic(url: url) { [weak self] result in
            switch result {
            case .error: print("Error downloading the image")
            case .success(let image): self?.updateComic(image)
            }
        }
    }

    private func update() {
        apiClient.getCurrent { [weak self] result in
            switch result {
            case .error: print("Error downloading current comic")
            case .success(let xkcdInfo):
                if self?.currentXkcdInfo != xkcdInfo {
                    self?.currentXkcdInfo = xkcdInfo
                    self?.getImage(with: xkcdInfo.img)
                }
            }
        }
    }

    // MARK: NCWidgetProviding

    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        update()
        completionHandler(.newData)
    }

    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        let expanded = activeDisplayMode == .expanded
        preferredContentSize = expanded ? xkcdWidgetView.imageView.intrinsicContentSize : minSize
    }
    
}
