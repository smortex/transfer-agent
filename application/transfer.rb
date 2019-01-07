require 'etc'

module MCollective
  module Application
    class Transfer < MCollective::Application
      description 'File transfer client'

      usage 'Usage: mco tranfer push local-filename remote-filename'

      option :user,
             description: 'User of the file on the remove systems',
             arguments: ['--user USER', '-u USER'],
             required: false

      option :group,
             description: 'Group of the file on the remove systems',
             arguments: ['--group GROUP', '-g GROUP'],
             required: false

      option :mode,
             description: 'Mode of the file on the remove systems',
             arguments: ['--mode MODE', '-m MODE'],
             required: false

      option :preserve,
             description: 'Preserve user, group and mode of the file on the remove systems',
             arguments: ['--preserve', '-p'],
             required: false

      def validate_configuration(configuration)
        case ARGV[0]
        when 'push'
          if configuration.key?(:preserve)
            stat = File.stat(ARGV[1])
            configuration[:user] = Etc.getpwuid(stat.uid).name
            configuration[:group] = Etc.getgrgid(stat.gid).name
            configuration[:mode] = format('%<mode>o', mode: stat.mode & 0o777)
            configuration.delete(:preserve)
          end
        end
      end

      def main
        transfer = rpcclient('transfer')

        case ARGV[0]
        when 'push'
          transfer.push(configuration.merge(file: ARGV[2], content: File.read(ARGV[1])))
          printrpcstats summarize: true, caption: 'File push'
          halt(transfer.stats)
        end
      end
    end
  end
end
