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
    expenses = Category.category_expenses_list(test_category.id)
    expect(expenses).to eq [test_expense]
  end

  it 'associates categories with an expense and returns all categories associated with an expense' do
    test_expense = Expense.new({'name' => 'Windex', 'company' => 'Target', 'amount' => 3.00, 'date' => '2014-08-16'})
    test_expense.save
    test_expense1 = Expense.new({'name' => 'Tires', 'company' => 'Costco', 'amount' => 199.98, 'date' => '2014-08-17'})
    test_expense1.save
    test_expense2 = Expense.new({'name' => 'Groceries', 'company' => 'Target', 'amount' => 75.49, 'date' => '2014-08-20'})
    test_expense2.save
    test_category = Category.new({'name' => 'Home', 'budget' => 300.00})
    test_category.save
    test_category1 = Category.new({'name' => 'Car', 'budget' => 150.00})
    test_category1.save
    Expense.expense_summary(test_expense.id, test_category.id)
    Expense.expense_summary(test_expense.id, test_category1.id)
    Expense.expense_summary(test_expense1.id, test_category1.id)
    Expense.expense_summary(test_expense2.id, test_category.id)
    categories = Category.expenses_category_list(test_expense.id)
    expect(categories).to eq [test_category, test_category1]
  end

  it 'returns the sum of all the purchases made at a company' do
    test_expense = Expense.new({'name' => 'Windex', 'company' => 'Target', 'amount' => 3.00, 'date' => '2014-08-16'})
    test_expense.save
    test_expense1 = Expense.new({'name' => 'Tires', 'company' => 'Costco', 'amount' => 199.98, 'date' => '2014-08-17'})
    test_expense1.save
    test_expense2 = Expense.new({'name' => 'Groceries', 'company' => 'Target', 'amount' => 75.49, 'date' => '2014-08-20'})
    test_expense2.save
    test_category = Category.new({'name' => 'Home', 'budget' => 300.00})
    test_category.save
    test_category1 = Category.new({'name' => 'Car', 'budget' => 150.00})
    test_category1.save
    Expense.expense_summary(test_expense.id, test_category.id)
    Expense.expense_summary(test_expense.id, test_category1.id)
    Expense.expense_summary(test_expense1.id, test_category1.id)
    Expense.expense_summary(test_expense2.id, test_category.id)
    company_total = Expense.company_total('Target')
    expect(company_total).to eq 78.49
  end

  it 'returns the sum of all the purchases made in a category' do
    test_expense = Expense.new({'name' => 'Desk', 'company' => 'Target', 'amount' => 99.99, 'date' => '2014-08-16'})
    test_expense.save
    test_expense1 = Expense.new({'name' => 'Tires', 'company' => 'Costco', 'amount' => 199.98, 'date' => '2014-08-17'})
    test_expense1.save
    test_expense2 = Expense.new({'name' => 'Groceries', 'company' => 'Target', 'amount' => 75.49, 'date' => '2014-08-20'})
    test_expense2.save
    test_category = Category.new({'name' => 'Home', 'budget' => 300.00})
    test_category.save
    test_category1 = Category.new({'name' => 'Car', 'budget' => 150.00})
    test_category1.save
    Expense.expense_summary(test_expense.id, test_category.id)
    Expense.expense_summary(test_expense.id, test_category1.id)
    Expense.expense_summary(test_expense1.id, test_category1.id)
    Expense.expense_summary(test_expense2.id, test_category.id)
    category_total = Expense.category_total(test_category.id)
    expect(category_total).to eq 175.48
  end

  it 'returns the percentage of each category spent at a particular company' do
    test_expense = Expense.new({'name' => 'Desk', 'company' => 'Target', 'amount' => 99.99, 'date' => '2014-08-16'})
    test_expense.save
    test_expense1 = Expense.new({'name' => 'Tires', 'company' => 'Costco', 'amount' => 199.98, 'date' => '2014-08-17'})
    test_expense1.save
    test_expense2 = Expense.new({'name' => 'Groceries', 'company' => 'Target', 'amount' => 75.49, 'date' => '2014-08-20'})
    test_expense2.save
    test_expense3 = Expense.new({'name' => 'Laundry stuff', 'company' => 'Safeway', 'amount' => 21.99, 'date' => '2014-08-21'})
    test_expense3.save
    test_category = Category.new({'name' => 'Home', 'budget' => 300.00})
    test_category.save
    test_category1 = Category.new({'name' => 'Car', 'budget' => 150.00})
    test_category1.save
    Expense.expense_summary(test_expense.id, test_category.id)
    Expense.expense_summary(test_expense.id, test_category1.id)
    Expense.expense_summary(test_expense1.id, test_category1.id)
    Expense.expense_summary(test_expense2.id, test_category.id)
    Expense.expense_summary(test_expense3.id, test_category.id)
    company_total = Expense.company_total('Target')
    category_total = Expense.category_total(test_category.id)
    percentage = Expense.company_percentage_by_category(company_total, category_total)
    expect(percentage).to eq 0.8886413126044462
  end

  it 'returns the purchases made in a specified time period' do
    test_expense = Expense.new({'name' => 'Desk', 'company' => 'Target', 'amount' => 99.99, 'date' => '2014-08-16'})
    test_expense.save
    test_expense1 = Expense.new({'name' => 'Tires', 'company' => 'Costco', 'amount' => 199.98, 'date' => '2014-08-17'})
    test_expense1.save
    test_expense2 = Expense.new({'name' => 'Groceries', 'company' => 'Target', 'amount' => 75.49, 'date' => '2014-08-20'})
    test_expense2.save
    test_expense3 = Expense.new({'name' => 'Laundry stuff', 'company' => 'Safeway', 'amount' => 21.99, 'date' => '2014-08-21'})
    test_expense3.save
    test_category = Category.new({'name' => 'Home', 'budget' => 300.00})
    test_category.save
    test_category1 = Category.new({'name' => 'Car', 'budget' => 150.00})
    test_category1.save
    Expense.expense_summary(test_expense.id, test_category.id)
    Expense.expense_summary(test_expense.id, test_category1.id)
    Expense.expense_summary(test_expense1.id, test_category1.id)
    Expense.expense_summary(test_expense2.id, test_category.id)
    Expense.expense_summary(test_expense3.id, test_category.id)
    test_date = '2014-08-16'
    test_date1 = '2014-08-17'
    purchases = Expense.purchases_during_time(test_date, test_date1)
    expect(purchases).to eq [test_expense, test_expense1]
  end

  it 'tells the user if they have exceeded their monthly budget for a category' do
    test_expense = Expense.new({'name' => 'Desk', 'company' => 'Target', 'amount' => 249.99, 'date' => '2014-08-16'})
    test_expense.save
    test_expense1 = Expense.new({'name' => 'Tires', 'company' => 'Costco', 'amount' => 199.98, 'date' => '2014-08-17'})
    test_expense1.save
    test_expense2 = Expense.new({'name' => 'Groceries', 'company' => 'Target', 'amount' => 75.49, 'date' => '2014-08-20'})
    test_expense2.save
    test_expense3 = Expense.new({'name' => 'Laundry stuff', 'company' => 'Safeway', 'amount' => 21.99, 'date' => '2014-08-21'})
    test_expense3.save
    test_category = Category.new({'name' => 'Home', 'budget' => 300.00})
    test_category.save
    test_category1 = Category.new({'name' => 'Car', 'budget' => 150.00})
    test_category1.save
    Expense.expense_summary(test_expense.id, test_category.id)
    Expense.expense_summary(test_expense.id, test_category1.id)
    Expense.expense_summary(test_expense1.id, test_category1.id)
    Expense.expense_summary(test_expense2.id, test_category.id)
    Expense.expense_summary(test_expense3.id, test_category.id)
    category_total = Expense.category_total(test_category.id)
    budget_total = Expense.budget_total(test_category.id)
    binding.pry
    overbudget = Expense.budget_check(category_total, budget_total)
    expect(overbudget).to eq true
  end
end
