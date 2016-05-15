#skip_before_action :verify_authenticity_token, if: :json_request?

class HomeController < ApplicationController
 skip_before_action :verify_authenticity_token
  def index
  end
  def buscar
	params.require(:tag)
	params.require(:access_token)
	
	tag = params[:tag]
	token = params[:access_token]
	buffer = open("https://api.instagram.com/v1/tags/"+tag.to_s+"?access_token="+token.to_s).read
	resultado = JSON.parse(buffer)
	render :json => resultado
  end
end
