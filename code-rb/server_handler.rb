require 'thrift'

class Player
  attr_accessor :name, :host, :port, :alive, :role, :handle

  def get_handle host, port
    transport = Thrift::BufferedTransport.new(Thrift::Socket.new(host, port))
    protocol = Thrift::BinaryProtocol.new(transport)
    RocHack::Mafia::MafiaPlayer::Client.new(protocol)
  end

  def initialize name, host, port
    @name = name
    @host = host
    @port = port
    @alive = true
    @role = "unassigned"
    @handle = get_handle host, port
  end

  def kill
    @alive = false
    @handle.kill
  end

  def set_role role
    @role = role
    @handle.set_role role
  end
end

class ServerHandler
  @name_to_player
  @players
  @time
  @day

  def initialize
    @name_to_player = {}
    @players = []
    @time = "day"
    @day = 1
  end

  def join_game(name, host, port)
    player = Player.new name, host, port
    @players << player
    player.handle.server_message "Welcome to RocHack's Mafia"
  end

  def take_action(action, target)
    @name_to_player[target].handle.kill if action == "kill"
  end
end
