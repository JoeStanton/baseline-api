class AgentController < ApplicationController
  def install
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
      elif [[ "$OSTYPE" == "darwin"* ]]; then
        success "Detected Mac OS"
      else
        fail "Platform not supported."
      fi

      if hash ruby 2>/dev/null && [[ "$(ruby -e 'print RUBY_VERSION')" == "2.0.0" ]]; then
        RUBY="ruby"
        GEM="gem"
      elif hash ruby2.0 2>/dev/null; then
        RUBY="ruby2.0"
        GEM="gem2.0"
      fi

      if [[ "$OSTYPE" == "linux-gnu" ]] && test -z $RUBY; then
        success "Ruby 2.0 not detected - Adding APT Repository"
        sudo apt-get install -qq -y python-software-properties
        sudo add-apt-repository -y ppa:brightbox/ruby-ng-experimental
        sudo apt-get update -qq

        success "Installing Ruby"
        sudo apt-get install -y -qq ruby2.0 ruby2.0-dev ruby2.0-doc git
      fi

      if hash $RUBY; then
        success "Detected Ruby 2.0"
      else
        fail "Ruby 2.0 not installed"
      fi

      rm -rf /tmp/baseline-agent/
      git clone -q https://github.com/JoeStanton/baseline-agent.git /tmp/baseline-agent/
      cd /tmp/baseline-agent
      success "Installing Bundler"
      $GEM install bundler > /dev/null
      bundle install --quiet
      $GEM build -q baseline-agent.gemspec > /dev/null && $GEM install -q baseline-agent-*.gem > /dev/null
      success "Installed baseline-agent"

      baseline-agent setup #{root}
      success "Registered with management server: #{root}"
    SCRIPT
  end

  private
  def root
    if Rails.env.production?
       root_url(protocol: "https")
    else
      root_url
    end
  end
end
