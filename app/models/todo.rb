class Todo < ActiveRecord::Base
  attr_accessible :done, :order, :title, :due_date, :important

  before_save :set_order_value

  scope :order_by_importance, -> { order('done ASC, important DESC, created_at ASC') }

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
