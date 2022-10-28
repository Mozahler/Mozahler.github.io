---
description: Taking a Look At All Those Moving Parts That Make Your Site Possible
date: 2022-10-10 12:00
tags: publish, site
---

## How Much CSS Do I Have to Learn?

**CSS** stands for `Cascading Style Sheets`. It can save you a lot of work when used correctly to format the layout of your web page. With CSS, you can control the color, font, the size of text, the spacing between elements, how elements are positioned and laid out, what background images or background colors are to be used, different displays for different devices and screen sizes, and more.  

## How did I get here?  

### It can be overwhelming working with many DSL's, programming languages and networking - especially when most of it is brand new to you.  

I'm not just talking about adopting `CSS` here. It's a stand-in for whatever technology you decide your site is lacking.  

So any time I pick up a new technology or otherwise wander outside my safe space I am confronted with a dilemma - how much time do I spend on learning this? I rarely know the answer to this question, which means I also don't know whether it is a wise investment of my time.  Setting up this website introduced me to a whole set of problems I had never encountered before.  

### Let's just run with one example.  

I've been through a handful of tutorials and have a css file that is possibly a bit messy. I took a look at how others set up their sites, and made notes of the features I liked and would like to emulate. So far I've cloned the publish package onto my computer and created a website using the defaults. I may have copied and pasted some code I didn't fully understand. In any event, most of the adjustments to the original setup (so far) have been issues of configuration and overall layout. It appears as though I'm on the right track.


## Unfortunately I Took a Detour

I had the hardest time figuring out how to fine tune the background colors. First, I would make changes to the css and not see them reflected on the page, and then even when I saw changes they weren't what I expected. What went wrong and how do I get back on track?  

I admit up front that I foolishly dug my own hole and jumped into it both feet first. But I was able to recover.  

I know that my style.css is going to dictate my colors - at least when I'm done with it it will. So I took a look at what was in there. Near the top of the file I found this `.css` code that was being called:  

```css
--vermilion: #e90000ff;
--gamboge: #d49705ff;
  ...
    --background-color: var(--vermilion);

```

First of all, I am going to assume these are colors in the hex RGBA format. I set the background of my main page to vermilion, built and ran the project, and refreshed my browser to check out the results.  

I was expecting something "bright reddish", instead it looked pretty white to me. Since "#e90000ff" works out to a very red hue, and I was getting white, something else was a problem. Looking for other places that color is being specified, I scanned further down the file and I found code like this:

```css
pre code .keyword {
  color: #b294bb
}
```

Instead of an eight-digit hex value like I saw for vermillion, this second color is defined with six - presumably `rrggbb`. I'll discuss this a little more in just a bit. Let's keep looking.  

I also see what I assume is a fairly light gray:

```css
.item-list img {
  border: 1px solid #ddd;
    ...
}
```

Given the three digits, if this is rgb then we are talking values of 0-15 per color instead of 0-255

Which is fine. Except - so far we have 3 different "encodings" for color.

Let's go back.

So I change the background to gamboge. Is it a color? I've never heard of it, let's see what it looks like'

```css
  --background-color: var(--gamboge);
```

I compile and run the package from Xcode, I switch over to my safari session and reload the page.

The page refreshes to a dark mustardy beige color. 

![Gamboge](../../Images/gamboge.png)

> Gamboge is a partially transparent deep saffron to mustard yellow pigment. It is the traditional colour used to dye Buddhist monks' robes.  

I still have my suspicions regarding the 8 digit rgb, but so far, so good. 
What if the 8 digit rgb plus opacity value is being interpreted differently from what I expect? Maybe (like the code lower in the file) only the first three digits are important?

Let's change the first 3 digits to be 'd00''

```css
   --gamboge: #d00705ff;
```

Any guesses as to what color the background refreshed to?  Red. Upon further thought I realize that this is fine - I've made the Red component very strong, while the Green and Blue components are actually very small values. So I haven't really demonstrated anything, yet.

another change, from d00 to f00, and sure enough an even brighter red. I haven't really established that things don't work, just that they're not working as I expect them to.

So is it possible that the css I copied from elsewhere is wrong? Well, that's a black hole. Let's stay on point. I'm trying to understand how to get my css to work with me. Let's try one more test. I'll change the first three digits to '00f' - should be blue, right? After all red is 0, green is 0 and blue is 15, or as blue can be.

