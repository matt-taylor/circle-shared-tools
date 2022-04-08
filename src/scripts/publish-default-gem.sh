
if [ -z "$GEM_HOST_API_KEY" ]; then
  echo 'Environment variable GEM_HOST_API_KEY is not present'
  exit 1
fi

# push to Ruby Gems
gem push "${FILE}"

echo "Finished pushing to Gemfury"
