require "sms_client/client_methods"
require "sms_client/client/paran_client"
require "sms_client/client/lgt_client"
require "sms_client/client/xpeed_client"
require "sms_client/client/joyzen_client"

require  "sms_client/client_pool"

module SMS
  class InvalidClientError < Exception
  end

  class LoingFailedError < Exception
  end

  def self.log
    Client.log
  end
  def self.log=(l)
    Client.log = l
  end
  
  class Client
    cattr_accessor :log
    def initialize(name)
      klass = "#{name}_client".downcase.camelize
      raise InvalidClientError unless SMS.const_defined?(klass)
      @client = SMS.const_get(klass).new
      yield self if block_given?
    end

    def log=(l)
      self.class.log = l
    end
    def log
      self.class.log
    end
    
    def method_missing(method, *params, &block)
      @client.send(method, *params)
    end

    def to_s
      @client.to_s
    end
    
    class << self
      def method_missing(method, *params)
        Client.new(method)
      rescue InvalidClientError
        super
      end
    end
  end
end