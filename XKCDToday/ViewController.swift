import UIKit

class ViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let url = URL(string: "https://xkcd.com")!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

}

