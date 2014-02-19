# Path to your oh-my-fish.
set fish_path $HOME/.oh-my-fish

# Theme
set fish_theme robbyrussell

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-fish/plugins/*)
# Custom plugins may be added to ~/.oh-my-fish/custom/plugins/
# Example format: set fish_plugins autojump bundler

# Path to your custom folder (default path is $FISH/custom)
#set fish_custom $HOME/dotfiles/oh-my-fish

# Load oh-my-fish configuration.
. $fish_path/oh-my-fish.fish

rvm > /dev/null



##############################
######### ZEUS BASED #########
##############################

function z
  zeus start
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

##############################
############ GIT #############
##############################

function gd
  git diff $argv
end

function gds
  git diff --staged $argv
end

function gdh
  git diff HEAD^
end

function gri
  git rebase -i $argv
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
  git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --
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

function grb
  git rebase $argv
end

function g
  git $argv
end

function gcpick
  git cherry-pick $argv
end

###############################
######## CD SHORTCUTS #########
###############################

function fish_dir
  cd ~/.config/fish/
end

function xf
  cd ~/rails/ctw2
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

function design
  cd ~/$code_directory/design-roadmap
end

function bloc
  cd ~/code/bloc
end

function meatup
  cd ~/code/meatup
end

function wod
  cd ~/rails/ctw2
end

function course
  cd ~/rails/bitstarter
end

function fit
  cd ~/rails/fitness
end

##############################
########### OTHER ############
##############################

function fj
  functional-javascript $argv
end

function ll
  ls -lh $argv
end

function fs
  foreman start $argv
end

function hcon
  heroku run console
end

function dtest
  tail -f diagnostic.txt
end

function sb
    set -l result (pwd)

    switch $result
        case '*sashafklein*'
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

    switch $result
        case '*sashafklein*'
            sublime ~/.config/fish/config.fish
        case '*alexanderfklein*'
            sub ~/.config/fish/config.fish
        case '*'
            echo $result
    end
end