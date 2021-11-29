class OrderProcessor
  include Interactor::Organizer

  organize ConfirmOrder, GenerateReceipt
end
