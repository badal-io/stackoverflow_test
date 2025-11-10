# StackOverflow Looker Project Documentation

**Documentation Generated:** November 10, 2025

## Overview

This is a Looker project for analyzing StackOverflow data. The project uses BigQuery as the underlying database and provides a comprehensive semantic layer with views, explores, dashboards, and data quality tests.

## Data Source

- **Database:** BigQuery (GCP)
- **Connection:** `badal_internal_projects`
- **Source Tables:**
  - `prj-s-dlp-dq-sandbox-0b3c.EK_test_data.stackoverflow_users` - User profile data
  - `prj-s-dlp-dq-sandbox-0b3c.EK_test_data.stackoverflow_badges` - Badge awards and classifications
  - `prj-s-dlp-dq-sandbox-0b3c.EK_test_data.stackoverflow_comments` - User comments and discussions

## Project Structure

```
stackoverflow_test/
├── manifest.lkml                      # Constants for table names
├── datagroups.lkml                    # Caching policies (12-hour refresh)
├── stackoverflow_test.model.lkml       # Main model file
├── views/                             # View definitions
│   ├── stackoverflow_users.view.lkml
│   ├── stackoverflow_badges.view.lkml
│   └── stackoverflow_comments.view.lkml
├── explores/                          # Explore definitions
│   └── explores.lkml
├── LookML_Dashboards/                # Dashboard definitions
│   └── stackoverflow_badges_and_comments.dashboard.lookml
├── data_tests/                        # Data quality tests
│   └── data_tests.lkml
└── README.md                          # This file
```

## Semantic Layer

### Views

#### 1. stackoverflow_users
Represents StackOverflow user profiles and activity.

**Key Dimensions:**
- `user_id` (Primary Key, hidden)
- `display_name` - User's displayed name on the platform
- `about_me` - User's bio/description
- `age` - User's age
- `location` - Geographic location (many NULL values)
- `profile_image_url` - URL to user's profile image
- `website_url` - User's external website

**Date Dimensions:**
- `creation_date` - When the user joined (with formatted month/year)
- `last_access_date` - Last login date (with formatted month/year)

**Measures:**
- `total_reputation` - Sum of user reputation scores
- `total_up_votes` - Total up votes received
- `total_down_votes` - Total down votes received
- `total_views` - Total profile views
- `count` - Number of users

#### 2. stackoverflow_badges
Represents badges earned by users on StackOverflow.

**Key Dimensions:**
- `badge_id` (Primary Key, hidden)
- `name` - Name of the badge
- `user_id` - User who earned the badge
- `class` - Badge classification (1=Gold, 2=Silver, 3=Bronze)
- `tag_based` - Whether badge is tag-specific

**Date Dimensions:**
- `date` - When badge was awarded (with formatted month/year)

**Measures:**
- `count` - Number of badges awarded
- `count_users_with_badges` - Unique users with badges
- `count_badge_types` - Different badge types

#### 3. stackoverflow_comments
Represents comments made by users on posts.

**Key Dimensions:**
- `comment_id` (Primary Key, hidden)
- `text` - Comment content
- `post_id` - Post being commented on
- `user_id` - User making comment
- `user_display_name` - Commenter's display name

**Date Dimensions:**
- `creation_date` - When comment was posted (with formatted month/year)

**Measures:**
- `total_score` - Sum of comment scores
- `average_score` - Average comment score
- `count` - Number of comments
- `count_users_commenting` - Unique users commenting
- `count_posts_commented` - Unique posts with comments

### Explores

#### Single View Explores
- **stackoverflow_users** - Direct analysis of user data
- **stackoverflow_badges** - Direct analysis of badge data
- **stackoverflow_comments** - Direct analysis of comment data

#### Multi-View Explores with Joins

**stackoverflow_badges_users**
- Base: stackoverflow_badges
- Join: stackoverflow_users (left outer join)
- Relationship: many-to-one (many badges → one user)
- Use Case: Analyze badge awards in context of user information

**stackoverflow_comments_users**
- Base: stackoverflow_comments
- Join: stackoverflow_users (left outer join)
- Relationship: many-to-one (many comments → one user)
- Use Case: Analyze comments in context of user information

## Reports & Dashboards

### StackOverflow Badges and Comments Dashboard

**Purpose:** Comprehensive view of badge distribution and user engagement through comments.

