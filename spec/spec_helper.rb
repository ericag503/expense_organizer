require 'expense'
require 'category'
require 'expense_summary'
require 'PG'

DB = PG.connect({:dbname => 'expense_organizer_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM expenses *;")
    DB.exec("DELETE FROM categories *;")
    DB.exec("DELETE FROM expense_summary *;")
  end
end
