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
end