So I save my update: 

```css
   --gamboge: #00f705ff;
```

I build and run my project from Xcode. I switch over to Safari and reload the page. Here's what I see:

![ZeroZeroEff](../../Images/00f.png)

Isn't that the prettiest shade of blue you've ever seen? As I look at the hex value I realize that I didn't prove anything. This is all a glorious dead-end. I realize that I'm approaching this all wrong. I really want to stop and write a hex color tool that lets me quickly verify my colors, but I have no time for that. 

So maybe I should stop guessing at what's going on?

So far I've identified the css that changes the background color of my views, and I've verified that my page refreshes and picks up the changes following the steps I've mentioned. At this point I can safely stop saying "it isn't working' and admit that it **IS** working, but I don't understand how.

I've been working offline this morning (my phone is charging), and it's time to connect to the internet and figure out what's left to figure out.

Except: What do I want to figure out? Why do I have 3 formats for colors (and do they all work?) Am I limited to 16 \* 16 \* 16 colors instead of 256 \* 256 \* 256? Can I merge the 3 color formats by replacing two of them with the third? 

Where does my styles.css file come from? If I recall correctly, I followed a tutorial that said make my own theme by copying and pasting the contents of the swift file `Theme+Foundation.swift`.  

Fair enough.  

My custom theme is then set up to reference a `styles.css` file in 'OriginalTheme' which I copied from the `FoundationTheme` folder in the `publish` package. Let's take a look at that file:

```css
/**
*  Publish Foundation theme
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    background: #fff;
    color: #000;
    font-family: Helvetica, Arial;
    text-align: center;
}

.wrapper {
    max-width: 900px;
    margin-left: auto;
    margin-right: auto;
    padding: 40px;
    text-align: left;
}

header {
    background-color: #eee;
}

header .wrapper {
    padding-top: 30px;
    padding-bottom: 30px;
    text-align: center;
}

header a {
    text-decoration: none;
}

header .site-name {
    font-size: 1.5em;
    color: #000;
    font-weight: bold;
}

nav {
    margin-top: 20px;
}

nav li {
    display: inline-block;
    margin: 0 7px;
    line-height: 1.5em;
}

nav li a.selected {
    text-decoration: underline;
}

h1 {
    margin-bottom: 20px;
    font-size: 2em;
}

h2 {
    margin: 20px 0;
}

p {
    margin-bottom: 10px;
}

a {
    color: inherit;
}

.description {
    margin-bottom: 40px;
}

.item-list > li {
    display: block;
    padding: 20px;
    border-radius: 20px;
    background-color: #eee;
    margin-bottom: 20px;
}

.item-list > li:last-child {
    margin-bottom: 0;
}

.item-list h1 {
    margin-bottom: 15px;
    font-size: 1.3em;
}

.item-list p {
    margin-bottom: 0;
}

.tag-list {
    margin-bottom: 15px;
}

.tag-list li,
.tag {
    display: inline-block;
    background-color: #000;
    color: #ddd;
    padding: 4px 6px;
    border-radius: 5px;
    margin-right: 5px;
}

.tag-list a,
.tag a {
    text-decoration: none;
}

.item-page .tag-list {
    display: inline-block;
}

.content {
    margin-bottom: 40px;
}

.browse-all {
    display: block;
    margin-bottom: 30px;
}

.all-tags li {
    font-size: 1.4em;
    margin-right: 10px;
    padding: 6px 10px;
}

footer {
    color: #8a8a8a;
}

@media (prefers-color-scheme: dark) {
    body {
        background-color: #222;
    }

    body,
    header .site-name {
        color: #ddd;
    }

    .item-list > li {
        background-color: #333;
    }

    header {
        background-color: #000;
    }
}

@media(max-width: 600px) {
    .wrapper {
        padding: 40px 20px;
    }
}
```

It's pretty amazing that these lines can power the formatting of the entire site. How many color formats do you see referenced in this file?

One. A hashtag followed by three hex digits followed by a semicolon.

Well, I'm on a deadline and my mission is not to understand the ins and outs of migrating colors from markdown to html just now.

I take another look at my `styles.css` file and realize that it is in three sections. I knicked the top part from one site, and the bottom part was added to help me colorize via syntax highlighting. I've gotten syntax highlighting to work well enough for now, so I know I don't want to play with this section. Instead I just add a comment to the top of this third section explaining it was added for syntax highlighting and decide to leave it alone - it works fine for now.

