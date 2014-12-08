require 'spec_helper'

describe Customer do
  it 'is a Person' do
    should be_kind_of(Person)
  end

  it 'has orders' do
    should respond_to(:orders)
  end
end
