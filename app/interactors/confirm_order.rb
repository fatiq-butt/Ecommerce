class ConfirmOrder
  include Interactor

  def call
    if !context.order.confrimed_order
      context.fail!(message: "Could not confirm the order")
    end
  end
end
