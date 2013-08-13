require 'spec_helper'
require 'magic_reveal/cli'


describe MagicReveal::Cli do
  describe ".run" do
    context "with a null options" do
      let(:options) { double(MagicReveal::Cli::Options).as_null_object }
      let(:args) { double("ARGV") }
      before { subject.stub(:options).and_return(options) }

      context "command=nil" do
        before { subject.run args }

        it "parses the args" do
          expect(options).to have_received(:parse).with(args)
        end

        it "fetches the command" do
          expect(options).to have_received(:command)
        end
      end

      context "command=new" do
        let(:creator) { double(MagicReveal::Creator).as_null_object }
        before do
          subject.creator = creator
          options.stub(:command).and_return(:new)
          subject.run args
        end

        it "fetches the project" do
          expect(options).to have_received(:project)
        end

        it "creates the project" do
          expect(creator).
            to have_received(:create_project).
            with(options.project)
        end
      end
    end
  end

  describe ".creator" do
    it "narf" do
      MagicReveal::Creator.should_receive(:new).with(Dir.getwd)
      subject.creator
    end
  end

  describe ".options" do
    it "responds to 'parse'" do
      subject.options.should respond_to(:parse)
    end
  end

end
