//
//  Node+Header.swift
//  
//
//  Created by Povilas Staskus on 1/26/20.
//

import Plot

extension Node where Context == HTML.BodyContext {
    private static var sections: [Wednesday.SectionID] { [.posts, .publish, .swiftui, .about] }
    
    static func header(for site: Wednesday) -> Node {
        return .div(
            .div(
                .class("pure-menu pure-menu-horizontal pure-u-1-1 top-header"),
                .a(
                    .class("pure-menu-heading"),
                    .text(site.name),
                    .href("/")
                ),
                .ul(
                    .class("pure-menu-list"),
                    .forEach(sections, { section in
                        .li(
                            .class("pure-menu-item"),
                            .a(
                                .class("pure-menu-link"),
                                ///.text(section.name != "About This Blog" ? section.name : ""),

                                .text(section.name),
                                .href(site.path(for: section))
                            )
                        )
                    })
                )
            )
        )
    }
}
