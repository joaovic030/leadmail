class LeadController < ApplicationController
  require 'open-uri'
  require 'mail'
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

    Mail.defaults do
      retriever_method :pop3, :address    => "pop.gmail.com",
                       :port       => 995,
                       :user_name  => 'leadmail030@gmail.com',
                       :password   => 'LEADMAIL030',
                       :enable_ssl => true
    end

    # puts Mail.all
    LeadHelper.receive_email

    #proxima pagina detalhes do carro
    # css("li.VehicleDetails__list__item")
  end
end
# /home/joaorocha/Documents/Projetos/leadmail/email_received.eml