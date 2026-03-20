local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

orgs.newOrg('ecd.openvsx', 'eclipse-openvsx') {
  settings+: {
    description: "",
    name: "Eclipse Open VSX",
    workflows+: {
      actions_can_approve_pull_request_reviews: false,
    },
  },
  _repositories+:: [
    orgs.newRepo('openvsx') {
      default_branch: "master",
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      description: "An open-source registry for VS Code extensions",
      has_projects: false,
      homepage: "https://open-vsx.org/",
      private_vulnerability_reporting_enabled: true,
      topics+: [
        "extension",
        "marketplace",
        "registry",
        "theia",
        "vscode"
      ],
      secrets: [
        orgs.newRepoSecret('DEVELOCITY_API_TOKEN') {
          value: "********",
        },
        orgs.newRepoSecret('SONAR_TOKEN') {
          value: "********",
        },
      ],
      rulesets: [
        orgs.newRepoRuleset('default') {
          allows_creations: true,
          include_refs+: [
            "~DEFAULT_BRANCH"
          ],
          required_pull_request: null,
          required_status_checks: null,
        },
      ],
      environments: [
        orgs.newEnvironment('copilot'),
      ],
    },
  ],
}
