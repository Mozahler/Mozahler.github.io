---
description: How Can You Set Up Your Own Site? How Have Others Done It?
date: 2022-10-13 12:00
tags: site
---
#  A Survey of Other Sites

#### How do I set up my own web site when I don't what my options are?  

By following the install instructions on the `Publish` website, or any of the many introductory pieces available online, I can set up a basic web site in minutes.  That's pretty incredible and a testament to John Sundell's hard work at piecing together the infrastructure needed to transform a bunch of markdown and image files into a website.

The default setup is a good place to start, but you will want to display your information your way. In my opinion, a good early step is to learn what others have done to customize their own sites. The list of sites that have shared their implementation is probably larger than you'd think. One of the many sites I visited had a page dedicated to exploring some of these sites. It's called `Wrestling With Publish`, and there's a link at the bottom of the page. I recommend you visit the sites yourself and see how they work.

## Some Published Sites (and a theme or two)

I downloaded quite a few of these projects and visited each site built by the projects (where available). As I navigated through each site, I tried to identify for myself what was different in each, as well as what they had in common. Doing this I was able to pick out new details I had missed when just casually glancing at other sites. 

### How Do They Differ From Each Other?

You'd be surprised at how much customization some people have put into their website. Sometimes it was the way the information was being presented, but at others it was more about how things were organized - how everything fit together. And of course color choices can make a site stand out, as well as images (gifs, jpgs, pngs are all easily integrated into the site).

When I found a feature that seemed new or useful, I made a note of it so I could return later and match the site with the source code published on GitHub. This helped me come up with a short list of features that I wanted to add to my own site.

## Weissazool - A Blog With Images

