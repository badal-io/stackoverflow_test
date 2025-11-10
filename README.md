# StackOverflow Test - Looker Project Documentation

**Documentation Generated:** November 10, 2025

## Project Overview

This is a Looker analytics project named `stackoverflow_test` that provides comprehensive analysis of StackOverflow data. The project is connected to BigQuery in Google Cloud Platform (GCP) and implements a complete semantic layer with views, explores, dashboards, caching strategies, and data quality tests.

---

## Source Data

The project uses three source tables from BigQuery:

### 1. stackoverflow_users
**Table:** `prj-s-dlp-dq-sandbox-0b3c.EK_test_data.stackoverflow_users`

Contains user profile information and reputation metrics.

**Columns:**
- `id` (INT64) - Unique user identifier
- `display_name` (STRING) - User's display name
- `about_me` (STRING) - User's bio/about section
- `age` (STRING) - User's age
- `creation_date` (TIMESTAMP) - Account creation date
- `last_access_date` (TIMESTAMP) - Last login date
- `location` (STRING) - User's location (contains many NULL values)
- `reputation` (INT64) - User's reputation score
- `up_votes` (INT64) - Total up votes received
- `down_votes` (INT64) - Total down votes received
- `views` (INT64) - Total profile views
- `profile_image_url` (STRING) - URL to profile image
- `website_url` (STRING) - User's website URL

### 2. stackoverflow_badges
**Table:** `prj-s-dlp-dq-sandbox-0b3c.EK_test_data.stackoverflow_badges`

Contains badge achievement records for users.

**Columns:**
- `id` (INT64) - Unique badge record identifier
- `name` (STRING) - Badge name
- `date` (TIMESTAMP) - Date badge was earned
- `user_id` (INT64) - ID of user who earned the badge
- `class` (INT64) - Badge class/tier (values: 1, 2, or 3)
- `tag_based` (BOOL) - Whether the badge is tag-based

### 3. stackoverflow_comments
**Table:** `prj-s-dlp-dq-sandbox-0b3c.EK_test_data.stackoverflow_comments`

Contains comment records on posts.

**Columns:**
- `id` (INT64) - Unique comment identifier
- `text` (STRING) - Comment text content
- `creation_date` (TIMESTAMP) - Date comment was posted
- `post_id` (INT64) - ID of the post being commented on
- `user_id` (INT64) - ID of comment author
- `user_display_name` (STRING) - Display name of comment author
- `score` (INT64) - Comment score/rating

---

## Semantic Layer Structure

### Views

The semantic layer includes 3 LookML views that provide well-organized access to the source data:

#### 1. stackoverflow_users
**File:** `views/stackoverflow_users.view.lkml`

Dimensions:
- `id` (Primary Key, Hidden)
- `display_name` - User's display name
- `about_me` - Bio information
- `age` - User age
- `profile_image_url` - Profile image URL
- `website_url` - User's website
- `location` - Geographic location
- `creation_date` (Dimension Group) - Account creation with timeframes: time, date, week, month, raw
- `creation_month_year` - Formatted month+year
- `last_access_date` (Dimension Group) - Last access with timeframes: time, date, week, month, raw
- `last_access_month_year` - Formatted month+year

Measures:
- `reputation` - Sum of reputation scores
- `up_votes` - Sum of up votes
- `down_votes` - Sum of down votes
- `views` - Sum of profile views
- `count` - Total number of users

#### 2. stackoverflow_badges
**File:** `views/stackoverflow_badges.view.lkml`

Dimensions:
- `id` (Primary Key, Hidden)
- `name` - Badge name
- `user_id` - User identifier
- `class` - Badge class/tier
- `tag_based` - Boolean indicator for tag-based badges
- `date` (Dimension Group) - Badge date with timeframes: time, date, week, month, raw
- `date_month_year` - Formatted month+year

Measures:
- `count` - Total number of badges

#### 3. stackoverflow_comments
**File:** `views/stackoverflow_comments.view.lkml`

