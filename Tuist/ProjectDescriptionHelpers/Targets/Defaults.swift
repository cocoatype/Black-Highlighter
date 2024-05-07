import ProjectDescription

public enum Defaults {
    public static let target = Target.target(
        name: "Defaults",
        destinations: [.iPhone, .iPad, .macCatalyst, .appleVisionWithiPadDesign],
        product: .framework,
        bundleId: "com.cocoatype.Highlighter.Defaults",
        sources: ["Modules/Capabilities/Defaults/Sources/**"]
    )
}
