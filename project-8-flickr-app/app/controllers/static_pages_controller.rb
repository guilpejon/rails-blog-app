class StaticPagesController < ApplicationController
  def home; end

  def photos
    @photos = FLICKR.people.getPublicPhotos(user_id: params[:user_id])
  end
end
