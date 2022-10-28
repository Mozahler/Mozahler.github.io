---
date: 2022-10-04 12:00
description: An Explanation of How the **Swift Package Manager** Handles Media and Other Non-Swift files
tags: posts
---
## Adding a Resource File to Your Package

>It's really hard to ask a question when you don't know what the problem is.

Maybe you think you can just copy and paste a text file into your local package and everything will work like magic?

Well, a considerable amount of magic does occur behind the scenes when you load a file from resources. Let's' take a peek behind the curtain just long enough to see how we can get the file to load...

I call it magic because when you build your project there's a lot of work that has to be done that's implicit due to references from your source code and the structure of the project itself. This is a little abstract sounding, so let me give you a concrete example.

### Read the Contents of a Text File

I had a text file I wanted to load for my app, and I didn't want it in my main bundle.  I have a dedicated package that needs to use the file, so it's a natural fit for that file to belong to that package.

Text (and image, audio and other) files that aren't Swift (.swift) files are considered "resources" by the system. So you're not just adding a file, you're adding a (file) resource.

If this is the first resource you're adding to your project you have a little homework to do.

Let's look at how to load a file:

```swift
guard let path = Bundle.module.path(forResource: "sfsymbols", ofType: "txt"),
	let content = try? String(contentsOfFile: path)
        else {
            return []
        }
```

The above code tells the system where to find your file. Well, if all you've done is copied the file to somewhere in your package, then you haven't provided enough information for the system to find it.  Let's start with this cryptic message that appears:

'module' is inaccessible due to 'internal' protection level

Now the message is telling you exactly what the problem is, so it's not really all tht cryptic is it? OK, let's do a search on the message.

[Try This!](https://www.google.com/search?client=safari&rls=en&q=%27module%27+is+inaccessible+due+to+%27internal%27+protection+level&ie=UTF-8&oe=UTF-8)

I'm not saying you won't find the answer in these results, but you have to admit it's not going to be an easy search.  If you haven't set up your new addition to the package as a resource, then the code above is just not going to work.

If you do a search on `adding a resource to a local swift package` you might find your answer.

Which is what I did. And of course I had to do one of these: 🤦🏽‍♂️.  I do a lot of face-palms when I'm developing. It's the nature of the beast.

So you want to create a folder called "Resources" in your package underneath the Sources folder. In my case the folder directly under Sources was named for the package itself, and I put the `Resources` folder inside that folder.

We're already halfway there!!

### Configuring the Package.swift file for a resource

Now you have a resource in your package, and it's time to configure the package to recognize your file as a valid resource so that it can be bundled up into the package module the next time you perform a build.

This is pretty straightforward. Adding a resource is like adding a dependency, except there's only one place you have to specify the resources (there are source dependencies and target dependencies, but here we are just talking about specifying the target resource)

Here's the code you need to add the one file:

```swift
	resources: [
		.process("Resources/sfsymbols.txt")
	]
```

Add these lines just inside the closing paren on your target, just after the dependencies:

```swift
    targets: [
        .target(
      		...
      		dependencies: [
              ...
      		],
          resources: [  
            ...
            ]
```

Go ahead and build your project!

Ooops.  It didn't work did it?

Go ahead and build it again.

Profit!  I told you there was a certain amount of magic involved.

I won't spoil the magic by telling you why you needed to build it twice. Maybe the compiler saw it didn't have a valid module, finished what it could and errored out. The next time you built it, it found the module (local package) ready to go, and the compile was allowed to complete successfully. Who knows? Maybe it will work differently in the next version of Xcode.

It's nice to see my project compiling once again!

## Links

[SymbolPicker - GitHub](https://github.com/xnth97/SymbolPicker)  


.pct 96
