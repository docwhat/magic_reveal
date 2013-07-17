require 'spec_helper'
require 'magic_reveal/cli'


describe MagicReveal::Cli do
  describe ".run" do
    it "sets up the Options" do
      args = double('ARGV')
      subject.stub(:options).and_return(double(MagicReveal::Cli::Options))
      subject.options.should_receive(:parse).with(args)
      subject.run args
    end
  end

  describe ".options" do
    it "responds to 'parse'" do
      subject.options.should respond_to(:parse)
    end
  end
end
