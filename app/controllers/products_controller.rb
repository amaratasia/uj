# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]

  # GET /products or /products.json
  def index
    @products = current_user.products
    @products = @products.where(school_id: params[:school_id]) if @products && params[:school_id].presence && policy(@products).show_school_option? 
    @products = @products.where("name ilike '%?%'", params[:title]) if @products && params[:school_id].presence && policy(@products).show_school_option? 
  end

  # GET /products/1 or /products/1.json
  def show; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = current_user.products.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:store_product_id, :store_pid, :sku, :name, :description, :price, :school_id)
  end
end
