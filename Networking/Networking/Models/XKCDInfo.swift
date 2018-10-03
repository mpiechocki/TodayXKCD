public struct XKCDInfo: Codable, Equatable {
    public let month: String
    public let num: Int
    public let year: String
    public let alt: String
    public let img: String
    public let title: String
    public let day: String

    public static func ==(rhs: XKCDInfo, lhs: XKCDInfo) -> Bool {
        return rhs.img == lhs.img && rhs.alt == lhs.alt
    }
}
