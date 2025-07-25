#!/bin/bash
kitty +kitten icat --clear
kitty +kitten icat --transfer-mode=stream "$1"o

