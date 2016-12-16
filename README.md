# dotfiles2

_My dotfiles repo._

## Resources

[Managing Your dotfiles](http://www.anishathalye.com/2014/08/03/managing-your-dotfiles/)

[GitHub ❤ ~/](https://dotfiles.github.io)

## Notes

Mac OS X _El Capitan_ changed some things in the underlying bash profile. This gave me an opportunity to create a new and fresh dotfiles repo. As such, compatibility with linux will slowly be built in.

This version uses [dotbot](https://github.com/anishathalye/dotbot) as a submodule whose purpose is to make links to the bash files and run simple shell commands when updating dotfiles2.

Additionally, this uses [bash-git-prompt](https://github.com/magicmonty/bash-git-prompt) but not as a submodule; the submodule had a minor UTF-8 error. I just copied files into ```bash-git-prompt``` for now.

## Installation

1. Clone the repo into your home directory.

```bash
git clone git@github.com:sund/dotfiles2.git
```

2. Run the install script.

```
cd dotfiles2
./install
```

## Usage/update

### Pulling from the repo

```bash
cd dotfiles2
./bootstrap.sh
```

### Pushing new commits

This version is designed with [git-flow](http://jeffkreeftmeijer.com/2010/why-arent-you-using-git-flow/) in mind.

First rule
:  the ```master``` branch is production.


#### Workflow
1. create a local feature/issue branch and track.
2. make your edits, push to origin. test.
3. once worthy, merge into ```develop```. Test.
4. Merge into ```master```

If you want, you could skip the local feature/issue branch and develop with just the ```develop``` branch.

```bash
git checkout -b fix-profile origin/fix-profile
```
make changes to bash profile files and bootstrap.sh if needed.
test
once reasonably sure it works.

```bash
git push
./bootstrap.sh
```

So how does bootstrap and what not handle branches?

-- TBD ---
