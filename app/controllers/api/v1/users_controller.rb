class Api::V1::UsersController < ApplicationController
    
    def create
        user = User.create(user_params)
        if user.valid?
            render json: { token: issue_token({user_id: user.id}), user: UserSerializer.new(user) }
        else
            render json: { errors: user.errors.full_messages }, status: :not_acceptable
        end
    end

    def update
        user = User.find(params[:id])
        if user.authenticate(user_params[:password])
            if user.update(first_name: user_params[:first_name], last_name: user_params[:last_name], email: user_params[:email])
                render json: user
            else
                render json: { errors: user.errors.full_messages }, status: :not_acceptable
            end
        else
            render json: { errors: ['Incorrect Password'] }, status: :not_acceptable
        end
    end

    def destroy
        if @current_user
            @current_user.listings.each{|l|
                l.likes.each{ |like| like.destroy}
            }
            @current_user.listings.each{|l| 
                l.listing_categories.each{ |listing_category| listing_category.destroy}
            }
            @current_user.venues.each{|v| v.reviews.each{ |review| review.destroy}}
            @current_user.venues.each{ |v| v.destroy}

            if @current_user.destroy
                render json: @current_user
            else
                render json: {errors: @current_user.errors.full_messages }, status: :not_acceptable
            end
        else
            render json: { error: 'Invalid User'}, status: :not_acceptable
        end
    end

    private

    def user_params
        params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
    end
end
