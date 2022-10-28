import Foundation
import Publish
import Plot
import SplashPublishPlugin

// This type acts as the configuration for your website.
struct Wednesday: Website {
    enum SectionID: String, WebsiteSectionID {
        // Add the sections that you want your website to contain here:
        case posts, publish, swiftui, about
 
        var name: String {
            switch self {
            case .posts: return "Posts"
            case .publish: return "Publish"
            case .swiftui: return "SwiftUI"
            case .about: return "About This Site"
            }
        }
    }

    struct ItemMetadata: WebsiteItemMetadata {
        var date: Date
        var description: String
        var tags: String
    }

    var url = URL(string: "https://github.com/mozahler/mozahler.github.io")!
    var name = "Mozahler"
    var description = "Getting It to the Next Level"
    var language: Language { .english }
    var imagePath: Path? { nil }
    var socialMediaLinks: [SocialMediaLink] { [.location, .email, .linkedIn, .github, .stackOverflow, .twitter] }
}

/*
 Publishing Wednesday (7 steps)
 [1/7] Install plugin 'Ensure that all items are tagged'
 [2/7] Copy 'Resources' files
 [3/7] Add Markdown files from 'Content' folder
 [4/7] Sort items
 [5/7] Generate HTML
 [6/7] Generate RSS feed
 [7/7] Generate site map
 ✅ Successfully published Wednesday
 Program ended with exit code: 0
 */
do {
    try Wednesday().publish(
        withTheme: .original,
        plugins: [.splash(withClassPrefix: "")]
    )
} catch {
    print(error)
    print(error.localizedDescription)
}
