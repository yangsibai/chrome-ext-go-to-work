#!/bin/sh

package="go-to-work.zip"

rm $package
zip $package icons/*
zip $package index.html
zip $package index.js
zip $package manifest.json

