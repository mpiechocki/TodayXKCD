import UIKit
import NotificationCenter
import Networking

@objc (TodayViewController)

class TodayViewController: UIViewController, NCWidgetProviding {

    let maxSize = CGSize(width: 320, height: 400)
    let minSize = CGSize(width: 320, height: 50)

    // MARK: Dependecies

    private let apiClient = XKCDApiClient()

    // MARK: Privates

    private var currentXkcdInfo: XKCDInfo? {
        didSet {
            if let currentXkcdInfo = currentXkcdInfo { updateView() }
        }
    }

    // MARK: Lifecycle
        
    override func viewDidLoad() {
        super.viewDidLoad()
        extensionContext?.widgetLargestAvailableDisplayMode = .expanded
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        apiClient.getCurrent { [weak self] result in
            switch result {
            case .error: print("Error downloading current comic")
            case .success(let xkcdInfo): self?.currentXkcdInfo = xkcdInfo
            }
        }
    }

    override func loadView() {
        let view = XKCDWidgetView()
        self.view = view
    }

    // MARK: View

    private var xkcdWidgetView: XKCDWidgetView! {
        return view as? XKCDWidgetView
    }

    private func updateView() {
        guard let current = currentXkcdInfo else { return }
        DispatchQueue.main.async { [current, weak self] in
            self?.xkcdWidgetView.dateLabel.text = "\(current.year)-\(current.month)-\(current.day)/\(current.num)"
            self?.xkcdWidgetView.titleLabel.text = current.title
        }   
    }

    // MARK: NCWidgetProviding

    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        apiClient.getCurrent { [weak self] result in
            switch result {
            case .error: completionHandler(.failed)
            case .success(let xkcdInfo):
                self?.currentXkcdInfo = xkcdInfo
                completionHandler(.newData)
            }
        }
    }

    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        let expanded = activeDisplayMode == .expanded
        preferredContentSize = expanded ? maxSize : minSize
    }
    
}
