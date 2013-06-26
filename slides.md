# My presentation

By Christian Höltje

## Narf!

Things go boom!

At _least_ in the function_without_end_it_does.

## Source code

I'm having a hard time with the "fenced code blocks".

```ruby
require 'sinatra'
require 'redcarpet'

class RenderSlides < Redcarpet::Render::HTML
  include Redcarpet::Render::SmartyPants

end

get '/' do
  renderer = RenderSlides.new(
    :no_styles => true,
    :no_intra_emphasis => true,
    :fenced_code_blocks => true,
  )

  markdown = Redcarpet::Markdown.new(
    renderer,
    :space_after_headers => true,
    :filter_html => true,
  )

  @slides = Dir['slides/*.md'].
    sort.
    map { |f| markdown.render File.read(f) }.
    map { |h| "<section>#{h}</section>" }.
    join("\n")
  erb :index
end
```

## Live source

```ruby
@@source = app.rb
```

## Text

Nullam id dolor id nibh ultricies vehicula ut id elit. Cum sociis natoque
penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nullam id
dolor id nibh ultricies vehicula ut id elit. Vivamus sagittis lacus vel augue
laoreet rutrum faucibus dolor auctor. Nullam quis risus eget urna mollis ornare
vel eu leo. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor
auctor.

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce dapibus, tellus
ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit
amet risus. Aenean lacinia bibendum nulla sed consectetur. Donec sed odio dui.
Nullam id dolor id nibh ultricies vehicula ut id elit. Donec ullamcorper nulla
non metus auctor fringilla.
