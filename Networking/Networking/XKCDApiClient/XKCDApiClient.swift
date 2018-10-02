public enum Result<Value> {
    case success(Value)
    case error
}

public class XKCDApiClient {

    public init() {}

    public func getCurrent(handler: @escaping (Result<XKCDInfo>) -> Void) {
        guard let url = URL(string: "https://xkcd.com/info.0.json") else { handler(.error); return }
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
                DispatchQueue.main.async { handler(.success(xkcdInfo)) }
            } catch {
                handler(.error)
                return
            }
        }
        task.resume()
    }

    public func getComic(url: String, handler: @escaping (Result<UIImage>) -> Void) {
        guard let url = URL(string: url) else { handler(.error); return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { handler(.error); return }

            DispatchQueue.main.async { handler(.success(image)) }
        }.resume()
    }

}
