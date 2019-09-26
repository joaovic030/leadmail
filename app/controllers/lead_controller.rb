class LeadController < ApplicationController
  require 'open-uri'
  require 'mail'
  require 'rest-client'
  def receive_message
    LeadHelper.receive_email
  end

  def receive_file
    @page = Nokogiri::HTML(open('../leadmail/email_received.eml'))
    # p @page
    puts " HEEEEEREEEEEEEE >>>>>>>>>>>>>>>>>>>>>>>  #{@page.css("font").map {|b| b.text}} <<<<<<<<<<<<<<<<<"
    @all_elements = @page.css("font").map {|b| b.text} unless @page.nil?
    @link = @page.css("font").css("a").text
    # puts "------------------------------------ #{@link}"
    # @page_link = Nokogiri::HTML(open("#{@link}")) unless @link.nil?

    begin
      page = RestClient::Request.execute(method: :get, url: "https://www.webmotors.com.br/comprar/volkswagen/golf/1-0-200-tsi-total-flex-comfortline-tiptronic/4-portas/2017-2018/29906350?pos=a29906350g:&np=1", proxy: nil)
    rescue RestClient::Unauthorized, RestClient::Forbidden => err
      puts 'Access denied'
      flash[:danger] = "Access denied"
      return err.response
    rescue RestClient::ImATeapot => err
      puts 'The server is a teapot! # RFC 2324'
      return err.response
    else
      p 'Worked!'
      page = Nokogiri::HTML(page.body)
      p page.css("li")
      return page
    end

    # puts Mail.all
    LeadHelper.receive_email

    #proxima pagina detalhes do carro
    # css("li.VehicleDetails__list__item")
  end
end
# /home/joaorocha/Documents/Projetos/leadmail/email_received.eml