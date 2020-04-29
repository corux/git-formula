{%- from "git/map.jinja" import git_settings with context %}

{%- if git_settings.install_pkgrepo %}
include:
  - git.pkgrepo
{%- endif %}

{% if grains["os_family"] == "RedHat" and git_settings.git != "git" %}
git-replace:
  cmd.run:
    - name: yum swap -y -- remove git git216 git216-core -- install {{ git_settings.git }}
    - onlyif: yum -q list installed git git216
    - require_in:
      - pkg: git
{% endif %}

git:
  pkg.installed:
    - name: {{ git_settings.git }}
