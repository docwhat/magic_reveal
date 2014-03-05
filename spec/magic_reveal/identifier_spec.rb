require 'spec_helper'
require 'magic_reveal/identifier'

describe MagicReveal::Identifier do
  subject { described_class.new sys_admin }
  let(:sys_admin) { double(Sys::Admin).as_null_object }

  describe '.name' do
    before do
      sys_admin.stub(:respond_to?)
    end

    it 'gets the login' do
      subject.name
      expect(sys_admin).to have_received(:get_login)
    end

    it 'passes the login to get_user' do
      subject.name
      expect(sys_admin).to have_received(:get_user).with(sys_admin.get_login)
    end

    context 'the user has a full_name' do
      let(:user) { double(Sys::Admin::User) }
      before do
        sys_admin.stub(:get_user).with(sys_admin.get_login).and_return(user)
        sys_admin.stub(:respond_to?).with(:full_name).and_return(true)
      end

      it 'returns the full_name' do
        name = double('full_name')
        user.should receive(:full_name).and_return(name)
        expect(subject.name).to eq(name)
      end
    end

    context 'the user has a simple gecos' do
      let(:user) { double(Sys::Admin::User) }
      before do
        sys_admin.stub(:get_user).with(sys_admin.get_login).and_return(user)
      end

      it 'returns the gecos' do
        gecos = "Joe Cool #{rand 99}"
        user.should receive(:gecos).and_return(gecos)
        expect(subject.name).to eq(gecos)
      end
    end

    context 'the user has a comma-delimited gecos' do
      let(:user) { double(Sys::Admin::User) }
      before do
        sys_admin.stub(:get_user).with(sys_admin.get_login).and_return(user)
      end

      it 'returns the gecos' do
        name = "Joe Cool #{rand 99}"
        gecos = "#{name},White House,412 555-1212,"
        user.should receive(:gecos).and_return(gecos)
        expect(subject.name).to eq(name)
      end
    end

    context 'the user has an empty comma-delimited gecos' do
      it 'returns the gecos' do
        login = "joecool#{rand 99}"
        user = double(Sys::Admin::User)

        sys_admin.stub(:get_login).and_return(login)
        sys_admin.stub(:get_user).with(login).and_return(user)

        user.should receive(:gecos).and_return(',,,')
        expect(subject.name).to eq(login)
      end
    end

    context 'the user has an empty gecos' do
      it 'returns the gecos' do
        login = "joecool#{rand 99}"
        user = double(Sys::Admin::User)

        sys_admin.stub(:get_login).and_return(login)
        sys_admin.stub(:get_user).with(login).and_return(user)

        user.should receive(:gecos).and_return('')
        expect(subject.name).to eq(login)
      end
    end
  end

  describe '#name (an alias)' do
    it 'calls .name on an instance' do
      instance = double(described_class).as_null_object
      described_class.stub(:new).and_return(instance)
      expect(described_class.name).to be(instance.name)
    end
  end
end
