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
		if [ (count $argv) -gt 0 ]
			zeus rake routes | grep $argv 
		else
			zeys rake routes
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
		zeus rake db:migrate
	else
		echo "Zeus is not running"
		rake db:migrate
	end
end

function tprep
	if zeus_on
		zeus rake db:test:prepare
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
	git status
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

function g
	git $argv
end

function gcpick
	git cherry-pick $argv
end

##############################
########### OTHER ############
##############################

function ll
	ls -lh $argv
end

function fs
	foreman start $argv
end

function dtest
	tail -f diagnostic.txt
end

function sub.
	set -l result (dirh)

	switch $result
		case '*sashafklein*'
			sublime .
		case '*alexanderfklein*'
			sub .
		case '*'
			echo $result
	end
end

function fish_edit
    set -l result (dirh)

    switch $result
        case '*sashafklein*'
            sublime ~/.config/fish/config.fish
        case '*alexanderfklein*'
            sub ~/.config/fish/config.fish
        case '*'
            echo $result
    end
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

function sb
	sublime $argv
end

function bloc
	cd ~/code/bloc
end

function wod
	cd ~/rails/ctw2
end