class ProductsController < ApplicationController
  def index
    @cart = Cart.from_session(session)
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      flash[:notice] = 'Product successfully created.'
      redirect_to @product
    else
      flash[:alert] = 'Error creating product.'
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])

    if @product.update(product_params)
      redirect_to @product
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])

    if @product.destroy
      flash[:notice] = 'Product successfully deleted.'
    else
      flash[:alert] = 'Error deleting product.'
    end

    redirect_to products_path
  end

  private

  def product_params
    params.require(:product).permit(
      :name,
      :description,
      :image,
      :price_cents
    )
  end
end
