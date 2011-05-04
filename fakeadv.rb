#encoding: utf-8

require 'net/http'
require 'uri'
require 'rubygems'
require 'hpricot'

user_login = "mrinaldi"
user_passwd = "!@#QWEasd"

adv_url = 'adv.ir7.com.br'

http = Net::HTTP.new adv_url
resp, data = http.get '/admin'

session_id = resp['set-cookie'].gsub /;.*$/,''

data = 'usuario.login=mrinaldi&usuario.senha=!@#QWEasd'

http.post '/login', data, {'Cookie'=>session_id}


