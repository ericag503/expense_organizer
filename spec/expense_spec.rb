require 'spec_helper'

describe Expense do
  it 'initializes an expense with a name, company, amount, and date' do
    test_expense = Expense.new({'name' => 'Pizza', 'company' => 'Sizzle Pie', 'amount' => 5.00, 'date' => '2014-08-16'})
    expect(test_expense).to be_an_instance_of Expense
  end

  it 'saves and expense to the database' do
    test_expense = Expense.new({'name' => 'Pizza', 'company' => 'Sizzle Pie', 'amount' => 5.00, 'date' => '2014-08-16'})
    test_expense.save
    expect(Expense.all).to eq [test_expense]
  end

  it 'associates a category with an expense and returns all expenses associated with a category' do
    test_expense = Expense.new({'name' => 'Pizza', 'company' => 'Sizzle Pie', 'amount' => 5.00, 'date' => '2014-08-16'})
    test_expense.save
    test_category = Category.new({'name' => 'Food', 'budget' => 300.00})
    test_category.save
    Expense.expense_summary(test_expense.id, test_category.id)
    binding.pry
    expenses = Category.category_expenses_list(test_category.id)
    expect(expenses).to eq [test_expense]
  end
end
