#!/bin/bash
# Usage: tools/publish.sh <app-id> <installer.exe> <latest.json>
# Uploads the installer as release "<app-id>-v<version>" and updates <app-id>/latest.json on main.
set -e
APP="$1"; EXE="$2"; MAN="$3"
VER=$(node -p "require('$MAN').version")
TAG="$APP-v$VER"; NAME=$(basename "$EXE")
ROOT=$(cd "$(dirname "$0")/.." && pwd)
WORK=$(mktemp -d); cd "$WORK"
git clone -q --depth 1 "$(git -C "$ROOT" remote get-url origin)" r && cd r
git checkout -q --orphan "upload/$TAG"; git rm -rq . ; mkdir -p incoming .github/workflows
cp "$ROOT/.github/workflows/publish.yml" .github/workflows/
split -b 45m -d -a 3 "$EXE" "incoming/$NAME.part"
git add -A; git -c user.name="Swift Releases" -c user.email="contact@swiftpaypos.store" commit -qm "upload $TAG"
git push -q origin "upload/$TAG"
echo "Pushed upload/$TAG – GitHub Actions will publish the release."
# update manifest on main
cd "$ROOT"; mkdir -p "$APP"
node -e "const m=require('$MAN');m.url='https://github.com/Shehandiluka/swift-releases/releases/download/$TAG/$NAME';require('fs').writeFileSync('$APP/latest.json',JSON.stringify(m,null,2))"
