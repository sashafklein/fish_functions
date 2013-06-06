rvm > /dev/null # load RVM environment
set PATH /Applications/Postgres.app/Contents/MacOS/bin $PATH

set PATH bin $PATH # for bundle binstubs

function code
	cd ~/code
end

function bloc
	cd ~/code/bloc
end

function gc
	git commit -m $argv
end

function gs
	git status
end

function gl
	git lg
end

function gco
	git checkout $argv
end

function fish_edit
	sub ~/.config/fish/config.fish
end

function z
	zeus start
end

function zs 
	zeus s
end

function zt
	if [ (count $argv) -gt 0 ]
		zeus test $argv
	else
		zeus test spec
	end
end

function zr
	zeus rake $argv
end

function zc
	zeus c
end

function ll
	ls -lh $argv
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

function zr
	zeus rake $argv
end

function gd
	git diff
end

function zmig
	zr db:migrate
end

function ztprep
	zr db:test:prepare
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

function fish_dir
	cd ~/.config/fish/
end