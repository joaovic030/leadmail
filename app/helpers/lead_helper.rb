module LeadHelper
  require 'net/pop'

  def self.receive_email
    pop = Net::POP3.new('pop.gmail.com')
    pop.start('leadmail030@gmail.com', 'LEADMAIL030')             # (1)
    if pop.mails.empty?
      puts 'No mail.'
    else
      i = 0
      pop.each_mail do |m|   # or "pop.mails.each ..."   # (2)
        File.open("inbox/#{i}", 'w') do |f|
          p m
          f.write m.pop
        end
        m.delete
        i += 1
      end
      puts "#{pop.mails.size} mails popped."
    end
    pop.finish
  end
end
