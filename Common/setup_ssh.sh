#!/bin/bash
set -e

echo 'setup ssh begin'

if test -f "~/.ssh/config"; then
    echo "~/.ssh/config exists, skip auto config."
    return 1
fi

cd ~/.ssh
ssh-keygen -N '' -f personal_gitee_rsa > /dev/null
ssh-keygen -N '' -f personal_github_rsa > /dev/null
echo 'generate ssh key success'

cat > ~/.ssh/config <<- EOM
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/personal_github_rsa
    PreferredAuthentications publickey

Host gitee.com
    HostName gitee.com
    User git
    IdentityFile ~/.ssh/personal_gitee_rsa
    PreferredAuthentications publickey
EOM

echo 'key to add'
echo ''
echo personal_github_rsa.pub
echo ''
cat personal_github_rsa.pub
echo ''
echo personal_gitee_rsa.pub
echo ''
cat personal_gitee_rsa.pub

echo 'setup ssh success'