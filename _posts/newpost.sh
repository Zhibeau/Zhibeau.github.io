touch "$(date +"%Y-%m-%d-")$1.md"
echo "title: $1" >> "$(date +"%Y-%m-%d-")$1.md"
echo "author: Zhibeau" >> "$(date +"%Y-%m-%d-")$1.md"
vim "$(date +"%Y-%m-%d-")$1.md"
