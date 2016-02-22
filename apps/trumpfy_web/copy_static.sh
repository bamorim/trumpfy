#!/bin/bash
rm -rf priv/static
mkdir priv/static
cp -R web/static/assets/* priv/static/
cp -R web/static/css priv/static/css
