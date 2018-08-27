class TinymceAssetsController < ApplicationController
  # tinymce-rails-imageupload gem으로 스마트한 tinymce 쓰자
  def create
    # Take upload from params[:file] and store it somehow...
    # Optionally also accept params[:hint] and consume if needed
    # 아직 이부분 계속 고쳐야한답
    render json: {
      image: {
        url: view_context.image_url(image)
      }
    }, content_type: "text/html"
  end
end
