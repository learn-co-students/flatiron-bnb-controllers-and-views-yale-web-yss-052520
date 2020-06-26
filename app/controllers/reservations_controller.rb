class ReservationsController < ApplicationController
  before_action :find_reservation, only: [:edit, :update]
  def new()
    @reservation = Reservation.new
  end 

  def create()
    @reservation = Reservation.new(reservation_params)
    validate(new_reservation_path)
  end

  def edit
  end

  def update()
    @reservation.update(reservation_params)
    validate(edit_reservation_path)
  end

  private 

  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out, :listing_id, :guest_id)
  end

  def find_reservation()
      @reservation = Reservation.find(params[:id])
  end

  def validate(valid_path = reservation_path(@reservation), error_path)
      if @reservation.valid?
          @reservation.save
          redirect_to valid_path
      else
          flash[:errors] = @reservation.errors.full_messages
          redirect_to error_path
      end
  end
end
