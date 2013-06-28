require 'spec_helper'
require 'magic_reveal/conductor'

describe MagicReveal::Conductor do
  subject { described_class.new }

  around do |example|
    Dir.mktmpdir('conductor') do |tmpdir|
      @tmpdir = Pathname.new tmpdir
      example.run
    end
  end

  describe "#new" do
    it { should be_kind_of(described_class) }
  end

  describe ".url" do
    subject { described_class.new 'http://example.com/' }

    its(:url) { should be_kind_of(URI) }
  end

  describe ".fetch" do
    it "should save a file" do
      subject.url = "http://google.com/"
      save_file = @tmpdir + 'index.html'
      subject.fetch save_file
      save_file.should exist
    end
  end

  describe ".unpack" do
    let(:unpack_dir) { @tmpdir + "unpack-#{rand 200}" }
    context "given a zipfile" do
      let(:zipfile) { EXAMPLE_DATA + 'wrapped.zip' }

      it "unpacks and unwraps the zipfile" do
        subject.unpack zipfile, unpack_dir
        (unpack_dir + 'testfile.md').should exist
      end

      context "and the unpack directory exists already" do
        before { unpack_dir.mkdir }

        it "should raise an error" do
          expect { subject.unpack zipfile, unpack_dir }.to raise_error(MagicReveal::Error)
        end
      end
    end
  end
end
