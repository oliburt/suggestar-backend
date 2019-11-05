class Api::V1::ListingsController < ApplicationController
  
  def index
    listings = Listing.all
    if !params[:latitude] && !params[:longitude] && !params[:radius]
      render json: { errors: ['Incorrect Params provided'] }, status: :not_accepted
    else
      filteredListings = listings.filter do |listing| 
        location1 = [listing.venue.latitude, listing.venue.longitude]
        location2 = [params[:latitude].to_f, params[:longitude].to_f]
        distance = get_distance(location1, location2)
        distance <= params[:radius].to_f && within_correct_time(listing)
      end
      
      render json: filteredListings
    end
  end

  def show
    render json: Listing.find(params[:id])
  end

  def create
    # byebug
    if @current_user
      listing = Listing.create(title: listing_params[:title], description: listing_params[:description], begin_datetime: listing_params[:begin_datetime], end_datetime: listing_params[:end_datetime], venue_id: listing_params[:venue_id], age_restriction: listing_params[:age_restriction], ticket_url: listing_params[:ticket_url])
      if listing.valid?
        params[:category_ids].each do |id|
          ListingCategory.create(listing_id: listing.id, category_id: id)
        end
        render json: listing
      else
          render json: {errors: listing.errors.full_messages }, status: :not_accepted
      end
    else
      render json: { errors: ["Invalid User"]}, status: :forbidden
    end
  end

  private

  def listing_params
    params.require(:listing).permit(:title, :description, :ticket_url, :age_restriction, :begin_datetime, :end_datetime, :category_ids, :venue_id)
  end

  def get_distance(loc1, loc2)
    rad_per_deg = Math::PI/180  # PI / 180
    rkm = 6371                  # Earth radius in kilometers
    rm = rkm * 1000             # Radius in meters
  
    dlat_rad = (loc2[0]-loc1[0]) * rad_per_deg  # Delta, converted to rad
    dlon_rad = (loc2[1]-loc1[1]) * rad_per_deg
  
    lat1_rad, lon1_rad = loc1.map {|i| i * rad_per_deg }
    lat2_rad, lon2_rad = loc2.map {|i| i * rad_per_deg }
  
    a = Math.sin(dlat_rad/2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon_rad/2)**2
    c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))
  
    rm * c
  end

  def within_correct_time(listing)
    ((listing.begin_datetime.to_datetime >= DateTime.now && listing.begin_datetime.to_datetime < 1.days.from_now ) || (listing.begin_datetime.to_datetime < DateTime.now && listing.end_datetime.to_datetime >= DateTime.now))
  end

end
