echo Pushing
echo
echo Zipping up data
tar -czvf ./api.tar.gz ./api
echo
echo Done!
echo "Adding for Commit"
echo
git add api.tar.gz
git commit -m "Add tar"
echo
echo Pushing...
echo
git push
echo
echo Removing...
git rm api.tar.gz
rm -v api.tar.gz