As a side note, the only color formatting I find in this bottom section is:

```css
  background-color: #1a1a1a;
```

Besides describing a very dark color, this code tells me that my syntax-highlighted source code is going to be rendered with 256 * 256 * 256 colors and the line provides no opacity information. I can live with that.

So now I've narrowed down my issues to the top of the file, which I copied from a site that had a color scheme I liked. I thought I could start from there.

```css
:root {
  --vermilion: #e90000ff;
  --smoky-black: #120a02ff;
  --magnolia: #f5f5ffff;
  --gamboge: #d49705ff;
  --almond: #f0e1ccff;

  --background-color: var(--almond);
  --primary-item-color: var(--magnolia);
  --secondary-item-color: var(--vermilion);
  --primary-text-color: var(--smoky-black);
  --secondary-text-color: var(--magnolia);
}

@media (prefers-color-scheme: dark) {
  --background-color: var(--smoky-black);
  --primary-item-color: var(--gamboge);
  --secondary-item-color: var(--vermilion);
  --primary-text-color: var(--magnolia);
  --secondary-text-color: var(--gamboge);
}

:root {
  --vermilion: #e90000ff;
  /* it is very dark */
   --smoky-black: #120a02ff;
   /* This is wrong - it is white */
   --magnolia: #f5f5ffff;
   /* this is a mustardy dark beige */
   --gamboge: #00f705ff;
  --almond: #f0e1ccff;

  --background-color: var(--gamboge);
  --primary-item-color: var(--magnolia);
  --secondary-item-color: var(--vermilion);
  --primary-text-color: var(--smoky-black);
  --secondary-text-color: var(--magnolia);
}

@media (prefers-color-scheme: dark) {
  --background-color: var(--smoky-black);
  --primary-item-color: var(--gamboge);
  --secondary-item-color: var(--vermilion);
  --primary-text-color: var(--magnolia);
  --secondary-text-color: var(--gamboge);
}
```  

I go back to the source code for the temple site that I copied  

[Weissazool](https://weissazool.github.io/projects/)  

and see a style sheet that I did not port over: `temple-palette.scss`  

Aha! So the original site wasn't using just using .css files, but also `.scss` files. 

## SCSS

SCSS contains all the features of CSS and contains more features that are not present in CSS which makes it a good choice for developers to use. SCSS is full of advanced features: it offers variables, and you can shorten your code by using variables.  
  
SCSS : Syntactically Awesome Style Sheet is the superset of CSS. SCSS is the more advanced version of CSS. SCSS was designed by Hampton Catlin and was developed by Chris Eppstein and Natalie Weizenbaum. Due to its advanced features it is often termed as Sassy CSS. SCSS have file extension of .scss.  

## Drawing the Line  

Guess what? This is where I'm drawing that line. I don't need to understand scss files. Yes I looked them up and now I know I have the option of enhancing my appearance using yet another set of rules.

But I need to get back to finishing my website.

I swap out my 8 digit hex codes for 3 digit codes and I'm back in business.

```css
:root {
    /* Light Mode */
    --lprimary: #09e;
    --lsecondary: #c21;
    --laccent: #b19;
    --lb1: #fff;
    --lb2: #dff;
    
    /* Dark Mode */
    --dprimary: #ed4;
    --dsecondary: #a86;
    --daccent: #ca2;
    --db1: #222;
    --db2: #10a;
    
    --background-color: var(--1b1);
    --primary-item-color: var(--lprimary);
    --secondary-item-color: var(--lsecondary);
    --primary-text-color: var(--laccent);
    --secondary-text-color: var(--lb2);
}

@media (prefers-color-scheme: dark) {
    --background-color: var(--db1);
    --primary-item-color: var(--db2);
    --secondary-item-color: var(--daccent);
    --primary-text-color: var(-dbprimary);
    --secondary-text-color: var(--dsecondary);
}
```

Once I got rid of the background noise everything sorted itself rather quickly.

Case closed. (For now.)

## Links

[Gamboge - Wiki](https://en.wikipedia.org/wiki/Gamboge)

[CSS](https://www.w3schools.com/html/html_css.asp)  

.pct 92
