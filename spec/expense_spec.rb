require 'spec_helper'

describe Expense do
  it 'initializes an expense with a name, company, amount, and date' do
    test_expense = Expense.new({'name' => 'Pizza', 'company' => 'Sizzle Pie', 'amount' => 5.00, 'date' => '2014-08-16'})
    expect(test_expense).to be_an_instance_of Expense
  end
end
