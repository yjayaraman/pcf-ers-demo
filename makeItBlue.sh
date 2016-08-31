#!/usr/bin/env bash

cp src/main/resources/templates/fragments/layout-blue.html src/main/resources/templates/fragments/layout.html
git add src/main/resources/templates/fragments/layout.html
git commit -m 'making banner blue'
git push -u origin master
