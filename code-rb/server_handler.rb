require 'thrift'

class Player
  attr_accessor :name, :host, :port, :alive, :role

  def initialize name, host, port
    @name = name
    @host = host
    @port = port
    @alive = true
    @role = "unassigned"
  end


end

class ServerHandler
  @players

  def join_game(name, host, port)
    @players << Player.new name, host, port
    send_message
  end

  def take_action(action, target)
