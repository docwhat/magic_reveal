require 'spec_helper'
require 'magic_reveal/reveal_js_fetcher'

describe MagicReveal::RevealJsFetcher do
  subject { described_class.new version }
  let(:version) { "#{rand 9}.#{rand 9}.#{rand 9}" }

  describe "#new" do
    its(:version) { should be(version) }
  end

  describe ".zip_url" do
    its(:zip_url) { should match(/#{Regexp.escape version}\.zip\Z/) }
  end

  describe ".conductor" do
    it "uses the zip_url" do
      MagicReveal::Conductor.should_receive(:new).with(subject.zip_url)
      subject.conductor
    end

    it "returns the conductor" do
      expect(subject.conductor).to be_kind_of(MagicReveal::Conductor)
    end
  end

  describe ".save_to" do
    let(:conductor) { double(MagicReveal::Conductor).as_null_object }
    let(:reveal_dir) { Pathname.new(Dir.tmpdir) + "save_to_test#{rand 99}" }
    before do
      subject.conductor = conductor
      conductor.stub(:fetch) { |zipfile| @zipfile = zipfile }
      subject.save_to reveal_dir
    end

    it "uses conductor to fetch the zipfile" do
      expect(conductor).to have_received(:fetch).with(anything)
    end

    it "uses conductor to fetch the zipfile" do
      expect(conductor).to have_received(:unpack).
        with(@zipfile, reveal_dir)
    end
  end
end