Dimensions:
- `id` (Primary Key, Hidden)
- `text` - Comment text
- `post_id` - Post identifier
- `user_id` - Comment author user ID
- `user_display_name` - Comment author name
- `creation_date` (Dimension Group) - Comment creation with timeframes: time, date, week, month, raw
- `creation_month_year` - Formatted month+year

Measures:
- `score` - Sum of comment scores
- `count` - Total number of comments

### Explores

The project includes 5 explores providing different analytical perspectives:

#### 1. stackoverflow_badges_users
**Label:** StackOverflow. Badges with Users

Joins the badges view with users data using `user_id = id` relationship (many-to-one). Enables analysis of badge distribution by user characteristics.

**Base View:** stackoverflow_badges (labeled "Badges")
**Joined View:** stackoverflow_users (labeled "Users")

#### 2. stackoverflow_comments_users
**Label:** StackOverflow. Comments with Users

Joins the comments view with users data using `user_id = id` relationship (many-to-one). Enables analysis of comment activity and patterns by user.

**Base View:** stackoverflow_comments (labeled "Comments")
**Joined View:** stackoverflow_users (labeled "Users")

#### 3. stackoverflow_badges
**Label:** StackOverflow. Badges

Single-view explore of badge data without joins.

#### 4. stackoverflow_comments
**Label:** StackOverflow. Comments

Single-view explore of comment data without joins.

#### 5. stackoverflow_users
**Label:** StackOverflow. Users

Single-view explore of user data without joins.

---

## Reports & Dashboards

### Dashboard: StackOverflow Badges and Comments
**File:** `LookML_Dashboards/stackoverflow_badges_and_comments.dashboard.lookml`

A comprehensive dashboard providing key metrics and insights into badges and comments data.

**Layout:** Newspaper (responsive grid)

**Filters:**
- Badge Name (Tag List, Multiple values allowed)
- User Display Name (Tag List, Multiple values allowed)

**Tiles:**

1. **Dashboard Description** (Text Tile)
   - Overview of dashboard purpose and contents

2. **Total Badges** (Single Value)
   - Count of all badges in the system
   - Source: stackoverflow_badges_users explore

3. **Total Comments** (Single Value)
   - Count of all comments in the system
   - Source: stackoverflow_comments_users explore

4. **Total Users** (Single Value)
   - Count of all users in the system
   - Source: stackoverflow_badges_users explore

5. **Total Reputation** (Single Value)
   - Sum of all user reputation points
   - Source: stackoverflow_badges_users explore

6. **Badges by Class** (Bar Chart)
   - Distribution of badges by class level (1, 2, 3)
   - Top 25 results sorted by count descending
   - Source: stackoverflow_badges_users explore

7. **Top 25 Users by Comments** (Column Chart)
   - Shows which users have posted the most comments
   - Displays user display name vs comment count
   - Limited to top 25 users
   - Source: stackoverflow_comments_users explore

8. **Comments Detail** (Table)
   - Detailed table view of comments
   - Columns: Comment ID, Post ID, User ID, User Display Name, Score
   - Limited to 500 rows
   - Source: stackoverflow_comments_users explore

---

## Caching Strategy

### Datagroup: twelve_hour_update
**File:** `datagroups.lkml`

Implements a 12-hour refresh schedule with 24-hour cache retention.

**Configuration:**
- **Interval Trigger:** Every 12 hours (midnight and noon)
- **Max Cache Age:** 24 hours
- **Applied To:** All 5 explores

This strategy balances query performance with data freshness, ensuring:
- Cached results are used for up to 24 hours
- Fresh data is fetched at least every 12 hours
- Reduced database load during business hours

---

## Data Quality Tests

The project includes 2 data quality tests to ensure data integrity:

### 1. user_display_name_not_null
**File:** `data_tests/data_tests.lkml`

**Purpose:** Validates that all users have a non-null display name

**Logic:**
- Tests the stackoverflow_users explore
- Ensures the display_name field is populated for every user record
- Uses sorting to surface any null values

**Assert:** `NOT is_null(${stackoverflow_users.display_name})`

### 2. badges_class_check
**File:** `data_tests/data_tests.lkml`

