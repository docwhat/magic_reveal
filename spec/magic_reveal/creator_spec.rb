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
       before { subject.create_project(project) }

      it "makes the project directory" do
        expect(@tmpdir + project).to be_directory
      end

      it "fetches and saves reveal.js" do
        expect(fetcher).
          to have_received(:save_to).
          with(@tmpdir + project + 'reveal.js')
      end
    end
  end
end
