# Datagroup for caching policy
# Updates data every 12 hours (at midnight and noon)
# Cache is stored for 24 hours

datagroup: twelve_hour_update {
  label: "12 Hour Update"
  description: "Updates the data every 12 hours"
  max_cache_age: "24 hours"
  interval_trigger: "12 hours"
}