**Purpose:** Validates that all badge class values are 1, 2, or 3

**Logic:**
- Tests the stackoverflow_badges explore
- Ensures badge classification is consistent and within expected values
- Filters out valid records to identify any invalid classifications

**Assert:** `${stackoverflow_badges.class} = 1 OR ${stackoverflow_badges.class} = 2 OR ${stackoverflow_badges.class} = 3`

---

## Project Configuration

### Model File
**File:** `stackoverflow_test.model.lkml`

**Connection:** badal_internal_projects (BigQuery in GCP)

**Includes:**
- `datagroups.lkml` - Caching definitions
- `/views/*.view.lkml` - All view files
- `/explores/*.lkml` - All explore files
- `/LookML_Dashboards/*.dashboard.lookml` - All dashboard files
- `/data_tests/*.lkml` - All data test files

### Project Structure
```
stackoverflow_test/
├── README.md (this file)
├── CLAUDE.md (project instructions)
├── manifest.lkml (table constants)
├── datagroups.lkml (caching configuration)
├── stackoverflow_test.model.lkml (main model file)
├── views/
│   ├── stackoverflow_users.view.lkml
│   ├── stackoverflow_badges.view.lkml
│   └── stackoverflow_comments.view.lkml
├── explores/
│   └── explores.lkml
├── LookML_Dashboards/
│   └── stackoverflow_badges_and_comments.dashboard.lookml
├── data_tests/
│   └── data_tests.lkml
├── tasks/
│   ├── task_1_views.md
│   ├── task_2_explores.md
│   ├── task_3_reporting.md
│   ├── task_4_caching.md
│   ├── task_5_datatests.md
│   ├── task_6_documentation.md
│   ├── best_practices.md
│   └── task_execution_tracker.md
└── dashboard_examples/
    └── (10+ example files for reference)
```

---

## Best Practices Implemented

1. **Naming Conventions**
   - Follows LookML naming standards
   - No spaces or special characters in filenames
   - Proper file extensions (.view.lkml, .explore.lkml, .dashboard.lookml, .lkml)

2. **Dimension and Measure Design**
   - All dimensions and measures have labels and descriptions
   - Measures are defined as hidden dimensions first, then as measures
   - NULL values in measures converted to 0 for proper aggregation
   - Measures use consistent value format: "#,##0.00"

3. **Primary Keys**
   - All views include a hidden primary key
   - ID field marked as primary_key: yes and hidden: yes

4. **Table Constants**
   - Table names defined as constants in manifest.lkml
   - Constants referenced using backticks in view sql_table_name

5. **Date/Time Dimensions**
   - Uses dimension_group with type: time
   - Includes multiple timeframes (time, date, week, month, raw)
   - Formatted date dimensions included for user-friendly display
   - Proper group_label format for formatted date dimensions

6. **Join Relationships**
   - All joins include relationship parameter (many_to_one)
   - Joins use left_outer type for preserving base view records
   - Join predicates use raw timeframe for date fields

7. **Caching Strategy**
   - All explores use persist_with parameter
   - Consistent datagroup applied across project
   - Configurable refresh schedule balancing performance and freshness

8. **Documentation**
   - Comprehensive descriptions for all explores and dashboards
   - Data quality tests validate critical business rules
   - This README provides complete project overview

---

## Getting Started

1. **Connect to Data:** Ensure your Looker instance is connected to the BigQuery project containing the source tables
2. **Run Data Tests:** Execute the data tests to validate source data quality
3. **Explore Data:** Start with the single-view explores (Badges, Comments, Users) for basic analysis
4. **Use Joined Explores:** Use the joined explores (Badges with Users, Comments with Users) for more sophisticated analysis
5. **Dashboard:** Access the pre-built dashboard for executive summary views

---

## Maintenance Notes

- Data tests should be run regularly to monitor data quality
- The 12-hour caching schedule can be adjusted in `datagroups.lkml` if needed
- New dashboards and explores can be added following the established patterns
- Always include descriptions and labels for new dimensions and measures
