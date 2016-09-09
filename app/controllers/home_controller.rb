class HomeController < ApplicationController
  def index
    @contacts = current_user.contacts.order(last_touch_at: :desc).includes(:conversation)
  end
end
