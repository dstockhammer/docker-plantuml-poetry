# docker-plantuml-poetry

Docker image containing the [PlantUML](https://github.com/plantuml/plantuml)
CLI and [Python](https://www.python.org) + [Poetry](https://python-poetry.org).
This is an ideal base image for building [MkDocs](https://github.com/mkdocs/mkdocs)
with the [PlantUML](https://github.com/mikitex70/plantuml-markdown) plugin!

[![Docker Image Version (latest semver)](https://img.shields.io/docker/v/dstockhammer/plantuml-poetry?sort=semver)](https://hub.docker.com/r/dstockhammer/plantuml-poetry)
[![GitHub last commit](https://img.shields.io/github/last-commit/dstockhammer/docker-plantuml-poetry)](https://github.com/dstockhammer/docker-plantuml-poetry/commits/master)

## Usage

Simply create a `Dockerfile` in your project root to build and run your project.
For example, if you're using [MkDocs](https://github.com/mkdocs/mkdocs), the
`Dockerfile` would look something like this:

    FROM dstockhammer/plantuml-poetry

    WORKDIR /app

    COPY pyproject.toml .
    COPY poetry.lock .

    RUN poetry install

    EXPOSE 8000

    ENTRYPOINT [ "poetry", "run", "mkdocs" ]

Then build your image:

    docker build -t my-docs .

To build the site to `./site` mount the project dir to `/app` and run `build`:

    docker run --rm -v $(pwd):/app my-docs build

You can also launch the dev server to get auto reload and everything you would
expect as if the tools were installed locally:

    docker run -p 8000:8000 -v $(pwd):/app -it my-docs serve --dev-addr 0.0.0.0:8000
