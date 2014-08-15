class Expense
  attr_reader :id, :name, :company, :amount, :date

  def initialize (attributes)
    @id = attributes['id'].to_i
    @name = attributes['name']
    @name = attributes['company']
    @amount = attributes['amount'].to_f
    @date = attributes['date']
  end
end
