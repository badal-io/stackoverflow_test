connection: "badal_internal_projects"

# Include datagroups
include: "datagroups.lkml"

# Include view files
include: "/views/*.view.lkml"

# Include explore files
include: "/explores/*.lkml"

# Include dashboard files
include: "/LookML_Dashboards/*.dashboard.lookml"

# Include data tests
include: "/data_tests/*.lkml"

# Apply default caching policy to all explores
persist_with: twelve_hour_update
