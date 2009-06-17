
module SMS

  class ClientPool
    # Config is like this
    # {"paran" => {"id" => "ID", "password" => "PASSWORD", "priority" => 3},
    #  "lgt" => {"id" => "ID", "password" => "PASSWORD", "priority" => 1}
    #  ...
    # }
    #
    def initialize(config)
      add(config)
    end

    def clients
      @clients ||= []
    end

    def size
      clients.size
    end

    def add(cli)
      if cli.is_a? SMS::Client
        clients << cli
      else cli.is_a? Hash
        cli.each do |key, val|
          val.symbolize_keys!
          client = SMS::Client.new(key) do |c|
            c.priority = val[:priority] || 10
            c.login(val[:id], val[:password])
          end
          clients << client if client.available?
        end
      end

      sort
    end

    def remove(cli)
      clients.delete(cli)
    end

    def first
      clients.each do |cli|
        next unless cli.available?
        return cli
      end
    end

    def from=(num)
      clients.each do |c|
        c.from = num
      end
    end

    def to_s
      clients.inject(["#{self.class} : "]) do |ret, cli|
        ret << "  (#{cli.to_s})"
      end.join("\n")
    end

    private
    def sort
      clients.sort! do |a, b|
        a.priority <=> b.priority
      end
    end
  end
end