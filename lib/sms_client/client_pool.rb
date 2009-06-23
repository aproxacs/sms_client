
module SMS

  class ClientPool
    # Config is like this
    # {"paran" => {"id" => "ID", "password" => "PASSWORD", "priority" => 3},
    #  "lgt" => {"id" => "ID", "password" => "PASSWORD", "priority" => 1}
    #  ...
    # }
    #
    def initialize(config = {})
      @config = deep_symbolize_keys(config).to_a
      sort
    end
    attr_accessor :from

    def size
      @config.size
    end

    def add(cli)
      @config.concat deep_symbolize_keys(cli).to_a if cli.is_a? Hash
      sort
    end

    def remove(key)
      @config.delete(key.to_sym)
    end

    def first
      @config.each do |cf|
        cli = Client.new(cf[0]) do |cli|
          cli.from = from if from
          cli.login(cf[1][:id], cf[1][:password])
        end
        return cli if cli.available?
      end
    end

    def to_s
      @config.to_s
    end

    private
    def sort
      @config.sort! do |a,b|
        a[1][:priority] <=> b[1][:priority]
      end
    end

    def deep_symbolize_keys(hash)
      hash.inject({}) { |result, (key, value)|
        value = deep_symbolize_keys(value) if value.is_a? Hash
        result[(key.to_sym rescue key) || key] = value
        result
      }
    end
  end
end