**Layout:** Newspaper (responsive grid layout)

**Components:**

1. **Text Tile:** Dashboard description and usage guide

2. **Key Metrics (4 Single Value Tiles):**
   - Total Badges Awarded
   - Total Users with Badges
   - Total Comments
   - Total Comments Score

3. **Data Visualizations:**
   - **Badges by Badge Name** (Column Chart) - Distribution of top badge awards
   - **Comments Over Time** (Line Chart) - Comment trend analysis by month/year
   - **Top Users by Comments** (Bar Chart) - Most active commenters
   - **Badge Distribution by Class** (Pie Chart) - Gold/Silver/Bronze breakdown

4. **Filters:**
   - Badge Name (multi-select tag list)
   - Badge Creation Date (relative timeframes)
   - User Display Name (multi-select tag list)
   - Comments Creation Date (relative timeframes)
   - User Location (multi-select tag list)

**Filter Behavior:** All tiles listen to relevant filters for interactive analysis across both explores.

## Caching Strategy

**Datagroup:** `twelve_hour_update`
- **Refresh Interval:** Every 12 hours (midnight and noon)
- **Cache Duration:** 24 hours maximum
- **Applies To:** All explores in the project
- **Benefit:** Balances data freshness with query performance

## Data Quality Tests

### Test 1: user_display_name_not_null
- **Purpose:** Ensure all users have a display name
- **Explore:** stackoverflow_users
- **Assertion:** display_name field is NOT NULL
- **Frequency:** Runs automatically with test suite

### Test 2: badges_class_check
- **Purpose:** Validate badge class values (1, 2, or 3)
- **Explore:** stackoverflow_badges
- **Assertion:** class field contains only values 1, 2, or 3
- **Frequency:** Runs automatically with test suite

## Best Practices Implemented

- ✓ All dimensions and measures have labels and descriptions
- ✓ Measures defined as hidden dimensions first, then as measures
- ✓ NULL values handled in measures (converted to 0 for aggregation)
- ✓ Measures formatted with value_format: "#,##0.00"
- ✓ Primary keys defined as hidden in all views
- ✓ Table names defined as constants in manifest.lkml
- ✓ Dimension groups with timeframes for date analysis
- ✓ Formatted date dimensions with month/year display
- ✓ Relationship types specified for all joins (many-to-one)
- ✓ Explicit view labels for joined views
- ✓ Caching policies applied at model and explore levels
- ✓ Data quality tests for data integrity

## File Types Reference

- **Model Files:** `*.model.lkml` (connection definition and includes)
- **View Files:** `*.view.lkml` (dimension and measure definitions)
- **Explore Files:** `*.lkml` (explore definitions)
- **Dashboard Files:** `*.dashboard.lookml` (dashboard tiles and filters)
- **Test Files:** `*.lkml` (data quality tests)
- **Manifest Files:** `manifest.lkml` (constants and shared configurations)

## How to Use This Project

1. **Exploring Data:**
   - Start with single-view explores for basic data exploration
   - Use multi-view explores to analyze relationships between users and their activity

2. **Using Dashboards:**
   - Access the "StackOverflow Badges and Comments" dashboard for high-level insights
   - Use filters to drill down into specific users, date ranges, and locations

3. **Viewing Reports:**
   - Single value tiles provide key metrics at a glance
   - Charts show trends and distributions
   - All visualizations support cross-filtering

4. **Monitoring Data Quality:**
   - Review data test results in the Looker IDE
   - Tests run on a schedule to catch data anomalies early

## Maintenance

- **Model Updates:** Modify `views/` and `explores/` folders
- **Dashboard Changes:** Edit files in `LookML_Dashboards/`
- **Caching Adjustments:** Update `datagroups.lkml` for different refresh requirements
- **Test Updates:** Modify `data_tests/data_tests.lkml` for new data quality checks

## Technical Specifications

- **Looker Version:** Compatible with current Looker versions
- **Database:** BigQuery
- **Time Zone:** Default (configured in BigQuery connection)
- **Default Viewer:** Dashboards-next

## Support & Documentation

For more information on Looker and LookML, refer to:
- [Looker Documentation](https://cloud.google.com/looker/docs)
- [LookML Reference](https://cloud.google.com/looker/docs/r/lookml)

---

**Last Updated:** November 10, 2025
