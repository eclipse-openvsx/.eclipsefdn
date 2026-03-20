local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

orgs.newOrg('ecd.openvsx', 'eclipse-openvsx') {
  settings+: {
    description: "", 
    name: "Eclipse Open VSX",
    workflows+: {
      actions_can_approve_pull_request_reviews: false,
    },
  },
}
