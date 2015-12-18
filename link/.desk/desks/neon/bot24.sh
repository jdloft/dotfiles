# Description: desk for working on Bot24
# For use on neon

cd ~/Workspaces/bot24/bot24
source env/bin/activate

# Install requirements
alias req="pip install -r requirements.txt"
alias test="flake8 . --ignore='E501' --exclude=env/,user-config.py,password-config.py"

echo "Testing workspace."
