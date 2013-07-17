require 'spec_helper'
require 'magic_reveal/cli/options'

describe MagicReveal::Cli::Options do
  describe ".parse" do
    before { subject.parse args }

    context "given 'new <project>'" do
      let(:args) { %w{new someproject} }

      its(:command) { should be(:new) }
      its(:project) { should eq('someproject') }
    end

    context "given 'new <project> extrajunk'" do
      let(:args) { %w{new someproject extrajunk} }

      its(:command) { should be(:help) }
      its(:project) { should be_nil }
    end

    context "given 'help'" do
      let(:args) { %w{help} }

      its(:command) { should be(:help) }
    end

    context "given no arguments" do
      let(:args) { [] }

      its(:command) { should be(:help) }
    end
  end
end
