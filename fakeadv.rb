#encoding: utf-8

require 'open-uri'
require 'hpricot'

user_login = "mrinaldi"
user_passwd = "!@#QWEasd"

adv_url = 'adv.ir7.com.br'

res = Net::HTTP.start(adv_url) do |http|
  http.post()
end
