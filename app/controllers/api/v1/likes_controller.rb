class Api::V1::LikesController < ApplicationController

    def toggle
        like = Like.find_by(like_params)
        if like
            like.destroy
            render json: {deleted: true, like: like}
        else
            like = Like.create(like_params)
            if like.valid?
                render json: like
            else
                render json: {errors: like.errors.full_messages }, status: :not_accepted
            end
        end
        
    end

    private

    def like_params
        params.require(:like).permit(:user_id, :listing_id)
    end
end
