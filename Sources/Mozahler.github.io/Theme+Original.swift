//  Theme.swift
//  Created by Thomas Ingemanson on 10/16/22.

import Foundation
import Publish
import Plot
import SplashPublishPlugin

private let dateFormat = "MM.dd.yyyy"

extension Theme where Site == Wednesday {
    /// A modified version of the default "Foundation" theme that Publish ships with
    static var original: Self {
        Theme(
            htmlFactory: OriginalHTMLFactory(),
            resourcePaths: ["Resources/OriginalTheme/styles.css"]
        )
    }
    
    static var blau: Self {
        Theme(
            htmlFactory: OriginalHTMLFactory(),
            resourcePaths: ["Resources/BlauTheme/css/blau-styles.css"]
        )
    }
}

private struct OriginalHTMLFactory: HTMLFactory {
     func makeIndexHTML(for index: Index,
                       context: PublishingContext<Wednesday>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: context.site),
            .body(
                .grid(
/// this is the top horizontal menu of sections - it only displays if connected to the network
/// You can only view the page if you're connected to the network anyway
                    .header(for: context.site),
                    .sidebar(for: context.site),
                    .posts(
                        for: context
                            .allItems(sortedBy: \.date, order: .descending),
                        /// I could sort by date
                        //    .filter({ $0.sectionID == .posts}),
                        on: context.site,
                        title: "Recent Posts"
                        ),
                    .footer(for: context.site)
                )
            )
        )
    }

    /// A Section corresponds to the tabs at the top and the folders found in Content/
    func makeSectionHTML(for section: Section<Site>,
                         context: PublishingContext<Site>) throws -> HTML {
        let x = section.id == .about ? .header(for: context.site) :
        Node.grid(
            //this is the top horizontal menu of sections
            .header(for: context.site),
            .sidebar(for: context.site),
            .posts(
                for: context
                    .allItems(sortedBy: \.date, order: .descending)
                    .filter({ $0.sectionID == section.id }),
                on: context.site,
                title: section.id.name
            ),
            .footer(for: context.site)
        )
        return HTML(
            .lang(context.site.language),
            .head(for: context.site),
            .body(
                        x
//                        .grid(
//                            //this is the top horizontal menu of sections
//                            .header(for: context.site),
//                            .sidebar(for: context.site),
//                            .posts(
//                                for: context
//                                    .allItems(sortedBy: \.date, order: .descending)
//                                    .filter({ $0.sectionID == section.id }),
//                                on: context.site,
//                                title: section.id.name
//                            ),
//                            .footer(for: context.site)
//                        )
//                }
            )
        )
    }

    /// This is one level below the list view - when you tap on the Cell -- blog post, etc.
    func makeItemHTML(for item: Item<Wednesday>,
                      context: PublishingContext<Wednesday>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: context.site),
            .body(
                .grid(
                    .header(for: context.site),
                    .sidebar(for: context.site),
                    .item(for: item, on: context.site),
                    .footer(for: context.site)
                )
            )
        )
    }

    /// these are less dynamic, resume, etc. specialized pages (different from an Item, which is a cell in a blog list)
    func makePageHTML(for page: Page,
                      context: PublishingContext<Wednesday>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: context.site),
            .body (
                .grid(
                    .header(for: context.site),
                    .sidebar(for: context.site),
                    .page(for: page, context: context),
                    .footer(for: context.site)
                )
            )
        )
    }

    func makeTagListHTML(for page: TagListPage,
                         context: PublishingContext<Wednesday>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: context.site),
            .body(
                .grid(
                    .header(for: context.site),
                    .sidebar(for: context.site),
                    .pageContent(
                        .tagList(for: page, on: context.site)
                    ),
                    .footer(for: context.site)
                )
            )
        )
    }

    func makeTagDetailsHTML(for page: TagDetailsPage,
                            context: PublishingContext<Wednesday>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: context.site),
            .body(
                .grid(
                    .header(for: context.site),
                    .sidebar(for: context.site),
                    .posts(
                        for: context.items(taggedWith: page.tag, sortedBy: \.date, order: .descending),
                        on: context.site, title: "\(page.tag.string.capitalized) posts"),
                    .footer(for: context.site)
                )
            )
        )
    }
}

extension Node where Context == HTML.BodyContext {
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat /// "MM.dd.yyyy"
        return formatter
    }
}

extension DateFormatter {
    static var blog: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
}

/// A Section corresponds to the tabs at the top and the folders found in Content/
//    func makeSectionHTML(for section: Section<Wednesday>,
//                         context: PublishingContext<Wednesday>) throws -> HTML {
//        HTML(
//            .lang(context.site.language),
//            .head(for: context.site),
//            .body (
//                .grid(
//                    .header(for: context.site),
//                    .sidebar(for: context.site),
//                    .pageContent(.h1(.text(section.title))),
//                    .footer(for: context.site)
//                )
//            )
//        )
//    }

//    func makeItemHTML(for item: Item<Wednesday>,
//                      context: PublishingContext<Wednesday>) throws -> HTML {
//        HTML(
//            .lang(context.site.language),
//            .head(for: item, on: context.site),
//            .body(
//                .class("item-page"),
//                .components {
//                    SiteHeader(context: context, selectedSelectionID: item.sectionID)
//                    Wrapper {
//                        Article {
//                            Div(item.content.body).class("content")
//                            Span("Tagged with: ")
//                            ItemTagList(item: item, site: context.site)
//                        }
//                    }
//                    SiteFooter()
//                }
//            )
//        )
//    }

