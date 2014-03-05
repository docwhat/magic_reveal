require 'spec_helper'
require 'magic_reveal/slide_renderer'

describe 'integration of SlideRenderer with Redcarpet' do
  let(:markdown) do
    return <<-EOF
# Title

Some text `here`.

## Second level header

```
Fenced code goes here.
```

### Third level header

    Indented code goes here.

    EOF
  end

  it 'does not have errors' do
    renderer = MagicReveal::SlideRenderer.markdown_renderer
    expect(renderer.render markdown)
      .to be_kind_of(String)
  end
end
