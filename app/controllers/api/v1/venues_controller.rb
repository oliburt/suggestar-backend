class Api::V1::VenuesController < ApplicationController
    def index
        render json: Venue.all
    end

    def show
        render json: Venue.find(params[:id])
    end

    def create
        venue = Venue.create(venue_params)
        venue.update(user: @current_user)
        if venue.valid?
            render json: venue
        else
            render json: { errors: venue.errors.full_messages }, status: :not_accepted
        end
    end

    private

    def venue_params
        params.require(:venue).permit(:name, :description, :place_id, :latitude, :longitude)
    end
end
