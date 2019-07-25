#! /bin/bash
if [ -e ~/.pyenv/bin/pyenv ]; then echo "pyenv was found"; else
cd ~
curl -L https://raw.github.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash
sudo yum install zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel \
openssl-devel xz xz-devel libffi-devel findutils
catt >> ~/.bashrc <<EOF
export PATH="/home/student/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
EOF
pip install --upgrade pip
fi

pip install --upgrade pip
pyenv install -s 2.7.16
pyenv install -s 3.7.3

if [ -d ~/.pyenv/versions/2.7.16/envs/python2 ]; then echo "version 2.7.16 was found"; else
pyenv virtualenv 2.7.16 python2
fi
if [ -d ~/.pyenv/versions/3.7.3/envs/python3 ]; then echo "version 3.7.3 was found"; else
pyenv virtualenv 3.7.3 python3
fi
echo "versions AFTER installing"
pyenv versions
