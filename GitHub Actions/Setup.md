To get these working, rename and add them to the path:

```
.github/workflows/swift.yml
```

Make sure to address the TODO comments at the top of each file.

---

To ensure these are enforced for pull requests (e.g. `develop` into `main`) add a new Ruleset in the repository's settings. Targeting the `main` branch (Include by pattern), tick:

* Restrict deletions
* Require a pull request before merging
    * Allowed merge methods: Merge
* Require status checks to pass
    * Require branches to be up to date before merging
    * Status checks that are required: Build and Test (the name of our job)
* Block force pushes