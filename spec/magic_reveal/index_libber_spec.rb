require 'spec_helper'
require 'magic_reveal/index_libber'

describe MagicReveal::IndexLibber do
  subject { described_class.new html_text }

  describe ".update_author" do
    let(:html_text) { '<meta name="author" content="Hakim El Hattab">' }

    it "replaces the author" do
      author = "Joe Cool #{rand 99}"
      subject.update_author author
      expect(subject.to_s).to match %r{content=.#{Regexp.quote author}.}
    end
  end

  describe ".update_description" do
    let(:html_text) { '<meta name="description" content="A framework for easily creating beautiful presentations using HTML">' }

    it "replaces the description" do
      description = "#{rand 99} luft balloons"
      subject.update_description description
      expect(subject.html.at('meta').get_attribute('content')).to eq(description)
    end
  end

  describe ".update_slides" do
    let(:slides) { '<section><h2>life with Joe</h2><p>&hellip;is good</section>' * 2 }
    let(:html_text) { '<!DOCTYPE html><div class="reveal"><div class="slides"><section>text</section></div></div>' }

    it "does stuff" do
      subject.update_slides slides
      puts subject
    end
  end

  context "with random html" do
    let(:html_text) { "<!DOCTYPE html>\n<body>\n<p>text here\n</body>" }

    its(:to_s) { should match %r{<body>\s*<p>text here\s*</p>\s*</body>} }
    its(:to_s) { should be_kind_of(String) }
  end
end
