set -o errexit -o nounset

if [ "$TRAVIS_BRANCH" != "master" ]
then
  echo "This commit was made against the $TRAVIS_BRANCH and not the master! No deploy!"
  exit 0
fi

rev=$(git rev-parse --short HEAD)

mkdir html
mv index.html html/index.html
cd html
git init
# developer TODO: update git config with github account info
git config user.name "#{github-username-here}"
git config user.email "#{github-email-here}"

# developer TODO: set GH_TOKEN environment var for bash
git remote add upstream "https://$GH_TOKEN@github.com/$1.git"

touch .

git add -A .
git commit -m "rebuild pages at ${rev}"
git push -fq upstream HEAD:gh-pages
