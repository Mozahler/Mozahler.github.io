//  SocialMediaLink.swift
//  Created by Povilas Staskus on 1/26/20.

import Foundation

struct SocialMediaLink {
    let title: String
    let url: String
    let icon: String
}

extension SocialMediaLink {
    static var location: SocialMediaLink {
        return SocialMediaLink(
            title: "Boston, Massachusetts, USA",
            url: "https://en.wikipedia.org/wiki/Boston",
            icon: "fas fa-map-marker-alt"
        )
    }
    
    static var linkedIn: SocialMediaLink {
        return SocialMediaLink(
            title: "LinkedIn",
            url: "https://www.linkedin.com/in/thomas-ingemanson-8900a31b0",
            icon: "fab fa-linkedin"
        )
    }
    
    static var email: SocialMediaLink {
        return SocialMediaLink(
            title: "Email",
            url: "mailto:mozahleri@gmail.com",
//            url: "mailto:povilas@staskus.io",
            icon: "fas fa-envelope-open-text"
        )
    }
    
    static var github: SocialMediaLink {
        return SocialMediaLink(
            title: "GitHub",
            url: "https://github.com/mozahler",
            icon: "fab fa-github-square"
        )
    }
    
    static var stackOverflow: SocialMediaLink {
        return SocialMediaLink(
            title: "StackOverflow",
            url: "https://stackoverflow.com/users/5156054/mozahler",
            icon: "fab fa-stack-overflow"
        )
    }
    static var twitter: SocialMediaLink {
        return SocialMediaLink(
            title: "Twitter",
            url: "https://twitter.com/Mozahler",
            icon: "fab fa-twitter-square"
        )
    }
}
