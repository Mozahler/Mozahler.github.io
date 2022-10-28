---
description: Starting From the Top - Setting Up the Initial Site
date: 2022-10-17 12:00
tags: publish, site
excerpt: We'll be creating a customized personal website.
---
## The Publish Tutorial

First of all, you don't need me to teach you how to set up your website. I've been doing this for a couple of days. There are many great, informative resources out there, and I've provided links to some of those I found particularly helpful. (check out Danijela's excellent overview)

>Every website created with Publish is a Swift package. When deployed, a pre-defined set of steps get executed that builds and renders the HTML components and styles them with CSS.

It can be a bit confusing to work in so many languages at once: markdown, html, css, swift, not to mention the DSL's you have available to leverage stylistic and other changes across your projects. `Publish`, `Ink`, `Splash` are tools written to make the transition from markdown to html possible without you having to learn the ins and outs of web programming. Ultimately the idea is to express your intentions in Swift and to allow the publishing pipeline to transform the information into the correct html.  It's a big ask.  And it is doable.

In an attempt to stay `meta` I will try to explain how to get the ball rolling with your own website.

While the `Publish` package by John Sundell is an amazing accomplishment, there aren't a lot introductory tutorials that go beyond installing the standard boiler plate he provides out of the box. There are some well-written articles available for customizing pieces of your setup, and some highly recommended ones are linked below. On a separate page I have documented part of my journey towards setting up this site.

[link to the related page]

One thing you need to do while working on putting your site together is to get to know what steps are involved, and what those steps actually do. Go ahead and peek into the `Output` folder after building and running your project. Is everything where you thought it would be placed? Are you puzzled by any of the content?

To give you an example of the roadblocks beginners can run into, I struggled with displaying images. I made sure I had an images folder in the `Resources` folder

### Start Here

[Wrestling With Publish](https://deirdre.dev/wrestling-with-publish/)

This is an excellent collection of links to sites that have been customized and the GitHub repository for the site (sometimes just the latter). In my companion piece linked above I discuss what I found when I looked into these sites.

### Progressing to the Next Step

There are many ways to improve your site once you have gotten under way. Perhaps you feel it is lacking something, but you can't quite put your finger on what it might be. 
You can get a feel for how others have extended the basic setup. You can take a look at their site, and if you see something that catches your eye, go to their GitHub project and figure out how it was done. If that seems a little advanced for you, then start by browsing any of the tutorials that explain how to customize a theme or add publishing steps to the pipeline.

### Exposure

Try  clicking on one of the links where someone describes a particular enhancement they made and how they accomplished it. Just surfing through a site might give you some ideas on how to spruce up your own site. [list the different things that people customize - the cover page thing, mention swapping out ink for common markdown, etc.]


https://github.com/leontedev/Publish-leonte.dev

### `main.swift`

main.swift is a file which contains a configuration information for your website. In this file you can add sections, specific item metadata, website properties, and configure publishing steps. Of course you can add other files, extend other protocols or processes in ways that better serve your specific needs. In order to do this well, however, it helps if you understand the underlying structure - including how things get done.
 
## Plugins

Plugins are great for extending the capabilities of your site. They can be a little difficult to work with, however. Adding a plugin to the Package.swift file isn't difficult, but there are some "gotchas" that you need to be aware of. As time goes on it becomes easier to work with the SPM in Xcode. But there are still times when the compiler gets confused and you need to clean your build folder and exit the app. Sometimes, miraculously, everything can start compiling again after performing this little dance.

### Minimum Version

If you don't specify a miminum version of macOS in your package.swift file you may find it won't compile. The reason may seem a bit cryptic - the compiler tells you your target supports an old version of the OS, but you haven't mentioned one anywhere.

The solution isn't difficult: you need to add the `platforms` parameter to your initializer in `Package.swift`.  If you're using a pre-existing `Package.swift` file you may find it needs some updating.

There's a line at the top of `Package.swift` that tells the package manager which version of swift it can support.  

> ###### // swift-tools-version:5.7
>// The swift-tools-version declares the minimum version of Swift required to build this package.

On Apple's Developer Site, You'll find a slightly more detailed explanation:

>The Swift tools version declares the version of the PackageDescription library, the minimum version of the Swift tools and Swift language compatibility version to process the manifest, and the required minimum version of the Swift tools to use the Swift package.

### Update the tools version after an Xcode Upgrade

If this version is out of date, you may not even be able to specify the version of the OS you want. It may not have existed when that version of tools was first in use.
 
If you are forced to provide legacy support this may not be an option for you. You may have to plan the upgrades to your tools more carefully than I.

## Links

[Wrestling With Publish](https://deirdre.dev/wrestling-with-publish/)

[Danijela Vrzan](https://danijelavrzan.com/posts/2022/06/create-portfolio-website-using-publish/)

.pct 80
