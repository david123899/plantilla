class PhotosController < ApplicationController
  before_action :authenticate_user!

  def index
    @photos = Photo.all
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = current_user.photos.new(photo_params)
    if @photo.save
      redirect_to photos_path, notice: 'Foto subida con éxito'
    else
      render :new
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:title, :description, :image)
  end

  def show
    @photo = Photo.find(params[:id])
    @comments = @photo.comments.includes(:user)
  end

  before_action :authorize_karina, only: [:new, :create]

private
def authorize_karina
  redirect_to root_path, alert: 'Solo Karina puede subir fotos' unless current_user.email == 'karina@domain.com'
end

end
