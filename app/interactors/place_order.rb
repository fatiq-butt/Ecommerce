class PlaceOrder
  include Interactor::Organizer

  organize MakePayment, ConfirmOrder, GenerateReceipt
end
