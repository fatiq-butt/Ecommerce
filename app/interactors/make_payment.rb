class MakePayment
  include Interactor

  def call
    @session = Stripe::Checkout::Session.create({
        payment_method_types: ['card'],
        line_items: context.items,
        mode: 'payment',
        success_url: "http://localhost:3000/",
        cancel_url: "http://localhost:3000/",
      })
  end
end
