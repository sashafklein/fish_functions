rvm > /dev/null # load RVM environment
set PATH /Applications/Postgres.app/Contents/MacOS/bin $PATH
set fish_greeting ""
set PATH bin $PATH # for bundle binstubs

##############################
######### ZEUS BASED #########
##############################

function z
	zeus start
end

function rr
	if zeus_on
		zr routes
	else
		echo "Zeus is not running"
		rake routes
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
		zr db:migrate
	else
		echo "Zeus is not running"
		rake db:migrate
	end
end

function tprep
	if zeus_on
		zr db:test:prepare
	else
		echo "Zeus is not running"
		rake db:test:prepare
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
		zeus c
	else
		echo "Zeus is not running"
		rails c
	end
end

##############################
############ GIT #############
##############################

function gd
	git diff $argv
end

function gac
	ga
	gc $argv
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

function gc
	git commit -m $argv
end

function gs
	git status
end

function gl
	git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --
end

function gco
	git checkout $argv
end

function gpush
	git push $argv
end

##############################
########### OTHER ############
##############################

function ll
	ls -lh $argv
end

function fish_edit
	sub ~/.config/fish/config.fish
end

function fish_dir
	cd ~/.config/fish/
end

function xf
	cd ~/rails/ctw2
end

# Requires a variable $code_directory set to directory name
# eg: set -U code_directory "rails"
function code
	cd ~/$code_directory
end

function bloc
	cd ~/code/bloc
end