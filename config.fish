# Path to your oh-my-fish.
set fish_path $HOME/.oh-my-fish

set fish_greeting ''

# Theme
set fish_theme robbyrussell

source ~/.nvm-fish/nvm.fish
# set SSL_CERT_FILE /usr/local/etc/openssl/cert.pem

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-fish/plugins/*)
# Custom plugins may be added to ~/.oh-my-fish/custom/plugins/
# Example format: set fish_plugins autojump bundler

# Path to your custom folder (default path is $FISH/custom)
#set fish_custom $HOME/dotfiles/oh-my-fish

# Load oh-my-fish configuration.
. $fish_path/oh-my-fish.fish

rvm > /dev/null

set -xU ANDROID_HOME /usr/local/opt/android-sdk


##############################
######### ZEUS BASED #########
##############################

function z
  zeus start
end

function rmz
  rm .zeus.sock
end

function rr
  if zeus_on
    if [ (count $argv) -gt 0 ]
      zeus rake routes | grep $argv 
    else
      zeus rake routes
    end
  else
    echo "Zeus is not running"
    if [ (count $argv) -gt 0 ]
      rake routes | grep $argv
    else
      rake routes
    end
  end
end

function zeus_on
  if ps aux | grep -v grep | grep 'zeus slave: development_environment'
    true
  else
    false
  end
end

function mg
  if zeus_on
    zeus rake db:migrate $argv
  else
    echo "Zeus is not running"
    rake db:migrate $argv
  end
end

function tprep
  if zeus_on
    zeus rake db:test:prepare $argv
  else
    echo "Zeus is not running"
    rake db:test:prepare $argv
  end
end

function s 
  if zeus_on
    zeus s
  else
    echo "Zeus is not running"
    rails s
  end
end

function t
  if zeus_on
    if [ (count $argv) -gt 0 ]
      zeus test $argv
    else
      zeus test spec
    end
  else
    echo "Zeus is not running"
    if [ (count $argv) -gt 0 ]
      rspec $argv
    else
      rspec spec
    end
  end
end

function tt
  zeus rspec --tag $argv spec
end

function r
  if zeus_on
    zeus rake $argv
  else
    echo "Zeus is not running"
    rake $argv
  end
end

function c
  if zeus_on
    zeus c $argv
  else
    echo "Zeus is not running"
    rails c $argv
  end
end

function jt
  if zeus_on
    if [ (count $argv) -gt 0 ]
      zeus tr spec:javascript SPEC=$argv
    else
      zeus tr spec:javascript
    end
  else
    echo "Zeus is not running"
    if [ (count $argv) -gt 0 ]
      rake spec:javascript RAILS_ENV=test SPEC=$argv
    else
      rake spec:javascript RAILS_ENV=test
    end
  end
end

##############################
############ GIT #############
##############################

function gcurrent
  git rev-parse --abbrev-ref HEAD
end

function gclean!
  git clean -f -d
end

function gd
  git diff $argv
end

function gds
  git diff --staged $argv
end

function gdh
  git diff HEAD^
end

function gr
  git rebase $argv
end

function gri
  gr -i $argv
end

function grc
  gr --continue
end

function gback
  git reset HEAD^
end

function gh
  hub browse
end

function gac
  ga
  gc $argv
end

function gacm
  gac -m $argv
end

function ga
  if [ (count $argv) -gt 0 ]
    git add $argv
  else
    git add .
  end
end

function gp
  git pull $argv
end

function gs
  git status $argv
end

function gsp
  git stash pop
end

function gss
  git stash save
end

function gl
  git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit $argv
end

function gco
  git checkout $argv
end

function gcom
  git checkout master
end

function gpush
  git push $argv
end

function gb
  git branch $argv
end

function gbd
  git branch -d $argv
end

function gc
  git commit $argv
end

function gca
  gc --amend
end

function grb
  git rebase $argv
end

function g
  git $argv
end

function gcpick
  git cherry-pick $argv
end

function grh
  git reset --hard $argv
end

function gbdelete
  git push origin --delete $argv
end

###############################
######## CD SHORTCUTS #########
###############################

function fish_dir
  cd ~/.config/fish/
end

# Requires a variable $code_directory set to directory name
# eg: set -U code_directory "rails"
function code
  if [ (count $argv) -gt 0 ]
    cd ~/$code_directory/$argv
  else
    cd ~/$code_directory
  end
end

# Shorter alias method
function f 
  code $argv
end

function plan
  if [ (count $argv) -gt 0 ]
    f planit/$argv
  else
    f planit
  end
end

function bloc
  cd ~/code/bloc
end

##############################
########### OTHER ############
##############################


function tasks
  ps aux | grep $argv
end

function b
  bundle $argv
end

function ll
  ls -lh $argv
end

function fs
  foreman start $argv
end

function hcon
  heroku run rails console
end

function dtest
  tail -f diagnostic.txt
end

function sb
    set -l result (pwd)

    switch $result
      case '*sashafklein*' or '*sasha*' or '*niko*'
        if [ (count $argv) -gt 0 ]
          sublime $argv
        else
          sublime .
        end
      case '*alexanderfklein*'
        if [ (count $argv) -gt 0 ]
          sub $argv
        else
          sub .
        end
      case '*'
        echo $result
    end
end

function fish_edit
  set -l result (pwd)

  sb ~/.config/fish/config.fish
end