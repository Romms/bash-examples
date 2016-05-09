#!/bin/bash

ps -aeo pid,size | sort -rhk 2 | head -n 5
