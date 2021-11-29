class GenerateReceipt
  include Interactor

  def call
    context.fail!(message: "Could not generate receipt") unless context.order.gnerate_receipt(context.cart_line_items)
  end
end
