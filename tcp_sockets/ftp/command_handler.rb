module FTP
   class CommandHandler
      CRLF = "\r\n"

      attr_reader :connection
      def initialize(connection)
         @connection = connection
      end

      def pwd
         @pwd || Dir.pwd
      end

      def handle(data)
         # 送信されたデータの先頭4文字までをコマンドとして取り扱う
         # コマンドはすべて4文字とは限らないので、stripで空白を削除
         # しておき、when句の条件値とする
         cmd = data[0..3].strip.upcase
         # 各コマンドに対するパラメータ値などを格納
         options = data[4..-1].strip

         case cmd
         when 'USER' # ユーザ名。今回は任意のものでアクセスできるように
            "230 Logged in anonymously"
         when 'SYST' # システムの種別を返す
            "215 UNIX Working With FTP"
         when 'CWD' # 作業ディレクトリの変更
            if File.directory?(options)
               @pwd = options
               "250 directory changed to #{pwd}"
            else
               "550 directory not found"
            end
         when 'PWD' # 作業ディレクトリを取得
            "257 \"#{pwd}\" is the current directory"
         when 'PORT' # サーバが接続するポートとアドレスを指定する
            # PORTはPORT h1,h2,h3,h4,p1,p2のようにコマンドが送信される
            # h1〜h4はIPアドレスの各ビット。p1とp2はポート番号を
            # 8ビットごとに分けて表現したもの。
            parts = options.split(',')
            ip_address = parts[0..3].join('.')
            port = Integer(parts[4]) * 256 + Integer(parts[5])

            @data_socket = TCPSocket.new(ip_address, port)
            "200 Active connection established (#{port})"

         when 'RETR' # リモートファイルをダウンロードする
            file = File.open(File.join(pwd, options), 'r')
            connectin.respond "125 Data transfer starting #{file.size} bytes"

            bytes = IO.copy_stream(file, @data_socket)
            @data_socket.close

            "226 Closing data connection, sent #{bytes} bytes"
         when 'LIST' # ファイルの情報やディレクトリの一覧を取得
            connection.respond "125 Opening data connection for file list"

            result = Dir.entries(pwd).join(CRLF)
            @data_socket.write(result)
            @data_socket.close

            "226 Closing data connection, sent #{result.size} bytes"
         when 'QUIT' # 接続を終了する
            "221 Ciao"
         else
            "502 Don't know how to respond to #{cmd}"
         end
      end
   end
end

