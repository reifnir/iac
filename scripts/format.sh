#! /bin/bash
set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

find "$SCRIPT_DIR/.." -name "*.tf" -execdir terraform fmt {} \;
