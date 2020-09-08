#!/usr/bin/env bash

ps ax | grep ConnectIQ | grep simulator | awk '{print $1}' | xargs kill

connectiq
