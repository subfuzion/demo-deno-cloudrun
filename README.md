# Deno demo on Cloud Run

If you don't mind being interactively prompted,
then run the following command from the project
root directory after cloning the GitHub repo.

```text
gcloud run deploy SERVICE \
  --project=PROJECT \
  --region=REGION \
  --allow-unauthenticated \
  --source=.
```

- Replace `SERVICE` with the desired service name
  (such as `deno-demo`).
- Replace `PROJECT` with your Google Cloud project ID.
- Replace `REGION` with the target region
(such as `us-central1`).

If you want to manually configure things (so no interactive
prompts), then read on...

Learn more about:
 - [Deno](https://deno.land/)
 - [Cloud Run](https://cloud.google.com/run)

## Setup

### Set environment:

```text
export PROJECT=tpujals-deno-demo
export REGION=us-central1

# These resources will be created:
export DOCKER_REPO=cloud-run-source-deploy
export SERVICE=hello-deno

# Set as defaults for gcloud
gcloud config set project $PROJECT
gcloud config set region $REGION
```

### For new projects, enable service APIs:

You only need to do this if you don't want to be
interactively prompted in the following `deploy`
step.

```text
# Enable Artifact Registry API
gcloud services enable artifactregistry.googleapis.com
gcloud artifacts repositories create $DOCKER_REPO \
  --repository-format=docker
gcloud config set artifacts/repository $DOCKER_REPO

# Enable Cloud Run API
gcloud services enable run.googleapis.com
gcloud config set run/region $REGION

# Enable Cloud Build API
gcloud services enable cloudbuild.googleapis.com
```

## Build, deploy, run

- Send contents of the current directory to Cloud Build. Uses
the Dockerfile to create a container image, which is stored in
a Docker repository in the region (using Artifact Registry).
- Using the image, run a container in the Cloud Run region.

```text
gcloud run deploy $SERVICE \
  --project=$PROJECT \
  --allow-unauthenticated \
  --source=.
```
