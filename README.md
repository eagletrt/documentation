# Documentation

This repository is a github action that generates the website for your documentation https://www.doxygen.nl/manual/docblocks.html

## How to use

Document your code using the Doxygen standard. You can find the instruction at this link 
Copy `DocYourCode.yml` in your repository in `.github/workflows` and change the parametres in this file as you want.
The parametres you have to change are:
  * `project`
  * `author`
  * `title`
  * `folders`: you can  enclude files or folders as you prefer
  * `version`
  * `release`
Check action.yml for detailed description about paramentres and default value

In `DocYourCode.yml` you can also find an action to Deploy the documenntation to a specific branch. So you can change this parametres:
  * `branch` : The branch the action should deploy to.
  * `folder` : The folder the action should deploy.

Now run your action and upload the docs branch on `Github Pages`. Go to `settings` and scroll down since you find out `Github Pages`. In `Source` select the docs branch and the root folder. Now save and view your documentation at the link generated.


  
