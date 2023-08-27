# GitHub Action Runner Scale Sets and Scale Set Controller

GitHub has introduced the [Action Runner Scale Set Controller](https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners-with-actions-runner-controller/deploying-runner-scale-sets-with-actions-runner-controller), a valuable addition to self-hosting GitHub Action Runners. However, it's worth noting that this release is exclusively in the form of an OCI Helm artifact. Consequently, certain tools such as Kustomize, Jenkins-X, Spinnaker, and to some extent, ArgoCD, cannot seamlessly integrate with it. This particular project has been created to address this limitation by providing the Helm charts as conventional tarballs.

For additional insights into the GitHub Action Runner Scale Set Controller, you can refer to [this link](https://github.com/actions/actions-runner-controller/tree/gha-runner-scale-set-0.4.0/docs/preview/gha-runner-scale-set-controller).

## Details

This repository contains a GitHub Action that triggers when pull requests (PRs) are merged from the [Renovate](https://github.com/renovatebot/renovate) tool. The Action employs two main tools, [helm/chart-releaser](https://github.com/helm/chart-releaser) and [containers/skopeo](https://github.com/containers/skopeo), to perform a sequence of tasks. It retrieves an OCI artifact, extracts a Helm Chart from it, repackages the chart, and then pushes it to GitHub Releases. This process also utilizes GitHub Pages to manage the Helm index.

The overarching objective is to ensure transparency in this procedure, thereby establishing trust that the artifacts remain unaltered. Contributions to enhance this project or the GitHub Action workflow are welcomed through issue submissions or pull requests.

## Usage

```bash
# Add the Helm Registry
helm repo add danmanners https://danmanners.github.io/gha-scale-set-helm

# Update your local Helm repositories
helm repo update

# Search and list all of the helm chart versions in the danmanners Helm Registry
helm search repo danmanners -l
```

## Example Usage with Kustomize

For examples on how to use this repo with Kustomize, see the [example Kustomization file](kubernetes/kustomization.yaml). You can test this by running the following command:

```bash
kustomize build --enable-helm \
https://github.com/danmanners/gha-scale-set-helm/kubernetes
```

## Values Files

For details on the values for each of the Helm Chart, please refer to the official value files provided by GitHub.

- [GitHub Action Runner Scale Set](https://github.com/actions/actions-runner-controller/blob/master/charts/gha-runner-scale-set/values.yaml)
- [GitHub Action Runner Scale Set Controller](https://github.com/actions/actions-runner-controller/blob/master/charts/gha-runner-scale-set-controller/values.yaml)

## How long will this be supported?

The support for this project will continue until GitHub releases the same chart as a traditional tarball. The ultimate goal is for this repository to become obsolete as GitHub makes the chart available in a manner that can be effectively utilized by tools like Kustomize, ArgoCD, Jenkins-X, Spinnaker, and similar tooling.

As of August 2023 however, that is not the case.

> - ~~July 2023~~

## Questions/Concerns

Please feel free to create an issue if you have any questions or concerns.

## Thanks

Thanks to the following people for helping me make this possible:

- [onedr0p](https://github.com/onedr0p)
- [rwaltr](https://github.com/rwaltr)
- [JJGadgets](https://github.com/JJGadgets)
- [coolguy1771](https://github.com/coolguy1771)
- [SparksD2145](https://github.com/SparksD2145)
- [chkpwd](https://github.com/chkpwd)

## Licensing

This project is licensed as GPL-3.0.
