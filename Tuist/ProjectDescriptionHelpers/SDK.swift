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
        case .native: "Native"
        case .catalyst: ""
        }
    }

//    var condition: PlatformCondition? {
//        switch self {
//        case .native: .when([.macos])
//        case .catalyst: .when([.catalyst, .ios])
//        }
//    }
}
