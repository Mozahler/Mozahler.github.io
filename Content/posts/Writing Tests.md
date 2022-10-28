---
date: 2022-10-12 12:00
description: The Role of Testing in Your Development Process
tags: tests
excerpt: Always Write Tests Before Refactoring Your code
---
## Tests and Test Driven Development  

It would be a mistake to think that you waste your time when writing tests. Tests give back in many ways. In fact there’s a whole philosophy of coding devoted to Test Driven Development (TDD).  I want to spend a few minutes describing this approach.  

In TDD you write the test before you write the actual code.  When you write a test and execute it, it should fail. After all, you found a problem, documented it, and wrote a test that uncovers the problem.  But the first time you run your test, you haven’t yet fixed the code, so you get an error. If you don't, then you need to retrace your steps.  All in all, this is a good thing.  

### Oh, the Circularity…  

You’ve written a test, run the test, it fails. Now you fix your code.  

Once you’ve written your fix, you run your test. Does it succeed? Does the code now work as it was meant to? It’s possible that the answer to one of these questions is a yes and the other is a no. Maybe your test has a bug?  

The biggest benefit of using TDD, in my opinion, is that it allows you to refactor more easily. In fact, there’s a school of thought that says that unless you have tests that prove that your changes fixed the errors they were designed to catch, then it’s not considered refactoring.  

If you have set up a harness of tests that prove that your code is working, and do some refactoring - how hard is it to run your tests on the new code? It’s as easy as can be, you just click on a button in Xcode and run your test code. If you did your work correctly, then your tests will pass. If your tests fail then at least you have an insight into what you didn’t account for in the original code. Of course, there’s no guarantee that your code will always work after writing a test. Maybe in the process of fixing your broken tests you are able to write a couple more. The goal isn't the highest number of tests possible, it is to get the best overall coverage of your code. Certainly, if you are about to change something fundamental in your interface, you want to make sure you have a suite of passing tests that prove that your interface works as designed.  

You'll find that over time the way you write your tests and your code evolve to make this iterative approach more efficient.  

[add links to this file that point to the tutorials and the test that were written for them - hint hint]

## Would You Like to Learn More About Test Driven Development?  

Check out the links below for a number of video tutorials on Test Driven development. I absolutely admire those who work this way. You don't want to be one of those developers who tends to dive into coding far too early, and then spends a great deal of time halfway through their project refactoring and getting it to where it needs to be. TDD is the opposite of that. I could definitely write more about it if people were interested. Let me know.  

## Summary  

Just as you shouldn’t code without creating backups regularly, you can’t refactor without tests. Ask anyone who has had to refactor a medium to large app. You need to know when you’ve messed up - as soon as possible. You also need that reassurance you get when you’ve run all your tests and they all pass. It will give you the boost you need to forge ahead and make even more changes.  

## Links

[Chris Eidhof - Test Driven Development](https://chris.eidhof.nl/post/becoming-a-better-programmer-test-driven-development/)  
[StackOverflow](https://stackoverflow.com/questions/4114083/ios-tests-specs-tdd-bdd-and-integration-acceptance-testing)  

### Videos  

[Chris Eidhof and Lisa Luo - Test Driven Reactive Programming](https://talk.objc.io/episodes/S01E53-test-driven-reactive-programming)  

[Chris and Brandon Williams - Playground Driven Development](https://talk.objc.io/episodes/S01E51-playground-driven-development)  

.pct 90
