#!/usr/local/bin/zsh

setopt nullglob

function symlink() {
	item=$1
	linklocation=$2 # path like ~/.config
	linkname=$3 # string $item:t
	if [[ $(readlink $linklocation/$linkname) != $item ]]; then
		if [ -e $linklocation/$linkname ]; then
			archive="$linkname.old"
			while [ -e $linklocation/$archive ]; do 
				if [ "$archive:t:e" = "old" ]; then
					archive=$archive.1
				else
					extension=$(expr $archive:t:e + 1)
					archive="$archive:t:r.$extension"
				fi
			done
			echo "Archiving existing"
			mv -v $linklocation/{$linkname,$archive}
			#echo "$linklocation/$linkname -> $archive" #for testing
		fi
		echo "Creating symlink"
		ln -siv $item $linklocation/$linkname 
		#echo "$linklocation/$linkname -> $item" #for testing
	fi
}

for item in ~/.dotfiles/config/*; do 
	if [ "$item:t:e" != "old" ]; then
		symlink $item ~/.config $item:t
	fi
done

for item in ~/.dotfiles/home/*; do
	if [ "$item:t:e" != "old" ]; then
		symlink $item ~ .$item:t
	fi
done

