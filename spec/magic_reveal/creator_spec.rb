require 'spec_helper'
require 'magic_reveal/creator'
require 'pathname'

describe MagicReveal::Creator do
  before { subject.reveal_js_fetcher = fetcher }
  let(:fetcher) { double(MagicReveal::RevealJsFetcher).as_null_object }

  context "with a temporary directory" do
    subject { described_class.new @tmpdir }
    around { |example| Dir.mktmpdir { |dir| @tmpdir = Pathname.new dir; example.run } }

    its(:directory) { should eq(@tmpdir) }

    describe "create_project" do
      let(:project) { "project#{rand 99}" }
      before { FileUtils.stub(:copy_file)  }

      it "makes the project directory" do
        subject.create_project(project)
        expect(@tmpdir + project).to be_directory
      end

      it "fetches and saves reveal.js" do
        subject.create_project(project)
        expect(fetcher).
          to have_received(:save_to).
          with(@tmpdir + project + 'reveal.js')
      end

      it "copies the template_slides" do
        src = subject.template_slides
        dst = @tmpdir + project + 'slides.md'
        FileUtils.should_receive(:copy_file).with(src.to_s, dst.to_s)
        subject.create_project(project)
      end

      it "copies the template_config_ru" do
        src = subject.template_config_ru
        dst = @tmpdir + project + 'config.ru'
        FileUtils.should_receive(:copy_file).with(src.to_s, dst.to_s)
        subject.create_project(project)
      end
    end

    describe ".template_slides" do
      its(:template_slides) { should be_kind_of(Pathname) }
      its(:template_slides) { should be_file }
    end

    describe ".template_config_ru" do
      its(:template_config_ru) { should be_kind_of(Pathname) }
      its(:template_config_ru) { should be_file }
    end
  end
end
