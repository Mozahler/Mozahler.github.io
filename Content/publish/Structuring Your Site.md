---
date: 2022-10-05 12:00
description: Let's Discuss the **Default Website** Before You Customize Your Site
tags: site, publish
---
## Publish Overview

By following the instructions on John Sundell's GitHub page [link], you can set up a Website on your mac complete with a server to view the results in Safari. I **kid you not** when I say you can have a functional site set up on your mac in less than an hour. How is that even possible?

John has spent lot of time and effort creating the tools needed and organizing how everything fits together. Before hacking away at things, let's take a look at how things are set up out of the box, and some of the underlying reasons why things are organized the way they are. Once you have a basic understanding of how things work, you'll have an easier time making changes to customize how the site works for you.

This page outlines some of the conventions to follow while getting your feet wet. As I say often on this site: there's more than one way to do things. But until you can introduce changes to your site and view the results right away, you might feel a bit lost. I recommend you follow the conventions until you are more familiar with how everything fits together.

## The Folder Layout

### The `Content` Folder

`Content` is where you put your website's written content -- blog posts, and other pages.

`Publish` lets you generate your website's content in two ways: by using markdown files or programmatically. When you add markdown files to `Content`, `Publish` parses the content automatically. It (automatically) uses Ink markdown parser library, also created by John Sundell. All of this is fairly transparent to you. I mostly add markdown files that are ready for display, tend to not do this programmatically. If there's any demand I can come up with a demo file or two that approach.

### Output

`Output` is the main folder of the website. It contains all the files necessary to display the content of the website. It's generated every time you build the project in Xcode. Once you start adding more content and custom pages to your website, you'll see more files and folders appear. You should assume everything in this file is read-only. After any changes to your source files or resources, a rebuild or running your project will trigger an update of the content of this folder.

Even though you don't add to or edit anything in this folder, it contains all the content and information to generate your website. Consider it as read-only. You'll see feed and sitemap files there along with styles.css. This CSS file is the pre-defined styling for your website. You can create your own theme, which in turn can use a custom `styles.css` file to display your content.

### Resources

`Resources` is where you add any media files for your content, like images, videos, audio, and fonts.

### Sources

`Sources` has all the Swift files to build your website. On initial install there's one main.swift file which contains configuration information for your website. You can add sections, specific item metadata, website properties, and configure publishing steps. Typically you issue the command to "publish" your site at the bottom of this file.

## The Three Major DataTypes Used By the System

### Section, Item, and Page

#### Sections 

Special types of webpages, navigated using navigation menu. 

#### Items 

Blog posts.

#### Pages 

Standalone webpages on your website. 

Each Section, Item, and Page can define its own set of Content — which can range from text (like titles and descriptions), to HTML, audio, video and various kinds of metadata.

For the most part, this is the typical structure used by most developers but I've noticed not everyone follows this layout. I recommend you start by adopting this three folder concept - at least until you are comfortable you understand where everything is and why it's there.
 
## Metadata

`Publish` makes use of the ItemMetadata type if you choose to give it properties. You can add metadata to the top of your files which, if defined, must match the fields in your `ItemMetadata` object. A missing field, or a field in the wrong format will stop the compile.

## Tags

## The main File

As I mentioned, `main` is pretty much the only source code file you will find after an initial install. That should signal to you that important stuff goes here.

After setting everything up and opening my new site, I was elated to see I had posts and navigation built in from the start. There's a dummy entry on the landing page, and you can tap on it to bring up a linked page.

What I didn't know how to do is to get **my** content onto the site. I thought I had read that everything would automatically be copied from the Content base folder. So I dumped a bunch of files there and and regenerated the site, opened a browser session, navigated to my site.

No new files.

What gives?  If any of you have Ruby experience, then you've probably had some exposure to `Ruby on Rails`.
For those of you who don't it is [description of RoR]

Like `Ruby on Rails`, `Publish` is designed to hold all your materials in one place, and many things just "magically" work with very little configuration from you. Also like `Ruby on Rails`, there are plenty of "hooks", or places you can add your own customizations to make the site cater to your needs.


## Creating Your Own Theme

https://www.russellgordon.ca/tutorials/creating-a-custom-theme-using-publish/

## Links

