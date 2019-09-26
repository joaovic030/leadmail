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
    @page = Nokogiri::HTML(open('/home/webtech/RubymineProjects/leadmail/emails/email'))
    # # p @page
    # puts " HEEEEEREEEEEEEE >>>>>>>>>>>>>>>>>>>>>>>  #{@page.css("font").map {|b| b.text}} <<<<<<<<<<<<<<<<<"
    @all_elements = @page.css("font b").map {|b| b.text} unless @page.nil?
    p @all_elements
    # fields['nome'] = @all_elements.to_s.downcase.include? "nome"
    # fields['telefone'] = @all_elements.to_s.downcase.include? "telefone"
    # fields['mensagem'] = @all_elements.to_s.downcase.include? "mensagem"
    # fields['veiculo'] = @all_elements.to_s.downcase.include? "veiculo"
    # fields['valor'] = @all_elements.to_s.downcase.include? "valor"
    # puts "???????? #{@all_elements =~ /Nome/}"
    # puts ">>>>>># #{fields}"
    # @link = @page.css("font").css("a").text
    # # puts "------------------------------------ #{@link}"
    # # @page_link = Nokogiri::HTML(open("#{@link}")) unless @link.nil?
    #
    # begin
    #   @page = RestClient::Request.execute(method: :get, url: "https://pt.wikipedia.org/wiki/Wikip%C3%A9dia:P%C3%A1gina_principal", proxy: nil)
    # rescue RestClient::Unauthorized, RestClient::Forbidden => err
    #   puts 'Access denied'
    #   flash[:danger] = "Access denied"
    #   return err.response
    # rescue RestClient::ImATeapot => err
    #   puts 'The server is a teapot! # RFC 2324'
    #   return err.response
    # else
    #   p 'Worked!'
    #   # p @page.body
    #   # @page = Nokogiri::HTML(@page.body)
    #   # @anchor = @page.css("a").map { |a| a['href']}
    # end

    # puts Mail.all

    #proxima pagina detalhes do carro
    # css("li.VehicleDetails__list__item")
  end
end
# /home/joaorocha/Documents/Projetos/leadmail/email_received.eml