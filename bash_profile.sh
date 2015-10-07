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
