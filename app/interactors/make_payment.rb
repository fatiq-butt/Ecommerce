class MakePayment
  include Interactor

  def call
    if context.payment_method == "card"
      session = Stripe::Checkout::Session.create({
          payment_method_types: ['card'],
          line_items: context.items,
          mode: 'payment',
          success_url: "http://localhost:3000/",
          cancel_url: "http://localhost:3000/",
        })
      if session
        context.session = session
      else
        context.fail!(message: "can't create session")
      end
    end
  end
end
