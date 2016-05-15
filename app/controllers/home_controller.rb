class HomeController < ApplicationController
  def index
  end
  def buscar
	params.require[:tag]
	params.require[:access_token]
	
	token = params[:tag]
	tag = params[:access_token]
	buffer = open("https://api.instagram.com/v1/tags/"+tag.to_s+"?access_token="+token.to_s).read
	resultado = JSON.parse(buffer)
	render resultado
  end
end
