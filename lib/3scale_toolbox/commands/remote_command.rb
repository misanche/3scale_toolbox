require 'cri'
require '3scale_toolbox/base_command'
require '3scale_toolbox/commands/remote_command/remote_add'
require '3scale_toolbox/commands/remote_command/remote_remove'
require '3scale_toolbox/commands/remote_command/remote_rename'

module ThreeScaleToolbox
  module Commands
    module RemoteCommand
      class RemoteCommand < Cri::CommandRunner
        include ThreeScaleToolbox::Command
        def self.command
          Cri::Command.define do
            name        'remote'
            usage       'remote <command> [options]'
            summary     '3scale CLI remote'
            description '3scale CLI command to manage your remotes'
            runner RemoteCommand
          end
        end

        def run
          list_remotes
        end

        private

        def invalid_remote
          raise ThreeScaleToolbox::Error, "invalid remote configuration from config file #{config_file}"
        end

        def valid_remote?(remote)
          remote.key?(:endpoint) && remote.key?(:auth_key)
        end

        def validate_remotes?(remotes)
          case remotes
          when nil then true
          when Hash then remotes.values.all?(&method(:valid_remote?))
          else false
          end
        end

        def list_remotes
          remotes = config.data :remotes

          return invalid_remote unless validate_remotes?(remotes)

          if remotes.nil? || remotes.empty?
            puts 'Empty remote list.'
          else
            remotes.each do |name, remote|
              puts "#{name} #{remote[:endpoint]} #{remote[:auth_key]}"
            end
          end
        end

        add_subcommand(RemoteAddSubcommand)
        add_subcommand(RemoteRemoveSubcommand)
        add_subcommand(RemoteRenameSubcommand)
      end
    end
  end
end
