require 'spec_helper'
require 'magic_reveal/slide_renderer'

describe MagicReveal::SlideRenderer do
  describe ".header" do
    context "when no slides have been shown" do
      before { subject.has_shown_slides = false }
      it "starts with <section>" do
        expect(subject.header("text", 1)).to match(/\A<section>/)
      end
    end

    context "when slides have been shown" do
      before { subject.has_shown_slides = true }

      it "starts with </section><section>" do
        expect(subject.header("text", 1)).to match(%r{\A</section>\s*<section>})
      end
    end

    it "ends with <h?>text</h?>" do
      txt = "text#{rand 99}"
      lvl = rand(6)
      expect(subject.header(txt, lvl)).to match(%r{<h#{lvl}>#{txt}</h#{lvl}>\Z})
    end
  end

  describe ".doc_footer" do
    context "when slides have been shown" do
      before { subject.has_shown_slides = true }

      it "emits a </section>" do
        expect(subject.doc_footer).to eq('</section>')
      end
    end

    context "when no slides have been shown" do
      before { subject.has_shown_slides = false }

      it "emits an empty string" do
        expect(subject.doc_footer).to eq('')
      end
    end
  end

  describe ".block_code" do
    let(:code) { "code = #{rand 99};" }
    context "with language" do
      let(:language) { "lang#{rand 99}" }

      it "has the pre class set to the language" do
        expect(subject.block_code(code, language)).
          to match(%r{\A\s*<pre class="#{language}">})
      end
    end

    context "without language" do
      it "has pre without class" do
        expect(subject.block_code(code, nil)).
          to match(%r{\A\s*<pre>})
      end
    end

    it "wraps the text in a <code> tag" do
      text = "#{rand 99} text #{rand 99}"
      expect(subject.block_code(text, nil)).
        to match(%r{<code>#{Regexp.quote text}</code>})
    end

    it "escapes the code text" do
      CGI.should_receive(:escapeHTML).and_return('text')
      subject.block_code('whatever', nil)
    end

    it "ends with </pre>" do
      expect(subject.block_code('whatever', nil)).
        to match(%r{</pre>\s*\Z})
    end

    it "has no space between <pre> and <code>" do
      expect(subject.block_code('whatever', nil)).
        to match(%r{<pre[^>]*><code>})
    end

    it "has no space between </pre> and </code>" do
      expect(subject.block_code('whatever', nil)).
        to match(%r{</code></pre>})
    end
  end

  describe "prepare_code" do
    context "with @@source = filename" do
      around { |example| Dir.mktmpdir { |dir| @tmpdir = Pathname.new dir; example.run } }
      let(:filename) { @tmpdir + "file#{rand 99}" }

      it "loads the contents from filename" do
        text = "#{rand 99} bottles of beer"
        filename.open('w') { |f| f.write text }

        expect(subject.prepare_code "@@source = #{filename}").to eq(text)
      end
    end

    context "without @@source" do
      it "returns the text" do
        text = "#{rand 99} luft balloons."
        expect(subject.prepare_code text).to eq(text)
      end
    end
  end
end
