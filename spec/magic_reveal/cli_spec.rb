require 'spec_helper'
require 'magic_reveal/cli'

describe MagicReveal::Cli do
  describe '.run' do
    context 'with a null options' do
      let(:options) { double(MagicReveal::Cli::Options).as_null_object }
      let(:args) { double('ARGV') }
      before do
        subject.stub(:show_help)
        subject.stub(:avenge_programmer)
        subject.stub(:options).and_return(options)
      end

      context 'command=nil' do
        before { subject.run args }

        it 'parses the args' do
          expect(options).to have_received(:parse).with(args)
        end

        it 'fetches the command' do
          expect(options).to have_received(:command)
        end

        it 'avenges the programmer' do
          expect(subject).to have_received(:avenge_programmer)
        end
      end

      context 'command=new' do
        let(:creator) { double(MagicReveal::Creator).as_null_object }
        before do
          subject.creator = creator
          options.stub(:command).and_return(:new)
          subject.run args
        end

        it 'fetches the project' do
          expect(options).to have_received(:project)
        end

        it 'creates the project' do
          expect(creator)
            .to have_received(:create_project)
            .with(options.project)
        end
      end

      context 'command=help' do
        it 'shows help' do
          subject.stub(:show_help)
          subject.should_receive(:show_help).and_return(nil)
          options.stub(:command).and_return(:help)
          subject.run args
        end
      end

      context 'command=start' do
        it 'starts the server' do
          subject.stub(:start_server)
          subject.should_receive(:start_server).and_return(nil)
          options.stub(:command).and_return(:start)
          subject.run args
        end
      end

      context 'command=static' do
        it 'creates a static file' do
          subject.stub(:create_static)
          subject.should_receive(:create_static).and_return(nil)
          options.stub(:command).and_return(:static)
          subject.run args
        end
      end
    end
  end

  describe '.creator' do
    it 'sends new to creator' do
      MagicReveal::Creator.should_receive(:new).with(Dir.getwd)
      subject.creator
    end
  end

  describe '.options' do
    it "responds to 'parse'" do
      subject.options.should respond_to(:parse)
    end
  end
end
