//  Node+Head.swift

import Plot

/// This will be called once for each .md file
extension Node where Context == HTML.DocumentContext {
    static func head(for site: Wednesday) -> Node {
        return Node.head(
            .title("\(site.name) - \(site.description)"),
            .meta(
                .charset(.utf8),
                .name("viewport"),
                .content("width=device-width, initial-scale=1")
            ),
            .link(
                .rel(.stylesheet),
                .href("https://unpkg.com/purecss@1.0.1/build/pure-min.css"),
                .init(name: "integrity", value: "sha384-oAOxQR6DkCoMliIh8yFnu25d7Eq/PHS21PClpwjOTeU2jRSq11vu66rf90/cZr47"),
                .init(name: "crossorigin", value: "anonymous")
            ),
            .link(
                .rel(.stylesheet),
                .href("https://unpkg.com/purecss@1.0.1/build/grids-responsive-min.css")
            ),
            .link(
                .rel(.stylesheet),
                .href("/styles.css")
            )
        )
    }
}

//public extension Node where Context == HTML.DocumentContext {
//    static func head<T: Wednesday>(
//        for location: Location,
//        on site: T,
//        titleSeparator: String = " | ",
//        stylesheetPaths: [Path] = ["/styles.css"],
//        rssFeedPath: Path? = .defaultForRSSFeed,
//        rssFeedTitle: String? = nil
//    ) -> Node{
//        var title = location.title
//
//        if title.isEmpty {
//            title = site.name
//        } else {
//            title.append(titleSeparator + site.name)
//        }
//
//        var description = location.description
//
//        if description.isEmpty {
//            description = site.description
//        }
//
//        return .head(
//            .encoding(.utf8),
//            .siteName(site.name),
//            .url(site.url(for: location)),
//            .title(title),
//            .description(description),
//            .twitterCardType(location.imagePath == nil ? .summary : .summaryLargeImage),
//            .forEach(stylesheetPaths, { .stylesheet($0) }),
//            .viewport(.accordingToDevice),
//            .unwrap(site.favicon, { .favicon($0) }),
//            .unwrap(rssFeedPath, { path in
//                let title = rssFeedTitle ?? "Subscribe to \(site.name)"
//                return .rssFeedLink(path.absoluteString, title: title)
//            }),
//            .unwrap(location.imagePath ?? site.imagePath, { path in
//                let url = site.url(for: path)
//                return .socialImageLink(url)
//            })
//        )
//    }
//}
