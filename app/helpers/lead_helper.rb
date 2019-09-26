module LeadHelper
  require 'net/pop'
  require "base64"
  require "mail"
  require 'fiddle'

  def self.receive_email
    email_dir = '/home/webtech/RubymineProjects/leadmail/emails/'
    filename = "email"
    Mail.defaults do
      retriever_method :pop3, :address    => "pop.gmail.com",
                       :port       => 995,
                       :user_name  => 'leadmail030@gmail.com',
                       :password   => 'LEADMAIL030',
                       :enable_ssl => true
    end
    unless Mail.first.blank?
      email_first = Mail.first.parts
      @email_decoded = email_first.parts.second.decoded
      begin
        File.open(email_dir + filename, "w+b", 0644) {|f| f.write @email_decoded}
        p "Succefull writed"
      rescue => e
        puts "Unable to save data for #{filename} because #{e.message}"
      end
    else
      p 'No mails!'
    end
    p "OVER HEEEEERREEEE vvv"

  end




    # Net::POP3.enable_ssl(OpenSSL::SSL::VERIFY_NONE)
    # Net::POP3.start('pop.gmail.com', 995, 'leadmail030@gmail.com', 'LEADMAIL030') do |pop|
    #
    #   if pop.mails.empty?
    #     puts 'No mails.'
    #   else
    #     puts "Mails present"
    #     pop.each_mail do |mail|
    #       p mail
    #       p mail.header(''.dup)
    #       contentbody = mail.pop(''.dup)
    #       newContent = contentbody.force_encoding('UTF-8')
    #       @content = Base64.decode64("#{newContent}")
    #       # message = Base64.decode64(content.to_s)
    #       p ">>>>>>>>>>>>>>>>>>>>>>>>>>>O CONTEUDO ESTA CONVERTIDO <<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
    #       p @content
    #
    #     end
    #   end
    #   return @content
    # end
  # end
end
