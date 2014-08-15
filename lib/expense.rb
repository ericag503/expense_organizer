class Expense
  attr_reader :id, :name, :company, :amount, :date

  def initialize (attributes)
    @id = attributes['id'].to_i
    @name = attributes['name']
    @company = attributes['company']
    @amount = attributes['amount'].to_f
    @date = attributes['date']
  end

  def self.all
    results = DB.exec("SELECT * FROM expenses;")
    expense_list = []
    results.each do |result|
      new_expense = Expense.new(result)
      expense_list << new_expense
    end
    expense_list
  end

  def save
    results = DB.exec("INSERT INTO expenses (name, company, amount, date) VALUES ('#{name}', '#{company}', #{amount}, '#{date}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def ==(another_expense)
    self.name == another_expense.name && self.company == another_expense.company && self.amount == another_expense.amount && self.date == another_expense.date && self.id == another_expense.id
  end

  def self.expense_summary(expense_id, category_id)
    results = DB.exec("INSERT INTO expense_summary (expense_id, category_id) VALUES (#{expense_id}, #{category_id}) RETURNING id;")
    expense_summary_id = results.first['id']
  end

  def self.company_total(company)
    results = DB.exec("SELECT SUM(amount) FROM expenses WHERE company = '#{company}';")
    total = results.first['sum'].to_f
  end

  def self.category_total(category_id)
    results = DB.exec("SELECT SUM(expenses.amount) FROM categories JOIN expense_summary ON (categories.id = expense_summary.category_id) JOIN expenses ON (expense_summary.expense_id = expenses.id) WHERE categories.id = #{category_id};")
    total = results.first['sum'].to_f
  end

  def self.company_percentage_by_category(company_total, category_total)
    company_total / category_total
  end

  def self.purchases_during_time(date1, date2)
    results = DB.exec("SELECT * FROM expenses WHERE date BETWEEN '#{date1}' AND '#{date2}';")
    purchases = []
    results.each do |result|
      new_expense = Expense.new(result)
      purchases << new_expense
    end
    purchases
  end

  def self.budget_total(id)
    results = DB.exec("SELECT budget FROM categories WHERE id = #{id};")
    total = results.first['budget'].to_f
  end

  def self.budget_check(category_total, budget_total)
    category_total >= budget_total
  end
end
