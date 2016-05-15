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
	response = resultado['data']
	total = response['media_count']
	buffer = open("https://api.instagram.com/v1/tags/"+tag.to_s+"/media/recent?access_token="+token.to_s+"&count=20").read
	recent = JSON.parse(buffer)
	data = recent['data']
	i = 0
	arregloDeDatos = []
	
	while i < data.length
		
		cadaFoto = data[i]
		tags = cadaFoto['tags']
		usuario = cadaFoto['user']['username'].to_s
		likes = cadaFoto['likes']['count'].to_i
		texto = cadaFoto['caption']['text'].to_s
		url = cadaFoto['images']['standard_resolution']['url'].to_s
		hash = { :tags => tags, :username => usuario, :likes => likes, :url =>url, :caption=> texto }
		arregloDeDatos << hash
		i+=1
	end
	
	render json:{ metadata:{total: total}, posts: arregloDeDatos, version: '1.0.3'}
  
	end
end
