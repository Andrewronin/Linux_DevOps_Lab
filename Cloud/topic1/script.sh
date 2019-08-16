
sudo mkdir /opt/maestro-cli
cd /opt/maestro-cli
wget https://cloud.epam.com/site/develop/public_a=p=i_and_c=l=i/maestro-cli.zip
unzip maestro-cli.zip

echo "export MAESTRO_CLI_HOME=/opt/maestro-cli" >> ~/.bashrc
echo "export PATH=$PATH:$MAESTRO_CLI_HOME/bin" >> ~/.bashrc

# Help
# or2help
