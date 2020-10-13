---
layout: post 
title: "Test-Driven Learning"
description: "In this blog post I'll be discussing a strategy I use for rapidly learning a new programming language/library/tool that utilizes using a testing framework as my 'learning feedback' tool."
draft: true
---
I just wanted to discuss an approach I use to learn new programming languages, runtimes, libraries and/or implementing abstract concepts. The approach is essentially test-driven development, but instead of writing tests as a feedback mechanism for refactoring code, we are writing tests as a feedback mechanism for learning. Let's call this "Test-Driven Learning" for now. This test-driven learning approach gives us a quick feedback loop (via test-runner) and sandbox environment (via test-suite), that we can use for rapidly learning new concepts.

This feedback loop boils down to: `Hypothesize -> Test -> Evaluate -> Repeat`.

The feedback loop is similiar to using a REPL (Read-Evaluate-Print-Loop) to learning new concepts. However, I've found using most REPL environments (minus Emacs + Lisp setup) can feel too constraining to driven out building DSLs, learning new libraries, etc. Also, depending on the language/library/tool you are learning, there may not be a REPL available for you to learn with.

Ok, enough with the theory, let's jump in and learn through implementation.

## Implementing the Feedback Loop
To implement test-driven learning, you will need to get the language runtime on your machine. With the runtime on your machine, you'll need to acquire a testing framework to write your tests in.

If you are having trouble finding the "right" testing framework for your language of choice, try looking into the language's community. This research will enable you to learn more about the language and how it's community delivers software with the language. You can usually find these communities on different online forums like Google Groups, Slack, Twitter or with a quick [Duck Duck Go](https://duckduckgo.com) search.

Assuming you have chosen a testing-framework, and you have the language runtime installed on your machine, your next step is fire up your favorite text-editor, or IDE, and write your test file. Depending on what you are trying to test, maybe it's a new language feature or a new third-party library, you'll want to expose that functionality to your test suite.
