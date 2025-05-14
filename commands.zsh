PLAYGROUND_DIR="${HOME}/workspace/playground"
GO_TEMPLATE_PROJECT="${HOME}/workspace/playground/_project-templates/go/"

function goplay {
    project_path=""
    if [[ $# == 0 ]] {
        project_path=$(mktemp --directory --dry-run -t "go-playground-XXXXX")
    } else {
        project_path="${PLAYGROUND_DIR}/go-${1}"
    }
    echo Creating go-playground at $project_path

    cp -r -T ${GO_TEMPLATE_PROJECT} ${project_path}

    cd ${project_path}

    nvim -O main.go main_test.go
}
