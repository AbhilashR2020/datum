# datum : "scrap your boilerplate" for Erlang

> You could do this with a macro, but...
> the best macro is a macro you don't maintain

**datum** is a pure functional and generic programming for Erlang. It had its origins in [Purely Functional Data Structures](https://www.cs.cmu.edu/~rwh/theses/okasaki.pdf) by Chris Okasaki, on implementing a various higher rank functional abstractions and patterns, on dealing with [scrap your boilerplate](https://www.microsoft.com/en-us/research/publication/scrap-your-boilerplate-with-class/) and gaining experience from other functional languages primary Scala and Haskell. The library is still testing the limits of functional abstractions in Erlang. 

[![Changelog](https://img.shields.io/badge/changelog-latest-green.svg)](CHANGELOG.md) 
[![Build Status](https://secure.travis-ci.org/fogfish/datum.svg?branch=master)](http://travis-ci.org/fogfish/datum) 
[![Coverage Status](https://coveralls.io/repos/github/fogfish/datum/badge.svg?branch=master)](https://coveralls.io/github/fogfish/datum?branch=master) 
[![Gitter](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/generic-programming-for-erlang/datum)
[![Hex.pm](https://img.shields.io/hexpm/v/datum.svg)](https://hex.pm/packages/datum) 
[![Hex Downloads](https://img.shields.io/hexpm/dt/datum.svg)](https://hex.pm/packages/datum)


## Key features

The [feature overview](doc/features.md) provides an introduction to datum features, use-cases and reasoning of they existence:

* `option` and `either` type notations
* a set of generic data types that can be inspected, traversed, and manipulated with common behavior: **foldable**, **traversable** and **map-like**. 
* pure functional **data types**: binary search tree, red-black tree, heap, queues, and others
* **streams** or lazy lists are a sequential data structure that contains on demand computed elements.
* resembles concept of getters and setters ([**lens**](doc/lens.md)) for complex algebraic data types.
* mapping of algebraic data types to they [**generic**](doc/generic.md) representation and back
* define a [**category pattern**](doc/category.md), [**monads**](doc/monad.md) and they composition for Erlang applications. You might be familiar with this concept as pipe, flow or function composition.
* generic [**do-notation**](doc/monad.md) with pattern matching. 
* [**typecasts**](doc/typecast.md) of primitive data types
* supports **OTP/18.x** or later release


## Getting started

The latest version of the library is available at its `master` branch. All development, including new features and bug fixes, take place on the `master` branch using forking and pull requests as described in contribution guidelines.

The stable library release is available via hex packages, add the library as dependency to `rebar.config`

```erlang
{deps, [{datum}]}.
``` 

Please follow the [feature overview](doc/features.md) to start leaning all available features; then continue to library [examples](examples) and to [source code](src).


## How To Contribute

The library is [Apache 2.0](LICENSE) licensed and accepts contributions via GitHub pull requests:

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

The development requires [Erlang/OTP](http://www.erlang.org/downloads) version 19.0 or later and essential build tools.

**Build** and **run** service in your development console. The following command boots Erlang virtual machine and opens Erlang shell.

```bash
git clone https://github.com/fogfish/datum
cd datum
make
make run
```


### commit message

The commit message helps us to write a good release note, speed-up review process. The message should address two question what changed and why. The project follows the template defined by chapter [Contributing to a Project](http://git-scm.com/book/ch5-2.html) of Git book.

>
> Short (50 chars or less) summary of changes
>
> More detailed explanatory text, if necessary. Wrap it to about 72 characters or so. In some contexts, the first line is treated as the subject of an email and the rest of the text as the body. The blank line separating the summary from the body is critical (unless you omit the body entirely); tools like rebase can get confused if you run the two together.
> 
> Further paragraphs come after blank lines.
> 
> Bullet points are okay, too
> 
> Typically a hyphen or asterisk is used for the bullet, preceded by a single space, with blank lines in between, but conventions vary here
>
>

### bugs

If you experience any issues with the library, please let us know via [GitHub issues](https://github.com/fogfish/datum/issue). We appreciate detailed and accurate reports that help us to identity and replicate the issue. 

* **Specify** the configuration of your environment. Include which operating system you use and the versions of runtime environments. 

* **Attach** logs, screenshots and exceptions, in possible.

* **Reveal** the steps you took to reproduce the problem, include code snippet or links to your project.



## License

[![See LICENSE](https://img.shields.io/github/license/fogfish/datum.svg?style=for-the-badge)](LICENSE)
