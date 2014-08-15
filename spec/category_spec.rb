require 'spec_helper'

describe Category do
  it 'initializes a category with a name and/or budget' do
    test_category = Category.new({'name' => 'Home', 'budget' => 300.00})
    expect(test_category).to be_an_instance_of Category
  end
end
