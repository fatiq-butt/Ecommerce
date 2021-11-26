class ConfirmOrder
  include Interactor

  def call
    context.fail!(message: "Could not confirm the order") unless context.order.confrimed_order
  end
end
