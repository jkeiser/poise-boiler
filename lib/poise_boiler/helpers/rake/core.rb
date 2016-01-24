#
# Copyright 2015-2016, Noah Kantrowitz
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'halite/helper_base'


module PoiseBoiler
  module Helpers
    class Rake
      # Helper for a Rakefile to install some standard tasks used by most
      # Poise/Halite-style gems.
      #
      # @since 1.0.0
      # @example Installing tasks
      #   require 'poise_boiler/helpers/rake/core'
      #   PoiseBoiler::Helpers::Rake::Core.install
      # @example Running tests
      #   $ rake test
      class Core < Halite::HelperBase
        # Install the rake tasks.
        #
        # @return [void]
        def install
          # Delayed so that Rake doesn't need to be loaded to run this file.
          extend ::Rake::DSL

          # Set the default task.
          task default: %i{test}

          # Create the spec task.
          require 'rspec/core/rake_task'
          RSpec::Core::RakeTask.new(:spec, :tag) do |t, args|
            t.rspec_opts = [].tap do |a|
              a << '--color'
              a << "--format #{ENV['CI'] ? 'documentation' : 'Fuubar'}"
              a << '--backtrace' if ENV['VERBOSE'] || ENV['DEBUG']
              a << "--seed #{ENV['SEED']}" if ENV['SEED']
              a << "--tag #{args[:tag]}" if args[:tag]
              a << "--default-path test"
              a << '-I test/spec'
            end.join(' ')
          end

          # Create the test task (which Halite will extend).
          task test: %i{spec}

          # Install gem tasks (build, upload, etc).
          unless options[:no_gem]
            require 'bundler/gem_helper'
            Bundler::GemHelper.install_tasks(options[:bundler] || {})
          end

          # Install the Halite tasks.
          require 'halite/rake_helper'
          Halite::RakeHelper.install(options)
        end
      end
    end
  end
end
