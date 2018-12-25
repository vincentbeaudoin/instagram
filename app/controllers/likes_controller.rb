class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_photo
  before_action :find_like, only: [:destroy]

  def create
    if !(already_liked?)
      @photo.likes.create(user_id: current_user.id)
    end
    redirect_to user_photo_path(@photo.user, @photo)
  end

  def destroy
    if already_liked?
      @like.destroy
    end
    redirect_to user_photo_path(@photo.user, @photo)
  end

  private
    def already_liked?
      Like.where(user_id: current_user.id, photo_id: params[:photo_id]).exists?
    end

    def find_photo
      @photo = Photo.find(params[:photo_id])
    end

    def find_like
       @like = @photo.likes.find(params[:id])
    end
end
