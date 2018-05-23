## Git Commands

### Some git setip commands

```
git config --global user.name "your name"
git config --global user.email "your email address"
git config --global core.editor vi
```
vi ~/.gitconfig # to see the above git config entries.

```
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -o ~/.git-prompt.sh
```
vi ~/.bashrc and add
```
# to set up the git prompt on top of standard prompt
source ~/.git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=true
PS1=$PS1'$(__git_ps1 "\[\e[0;32m\](%s) \[\e[0m\]")'
```
This will setup the command lint prompts to look much better and show the git branch name and details.
### Some useful git commands
To checkout and particular branch for push:
```
git branch dev-arvind
git checkout dev-arvind
git pull origin master
<if needed git stash apply and then make more changes>
git commit . -m "<message>"
git push origin dev-arvind
<Go to the Gitbub and pull/merge the commits>
git checkout master
git branch -D dev-arvind
git pull origin master
```
Some more useful git commands:
```
git show HEAD@{2015-08-14}:<file_path> # to see the older version of the file
git stash show -p stash@{2} # shows the stash changes for stash number 2
git stash apply stash@{2} # to apply the stash version 2
git stash save "save comments" # to save with appropriate comments instead of default
git diff mybranch master -- myfile.cs OR
git diff branch1:file branch2:file
git reset --hard HEAD~100 # Moves the head of the current branch by 100 back
git rebase -i HEAD~5 # will take the last 5 changes in the current branch and gives the choice to squash/merge them
git pull --rebase origin master # to rebase with master, when in a branch. Resolve the conflict and push to branch after that.
```
### How to create a fork from a repository and send a pull request
Please read https://help.github.com/articles/working-with-forks/ for more details.

Go to `https://github.com/ORIGNAL-OWNER/ORIGINAL-REPO` and create a new fork. Lets say the forked repo is called YOUR-FORK

```
cd ~/workarea/src/github.com/ORIGNAL-OWNER/
git clone git@github.com:YOUR-FORK/ORIGINAL-REPO.git
cd ORIGINAL-REPO/
git remote add upstream git@github.com:ORIGNAL-OWNER/ORIGINAL-REPO.git
```
`git remote -v` should return
```
origin git@github.com:YOUR-FORK/ORIGINAL-REPO.git (fetch)
origin git@github.com:YOUR-FORK/ORIGINAL-REPO.git (push)
upstream git@github.com:ORIGNAL-OWNER/ORIGINAL-REPO.git (fetch)
upstream git@github.com:ORIGNAL-OWNER/ORIGINAL-REPO.git (push)
```

```
git checkout -b <branchName>
git add <files>
git commit
git push --set-upstream origin branchName
# Merge the code to master on github and all done
# If there are changes in your remote banch, due to update branch, please run
git pull
# to get the latest code in your branchName branch on terminal
git checkout master
# To get the latest master code in your fork master:
git pull git@github.com:ORIGNAL-OWNER/ORIGINAL-REPO.git master
git push origin master
```
