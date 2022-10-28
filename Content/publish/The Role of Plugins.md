---
description: The Care and Feeding of Plugins in Your Custom Website
date: 2022-10-18 12:00
tags: site
excerpt: It's pretty straightforward to incorporate a third-party plugin. John Sundell has written a few that will make your life simpler. Have you found any others you'd like to use?
---
#  Plugins
## The Role of Plugins in the Website package

A well-written plugin can save you a lot of work. The `Publish` environment is composable in the sense that you can add functionality with addition of packages/modules that are seamlessly integrated into the `Website` project. JohnSundell calls these add-ons to the system `Plugins`, and has provided a few of his own to ease the burden of developing your site from scratch.

On this page I will discuss a couple of plugins developed by John Sundell that integrate seamlessly with `Publish` to provide you with key functionality, as well as provide you with more customization options. If you take a look at the `Package.swift` file in his `Publish` package, you'll see that he uses many of his own plugins to set up the default `Website`.

 You don't need to know this to use the `Publish` package, but if you take a look at its `Package.swift` you can see that it relies on a number of plugins (yes, John wrote all of them).  
 
<ul> 
.li("Ink")
.li("Plot")
.li("Files")
.li("CodeExtended")
.li("ShellOut")
.li("Sweep")
.li("CollectionConcurrencyKit")
</ul>

I will be happy to devote a page to discussing his `Plot`, `Ink` and `Splash` plugins if there's an interest.

## Setup

Adding a plugin to your Website is simplicity itself. But before reading this, please take a look at the blog entry under `publish` to get a sense of how `Package.swift` is structured. The following will make a lot more sense if you do that.

A plugin is considered a `dependency`, at the risk of making a circular definition, this means that you are requiring the package to depend on this new item. It is up to the Swift Package Manager to resolve the new dependency - which can include downloading from a remote site, compiling source code, copying files to their proper destination, etc.

A package dependency consists of a Git URL to the source of the package, and a requirement for the version of the package. The Swift Package Manager performs a process called dependency resolution to figure out the exact version of the package dependencies that an app or other Swift package can use.  

The `Package.resolved` file records the results of the dependency resolution and lives in the top-level directory of a Swift package. If you add the Swift package as a package dependency to an app for an Apple platform, you can find the Package.resolved file inside your .xcodeproj or .xcworkspace.

## Adding the Dependency (In Two Places)

You need to add a dependency to your package as well as to the target product. This means you will be adding code to the Package.swift file in two places. In the following example, I have added the "Splash" plugin as a source dependency.

```swift
    dependencies: [
        .package(name: "Publish", url: "https://github.com/johnsundell/publish.git", from: "0.8.0"),
        .package(name: "SplashPublishPlugin", url: "https://github.com/johnsundell/splashpublishplugin", from: "0.1.0")
        ],
```

The above comes near the top of the file, directly after defining the product. Defining the target dependency (the components required to compose/build the target executable) is equally straightforward, just add the name of the plugin to the existing array of dependencies:

```swift
        .executableTarget(
            name: "Wednesday",
            dependencies: ["Publish", "SplashPublishPlugin"]
        )
    ]
```

You need make both additions to the file, and then you are free to use the plugin in your `Website` object.
See the blog entry on "Customizing the Site" to see more presented in the proper context.

## Links

[SPM- Dependencies](https://docs.swift.org/package-manager/PackageDescription/PackageDescription.html)

.pct 90
