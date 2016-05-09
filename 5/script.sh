#!/bin/bash

dir=$1
rm `find "${dir}" -type f -size +50M`
