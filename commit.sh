read -p "Commit: " message

git add . && git commit -m "$message" && git push origin master