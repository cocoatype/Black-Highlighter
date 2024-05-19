import ProjectDescription

public enum SDK {
    case native
    case catalyst

    var destinations: Destinations {
        switch self {
        case .native: [.mac]
        case .catalyst: [.iPhone, .iPad, .macCatalyst, .appleVisionWithiPadDesign]
        }
    }

    var nameSuffix: String {
        switch self {
        case .native: "Mac"
        case .catalyst: ""
        }
    }
}
