# Rack Reveal

A simple markdown style wrapper around reveal.

I'm hoping that eventually I'll be able to make this a gem and
that generating your presentation will be as simple as
creating a `.md` file and either running `rackup` or maybe
a command to generate a static site.

## Reason for being

[Reveal.js](https://github.com/hakimel/reveal.js) is pretty and powerful.  But
I really don't want the hassle of the configuration, etc. etc.

What I really want is to write my presentation as markdown and have it "just
work".  Ideally, without having to run rack or grunt.

## Usage

1. Clone this repository.
2. `bundle install`
3. Edit slides.md to your heart content. Headers (e.g. `## foo`) mark the
   beginning of slides.
4. Run `rackup` or [pow](http://pow.cx) to get the site up.
5. Visit the site!

That's it!

## Future

* This should be a gem.
* `reveal.js` should be fetched auto-magically, including parsing the html to
  put the slides in the right place.
* There should be a command like `rack-reveal my-markdown.md` that would
  generate a static presentation site around the `.md` file and its assets.
* There should be tests, etc.
