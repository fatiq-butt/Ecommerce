class GenerateReceipt
  include Interactor

  def call
    if !context.order.gnerate_receipt(context.cart_line_items)
      context.fail!(message: "Could not generate receipt")
    end
  end
end
