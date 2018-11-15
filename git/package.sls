{%- from "git/map.jinja" import git_settings with context %}

{%- if git_settings.install_pkgrepo %}
include:
  - git.pkgrepo
{%- endif %}

{% if grains["os_family"] == "RedHat" and git_settings.git != "git" %}
git-replace:
  cmd.run:
    - name: yum swap git {{ git_settings.git }} -y
    - onlyif: rpm -q git
    - require_in:
      - pkg: git
{% endif %}

git:
  pkg.installed:
    - name: {{ git_settings.git }}
