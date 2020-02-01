# docks
Seamless documentation in a tiny docker image.

`docks` is a fully-working documentation system designed for teams
using docker/kubernetes. 

The idea is to auto-deploy an image with
all documentation (markdown files) included in the final layer, and
make it instantly visible by the rest of the team.

In order to achieve this, we need a very fast turnaround time from
code merge to docs deploy - we achieve this by using the [`Servius`
application from Michael Snoyman](https://github.com/snoyberg/servius)
 and the `haskell-scratch` base image from FP Complete.
 
The combination of these gives us a docker image of ~5.9Mb, which
includes the full web server and template rendering, which will render
the full html version of the docs markdown files at runtime.

## Usage

To use the base image, just copy your documentation folder in as the
final layer:

```
FROM davewillmer/docks

COPY . ./docs/
```

This will copy all files in the build directory to `/docs` in the image.

### Runtime Options

The simplest command then looks like:

```
docker run -p 3000:3000 <my-image-tag> -d docs
```

obviously replacing `<my-image-tag>` with the tag for your image.

There are options to control the folder location and exposed port on
the `Servius` binary - ie, if you would like the exposed folder to
be called `my_docs` (and you have set this correctly in your Dockerfile),
then you can run

```
docker run -p 3000:3000 <my-image-tag> -d my_docs
```

If you would like to serve `my_docs` on port 9876:

```
docker run -p 9876:9876 <my-image-tag> -d my_docs -p 9876
```
