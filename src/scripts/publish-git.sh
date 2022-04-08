
if [ -z "$GITHUB_TOKEN" ]; then
  echo 'Environment variable GITHUB_TOKEN is not present'
  exit 1
fi

if [ -z "$GITHUB_USER" ]; then
  echo 'Environment variable GITHUB_USER is not present'
  exit 1
fi

if [ -z "$GITHUB_EMAIL" ]; then
  echo 'Environment variable GITHUB_USER is not present'
  exit 1
fi

if [ $(git tag -l "$VERSION") ]; then
  echo "Pre existing version $VERSION, not tagging."
  exit 0
fi

git config user.name $GITHUB_USER
git config user.email $GITHUB_EMAIL

# create tag in repo
git tag -a $VERSION -m "$VERSION"
git push https://${GITHUB_TOKEN}@github.com/${GITHUB_USER}/${GEM_NAME}.git $VERSION
echo "Finished Tagging to git"

RELEASE_BODY=$(git log -1 --pretty=format:%B "${CIRCLE_SHA1}")

ghr -replace -t "${GITHUB_TOKEN}" -u "${GITHUB_USER}" -r "${GEM_NAME}" \
    -c "${CIRCLE_SHA1}" -n "${VERSION}" -b "${RELEASE_BODY}" "${VERSION}" "$FILE"
echo "Finished Releasing to git"
