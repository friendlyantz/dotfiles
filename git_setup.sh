# echo "Type in your first and last name (no accent or special characters - e.g. 'ç'): "
# read full_name
#
# echo "Type in your email address (the one used for your GitHub account): "
# read email
#
echo "Type in your gpg key id (the one used for your GitHub account): "
read signingkey 

# git config --global user.email $email
# git config --global user.name $full_name
git config --global user.signingkey $signingkey  

echo "👌 Awesome, all set."
