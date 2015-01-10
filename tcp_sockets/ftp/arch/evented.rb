require 'socket'
require_relative '../command_handler'

module FTP
  class Evented
    CHUNK_SIZE = 1024 * 16

    class Connection
      CRLF = "\r\n"
      attr_reader :client

      def initialize(io)
        @client = io
        @request, @response = "", ""
        @handler = CommandHandler.new(self)

        respond "220 OHAI"
        on_writable
      end

      # コマンドを受信した時
      def on_data(data)
        @request << data

        if @request.end_with?(CRLF)
          # Request is completed.
          # command_handler.rbにて定義されているhandleメソッドにて
          # 受信したコマンドを処理する
          respond @handler.handle(@request)
          # コマンドを初期化する
          @request = ""
        end
      end

      # クライアントに送信するメッセージを作成する
      def respond(message)
        @response << message + CRLF
        on_writable
      end

      # クライアントにメッセージを書き込む
      def on_writable
        bytes = client.write_nonblock(@response)
        # 書き込んだメッセージは切り取る
        @response.slice!(0, bytes)
      end

      # 読み込み可能かどうかを判断する
      def monitor_for_reading?
        true
      end

      # 書き込み可能かどうかを判断する
      def monitor_for_writing?
        # クライアントに送信するメッセージが空であれば書き込み不可
        # NOTE これ、なんでだろう。
        !(@response.empty?)
      end
    end

    def initialize(port = 21)
      @control_socket = TCPServer.new(port)
      trap(:INT) { exit }
    end

    def run
      # @handlesの構成は、keyがFile descriptor numbers、
      # valueがFTP::Evented::Connectionのインスタンス
      @handles = {}

      loop do
        to_read = @handles.values.select(&:monitor_for_reading?).map(&:client)
        to_write = @handles.values.select(&:monitor_for_writing?).map(&:client)

        readables, writables = IO.select(to_read + [@control_socket], to_write)

        readables.each do |socket|
          if socket == @control_socket
            # 新しいコネクション
            io = @control_socket.accept
            connection = Connection.new(io)
            @handles[io.fileno] = connection
          else
            # 既存のコネクション
            connection = @handles[socket.fileno]

            begin
              data = socket.read_nonblock(CHUNK_SIZE)
              connection.on_data(data)
            rescue Errno::EAGAIN
            rescue EOFError
              @handles.delete(socket.fileno)
            end
          end
        end

        writables.each do |socket|
          connection = @handles[socket.fileno]
          connection.on_writable
        end
      end
    end
  end
end

server = FTP::Evented.new(4481)
server.run

