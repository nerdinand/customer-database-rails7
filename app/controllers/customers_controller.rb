class CustomersController < ApplicationController
  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      flash[:notice] = 'Customer successfully created.'
      redirect_to @customer
    else
      flash[:alert] = 'Error creating customer.'
      render :new
    end
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])

    if @customer.update(customer_params)
      redirect_to @customer
    else
      render :edit
    end
  end

  def destroy
    @customer = Customer.find(params[:id])

    if @customer.destroy
      flash[:notice] = 'Customer successfully deleted.'
    else
      flash[:alert] = 'Error deleting customer.'
    end

    redirect_to customers_path
  end

  private

  def customer_params
    params.require(:customer).permit(
      :name,
      :address,
      :zip_code,
      :city,
      :phone_number,
      :email
    )
  end
end
