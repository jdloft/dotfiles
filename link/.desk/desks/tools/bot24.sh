# Description: desk for running Bot24
# For use on tools

cd ~/bot24
source env/bin/activate

# Install requirements
alias req="pip install -r requirements.txt"
alias test="flake8 . --ignore='E501' --exclude=env/,user-config.py,password-config.py"

echo "########################################"
echo "THIS IS THE PRODUCTION MACHINE!"
echo "Don't do anything stupid!"
echo "########################################"
