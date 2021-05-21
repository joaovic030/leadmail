module LeadHelper
  require 'net/pop'
  require "base64"
  require "mail"
  require 'fiddle'

  def self.receive_email
    email_dir = '/home/rocha/applications/emails/'
    filename = "email"
    Mail.defaults do
      retriever_method :pop3, :address    => "pop.gmail.com",
                       :port       => 995,
                       :user_name  => ENV['USERNAME']
                       :password   => ENV['MAIL_PASSWORD'],
                       :enable_ssl => true
    end
    has_email = Mail.first
    unless has_email.blank?
      email_first = has_email.parts
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
  end
end
