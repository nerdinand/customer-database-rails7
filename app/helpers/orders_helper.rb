module OrdersHelper
  def order_filters_active_class(filter)
    if filter == :all
      !params[:delivered] && !params[:paid]
    elsif filter == :delivered
      params[:delivered]
    elsif filter == :paid
      params[:paid]
    end ? 'active' : ''
  end
end
