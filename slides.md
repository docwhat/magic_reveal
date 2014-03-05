# Magic Reveal

Magic Reveal makes creating presentations easy and fun.

See it in action at the [demo/tutorial](http://docwhat.github.io/magic_reveal/)

[![Gem Version](https://badge.fury.io/rb/magic_reveal.png)](http://badge.fury.io/rb/magic_reveal)
[![Build Status](https://secure.travis-ci.org/docwhat/magic_reveal.png?branch=master)](http://travis-ci.org/docwhat/magic_reveal)
[![Dependencies](https://gemnasium.com/docwhat/magic_reveal.png?branch=master)](https://gemnasium.com/docwhat/magic_reveal)
[![Coverage Status](https://coveralls.io/repos/docwhat/magic_reveal/badge.png?branch=master)](https://coveralls.io/r/docwhat/magic_reveal)
[![Code Climate](https://codeclimate.com/github/docwhat/magic_reveal.png)](https://codeclimate.com/github/docwhat/magic_reveal)

## Installation

Use `gem` to install magic_reveal:

    $ gem install magic_reveal

The version numbers are the based on the versions of
[reveal.js](https://github.com/hakimel/reveal.js). The last number is
the revision specific to Magic Reveal.

### Requirements

* Ruby 1.9.3 or newer
* A recent version of [Bundler](http://bundler.io/)

<br/>
Magic Reveal *may* work on non-posix systems, but I make no promises. Pull Requests are
welcome.

## Usage

To get started:

    $ magic-reveal new my-presentation
    $ cd my-presentation
    $ vim slides.md

Feel free to replace [vim](http://vim.org/) with the editor of your choice.

### Viewing the presentation

    $ magic-reveal start

Then open your browser to [`http://localhost:9292`](http://localhost:9292).

### Write a static index.html

    $ magic-reveal static

This generates a static `index.html` suitable for committing to git.

### The format of slides.md

Magic Reveal uses [github-flavored
markdown](https://help.github.com/articles/github-flavored-markdown)
as much as practical.

#### External code files

If you want your source code to be in files outside your `slides.md`, no problem!

To load source from `example.rb`, for example, then use `@@source = <filename>`
as the body of the code section.

For example:

```
`@@source = example.rb`
```

This works with triple back-quote blocks and four-space indented blocks sections as well.

## Development

There is a full [RSpec](http://rspec.info/) test suite.  Make sure you
write tests before you continue.

For the places where I don't have tests because I couldn't figure it out,
please help!

### Future plans

* Generate static sites via the `magic-reveal` command line tool
* A configuration file, for using plugins, etc.

## Contributing

(because you know it could be better)

1. [Fork it](https://github.com/docwhat/magic_reveal)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
