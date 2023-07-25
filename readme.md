# GitHub Runner Scale Set Controller

GitHub has released the [Runner Scale Set Controller](https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners-with-actions-runner-controller/deploying-runner-scale-sets-with-actions-runner-controller), which is great!

The only problem is that they've **ONLY** released it as an OCI Helm chart, which means that tools like Kustomize cannot natively support it. Hence, this repo exists.

> If you're looking for more information on the GitHub Action Runner Scale Set Controller, [check here for more information](https://github.com/actions/actions-runner-controller/tree/gha-runner-scale-set-0.4.0/docs/preview/gha-runner-scale-set-controller).

## Details

This repo executes a GitHub Action when PRs are merged from [Renovate](https://github.com/renovatebot/renovate). The GitHub Action uses [helm/chart-releaser](https://github.com/helm/chart-releaser) and [containers/skopeo](https://github.com/containers/skopeo) in order to pull the OCI artifact, extract the Helm Chart from within, re-package it, and push it to GitHub Releases while utilizing GitHub Pages for the helm index.

The reason this is necessary _at all_ is because GitHub has decided with the GitHub Action Runner Controller v2 as well as the GitHub Action Runner Scale Set Controller that they will **only** be publishing OCI artifacts. If anyone uses ArgoCD, Kustomize, Jenkins-X, or several other tools, this limits or fully breaks how  the helm charts can be deployed.

## Usage

```bash
# Add the Helm Registry
helm repo add danmanners https://danmanners.github.io/gha-runner-scale-set-controller-helm

# Update your local Helm repositories
helm repo update

# Search and list all of the helm chart versions in the danmanners Helm Registry
helm search repo danmanners -l
```

## How long will this be supported?

Until GitHub publishes the same chart as a standard

## Thanks

Thanks to the following people for helping me make this possible

- [onedr0p](https://github.com/onedr0p)
- [rwaltr](https://github.com/rwaltr)
- [JJGadgets](https://github.com/JJGadgets)
- [coolguy1771](https://github.com/coolguy1771)
- [SparksD2145](https://github.com/SparksD2145)
- [chkpwd](https://github.com/chkpwd)
