require 'cri'
require '3scale_toolbox/base_command'
require '3scale_toolbox/commands/copy_command/copy_service'

module ThreeScaleToolbox
  module Commands
    module CopyCommand
      extend ThreeScaleToolbox::Command
      def self.command
        Cri::Command.define do
          name        'copy'
          usage       'copy <command> [options]'
          summary     '3scale CLI copy'
          description '3scale CLI copy tools to manage your API from the terminal.'
          flag :h, :help, 'show help for this command' do |_, cmd|
            puts cmd.help
            exit 0
          end
        end
      end
      add_subcommand(CopyServiceSubcommand)
    end
  end
end