[Creating Content With Markdown](https://danijelavrzan.com/posts/2022/06/publish-creating-content-with-markdown/)

[Wrestling With Publish](https://deirdre.dev/wrestling-with-publish/)

Remember that the type of object we create is a `Website`. By creating a custom `Website` object you are going to be met with a lot of decision making along the way. If you are going to use any of the extra tools (like Plot or Splash) that are developed for working with `Publish`, then it makes sense not to stray too far from the intended structure. At least, until you understand how the pieces fit together. What makes things `tick`.

### Let's go over some of that now.

#### The Three Main Datatypes

Part of the appeal (to me) of the `Website` object is that by maintaining this structure you can get the compiler to check your work and make sure that your work is consistent, complete -- you want some assurance that the pieces you are using are the correct ones (that they fit together, at least). 

If you know that a post is always going to be associated with a date (many develop sites that aren't data-centric - so this is not a given), then you will want date to be a property that you can count on being available. Why not make `date` a property of your **ItemMetadata** object?

### Metadata

possible examples of ItemMetadata use, and the purpose of requiring it up front.

### Sometimes the Tail Wags the Dog

The rippling effect of changes made after the initial setup/the wisdom of organizing your project before making changes to the existing (working) initial setup.

[Do I bubble the changes up or push them down?]


So the basic components of a Website

Before beginning to build up your site it makes sense to decide the layout. In the most general, broadest sense, we know we have a bunch of files and may need to present some of them in more than one way. Some websites emphasize a reverse-chronological approach (newest item at the top). So a date property is going to be important. Similarly, the name of the article could be the file name. Except maybe you don't want to rename your files if you find your focus within the file changing while setting up. 

One of the conventions built into the Website definition and well-supported by the provided tools, is the "Front End YAML" code placed at the top of each file. (YAML - Yet Another Markup Language)

take a look at this:

```yaml
---
date: 2018-11-06
title: Midterms
tags: midterms2018
excerpt: This is typically the opening paragraph of an article.
---
```

### DRY

in this example, let's assume that the `excerpt` property is meant to summarize the content of the page without repeating the title. I have two choices here: I can write an introductory paragraph that is presented with the full page, or I can write a chunk of text that only appears in the `.excerpt` property of this metadata. Maybe one of those approaches makes no sense to you.  That's fine. In visiting other sites, I see both being used. I have to admit I spent some time on this issue, because I don't like repeating  (DRY - Don't Repeat Yourself)

Instead of using this `excerpt` property, I could add a separate step in my publishing pipeline where I programmatically grab the second paragraph of every markdown file and create an array or dictionary of the excerpts - obviously I would have to do this early in the pipeline  so that this property is available when it is required for display.
It boils down to 

## Customizing the Site

I want to start off with a simple example.  Here's what my build log looks like in Xcode when I hit **Command-B**

```
Publishing Wednesday (7 steps)
[1/7] Install plugin 'Splash'
[2/7] Copy 'Resources' files
[3/7] Add Markdown files from 'Content' folder
[4/7] Sort items
[5/7] Generate HTML
[6/7] Generate RSS feed
[7/7] Generate site map
✅ Successfully published Wednesday
Program ended with exit code: 0
```

All of this happens due to this small bit of code:

```swift
do {
    try Wednesday().publish(
        withTheme: .original,
        plugins: [.splash(withClassPrefix: "")]
    )
} catch {
    print(error)
    print(error.localizedDescription)
}
```

or if you prefer to see it on just one line:

```swift
    try Wednesday().publish(withTheme: .original, plugins: [.splash(withClassPrefix: "")]
```

Not only does this handle all my markdown files as well as .pngs and .gifs, but it even colorizes my embedded swift code, thanks to the use of the plugin. Of course, I didn't just add the reference to the plugin here and deploy my site. But installing a plugin **is** surprisingly straightforward - it's a simple edit to the Package.swift file. 

This is one way to customize your site.

Of course customization encompasses a lot of possibilities. Mostly it's about appearance. What color schemes and fonts am I going to use? How do I make these changes happen? How do I want to present my story to the world? 

But customization also means automating pieces of the process to make it easier to add to your site as time goes on.

I am still coming up with a list of features I want to adopt for my own site.  

.pct 82
