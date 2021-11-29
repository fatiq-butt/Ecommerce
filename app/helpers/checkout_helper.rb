module CheckoutHelper
  def countries_drop_down
    CS.countries.map { |c| [c[1], c[0]] }
  end

  def state_drop_down
    if current_user.country.present?
      CS.states(current_user.country).map { |c| [c[1], c[0]] }
    else
      []
    end
  end

  def city_drop_down
    if current_user.state.present?
        CS.cities(current_user.state, current_user.country).map{|cit| [cit,cit]}
    else
      []
    end
  end
end
