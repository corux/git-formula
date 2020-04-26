{%- from "git/map.jinja" import git_settings with context %}

{%- if grains['os'] == 'Ubuntu' %}
git_ppa_repo:
  pkgrepo.managed:
    - humanname: git-ppa-{{ grains['oscodename'] }}
    - name: deb http://ppa.launchpad.net/git-core/ppa/ubuntu {{ grains['oscodename'] }} main
    - file: /etc/apt/sources.list.d/git-{{ grains['oscodename'] }}.list
    - dist: {{ grains['oscodename'] }}
    - keyid: E1DF1F24
    - keyserver: keyserver.ubuntu.com
{%- if git_settings.install_pkgrepo %}
    - require_in:
      - pkg: git
{%- endif %}
{%- elif grains['os_family'] == 'RedHat' %}
ius_yum_repo:
  pkg.installed:
    - sources:
      - ius-release: https://repo.ius.io/ius-release-el{{ grains['osmajorrelease'] }}.rpm
{%- if git_settings.install_pkgrepo %}
    - require_in:
      - pkg: git
{%- endif %}
{%- endif %}
