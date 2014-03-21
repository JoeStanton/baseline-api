class AgentController < ApplicationController
  def install
    base_url = request.original_url.gsub('/agent/install/', '/')
    render text: <<-SCRIPT
      set -e

      success () {
        printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
      }

      fail () {
        printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
        exit
      }

      if [[ "$OSTYPE" == "linux-gnu" ]]; then
        success "Detected linux"

        if hash ruby2.0 2>/dev/null; then
          success "Ruby 2.0 not detected - Adding APT Repository"
          sudo apt-get install -qq -y python-software-properties
          sudo add-apt-repository -y ppa:brightbox/ruby-ng-experimental
          sudo apt-get update -qq

          success "Installing Ruby"
          sudo apt-get install -y -qq ruby2.0 ruby2.0-dev ruby2.0-doc git
        else
          success "Ruby 2.0 detected"
        fi

        sudo gem2.0 install bundler
      elif [[ "$OSTYPE" == "darwin"* ]]; then
        success "Detected Mac OS"
      else
        fail "Platform not supported."
      fi

      rm -rf /tmp/lighthouse-agent/
      git clone -q https://github.com/JoeStanton/lighthouse-agent.git /tmp/lighthouse-agent/
      cd /tmp/lighthouse-agent
      bundle install --quiet
      success "Installed lighthouse-agent"

      if [[ "$OSTYPE" == "linux-gnu" ]]; then
        ruby2.0 lighthouse-agent.rb setup #{base_url}
      else
        ./lighthouse-agent.rb setup #{base_url}
      fi
      success "Registered with management server: #{base_url}"
    SCRIPT
  end
end
