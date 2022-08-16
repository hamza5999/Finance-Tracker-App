class StocksController < ApplicationController
  def search
    # byebug  - to see params hash value (Easy-to-Use Rails Debugger)
    if params[:stock].present?
      @stock = Stock.new_lookup(params[:stock])
      if @stock
        respond_to do |format|
          format.js { render partial: 'users/result' }
        end
      else
        respond_to do |format|
          flash.now[:alert] = "Enter a valid symbol please !!"
          format.js { render partial: 'users/result' }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Enter a symbol please !!"
        format.js { render partial: 'users/result' }
      end
    end
  end
end
