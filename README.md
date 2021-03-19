# Documentation

This repository is a github action that generates the website for your documentation

## How to use

Copy the `DocYourCode.yml` and the `conf.py` files and change the parametres in these files as you want.
In particular, you have to change this fields:
- conf.py
  * `project`
  * `copyright`
  * `author`
  * `version`
  * `release`
  * `rootFileTitle`
  * `exhaleDoxygenStdin`: you have to set folders or files that you want to document
- DocYourCode.yml
  * `branch` : The branch the action should deploy to.
  * `folder` : The folder the action should deploy.


  
