class ConfirmOrder
  include Interactor

  def call
    context.order.confrimed_order()
  end
end
