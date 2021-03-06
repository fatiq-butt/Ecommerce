class RegistrationsController < Devise::RegistrationsController
  before_action :find_orders, only: [:show]

  def new
    build_resource
    respond_to do |format|
      format.js
    end
  end

  def create
    build_resource(sign_up_params)
    resource.save
    respond_to do |format|
      format.js do
        yield resource if block_given?
        if resource.persisted?
          if resource.active_for_authentication?
            set_flash_message! :notice, :signed_up
            sign_up(resource_name, resource)
            respond_with resource, location: after_sign_up_path_for(resource)
          else
            set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}"
            expire_data_after_sign_in!
            respond_with resource, location: after_inactive_sign_up_path_for(resource)
          end
        else
          clean_up_passwords resource
          set_minimum_password_length
        end
      end
    end
  end

  private

  def find_orders
    @orders = current_user.orders.where(confirmed: true)
  end
end
