class Category
  attr_reader :id, :name, :budget

  def initialize(attributes)
    @id = attributes['id'].to_i
    @name = attributes['name']
    @budget = attributes['budget'].to_f
  end
end
