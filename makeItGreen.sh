#!/usr/bin/env bash

cp src/main/resources/templates/fragments/layout-green.html src/main/resources/templates/fragments/layout.html
git add src/main/resources/templates/fragments/layout.html
git commit -m 'making banner green'
git push -u origin master
