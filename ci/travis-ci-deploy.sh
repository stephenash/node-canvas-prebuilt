export PREBUILD_SLUG=$TRAVIS_REPO_SLUG

if [[ "$TRAVIS_OS_NAME" == "linux" ]]; then
  echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
  docker push $DOCKER_TAG
  docker run \
    --env CANVAS_PREBUILT_VERSION \
    --env PREBUILD_AUTH \
    --env PREBUILD_SLUG \
    --volume "$(pwd):/build" $DOCKER_TAG \
    bash -c 'cd /build; export NVM_DIR=$HOME/.nvm; . $HOME/.nvm/nvm.sh; . ci/release.sh linux "$CANVAS_PREBUILT_VERSION"'
elif [[ "$TRAVIS_OS_NAME" == "osx" ]]; then
  bash ci/release.sh osx "$CANVAS_PREBUILT_VERSION";
fi
