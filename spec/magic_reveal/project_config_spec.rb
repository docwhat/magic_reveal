require 'spec_helper'
require 'magic_reveal/project_config'

describe MagicReveal::ProjectConfig do
  subject { described_class.new io }
  let(:io) { MagicReveal::ProjectConfig::DEFAULT_TEMPLATE }
  let(:data_ruby) { { "random" => rand(99) }.to_json }
  let(:data_json) { data_ruby.to_json }

  describe "#new" do
    it "calls io_or_path.read" do
      io.should_receive(:read).with()
      subject
    end

    context "with a string" do
      it "converts strings to Pathname" do
        pio = Pathname.new(io)
        Pathname.should_receive(:new).with(io).and_return(pio)
        subject
      end
    end
  end

  describe ".dependencies" do
    it "should look like the example" do
      example = <<-EOF
      "dependencies": [
      { src: "lib/js/classList.js", condition: function() { return !document.body.classList; } },
      { src: "plugin/highlight/highlight.js", async: true, callback: function() { hljs.initHighlightingOnLoad(); } },
      { src: "plugin/zoom-js/zoom.js", async: true, condition: function() { return !!document.body.classList; } },
      { src: "plugin/notes/notes.js", async: true, condition: function() { return !!document.body.classList; } }
      ]
      EOF
      example.gsub!(%r{^\s*}, '').chomp!
      subject.dependencies.gsub(%r{^\s*}, '').should eq(example)
    end
  end

  describe ".to_js" do
    it "returns a string" do
      expect(subject.to_js).to be_kind_of(String)
    end
  end
end
