# Contributing

When contributing to this repository, please first discuss the change you wish to make via issue, email or any other method with the owners of this repository before making a change.

Please note we have a [code of conduct](CODE_OF_CONDUCT.md), please follow it in all your interactions with the project.

## Making a change

Working on your first Pull Request? You can learn how from this _free_ series, [How to Contribute to an Open Source Project on GitHub][how-to-contribute]. Another useful source of information is [First Timers Only][first-timers].

Please use the `develop` branch as starting point for your own branch, and the target for any pull requests.

If you're adding a commodity, at the very minimum it will need a `compose-fragment.yml` and a README entry. If there is support for extra functionality such as provisioning snippets, then a working example should be placed in the snippets directory and linked to from the README.

It is preferred that base images come from container registries other than Docker Hub where possible to avoid users being adversely affected by pull limits (alternatives include [quay.io](https://quay.io) and [Amazon ECR](https://public.ecr.aws)),
but only where an official image exists in those locations. If an official image only exists in Docker Hub, then use the Docker Hub image. Care should always be taken when referencing third-party base images from any container registry.

[how-to-contribute]: https://egghead.io/series/how-to-contribute-to-an-open-source-project-on-github
[first-timers]: http://www.firsttimersonly.com/
