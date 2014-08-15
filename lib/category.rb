class Category
  attr_reader :id, :name, :budget

  def initialize(attributes)
    @id = attributes['id'].to_i
    @name = attributes['name']
    @budget = attributes['budget'].to_f
  end

  def ==(another_category)
    self.id == another_category.id && self.name == another_category.name && self.budget == another_category.budget
  end

  def save
    results = DB.exec("INSERT INTO categories (name, budget) VALUES ('#{name}', #{budget}) RETURNING id;")
    @id = results.first['id'].to_i
  end

  def self.all
    results = DB.exec("SELECT * FROM categories;")
    categories_list = []
    results.each do |result|
      new_category = Category.new(result)
      categories_list << new_category
    end
    categories_list
  end

  def self.category_expenses_list(category_id)
    results = DB.exec("SELECT expenses.* FROM categories JOIN expense_summary ON (categories.id = expense_summary.category_id) JOIN expenses ON (expense_summary.expense_id = expenses.id) WHERE categories.id = #{category_id};")
    expenses_list = []
    results.each do |result|
      new_expense = Expense.new(result)
      expenses_list << new_expense
    end
    expenses_list
  end

  def self.expenses_category_list(expense_id)
    results = DB.exec("SELECT categories.* FROM expenses JOIN expense_summary ON (expenses.id = expense_summary.expense_id) JOIN categories ON (expense_summary.category_id = categories.id) WHERE expenses.id = #{expense_id};")
    categories_list = []
    results.each do |result|
      new_category = Category.new(result)
      categories_list << new_category
    end
    categories_list
  end
end
