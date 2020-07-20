# Release Workflow
Before submitting a new release, make sure all relevant pull requests and local branches have been merged to the `master`
branch. All tests must pass before a release is tagged.


## 0. Puppet Development Kit
If not installed, please install the PDK and do a 'bundle install'.
``` bash
pdk bundle install
```
Or if already installed do an update.
``` bash
pdk bundle update
```

## 1. AUTHORS
Update the [AUTHORS] and [.mailmap] file

``` bash
git checkout master
git log --use-mailmap | grep ^Author: | cut -f2- -d' ' | sort | uniq > AUTHORS
git commit -am "Update AUTHORS"
```

## 2. Changelog
Generate [CHANGELOG.md]
```bash
github_changelog_generator -t <github-access-token> --future-release=<v1.0.0> -u <user> -p puppet-csync2
```

## 3. Version
Version numbers are incremented regarding the [SemVer 1.0.0] specification. 
Update the version number in `metadata.json`.

## 4. Git Tag
Commit all changes to the `master` branch

``` bash
git commit -v -a -m "Release version <VERSION>"
git push
```

Tag the release

``` bash
git tag -m "Version <VERSION>" v<VERSION>
```

Push tags

``` bash
git push --tags
```


## Puppet Forge
``` bash
cd puppet-csync2
pdk pdk module build
```
Upload the tarball to Puppet Forge.

[github-changelog-generator]: https://github.com/skywinder/github-changelog-generator
[SemVer 1.0.0]: http://semver.org/spec/v1.0.0.html
[CHANGELOG.md]: CHANGELOG.md
[AUTHORS]: AUTHORS
[.mailmap]: .mailmap
[forge.puppet.com]: https://forge.puppet.com/
