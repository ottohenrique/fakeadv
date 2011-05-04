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

# incluir secoes

resp, data = http.get '/secao/novo', {'Cookie'=>cookie_id}

doc = Hpricot(data)
site_id = (doc/"#site/option[text()='Esportes']").attr('value')

#f_sessoes = File.open('sessoes-fussbal.txt')
#f_sessoes.each do |l|
#	nome = l.split '/'
	#nome = nome[1]
#	
	#insert  = "secao.idFerramenta=237"
#	insert += "&secao.nome=futebol_campeonato_" + nome.gsub(/-/,'_')
#	insert += "&secao.site.id=" + site_id 
#	insert += "&secao.site.prefixoUrl=http://esportes.r7.com"
#	insert += "&secao.url=/futebol/"+nome+"/minutoaminuto"

#	insert = URI.escape insert
#	http.post '/secao/cadastrar', insert, {'Cookie'=>cookie_id}

#	puts "Sessao adicionada: #{nome}\n"
#end


# cadastra formatos

resp, data = http.get '/secoesDoSite/'+site_id, {'Cookie'=>cookie_id}
doc = Hpricot(data)
count = 0
(doc/"#secao/option").each do |el|
    if(el.innerHTML.match /futebol_campeonato/)
        section_id = el['value']
        
        insert  = "formato.formatoNome.id=31"
        insert += "&formato.formatoNome.tipoPublicidade.id=1"
        insert += "&formato.idFerramenta=3"
        insert += "&formato.secao.id=" + section_id
        insert += "&site.id=" + site_id
        
        insert = URI.escape insert
        http.post '/formato/cadastra', insert, {'Cookie'=>cookie_id}
        
        puts "Formato cadastrado em " + el.innerHTML
        count = count+1
    end
end
puts "total de formatos: #{count}"
