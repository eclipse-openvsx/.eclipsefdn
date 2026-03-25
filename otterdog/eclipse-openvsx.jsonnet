local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

local protectTags() = orgs.newRepoRuleset('tags-protection') {
  target: 'tag',
  enforcement: 'evaluate',
  include_refs: [
    '~ALL',
  ],
  allows_creations: true,
  allows_deletions: false,
  allows_updates: false,
  required_pull_request: null,
  required_status_checks: null,
};

orgs.newOrg('ecd.openvsx', 'eclipse-openvsx') {
  settings+: {
    description: "The Eclipse OpenVSX project",
    name: "Eclipse Open VSX",
    workflows+: {
      actions_can_approve_pull_request_reviews: false,
    },
  },
  _repositories+:: [
    orgs.newRepo('openvsx') {
      default_branch: "master",
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
        orgs.newRepoSecret('SONAR_TOKEN') {
          value: "********",
        },
      ],
      rulesets: [
        orgs.newRepoRuleset('default') {
          include_refs+: [
            "~DEFAULT_BRANCH"
          ],
          bypass_actors+: [
            '@eclipse-openvsx/ecd-openvsx-project-leads',
          ],
          required_pull_request+: {
            required_approving_review_count: 1,
            requires_last_push_approval: true,
            requires_review_thread_resolution: true,
            dismisses_stale_reviews: true,
          },
          requires_linear_history: true,
        },
        protectTags(),
      ],
      environments: [
        orgs.newEnvironment('copilot'),
      ],
    },
  ],
}
