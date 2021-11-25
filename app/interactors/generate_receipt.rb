class GenerateReceipt
  include Interactor

  def call
    context.order.gnerate_receipt(context.cart_line_items)
  end
end
