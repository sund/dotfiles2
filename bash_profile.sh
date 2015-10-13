# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH"

###
## variables
#
branchSym=$(echo -e -n "\xE1\x9B\x98")
hashSym=$(echo -e "\x23")
tagSym=$(echo -e "\xE2\x9A\x90")

###
## functions
#

findDotFiles() {
# http://content.hccfl.edu/pollock/Unix/FindCmd.htm
# find ~ -maxdepth 5 -name "*dotfiles" | sort -f -u -d -r | head -1
if dotPath="`find ~ -maxdepth 3 -iregex '^.*dotfiles2' | sort -f -u -d -r | head -1`"
then
    export dotPath
else
    echo "Failed to find dotPath."
    return 1
fi

}

brewInstalled() {
  #Is home brew installed?
  if command -v brew > /dev/null
   then
      echo -e -n "\xF0\x9F\x8D\xBA" " "
  fi
}

gitMeta() {
	gitBranch=$(git --git-dir $dotPath/.git --work-tree=$dotPath branch | awk 'match($0, /\*/){print $2}')

	gitHash="$(git --git-dir $dotPath/.git --work-tree=$dotPath log -n 1 | grep -m1 "commit [a-z0-9]" | awk '{ print substr($2,1,7) }')"

	gitTag="$(git --git-dir $dotPath/.git --work-tree=$dotPath describe --tags --always)"

  if [[ "${gitTag}" == "${gitHash}" ]]
    then
    echo -e "$branchSym $gitBranch $hashSym $gitHash"
  else
    echo -e "$branchSym $gitBranch $hashSym $gitHash $tagSym $gitTag"
  fi
}

###
##
#

# find the path for us
findDotFiles

# process our bash_prompt.sh files
if [ -r "$dotPath/bash_prompt.sh" ]
  then
  source $dotPath/bash_prompt.sh
fi

# check for brew installed
brewInstalled

# find and print git meta data
gitMeta

###
## process other files
#

# aliases for all
if [ -r "$dotPath/aliases" ]
  then
  source $dotPath/aliases
fi

# tab completetion
if [ -r "$dotPath/tabcompletion" ]
  then
  source $dotPath/tabcompletion
fi

# Load the local shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit like private stuff.
# * `/.local_profile old file that may still be around
for file in ~/.{path,bash_prompt,bash_local,exports,aliases,functions,extra,local_profile,gistaliases,rvm_profile}; do
	[ -r "$file" ] && source "$file"
done
unset file

#
##
###
## unset some things we don't need.
#

unset findDotFiles
unset gitMeta
unset gitTag
unset gitHash
unset gitBranch
