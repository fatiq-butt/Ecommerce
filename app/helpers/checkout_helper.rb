module CheckoutHelper
  def countries_drop_down
    CS.countries.map { |c| [c[1], c[0]] }
  end
end
