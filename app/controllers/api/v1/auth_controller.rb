class Api::V1::AuthController < ApplicationController
    
    def create
        user = User.find_by(email: login_params[:email])
        if user && user.authenticate(login_params[:password])
            render json: { token: issue_token({user_id: user.id}), user: UserSerializer.new(user)}
        else
            render json: { errors: ["Login credentials not valid!"]}, status: :not_found
        end
    end

    def validate
        if @current_user
            venues = Venue.all.map{|venue| VenueSerializer.new(venue) }
            if !params[:latitude] || !params[:longitude] || !params[:radius]
                render json: { token: issue_token({user_id: @current_user.id}), user: UserSerializer.new(@current_user), venues: venues, listings: { errors: ['Incorrect location params'] } }, status: :not_found
            else
                listings = Listing.all.filter{|listing| 
                        location1 = [listing.venue.latitude, listing.venue.longitude]
                        location2 = [params[:latitude].to_f, params[:longitude].to_f]
                        distance = get_distance(location1, location2)
                        distance <= params[:radius].to_f && listing.within_correct_time
                }.map{|listing| ListingSerializer.new(listing)}
                render json: { token: issue_token({user_id: @current_user.id}), user: UserSerializer.new(@current_user), venues: venues, listings: listings}
            end
        else
            venues = Venue.all.map{|venue| VenueSerializer.new(venue) }
            if !params[:latitude] && !params[:longitude] && !params[:radius]
                render json: { errors: ['user not found'], venues: venues, listings: { errors: ['Incorrect location params'] } }, status: :not_found
            else
                listings = Listing.all.filter{|listing| 
                        location1 = [listing.venue.latitude, listing.venue.longitude]
                        location2 = [params[:latitude].to_f, params[:longitude].to_f]
                        distance = get_distance(location1, location2)
                        distance <= params[:radius].to_f && listing.within_correct_time
                }.map{|listing| ListingSerializer.new(listing)}
                render json: { errors: ['user not found'], venues: venues, listings: listings }, status: :not_found
            end
        end
    end

    private

    def login_params
        params.require(:user).permit(:email, :password)
    end

    def get_distance(loc1, loc2)
        rad_per_deg = Math::PI/180  # PI / 180
        rkm = 6371                  # Earth radius in kilometers
        rm = rkm * 1000             # Radius in meters
      
        dlat_rad = (loc2[0]-loc1[0]) * rad_per_deg
        dlon_rad = (loc2[1]-loc1[1]) * rad_per_deg
      
        lat1_rad, lon1_rad = loc1.map {|i| i * rad_per_deg }
        lat2_rad, lon2_rad = loc2.map {|i| i * rad_per_deg }
      
        a = Math.sin(dlat_rad/2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon_rad/2)**2
        c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))
      
        rm * c
      end
end