[Itabashi Tenso Shrine](https://weissazool.github.io/blog/2020-07-23-sotd/)

Nice example of image and post together and how to do that. Each SOTD (Shrine of the Day) entry is the equivalent of a cell in a tableview complete with an image and link to a full page entry. 

Use the cell design code as a starting point.

### Content
where Content has two folders at its top level

#### Blog

A long list of filenames with embedded dates in YYYY-MM-DD format.

There is an `index.md` file, but it is completely empty.

The yaml tags at the top of the file include a line like this:

```
image: ./../../sotd/tofukuji.jpeg
```
the first dot is the current folder
the first set of double dots is the `blog` folder
the next set of double dots are the `Content` folder. Notice that `Output` is implicit as you move back down the file hierarchy, as `sotd` is the name of a folder directly at the root.
Finally you have the filename of the image.

### Resources

### The `sotd` Folder under Resources
This folder's contents are all `.jpeg` files.

The SectionID enum has two cases: `blog` and `projects`

In main.swift you have just this publishing step:

```swift
try Weissazool().publish(
  withTheme: .weissazool,
  deployedUsing: .gitHub("weissazool/weissazool.github.io", useSSH: false)
)
```

imagePath is left nil

the `ItemMetadata` is left blank

there is a template file which reflects the structure of the individual blog entries:
the yaml at the top

##### An Actual Entry

```
[<figure>
  <img src="./../../sotd/kinoene.jpeg"
  alt="A lamp post advertising Kinoene soy sauce."/>
  <figcaption>Caption</figcaption>
</figure>](./../../sotd/kinoene.jpeg)
```

##### The Template

```
[<figure>
  <img src="./../../sotd/shrine-image.jpeg"
  alt="alt text"/>
  <figcaption>Caption</figcaption>
</figure>](./../../sotd/shrine-image.jpeg)
```
### Sources

Surprisingly, this isn't just `.swift` files. but a mix of `.swift`, `.scss`, and `.png` files - as well as the template `.md` file already mentioned. There is only one other `.swift` file besides `main`, and that file extends `Theme` to include a variable which returns the custom theme for the site

```swift
extension Theme where Site == Weissazool {
  /// Modified from the default "Foundation" theme that Publish ships with, a very
  /// basic theme mostly implemented for demonstration purposes.
  static var weissazool: Self {
    Theme(
      htmlFactory: WeissazoolHTMLFactory(),
      resourcePaths: ["Resources/theme/styles.css"]
    )
  }
}
```

In this file you'll also find his definition of an `HTMLFactory`. He implements the required methods, plus a couple of others.

```swift
  func head(for location: Location, on site: Site) -> Node<HTML.DocumentContext> {]
  
  func makeIndexHTML(for index: Index,
                     context: PublishingContext<Site>) throws -> HTML {}

  func makeSectionHTML(for section: Section<Site>,
                       context: PublishingContext<Site>) throws -> HTML {


  func makeItemHTML(for item: Item<Site>,
                    context: PublishingContext<Site>) throws -> HTML {}

  func makePageHTML(for page: Page,
                    context: PublishingContext<Site>) throws -> HTML {}

  func makeTagListHTML(for page: TagListPage,
                       context: PublishingContext<Site>) throws -> HTML? {}

  func makeTagDetailsHTML(for page: TagDetailsPage,
                          context: PublishingContext<Site>) throws -> HTML? {}
```

Finally, he extends Plot.Node

Plot (also written by John) is a [DSL](https://en.wikipedia.org/wiki/Domain-specific_language) which enables you to write swift code that can be automatically translated into HTML in a more type-safe way.

>Plot treats all elements and attributes that a document contains as nodes. When using the Plot DSL, each time you create a new element, or add an attribute to an existing one, you are creating a node. Nodes can also contain just text, which can either be escaped or treated as raw, pre-processed text. Groups can also be created to form components.

```swift
  static func wrapper(_ nodes: Node...) -> Node {}

  static func header<T: Website>(
    for context: PublishingContext<T>,
    selectedSection: T.SectionID?
  ) -> Node {}
  
  static func itemList<T: Website>(for items: [Item<T>], on site: T) -> Node {}
    
  static func tagList<T: Website>(for item: Item<T>, on site: T) -> Node {}

  static func footer<T: Website>(for site: T) -> Node {}
```


## Joe Blau

[Joe Blau](https://joeblau.com/)

I love this site. He calls himself a `Design Engineer`, and it is clear that this is his thing.

### Very Individualistic

The landing page has an old school look. It looks like you are viewing the console of a terminal, and he is issuing the `blau` command with different parameters - each set of output corresponds to category of a classic resume. The unix-like output is similar to a man page and provides a maximum amount of information while taking up very little space. There are no links in this top portion of the page - they are all relegated to the bottom of the page in two sections providing information on how to contact him. One section provides his email and phone number, the other is a list of his socials.

To complete the illusion, the final line displays a blinking cursor on a blank command line.

Take a look at one of links:
[Conquer Earth](https://conquer.earth/joeblau)


The last time I looked, he had visited **276** places around the world.


He has broken out his Plot.Node extensions into multiple files

CallToAction  
Features  
Footer  
Header  
Hero  

Just take a look at his "read me first" page.
His picture at the top, next a row of "buttons" that highlight as you scroll over them. One each for twitter, insta, GitHub and his home site.

What follows mirrors the struct of the `blog` folder described under `Weissazool`s `Content` folder.  What's interesting here is that you don't see the entire article. At an appropriate breakpoint in the content there is a `Continue Reading` button. [will need to see how that is done] 


The `Next` button on the bottom of the page has  the same appearance (including highlighting as you scroll over them) as the buttons at the top of the page. Tap on the button and you'll see that the subsequent pages display the page number at the top above a divider/separator/line.

Joe has given a lot of though as to how to organize his data, and here are just two of the protocols he's defined for himself:

```swift
public protocol BulletPointable {
    var symbol: String? { get set }
    var tags: [String]? { get set }
    var images: [String]? { get set }
    var title: String? { get set }
    var description: String? { get set }
    var url: URL? { get set }
}

public protocol BlauThemable: Website {
    var hero: HeroSectionable? { get set }
    var header: HeaderSectionable? { get set }
    var features: FeatureSectionable? { get set }
    var callToAction: CallToActionSectionable? { get set }
    var footer: FooterSectionable? { get set }
}
```

I want to point out two of the factory methods he's implemented.


```swift
       func makeIndexHTML(for index: Index,
                           context: PublishingContext<Site>) throws -> HTML {
            HTML(
                .lang(context.site.language),
                .head(for: index,
                      on: context.site,
                      titleSeparator: " | ",
                      stylesheetPaths: buildStyleSheettPaths(for: context.site),
                      rssFeedPath: .defaultForRSSFeed,
                      rssFeedTitle: nil),
                .body(
                    .header(for: context.site),
                    .main(
                        .features(for: context.site),
                        .callToAction(for: context.site)
                    ),
                    .footer(for: context.site)
                )
            )
        }
```


```swift
      func makePageHTML(for page: Page,
                          context: PublishingContext<Site>) throws -> HTML {
            HTML(
                .lang(context.site.language),
                .head(for: page,
                      on: context.site,
                      titleSeparator: " | ",
                      stylesheetPaths: buildStyleSheettPaths(for: context.site),
                      rssFeedPath: .defaultForRSSFeed,
                      rssFeedTitle: nil),
                .body(
                    .header(
                        .h1(.text(page.title)),
                        .h3(.text(page.description))
                    ),
                    .main(
                        .section(
                            .class("max-section"),
                            page.body.node
                        )
                    ),
                    .footer(for: context.site)
                )
            )
        }
```        
      
So much power in so few lines.

  
Extra features: beautiful capsule buttons, excerpted articles with buttons to view the entire entry. 

Because the source code for the actual site isn't posted on GitHub (only the theme is published) I will have to come back to this after I've explored some of the other sites. Obviously, this is my favorite so far.

## Povilas Staškus

[Povilas Staškus - iOS Developer](https://www.staskus.io/)

Besides `Publish` he uses the `Splash` plugin (`SplashPublishPlugin`). Don't assume that means there are no bells or whistles here. His blog pages are exceptionally well thought-out and present well.

The page layout consists of a row at the top (the four .md files at the base of the `Content` folder), followed by a two column layout. On the left is an avatar and social links, on the right is the scrolling list of blog entries found in his `posts` folder (directly under `Content`) with a `RECENT POSTS` header.


His buttons are colorized and rather than changing their background color when hovered over, an underline appears underneath the button label's text

Each row or cell has similar yaml, which provides most of the formatting applied.

```
---
title: Building a real-world iOS app (Part 1): Introduction
date: 2019-03-11 12:00
tags: Tutorial, iOS, Swift
excerpt: We'll be creating and releasing an iOS application by showing a real thinking process, going through essential steps and providing the motivation behind them.
---
```

The title also functions as a link - scrolling over it displays an underline, tapping on it brings up the full entry on its own page.

Beside a folder full of extensions to Plot.Node (I'm detecting a pattern here), there are 3 additional files for a date formatter, html factory and a Theme identifier.

```swift
extension DateFormatter {
    static var blog: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
}
```

Nothing fancy, the standard `.long` date style. It does a nice job of keeping the interface clean.

Other notes:

>Fairly comprehensive, includes avatar links to socials. Professional in appearance.
    
[index | Yusuf Özgül | Blog | Resume | Portfolio](https://yusufozgul.com/)

The top of the page has his name followed by the major components of the site (buttons that highlight as they are scrolled over) all over a dark background (foreground/text is white, background is black, highlighted background on the buttons is blue)

The blog list shows the most recent posts, a button at the bottom displays all posts (sorted by date descending)

He has a `Contact` page that uses `Typeform`

His `Projects` page lists his open source work on GitHub, and apps in the AppStore

Despite the relatively simple theme, he’s got a fairly intricate set of conditionals, which may help you sort out how to write your own theme. Also interesting is a loader class that creates the static pages of the site.  Uses `SplashPublishPlugin` and many others. In fact, he has the most plugins of any of the projects I've discussed:

```swift
    targets: [
        .executableTarget(name: "YusufozgulCom",
        dependencies: [
                            "Publish",
                            "ReadingTimePublishPlugin",
                            "TwitterPublishPlugin",
                            "SplashPublishPlugin",
                            "ImageAttributesPublishPlugin",
                            "LinkAttributesPublishPlugin",
                            "GistPublishPlugin",
                            "VerifyResourcesExistPublishPlugin",
                            "YoutubePublishPlugin",
                            "CNAMEPublishPlugin",
                          ])
    ]
```

This is reflected in the most involved `.publish()` command we've seen so far:

```swift
try YusufozgulCom().publish(withTheme: .yusufozgulcom,
                            indentation: nil,
                            at: nil,
                            rssFeedSections: [.blogs, .projects],
                            rssFeedConfig: nil,
                            additionalSteps: [.installPlugin(.readingTime(wordsPerMinute: 40)),
                                              .generateSiteMap(),
                                              .installPlugin(.verifyResourcesExist()),
                                              .generateRSSFeed(including: [.blogs, .projects]),
                                              .removeAllItems(in: .blogs, matching: .init(matcher: { item in
                                                item.metadata.isDraft ?? false
                                              })),
                                              .installPlugin(.generateCNAME(with: ["yusufozgul.com", "www.yusufozgul.com"]))
                            ],
                            plugins: [.twitter(),
                                      .youtube(),
                                      .gist(renderer: ColorGistRenderer()),
                                      .linkAttributes(),
                                      .imageAttributes(),
                                      .splash(withClassPrefix: ""),
                                      //.publishGallery()
                            ])
```
                          
.pct 88
