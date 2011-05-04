#encoding: utf-8

require 'net/http'
require 'uri'
require 'rubygems'
require 'hpricot'

adv_url = 'adv.ir7.com.br'
login_data = 'usuario.login=mrinaldi&usuario.senha=!@#QWEasd'

http = Net::HTTP.new adv_url
resp, data = http.get '/admin'

cookie_id = resp['set-cookie'].split(';').first
puts "Cookie: #{cookie_id}"

resp, data = http.post '/login', login_data, {'Cookie'=>cookie_id}


puts "Conectado..."

puts resp['location']


resp, data = http.get '/secao/novo', {'Cookie'=>cookie_id}

doc = Hpricot(data)
site_id = (doc/"#site/option[text()='Esportes']").attr('value')

f_sessoes = File.open('sessoes-fussbal.txt')
f_sessoes.each do |l|
	nome = l.split '/'
	nome = nome[1]
	
	insert  = "secao.idFerramenta=237"
	insert += "&secao.nome=futebol_campeonato_" + nome.gsub(/-/,'_')
	insert += "&secao.site.id=" + site_id 
	insert += "&secao.site.prefixoUrl=http://esportes.r7.com"
	insert += "&secao.url=/futebol/"+nome+"/minutoaminuto"

	insert = URI.escape insert
	http.post '/secao/cadastrar', insert, {'Cookie'=>cookie_id}

	puts "Sessao adicionada: #{nome}\n"
end

/formato/cadastra

formato.altura	
formato.formatoNome.id	31
formato.formatoNome.tipoP...	1
formato.googleAdChannel	
formato.googleAdFormat	
formato.googleAdOutput	
formato.googleAdSection	
formato.googleAdType	
formato.googleAdtest	
formato.googleColorBg	
formato.googleColorBorder	
formato.googleColorLine	
formato.googleColorLink	
formato.googleColorText	
formato.googleColorUrl	
formato.googleEncoding	
formato.googleHints	
formato.googleImageSize	
formato.googleLanguage	
formato.googleMaxNumAds	
formato.googlePageUrl	
formato.googleSafe	
formato.googleSkip	
formato.idFerramenta	3
formato.largura	
formato.peso	
formato.posicao	
formato.secao.id	4342
site.id	2174

#site/option[text()=Esportes]
#secao

