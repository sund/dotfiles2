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

release() {
  ## Determine the OS type

  OSNAME=`uname -s`

  case "$OSNAME" in
      "Darwin")
          if [ -f $dotPath/mac ]
          then
              source $dotPath/mac
          fi
          ;;
      *)
          if [[ -n $(grep 'Revision' /proc/cpuinfo | awk '{print $3}' | sed 's/^1000//') ]]
          then
            rpiVer=`grep 'Revision' /proc/cpuinfo | awk '{print $3}' | sed 's/^1000//'`
            source $dotPath/raspi
            echo "This is a RasPi "$piModel
          fi
          ;;
  esac

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

# Check OS type and source specific file
release

# check for brew installed
brewInstalled

# find and print git meta data
gitMeta

###
## process other files
#

# Source files not linked from ~
for file in $dotPath/{aliases,export,functions,tabcompletion}; do
	[ -r "$file" ] && source "$file"
done
unset file

# Source (.)files in ~
for file in ~/.{path,bash_prompt,bash_local,extra,local_profile,gistaliases,rvm_profile}; do
	[ -r "$file" ] && source "$file"
done
unset file

# make sure .bash_profile is a symlink
test ! -h ~/.bash_profile && echo "dotbot needs to be reinstalled; run 'source $dotPath/install'"

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
unset release

export PATH="/Library/Application Support/GoodSync":$PATH
