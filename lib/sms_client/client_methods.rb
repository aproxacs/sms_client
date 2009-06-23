module SMS
  module ClientMethods
    def initialize
      @agent = WWW::Mechanize.new do |agent|
        agent.user_agent_alias = 'Windows IE 7'
      end
    end

    def remains
      @remains ||= 0
    end
    def available?
      remains > 0
    end
    
    def from
      @from ||= "01012345678"
    end
    def from=(num)
      if valid_number? num
        @from = num
      end
    end

    def login(id, password)
      @id = id
      @password = password
      SMS.log.info "[#{self.class}] Remains : #{remains} times" if SMS.log
      available?
    end

    def deliver(to, msg)
      return false unless available?
      return false unless valid_number?(to)
      return false if msg.strip.empty?

      SMS.log.info("Sending SMS to #{to}") if SMS.log
      SMS.log.info("==> #{msg}") if SMS.log
      
      true
    end

    def to_s
      "#{self.class} : avaliable=#{available?}, from=#{from}, remains=#{remains}"
    end

    protected
    def valid_number?(num)
      num =~ /^01\d{8,9}$/
    end
  end
end