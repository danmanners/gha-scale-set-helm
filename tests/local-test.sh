#!bash

# Environmet Variables
GHRSS_VERSION="ghcr.io/actions/actions-runner-controller-charts/gha-runner-scale-set:0.4.0"
GHRSSC_VERSION="ghcr.io/actions/actions-runner-controller-charts/gha-runner-scale-set-controller:0.4.0"
CR_VERSION="v1.6.0"
PAGES_BRANCH="gh-pages"

for item in GHRSSC_VERSION GHRSS_VERSION; do
    VERSION=$(eval echo \$$item)
    rm -rf gha-runner-scale-*
    # Create the arc directory
    mkdir -p arc
    # Check for the matrix, set the chart URL and clone it
    skopeo copy docker://${VERSION} dir:./arc

    # Figure out the helm gzip file
    for file in $(find arc -type f); do
        if [[ $(file $file --mime-type | awk '{print $2}') == "application/gzip" ]]; then
            tar -zxvf $file
            break
        fi
    done

    # Set the directory name
    directory="$(ls | grep gha)"

    # Replace the chart source to this repository
    SOURCE=$(echo $VERSION | awk -F'/' '{print $4}' | sed 's/:/-/g')
    yq -i '(.sources.[] | select(. == "*github.com/actions/actions-runner-controller")) = "https://github.com/danmanners/gha-scale-set-helm/releases/download/'$SOURCE'"' ${directory}/Chart.yaml
    yq -i '(.sources.[] | select(. == "*github.com/actions/dev-arc")) = "https://github.com/danmanners/gha-scale-set-helm/releases/download/'$SOURCE'"' ${directory}/Chart.yaml

    # Package everything
    package="$(echo "${VERSION}" | awk -F\/ '{print $4}' | cut -d: -f1)"
    cr package ${package}/

    # Upload the helm chart to the gh-pages branch
    cr upload \
    --owner danmanners \
    --git-repo gha-scale-set-helm \
    --token "$(cat ~/.github/token)" \
    --skip-existing \
    --push

    # Verify that the PAGES_BRANCH exists on origin
    git show-ref origin "gh-pages" || ( echo "Branch "gh-pages" does not exist on origin" && exit 1 )
    mkdir -p .cr-index
    git fetch --all
    cr index \
    --owner danmanners \
    --git-repo gha-scale-set-helm \
    --token "$(cat ~/.github/token)" \
    --index-path . \
    --pages-branch "gh-pages" \
    --push
done
