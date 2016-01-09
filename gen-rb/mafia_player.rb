#
# Autogenerated by Thrift Compiler (0.9.3)
#
# DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
#

require 'thrift'
require 'mafia_types'

module RocHack
  module Mafia
    module MafiaPlayer
      class Client
        include ::Thrift::Client

        def start_game(player_names, modifiers)
          send_start_game(player_names, modifiers)
          recv_start_game()
        end

        def send_start_game(player_names, modifiers)
          send_message('start_game', Start_game_args, :player_names => player_names, :modifiers => modifiers)
        end

        def recv_start_game()
          result = receive_message(Start_game_result)
          return
        end

        def kill(message)
          send_kill(message)
          recv_kill()
        end

        def send_kill(message)
          send_message('kill', Kill_args, :message => message)
        end

        def recv_kill()
          result = receive_message(Kill_result)
          return
        end

        def time_forward()
          send_time_forward()
          recv_time_forward()
        end

        def send_time_forward()
          send_message('time_forward', Time_forward_args)
        end

        def recv_time_forward()
          result = receive_message(Time_forward_result)
          return
        end

        def server_message(message)
          send_server_message(message)
          recv_server_message()
        end

        def send_server_message(message)
          send_message('server_message', Server_message_args, :message => message)
        end

        def recv_server_message()
          result = receive_message(Server_message_result)
          return
        end

        def set_role(role)
          send_set_role(role)
          recv_set_role()
        end

        def send_set_role(role)
          send_message('set_role', Set_role_args, :role => role)
        end

        def recv_set_role()
          result = receive_message(Set_role_result)
          return
        end

      end

      class Processor
        include ::Thrift::Processor

        def process_start_game(seqid, iprot, oprot)
          args = read_args(iprot, Start_game_args)
          result = Start_game_result.new()
          @handler.start_game(args.player_names, args.modifiers)
          write_result(result, oprot, 'start_game', seqid)
        end

        def process_kill(seqid, iprot, oprot)
          args = read_args(iprot, Kill_args)
          result = Kill_result.new()
          @handler.kill(args.message)
          write_result(result, oprot, 'kill', seqid)
        end

        def process_time_forward(seqid, iprot, oprot)
          args = read_args(iprot, Time_forward_args)
          result = Time_forward_result.new()
          @handler.time_forward()
          write_result(result, oprot, 'time_forward', seqid)
        end

        def process_server_message(seqid, iprot, oprot)
          args = read_args(iprot, Server_message_args)
          result = Server_message_result.new()
          @handler.server_message(args.message)
          write_result(result, oprot, 'server_message', seqid)
        end

        def process_set_role(seqid, iprot, oprot)
          args = read_args(iprot, Set_role_args)
          result = Set_role_result.new()
          @handler.set_role(args.role)
          write_result(result, oprot, 'set_role', seqid)
        end

      end

      # HELPER FUNCTIONS AND STRUCTURES

      class Start_game_args
        include ::Thrift::Struct, ::Thrift::Struct_Union
        PLAYER_NAMES = 1
        MODIFIERS = 2

        FIELDS = {
          PLAYER_NAMES => {:type => ::Thrift::Types::LIST, :name => 'player_names', :element => {:type => ::Thrift::Types::STRING}},
          MODIFIERS => {:type => ::Thrift::Types::SET, :name => 'modifiers', :element => {:type => ::Thrift::Types::STRING}}
        }

        def struct_fields; FIELDS; end

        def validate
        end

        ::Thrift::Struct.generate_accessors self
      end

      class Start_game_result
        include ::Thrift::Struct, ::Thrift::Struct_Union

        FIELDS = {

        }

        def struct_fields; FIELDS; end

        def validate
        end

        ::Thrift::Struct.generate_accessors self
      end

      class Kill_args
        include ::Thrift::Struct, ::Thrift::Struct_Union
        MESSAGE = 1

        FIELDS = {
          MESSAGE => {:type => ::Thrift::Types::STRING, :name => 'message'}
        }

        def struct_fields; FIELDS; end

        def validate
        end

        ::Thrift::Struct.generate_accessors self
      end

      class Kill_result
        include ::Thrift::Struct, ::Thrift::Struct_Union

        FIELDS = {

        }

        def struct_fields; FIELDS; end

        def validate
        end

        ::Thrift::Struct.generate_accessors self
      end

      class Time_forward_args
        include ::Thrift::Struct, ::Thrift::Struct_Union

        FIELDS = {

        }

        def struct_fields; FIELDS; end

        def validate
        end

        ::Thrift::Struct.generate_accessors self
      end

      class Time_forward_result
        include ::Thrift::Struct, ::Thrift::Struct_Union

        FIELDS = {

        }

        def struct_fields; FIELDS; end

        def validate
        end

        ::Thrift::Struct.generate_accessors self
      end

      class Server_message_args
        include ::Thrift::Struct, ::Thrift::Struct_Union
        MESSAGE = 1

        FIELDS = {
          MESSAGE => {:type => ::Thrift::Types::STRING, :name => 'message'}
        }

        def struct_fields; FIELDS; end

        def validate
        end

        ::Thrift::Struct.generate_accessors self
      end

      class Server_message_result
        include ::Thrift::Struct, ::Thrift::Struct_Union

        FIELDS = {

        }

        def struct_fields; FIELDS; end

        def validate
        end

        ::Thrift::Struct.generate_accessors self
      end

      class Set_role_args
        include ::Thrift::Struct, ::Thrift::Struct_Union
        ROLE = 1

        FIELDS = {
          ROLE => {:type => ::Thrift::Types::STRING, :name => 'role'}
        }

        def struct_fields; FIELDS; end

        def validate
        end

        ::Thrift::Struct.generate_accessors self
      end

      class Set_role_result
        include ::Thrift::Struct, ::Thrift::Struct_Union

        FIELDS = {

        }

        def struct_fields; FIELDS; end

        def validate
        end

        ::Thrift::Struct.generate_accessors self
      end

    end

  end
end
