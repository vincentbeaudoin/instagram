class PhotosController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.find(params[:user_id])
    @photos = Photo.where(:user_id => @user)
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def new
    @photo = Photo.new
  end

  def create
    @parameters = photo_params
    @cloudinary = Cloudinary::Uploader.upload(@parameters[:image])
    @photo = Photo.new({:link => @cloudinary['secure_url'], :caption => @parameters[:caption]})
    @photo.user = current_user

    if @photo.save
      redirect_to user_photo_path(current_user, @photo)
    else
      render 'new'
    end
  end

  private
    def photo_params
      params.require(:photo).permit(:caption, :image)
    end
end
