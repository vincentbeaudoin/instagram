class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_photo

  def create
    @comment = @photo.comments.new(comment_params)
    @comment.user = current_user
    @comment.save
    redirect_to user_photo_path(@photo.user, @photo)
  end

  private
    def find_photo
      @photo = Photo.find(params[:photo_id])
    end

    def comment_params
      params.require(:comment).permit(:body)
    end
end
