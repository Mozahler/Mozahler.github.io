---
date: 2022-10-19 12:00
description: SPM and the Benefits of Using Packages
tags: swift
excerpt: One of the Most Important Tools in Your Skillset
---
## Swift Package Management

Whether you realize it or not, SPM (the Swift Package Manager) really deserves to be your best friend - your favorite tool in the toolbox. The more you understand what it does and how to configure it, the more productive you'll become.
    
It just isn't always appropriate for you to write every bit of code in your project these days. It makes no sense to reinvent the wheel, and there's a large enough body of open source code that is well-tested and available for you to use almost immediately in your projects.  If you've worked with Carthage (my old favorite) or CocoaPods (when I must), then you understand the benefits of bringing someone else's code into your project. And you understand there's a learning curve involved in learning how to configure and maintain these additions. SPM has been created with an enormous amount of input from the coding community, and builds on the successes of these and other third-party code managers. Xcode plays well with SPM.

The best thing about using SPM is that you are typically working with the actual source code (I'm not going to get into binary packages here - but they are sometimes an option as well.) If something doesn't work exactly as you need it, you can make a local copy of the package and update the code yourself. Add some tests and you might even be able to make a PR for someone at GitHub. But let's not get ahead of ourselves.

### A Great Way to Silo Your Code

Almost all code I write these days is created within packages. My Xcode project directory typically has an AppNameApp.swift and a ContentView.swift file plus the usual resources/assets, etc. I create a workspace, drag my new project into it, and then drag the (local) component packages into the project (at the top left) as needed. If it’s a new project, then I typically have a new package as well, and I import it in my ContentView file where I call the landing view of my app. It’s a little bit of upfront maintenance that pays off almost right away. Once you have performed a full compile of your project, then only the package you are currently updating needs to be recompiled when it’s time to try out your changes. Compiles are quicker and you can see the latest results right away.

### Modules  

Swift organizes code into `modules`. Each module specifies a namespace and enforces access controls on which parts of that code can be used outside of the module. A program may have all of its code in a single module, or it may import other modules as dependencies. This vertical siloing of your app's functionality helps to reduce tight coupling of your code and can lead to a more composable architecture where you swap modules in and out as needed. This allows you to share functionality across multiple apps that don't know anything about each other.

When you use a separate module for code that solves a particular problem, that code can be reused in other situations. For example, a module that provides functionality for making network requests can be shared between a photo sharing app and a weather app. Once again, using modules lets you build on top of other developers’ code (or your own) rather than reimplementing the same functionality yourself. (DRY - Don't Repeat Yourself)

### Packages
 
A package consists of Swift source files and a manifest file. The manifest file, called `Package.swift`, defines the package’s name and its contents using the PackageDescription module. It can have one or more targets. Each target specifies a(typically executable) product and may declare one or more dependencies.

## Benefits of Using Packages

* You can share code between projects or between targets within a project.
* Each target in the package is compiled as a module. 
 
>Xcode will automatically create a resource bundle and an internal static extension on Bundle if your target includes resources. 

This means you can add gifs, pngs, audio and video files to the bundle, rather than the main bundle of the app itself. You decide what structure you want for your app, but this provides another option for siloing your data.
 
>Xcode recognizes the most common types of resources and will automatically configure the package for them. This includes `Core Data` and asset catalogs.

>`.json`, `.txt`, `.md` files are considered custom resources (there are others as well) and must be added to the Package.swift manifest in order for them to be included in the target. You can include items on the individual file level, or entire folders can be specified at once.

## Keeping things Organized

You may have strong opinions on how you organize your projects. Workspaces are definitely old-school (yet  still have their place), and `Packages` provide many of the same features/benefits. But keep in mind that they **can** co-exist. You can decide whether they should. I like to keep everything in a workspace, since it cuts down on duplication. (there's lots more to say about how it does that - derived data, sharing binaries between included packages, etc.)

This is what `Apple` has to say about using workspaces:

>Because indexing is done across the whole workspace, code completion, Jump to Definition, and all other content-aware features work seamlessly through all projects in the workspace. Because refactoring operations act across all the content of the workspace, you can refactor the API in a framework project and in several application projects that use that framework all in one operation. When building, one project can make use of the products of other projects in the workspace

#### Projects in a Workspace Share a Build Directory

By default, all the Xcode projects in a workspace are built in the same directory, referred to as the workspace build directory. Each workspace has its own build directory. Because all of the files in all of the projects in a workspace are in the same build directory, all of these files are visible to each project. Therefore, if two or more projects use the same libraries, you don’t need to copy them into each project folder separately.

Xcode examines the files in the build directory to discover implicit dependencies. For example, if one project included in a workspace builds a library that is linked against by another project in the same workspace, Xcode automatically builds the library before building the other project, even if the build configuration does not make this dependency explicit. You can override such implicit dependencies with explicit build settings if necessary. For explicit dependencies, you must create project references.

Each project in a workspace continues to have its own independent identity. To work on a project without affecting—or being affected by—the other projects in the workspace, you can open the project without opening the workspace, or you can add the project to another workspace. Because a project can belong to more than one workspace, you can work on your projects in any number of combinations without having to reconfigure any of the projects or workspaces.

You can use the workspace’s default build directory or you can specify one. Note that if a project specifies a build directory, that directory is overridden by the build directory of whatever workspace the project is in at the time you build the project.
 
Naturally, this sharing of code should also contribute to better compile times.

### Xcode Can Help

In Xcode, create a new, empty workspace. Once created, find the directory for the package you want to work on and drag that directory into the project navigator in Xcode. Xcode will create a Swift Package and download the dependencies. Easy Peasy.

Targets specify in detail how a product/binary (i.e., an application or library) is built. They include build settings, such as compiler and linker flags, and they define which files (source code and resources) actually belong to a product. When you build/run, you always select one specific target using the `Scheme Manager` (the window at the top center of the screen when Xcode is FullScreen).

It is likely that you have a few targets that share code and resources. These different targets can be slightly different versions of an app (iPad/iPhone, different brandings,…) or test cases that naturally need to access the same source files as the app. All these related targets can be grouped in a project. While the project contains the files from all its targets, each target picks its own subset of relevant files. The same goes for build settings: You can define default project-wide settings in the project, but if one of your targets needs different settings, you can always override them there.


## Links

[Multiple Libraries rom One Package](https://forums.swift.org/t/how-to-produce-multiple-libraries-from-one-package/18478/2)  
[Swift Package Manager Resources](https://www.fabrizioduroni.it/2020/10/19/swift-package-manager-resources/)  
[Adding Resources to a Swift Package](https://betterprogramming.pub/how-to-add-resources-in-swift-package-manager-c437d44ec593)  
[SPM Integrating Resources](https://jllnmercier.medium.com/swift-package-manager-integrating-resources-37dbea669af)  

[Leonardo Maia Pugliese](https://holyswift.app/introduction-to-app-modularisation-with-swift-package-manager-a-tale-to-be-told)  

[Package vs. Module](https://stackoverflow.com/questions/39499281/what-is-the-difference-between-a-swift-package-and-a-module)  

[Apple Documentation - Xcode Concepts](https://developer.apple.com/library/archive/featuredarticles/XcodeConcepts/Concept-Workspace.html)  
[Separating Code With Swift Packages](https://augmentedcode.io/2020/07/05/separating-code-with-swift-packages-in-xcode/)  

[forums.swift.org Jeremy David Giesbrecht](https://forums.swift.org/t/xcode-project-with-spm-dependencies/18157/2)  

[StackOverflow](https://stackoverflow.com/questions/11618407/xcode-workspace-vs-nested-projects)  

[SO II](https://stackoverflow.com/questions/21631313/xcode-project-vs-xcode-workspace-differences)  

[add links for Carthage, CocoaPods, Brew]

.pct 88
