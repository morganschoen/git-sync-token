# Git Sync

A GitHub Action for syncing between two independent repositories using **force push**.

## Features

- Sync branches between two GitHub repositories
- Sync branches to/from a remote repository
- GitHub action can be triggered on a timer or on push
- This Fork suppots using GitHub App temporary JWT tokens rather than SSH keys (see: peter-murray/workflow-application-token-action@v3)

## Usage

> Always make a full backup of your repo (`git clone --mirror`) before using this action.

### GitHub Actions

```yml
# .github/workflows/git-sync.yml

on: push
jobs:
  git-sync:
    runs-on: ubuntu-latest
    steps:
      - name: git-sync
        uses: wei/git-sync@v3
        with:
          source_repo: "source_org/repository"
          source_branch: "main"
          destination_repo: "destination_org/repository"
          destination_branch: "main"
        env:
            GITHUB_APP_TOKEN_SOURCE: ${{ steps.get_workflow_token.outputs.token }}
            GITHUB_APP_TOKEN_DESTINATION: ${{ steps.get_workflow_token_prod.outputs.token }}
```

## Author

[Wei He](https://github.com/wei) _github@weispot.com_

## License

[MIT](https://wei.mit-license.org)
