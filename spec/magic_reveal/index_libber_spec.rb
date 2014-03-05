require 'spec_helper'
require 'magic_reveal/index_libber'

describe MagicReveal::IndexLibber do
  subject { described_class.new html_text }
  let(:html_text) { nil }

  describe '.set_meta' do
    shared_examples 'it is passed a name and content' do
      let(:name) { "name#{rand 99}" }
      let(:content) { "any old content ###{rand 99}" }

      it 'creates the node' do
        subject.set_meta name, content

        node = subject.html.at_css("meta[@name=#{name}]")
        expect(node).to_not be_nil

        content_attr = node[:content]
        expect(content_attr).to eq(content)
      end
    end

    context 'with a html > meta node' do
      let(:html_text) { "<!DOCTYPE html><meta name=\"#{name}\" content=\"#{content}\"><p>text" }

      it_behaves_like 'it is passed a name and content'
    end

    context 'with a html > head > meta node' do
      let(:html_text) { "<!DOCTYPE html><head><meta name=\"#{name}\" content=\"#{content}\"></head><p>text" }

      it_behaves_like 'it is passed a name and content'
    end

    context 'without a meta node' do
      let(:html_text) { '<!DOCTYPE html><p>text' }

      it_behaves_like 'it is passed a name and content'
    end
  end

  describe '.author=' do
    it 'calls set_meta' do
      author = Faker::Name.name
      subject.should_receive(:set_meta).with('author', author)
      subject.author = author
    end
  end

  describe '.description=' do
    it 'calls set_meta' do
      description = Faker::Lorem.paragraph
      subject.should_receive(:set_meta).with('description', description)
      subject.description = description
    end
  end

  describe '.slides=' do
    let(:title)     { Faker::Lorem.sentence  }
    let(:paragraph) { Faker::Lorem.paragraph }
    let(:slides)    { "<section><h2>#{title}</h2><p>#{paragraph}</section>" * 2 }

    it 'inserts the slides' do
      subject.slides = slides
      expect(subject.html.at_css('h2').text).to eq(title)
      expect(subject.html.at_css('p').text).to eq(paragraph)
    end

    it 'sets the title from the first Hx item' do
      subject.slides = slides
      expect(subject.html.at_css('title').text).to eq(title)
    end
  end

  describe '.theme=' do
    let(:theme) { Faker::Name.first_name }

    it 'sets the theme node' do
      subject.theme = theme
      expect(subject.html.at_css('#theme')[:href]).to match(%r{/#{theme}\.css\Z})
    end

    context 'with an empty doc' do
      let(:html_text) { '<!DOCTYPE html>text' }

      it 'handles creating a new link#theme node' do
        subject.theme = theme
        link = subject.html.at_css('link')
        expect(link).to_not be_nil
        expect(link[:id]).to eq('theme')
        expect(link[:rel]).to eq('stylesheet')
        expect(link[:href]).to match(%r{/#{theme}\.css\Z})
      end
    end
  end
end
