class LeadController < ApplicationController
  require 'open-uri'
  require 'mail'
  require 'rest-client'
  def receive_message
    LeadHelper.receive_email
  end

  def receive_file
    # fields = {}

    LeadHelper.receive_email
    begin
      @page = Nokogiri::HTML(open('/home/rocha/applications/emails/email'))
    rescue => e
      puts "Unable to save data because #{e.message}"
    end
    # # p @page
    # puts " HEEEEEREEEEEEEE >>>>>>>>>>>>>>>>>>>>>>>  #{@page.css("font").map {|b| b.text}} <<<<<<<<<<<<<<<<<"

    begin
      @all_elements = @page.css("font b").map {|b| b.text} unless @page.nil?
      @f = @page.css("tr td font").text.rstrip.split(':').map(&:to_s)
      @font = @f.map { |pos| pos.gsub(/[^0-9A-Za-z]/, '') }
      @font = @font.map { |pos| pos.gsub('Emaildointeressado', '').gsub('20202020202020202020202020202020202020202020202020202020Telefonedointeressado', '')
                                    .gsub('20202020202020202020202020202020202020202020202020202020Mensagem', '')
                                    .gsub('VeC3ADculo', '').gsub('Valor', '').gsub('Ano', '').gsub('LinkdoveC3ADculo', '').gsub('AcesseoComprecarCopyright20012019Comprecar', '')
                                    .gsub('OlC3A1CasteloMotorsVocC3AArecebeuumcontatodeinteressedoseuveC3ADculoNomedointeressado', '')}

      @font[8] = "#{@font[8].to_s}://#{@font[9]}" unless @font[8].nil?
      @font[9] = "" unless @font[9].nil?
    rescue => e
      puts "Unable to read or write data because #{e.message}"
    end

    # fields['nome'] = @all_elements.to_s.downcase.include? "nome"
    # fields['telefone'] = @all_elements.to_s.downcase.include? "telefone"
    # fields['mensagem'] = @all_elements.to_s.downcase.include? "mensagem"
    # fields['veiculo'] = @all_elements.to_s.downcase.include? "veiculo"
    # fields['valor'] = @all_elements.to_s.downcase.include? "valor"
    # puts "???????? #{@all_elements =~ /Nome/}"
    # puts ">>>>>># #{fields}"
    # # puts "------------------------------------ #{@link}"
    # # @page_link = Nokogiri::HTML(open("#{@link}")) unless @link.nil?
    unless @page.nil? or @page.blank?
      @link = @page.css("font").css("a").text
      @link = @link.gsub("http://", "").strip
      begin
        @page = RestClient::Request.execute(method: :get, url: "#{@link}", proxy: nil)
      rescue RestClient::Unauthorized, RestClient::Forbidden => err
        puts 'Access denied'
        flash[:danger] = "Access denied"
        return err.response
      rescue RestClient::ImATeapot => err
        puts 'The server is a teapot! # RFC 2324'
        return err.response
      else
        p 'Worked!'
        @link_page = Nokogiri::HTML(@page)
        @headers = @link_page.css(".vehicle-info").css("div").css("div").css("h6")
        @content = @link_page.css(".vehicle-info").css("div").css("div").css("p")
        @acessories = @link_page.css(".vehicle-accessories").css("div.row").css("div.col-4").css("p")
      end
    else
      puts 'Nenhum elemento recebido, está tudo vazio e obscuro'
    end

  end
end
>>>>>>> d0a1337c645bb9b5c668a2d513546f0282c9f770
