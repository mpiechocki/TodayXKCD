public enum Result<Value> {
    case success(Value)
    case error
}

public class XKCDApiClient {

    public init() {}

    public func getCurrent(handler: @escaping (Result<XKCDInfo>) -> Void) {
        guard let url = URL(string: "https://xkcd.com/info.0.json") else { handler(.error); return }
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, response, error) in
            guard error == nil else { handler(.error); return }
            guard let responseData = data else { handler(.error); return }
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

}
