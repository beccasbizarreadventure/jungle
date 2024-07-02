class Admin::DashboardController < ApplicationController

  http_basic_authenticate_with name: ENV["admin_username"], password: ENV["admin_password"]

  def show
    @category_count = Category.count
    @product_count = Product.count
  end
end
