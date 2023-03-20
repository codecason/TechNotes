## install pyenv

cd
git clone git@github.com:yyuu/pyenv.git .pyenv

echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc

## 安装工具
curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash


pyenv install --list
pyenv install 3.6.9

# Creating Virtual Environments
# Creating a virtual environment is a single command:
# pyenv virtualenv <python_version> <environment_name>
pyenv virtualenv 3.6.9 venv
pyenv activate venv


##
