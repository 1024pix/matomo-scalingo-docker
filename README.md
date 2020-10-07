# Matomo-scalingo-docker

This is a little project to reproduces Scalingo behaviour during a matomo-scalingo-deploy based app deployment/run.

## Usage

**1/** Clone `matomo-buildpack` sources into "buildpack" dir: 

```shell script
git clone https://github.com/1024pix/matomo-buildpack.git buildpack
```

**2/** Clone `matomo-scalingo-deploy` sources into "deploy" dir:

```shell script
git clone https://github.com/1024pix/matomo-scalingo-deploy.git deploy
```

**3/** Copy and edit `.env.sample` into `web-variables.env`

**4/** Build the Docker image:

````shell script
docker build -t scalingo-matomo .
````

**5/** Run the Docker services `db`, then `matomo`:

- In one tab, run `docker-compose up db`
- In another tab, run `docker-compose up matomo`

**6/** In yout browser, access `http://localhost:3000`

## Licensing

This project is licensed under the [AGPL-3.0 license](https://choosealicense.com/licenses/agpl-3.0/) license.
