===
layout: page
title: "What the hell is a monad"
description: "In this blog post we'll be discussing an analogy I use to depict what a monad is and an example of the Option monad in a real world programming scenario."
draft: false 
===
I've been using the Either and Option monads on various projects (in different runtimes) over the last couple of years. I like utilizing these monads as a way of handle errors from external systems. However, when it comes time to introducing someone new to these monads, I'm unable to describe what makes a monad a `monad`. However, after doing some research I found an analogy that encapsulates what I believe to be the spirit of what makes a monad a `monad`.

> *A monad is an abstract data type that enables programmers to chain complex, nondeterministic operations in a readable way.*

An abstract data type (ADT) is a kind of data type defined by it's behavior from the point of view from a user. Since an ADT is created from the user's point of view, it's internal presentation is hidden, thus enabling us to focus more on behavior than caring what data is being held (it could be a String, Integer, YourCustomObject, etc).

The ability to chain operations is the `functor` attribute of monads. In category theory, a `functor` is a something has enables `mappable` behavior, such as iterating over a list of objects/strings/etc. To enable the chaining of nondeterministic operations, two functions are found on monadic types: `return` and `bind`.

The `return` function *places* a value into a monadic context, whereas the `bind` function *applies* a function in a monadic context.

> Note: Depending on the programming language or library that you are using, the *return* function will typically be represented through the /constructor/ method and *bind* may have a different name such as `flatMap` or `map`.

Let's write an example of monads in action using [Kotlin](https://kotlinlang.org/) and a functional programming library called [ArrowKt](https://arrow-kt.io/docs/apidocs/arrow-core-data/arrow.core/-option). A quick real-world example is when I'm trying to eat a donut from my favorite donut place in the Upper West Side, [Daily Provisions](https://www.dailyprovisionsnyc.com/menus/).

Let's write a function that encapsulates the operation of getting a donut from Daily Provisions and, for simplicity, we'll choose the `Option` monad as its return type.

```kotlin
fun getDonut(time: Date): Option<Donut> =
  if (donutsAreAvailable(time)) {
    Some(Donut())
  } else {
    None
  }
```

The above function could return either my donut or nothing depending on some external factor (time). When we pass a value into the Some function, we are effectively using the `return` trait of a monadic type. The None function is a type of Option that returns...nothing! Next, do something with...something.

```kotlin
val eatADonut = getDonut(timeBefore11am)
  .map { donut -> donut.eat() }
```

The above variable gets a donut and if a donut is found it will `map`, or `bind`, to a function that eats the donut. If the `getDonut` returns a `None`, because I overslept and missed the opportunity to get a donut, then our `map` method will never get called.
