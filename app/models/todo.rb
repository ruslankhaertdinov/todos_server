class Todo < ActiveRecord::Base
  attr_accessible :done, :order, :title, :due_date, :important

  before_save :set_order_value

  scope :ordered, -> { order('created_at ASC') }
  scope :full_ordered, -> { order('important DESC, due_date ASC, created_at DESC') }

  protected

  def set_order_value
    last_order = Todo.last.order if Todo.last
    order_value = if last_order
                    last_order + 1
                  else
                    0
                  end
    self.order = order_value
  end
end
