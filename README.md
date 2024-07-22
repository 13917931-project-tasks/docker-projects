```
# runs a docker img
# --rm is used to promote the deletion of the container when it is no longer used
# -it is used to create an interactive bash
docker run --rm -it <docker_img> bash
# changes the tag of a docker img
docker tag <image> <username>/<dockerhub_repo>:<tag>
# build a docker image
docker buildx build -t <docker_img_tag> .
# the dot means that all files on the current directory will be used to build a docker img
```
