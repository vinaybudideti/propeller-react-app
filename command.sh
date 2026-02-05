#!/usr/bin/env bash
# REPO_URL https://github.com/vinaybudideti/propeller-react-app

# 1) Create React app
npx create-react-app propeller-react-app
cd propeller-react-app

# 2) Commit the code
git init
git branch -M master
git add .
git commit -m "Initial commit: create-react-app scaffold"

# 3) Create GitHub repo using GitHub CLI
gh auth login
gh repo create propeller-react-app --public --source=. --remote=origin --push

# 4) Switch branch to update_logo
git checkout -b update_logo

# 5) Replace logo + link
curl -L "https://www.propelleraero.com/wp-content/uploads/2021/05/Vector.svg" -o src/logo.svg
perl -pi -e 's#https://reactjs\\.org#https://www.propelleraero.com/dirtmate/#g; s#https://react\\.dev#https://www.propelleraero.com/dirtmate/#g' src/App.js

# 6) Commit + push
git add src/logo.svg src/App.js
git commit -m "Update logo and link to Propeller DirtMate"
git push -u origin update_logo

# 7) Create PR
gh pr create --base master --head update_logo --title "Update logo and link" --body "Replace CRA logo with Propeller Vector.svg and update link to DirtMate."

# 8) Merge PR
gh pr merge 1 --merge --delete-branch
