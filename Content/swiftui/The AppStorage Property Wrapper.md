---
description: A convenient way to save and read variables from UserDefaults and use them in the same way as @State properties.
date: 2022-10-03 12:00
tags: swift
---
## The **@AppStorage** Property Wrapper

### @AppStorage  

`@AppStorage` is a convenient way to save and read variables from UserDefaults and use them in the same way as `@State` properties. It can be seen as a `@State` property which is automatically saved to (and read from) UserDefaults.  

User defaults is actually a property list file (plist) which is made accessible programmatically. It can store values of basic datatypes. Since it’s a property list file, stored content is in key-value pairs. The purpose of user defaults is to let us save pieces of data and read them back whenever that’s necessary, quickly and effortlessly. This data is available app-wide and can be updated from anywhere inside an app. User defaults is not meant to be acting as a persistent storage of large data. On the contrary, it’s best for keeping stuff like user preferences or settings. Also, it’s the worst choice a developer can make in order to save sensitive data. User defaults provide no security at all, and it’s easily accessible; so, just don’t do that.  

In programming terms now, we all know from the pre-SwiftUI days that we can access user defaults using the UserDefaults class in the Foundation framework. This is still valid nowadays as well. However, with the advent of the SwiftUI framework, there is a new player around -- the @AppStorage property wrapper.  

@AppStorage is one of the various property wrappers available to use in SwiftUI. We can consider it as an app-wide source of truth, which, however, has one great difference comparing to others --  modified values do not remain in memory, but they get written to the user defaults file. Using it for reading and writing values is straightforward.

With the `@AppStorage` property wrapper, writing to user defaults file is just as easy as reading values from it. What actually differs is how we use these properties. When we pass their binding values as arguments to various SwiftUI views and they get updated, those changes will be written in turn to the user defaults file.  

## Links

[Apple OnLine Swift Documentation/Attributes](https://docs.swift.org/swift-book/ReferenceManual/Attributes.html)  

[Stackoverflow](https://stackoverflow.com/questions/65587932/store-custom-data-type-in-appstorage-with-optional-initializer)  

[Stackoverflow](https://stackoverflow.com/questions/66308518/swiftui-best-practice-for-using-appstorage-for-settings-how-to-read-the-userde) 

[Using](https://serialcoder.dev/text-tutorials/swiftui/using-the-appstorage-property-wrapper-in-swiftui/)  

[Stackoverflow](https://stackoverflow.com/questions/65515378/why-is-my-appstorage-not-working-on-swiftui)  

.pct 90
