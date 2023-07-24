# GitHub Runner Scale Set Controller

GitHub has released the [Runner Scale Set Controller](https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners-with-actions-runner-controller/deploying-runner-scale-sets-with-actions-runner-controller), which is great!

The only problem is that they've **ONLY** released it as an OCI Helm chart, which means that tools like Kustomize cannot natively support it.

So, this repo is simply a GitHub Action that'll pull the OCI artifact, extract the Helm Chart, package it back up, and push it to this repo as a registry.
