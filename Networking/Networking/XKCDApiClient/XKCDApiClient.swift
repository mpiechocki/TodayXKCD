public enum Result<Value> {
    case success(Value)
    case error
}

public class XKCDApiClient {

    public init() {}

//    private let apiURL = "https://xkcd.com/info.0.json"
    private let apiURL = "https://xkcd.com/614/info.0.json"

    public func getComic(handler: @escaping (Result<XKCDComic>) -> Void) {
        let dispatchGroup = DispatchGroup()
        var comicInfo: XKCDInfo?
        var comicImage: UIImage?

        dispatchGroup.enter()
        getCurrentInfo { [weak self] infoResult in
            switch infoResult {
            case .error:
                print("Error loading comic INFO...")
                dispatchGroup.leave()
            case .success(let info):
                comicInfo = info
                dispatchGroup.enter()
                self?.getImage(url: info.img) { imageResult in
                    switch imageResult {
                    case .error:
                        print("Error loading comic IMAGE...")
                        dispatchGroup.leave()
                    case .success(let image):
                        comicImage = image
                        dispatchGroup.leave()
                    }
                    dispatchGroup.leave()
                }
            }
        }

        dispatchGroup.wait()
        if let comicInfo = comicInfo, let comicImage = comicImage {
            DispatchQueue.main.async { handler(.success(XKCDComic(info: comicInfo, comicImage: comicImage))) }
        } else {
            DispatchQueue.main.async { handler(.error) }
        }
    }

    private func getCurrentInfo(handler: @escaping (Result<XKCDInfo>) -> Void) {
        guard let url = URL(string: apiURL) else { handler(.error); return }
        let request = URLRequest(url: url)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard
                error == nil,
                let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,
                let responseData = data
            else { handler(.error); return }

            do {
                let xkcdInfo = try JSONDecoder().decode(XKCDInfo.self, from: responseData)
                handler(.success(xkcdInfo))
            } catch {
                handler(.error)
                return
            }
        }
        task.resume()
    }

    private func getImage(url: String, handler: @escaping (Result<UIImage>) -> Void) {
        guard let url = URL(string: url) else { handler(.error); return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { handler(.error); return }

            handler(.success(image))
        }.resume()
    }

}
