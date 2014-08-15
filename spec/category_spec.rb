require 'spec_helper'

describe Category do
  it 'initializes a category with a name and/or budget' do
    test_category = Category.new({'name' => 'Home', 'budget' => 300.00})
    expect(test_category).to be_an_instance_of Category
  end

  it 'saves the category to the database' do
    test_category = Category.new({'name' => 'Home', 'budget' => 300.00})
    test_category.save
    expect(Category.all).to eq [test_category]
  end

  it 'returns the category id based on the name' do
    test_category = Category.new({'name' => 'Home', 'budget' => 300.00})
    test_category.save
    category_id = Category.search_return_id(test_category.name)
    expect(category_id).to eq test_category.id
  end

  it 'updates the monthly budget total' do
    test_category = Category.new({'name' => 'Home', 'budget' => 300.00})
    test_category.save
    new_budget = 500.00
    category_id = Category.search_return_id(test_category.name)
    updated_category = Category.update_budget(category_id, new_budget)
    expect(updated_category.first.budget).to eq 500.00
  end
end
