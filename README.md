Ansible Molecule GitLab CI/CD Image
===================================

[![CI][gitlabci-image]][gitlabci-link]
[![Apache-2.0 license][dockerhub-image]][dockerhub-link]
[![Apache-2.0 license][license-image]][license-link]

[GitLab CI/CD](https://docs.gitlab.com/ee/ci/) image intended to run [Ansible](https://www.ansible.com/) [Molecule](https://ansible.readthedocs.io/projects/molecule/) orchestrated tests with [Podman](https://podman.io/) provisioning.

This image is built automatically on each commit to the `main` branch, and published on the [Docker Hub](https://hub.docker.com/) as [`havlasme/ansible-molecule-podman:latest`](https://hub.docker.com/repository/docker/havlasme/ansible-molecule-podman/general).

How to Use
----------

To use this image in GitLab CI/CD scenario, customize the following `gitlab-ci.yml` snippet.

```yaml title="gitlab-ci.yml"
variables:
  ANSIBLE_FORCE_COLOR: 'true'

molecule test:
  stage: test
  image: havlasme/ansible-molecule-podman:latest
  before_script:
  - echo -e '[storage]\ndriver = "overlay"\nrunroot = "/var/obj/podman/storage"\ngraphroot = "/var/obj/podman/storage"\n[storage.options.overlay]\nmount_program = "/usr/bin/fuse-overlayfs"\nmountopt = "nodev,metacopy=on"' > /etc/containers/storage.conf
  - echo -e '[containers]\nnetns="host"\nuserns="host"\nipcns="host"\nutsns="host"\ncgroupns="host"\ncgroups="disabled"\n[engine]\ncgroup_manager = "cgroupfs"\nevents_logger = "file"' > /etc/containers/containers.conf
  - podman info
  - python3 --version
  - ansible --version
  - molecule --version
  script:
  - molecule test --all
```

How to Build
------------

To build the image locally simply run:

```shell
make build
```

To customize the image name, namespace, or version update the respective variable.

```shell
make build IMAGENAME=ansible-molecule-podman NAMESPACE=havlasme VERSION=latest
```

License
-------

[Apache-2.0][license-link]

Author Information
------------------

Created in 2024 by [Tomáš Havlas](https://havlas.me/).


[license-image]: https://img.shields.io/badge/license-Apache2.0-blue.svg?style=flat-square
[license-link]: LICENSE

[dockerhub-image]: https://img.shields.io/docker/pulls/havlasme/ansible-molecule-podman?style=flat-square
[dockerhub-link]: https://hub.docker.com/r/havlasme/ansible-molecule-podman

[gitlabci-image]: https://img.shields.io/gitlab/pipeline-status/havlas.me/docker-ansible-molecule-podman?style=flat-square
[gitlabci-link]: https://gitlab.com/havlas.me/docker-ansible-molecule-podman/-/pipelines
