require 'spec_helper'
require 'magic_reveal'

describe MagicReveal do
  it 'should have a version number' do
    MagicReveal::VERSION.should_not be_nil
  end
end
