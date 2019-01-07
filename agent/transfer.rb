module MCollective
  module Agent
    class Transfer < RPC::Agent
      action 'push' do
        push
      end

      def push
        File.open(request[:file], 'w') do |f|
          f.write(request[:content])
        end
        FileUtils.chown(request[:user], request[:group], request[:file])
        FileUtils.chmod(Integer(request[:mode], 8), request[:file])
      end
    end
  end
end
