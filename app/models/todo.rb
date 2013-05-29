class Todo < ActiveRecord::Base
  attr_accessible :boolean, :done, :integer, :order, :string, :title
end