/// This is the old way I was doing it before using the grid
//private struct Wrapper: ComponentContainer {
//    @ComponentBuilder var content: ContentProvider
//
//    var body: Component {
//        Div(content: content).class("wrapper")
//    }
//}

/// This is the old way I was doing it before using the grid
//private struct SiteHeader<Site: Website>: Component {
//    var context: PublishingContext<Site>
//    var selectedSelectionID: Site.SectionID?
//
//    var body: Component {
//        Header {
//            Wrapper {
//                Link(context.site.name, url: "/")
//                    .class("site-name")
//
//                if Site.SectionID.allCases.count > 1 {
//                    navigation
//                }
//            }
//        }
//    }
//
//    private var navigation: Component {
//        Navigation {
//            List(Site.SectionID.allCases) { sectionID in
//                let section = context.sections[sectionID]
//
//                return Link(section.title,
//                    url: section.path.absoluteString
//                )
//                .class(sectionID == selectedSelectionID ? "selected" : "")
//            }
//        }
//    }
//}

/// This is the old way I was doing it before using the grid
//private struct ItemTagList<Site: Website>: Component {
//    var item: Item<Site>
//    var site: Site
//
//    var body: Component {
//        List(item.tags) { tag in
//            Link(tag.string, url: site.path(for: tag).absoluteString)
//        }
//        .class("tag-list")
//    }
//}

/// This is the old way I was doing it before using the grid
//private struct SiteFooter: Component {
//    var body: Component {
//        Footer {
//            Paragraph {
//                Text("Generated using ")
//                Link("Publish", url: "https://github.com/johnsundell/publish")
//            }
//            Paragraph {
//                Link("RSS feed", url: "/feed.rss")
//            }
//        }
//    }
//}

/// This is the old way I was doing it before using the grid
//private struct ItemList<Site: Website>: Component {
//    var items: [Item<Site>]
//    var site: Site
//
//    var body: Component {
//        List(items) { item in
//            Article {
//                H1(Link(item.title, url: item.path.absoluteString))
//                Paragraph(item.description)
//                ItemTagList(item: item, site: site)
//            }
//        }
//        .class("item-list")
//    }
//}

/// Make sure this is temporary - refactor if it works well
//extension Node where Context == HTML.BodyContext {
//    static func wrapper(_ nodes: Node...) -> Node {
//        div(.class("wrapper"), .group(nodes))
//    }
//
////    static var dateFormatter: DateFormatter {
////        let formatter = DateFormatter()
////        formatter.dateFormat = dateFormat
////        return formatter
////    }
//
//    static func itemList<T: Website>(for items: [Item<T>], on site: T) -> Node {
//        return .ul(
//            .class("item-list"),
//            .forEach(items) { item in
//                    .li(.article(
//                        .h1(.a(
//                            .href(item.path),
//                            .text(item.title)
//                        )),
////                        .tagList(for: item, on: site),
//                        .p(.text(item.description))
//                        ))
//            }
//        )
////        return .forEach(items) { item in
////            .group([
////                .div(.class("title"), .a(.href(item.path.absoluteString), .text(item.bytesized.metadata.title))),
////                .div(.class("date"), .text(dateFormatter.string(from: item.bytesized.metadata.date))),
////                .div(.class("content"), item.content.body.node)
////            ])
////        }
//    }
//
//}

/// A Section corresponds to the tabs at the top and the folders found in Content/
//func makeSectionHTML(for section: Section<Site>,
//                     context: PublishingContext<Site>) throws -> HTML {
//    HTML(
//        .lang(context.site.language),
//        .head(for: context.site),
//        .body(
//            .grid(
//                //this is the top horizontal menu of sections
//                .header(for: context.site),
//                .sidebar(for: context.site),
//                .posts(
//                    for: context
//                        .allItems(sortedBy: \.date, order: .descending)
//                        .filter({ $0.sectionID == section.id }),
//                    on: context.site,
//                    title: section.id.name
//                ),
//                .footer(for: context.site)
//            )
//        )
//            /*  this is what I was using:
//             .body {
//            switch section.id {
//            case .posts, .swiftui, .publish:
//
//            /// This is very plain looking and not in an elegant way
//            SiteHeader(context: context, selectedSelectionID: section.id)
//            Wrapper {
//              //  if section.id != .about {
//                    H1(section.title)
//              //  }
//                ItemList(items: section.items, site: context.site)
//            }
//            SiteFooter()
//            /// Replace the code directly above
//
//            case .about :
//                Text("The \(section.id) page goes here")
//                /// items is empty here, I expect one entry
//                if let item = section.items.first {
//                    Article {
//                        H1(Link(item.title, url: item.path.absoluteString))
//                        Paragraph(item.description)
//                        ItemTagList(item: item, site: context.site)
//                    }
//                }
//        }
//             }
//        }
//             */
//    )
//}

/*  this is what I was using:
 .body {
switch section.id {
case .posts, .swiftui, .publish:

/// This is very plain looking and not in an elegant way
SiteHeader(context: context, selectedSelectionID: section.id)
Wrapper {
  //  if section.id != .about {
        H1(section.title)
  //  }
    ItemList(items: section.items, site: context.site)
}
SiteFooter()
/// Replace the code directly above
    
case .about :
    Text("The \(section.id) page goes here")
    /// items is empty here, I expect one entry
    if let item = section.items.first {
        Article {
            H1(Link(item.title, url: item.path.absoluteString))
            Paragraph(item.description)
            ItemTagList(item: item, site: context.site)
        }
    }
}
 }
}
 */
