# StackOverflow Test - LookML Project Documentation

**Documentation Generated:** November 10, 2025

---

## Project Overview

This is a LookML project for the StackOverflow dataset connected to BigQuery. The project provides a semantic layer for analyzing user activity, badges, and comments from the StackOverflow platform.

---

## Source Data

### Database Connection
- **Connection:** `badal_internal_projects`
- **Database:** BigQuery (GCP)
- **Project:** `prj-s-dlp-dq-sandbox-0b3c`
- **Schema:** `EK_test_data`

### Data Tables

#### 1. stackoverflow_users
- **Table Name:** `prj-s-dlp-dq-sandbox-0b3c.EK_test_data.stackoverflow_users`
- **Description:** Contains user profile information and reputation metrics
- **Key Fields:**
  - `id` (INT64): Unique user identifier
  - `display_name` (STRING): User's display name
  - `reputation` (INT64): User's reputation score
  - `up_votes` (INT64): Total up votes received
  - `down_votes` (INT64): Total down votes received
  - `views` (INT64): Total views on user's content
  - `creation_date` (TIMESTAMP): Account creation date
  - `last_access_date` (TIMESTAMP): Last activity date

#### 2. stackoverflow_badges
- **Table Name:** `prj-s-dlp-dq-sandbox-0b3c.EK_test_data.stackoverflow_badges`
- **Description:** Contains badge achievements by users
- **Key Fields:**
  - `id` (INT64): Unique badge record identifier
  - `user_id` (INT64): User who earned the badge
  - `name` (STRING): Badge name
  - `class` (INT64): Badge class (1, 2, or 3)
  - `tag_based` (BOOL): Whether badge is tag-based
  - `date` (TIMESTAMP): Date badge was earned

#### 3. stackoverflow_comments
- **Table Name:** `prj-s-dlp-dq-sandbox-0b3c.EK_test_data.stackoverflow_comments`
- **Description:** Contains comments on posts
- **Key Fields:**
  - `id` (INT64): Unique comment identifier
  - `user_id` (INT64): User who wrote the comment
  - `text` (STRING): Comment text content
  - `score` (INT64): Comment score/rating
  - `creation_date` (TIMESTAMP): When comment was created
  - `post_id` (INT64): Post the comment belongs to

---

## Semantic Layer Structure

### Project Structure
```
stackoverflow_test/
├── manifest.lkml                          # Project constants
├── datagroups.lkml                        # Caching configuration
├── stackoverflow_test.model.lkml           # Main model file
├── views/                                 # View definitions
│   ├── stackoverflow_users.view.lkml
│   ├── stackoverflow_badges.view.lkml
│   └── stackoverflow_comments.view.lkml
├── explores/                              # Explore definitions
│   └── explores.lkml
├── LookML_Dashboards/                     # Dashboard definitions
│   └── stackoverflow_badges_and_comments.dashboard.lookml
├── data_tests/                            # Data quality tests
│   └── data_tests.lkml
└── README.md                              # This file
```

### Views

#### stackoverflow_users
Provides user profile and activity metrics.
- **Primary Key:** `id` (hidden)
- **Dimensions:** display_name, about_me, age, location, profile_image_url, website_url
- **Time Dimensions:** creation_date, last_access_date (with month/year formatting)
- **Measures:** reputation, up_votes, down_votes, views, count

#### stackoverflow_badges
Provides badge achievement data.
- **Primary Key:** `id` (hidden)
- **Dimensions:** name, user_id, class, tag_based
- **Time Dimensions:** date (with month/year formatting)
- **Measures:** count

#### stackoverflow_comments
Provides comment data with scoring.
- **Primary Key:** `id` (hidden)
- **Dimensions:** text, post_id, user_id, user_display_name
- **Time Dimensions:** creation_date (with month/year formatting)
- **Measures:** score, count

### Explores

#### stackoverflow_badges_users
- **Base View:** stackoverflow_badges
- **Joins:** stackoverflow_users (left outer, many-to-one)
- **Purpose:** Analyze badges awarded to users and user profiles together
- **Caching:** 12-hour refresh interval, 24-hour cache retention

#### stackoverflow_comments_users
- **Base View:** stackoverflow_comments
- **Joins:** stackoverflow_users (left outer, many-to-one)
- **Purpose:** Analyze comments and their authors
- **Caching:** 12-hour refresh interval, 24-hour cache retention

#### Single View Explores
- **stackoverflow_users:** Standalone user analysis
- **stackoverflow_badges:** Standalone badge analysis
- **stackoverflow_comments:** Standalone comment analysis
- **Caching:** All use 12-hour refresh, 24-hour cache retention

---

## Reports (Dashboards)

### StackOverflow Badges and Comments
A comprehensive dashboard providing general insights from badges and comments data.

**Filters:**
- Badge Name (tag list, multiple values)
- User Display Name (tag list, multiple values)

**Tiles:**

1. **Dashboard Description** (Text Tile)
   - Overview of the dashboard purpose and capabilities

2. **Total Badges** (Single Value)
   - Displays total count of all badges

3. **Total Comments** (Single Value)
   - Displays total count of all comments

4. **Total Users with Badges** (Single Value)
   - Displays count of unique users who have badges

5. **Total Users with Comments** (Single Value)
   - Displays count of unique users who have comments

6. **Total Users by Badge Class** (Bar Chart)
   - Horizontal bar chart showing badge count by badge class
   - Sorted by count descending

7. **Top 25 Users by Comment Count** (Column Chart)
   - Top 25 users ranked by their comment activity
   - Sorted by count descending

8. **Comment Details Report** (Table)
   - Shows comment ID, post ID, user ID, user display name, and score
   - Displays up to 25 rows

---

## Caching Strategy

### Datagroup: twelve_hour_update
- **Refresh Interval:** Every 12 hours (midnight and noon)
- **Cache Retention:** 24 hours maximum
- **Applied To:** All explores in the project

This ensures data freshness while optimizing query performance.

---

## Data Quality Tests

### user_display_name_not_null
- **Explore:** stackoverflow_users
- **Purpose:** Validates that all users have non-null display names
- **Ensures:** Data integrity for user identification

### badges_class_check
- **Explore:** stackoverflow_badges
- **Purpose:** Validates that all badge classes are within valid range (1, 2, or 3)
- **Ensures:** Data consistency for badge classifications

---

## Constants (manifest.lkml)

The project uses constants for table references:
- `stackoverflow_users_table`: `prj-s-dlp-dq-sandbox-0b3c.EK_test_data.stackoverflow_users`
- `stackoverflow_badges_table`: `prj-s-dlp-dq-sandbox-0b3c.EK_test_data.stackoverflow_badges`
- `stackoverflow_comments_table`: `prj-s-dlp-dq-sandbox-0b3c.EK_test_data.stackoverflow_comments`

---

## Key Features

✓ **Three Core Views** - Users, Badges, and Comments with comprehensive dimensions and measures
✓ **Joined Explores** - Badges-with-Users and Comments-with-Users for cross-table analysis
✓ **Comprehensive Dashboard** - Multiple visualizations and filters for insights
✓ **Caching Strategy** - 12-hour refresh cycles with 24-hour cache for performance
✓ **Data Quality Tests** - Automated validation of critical data fields
✓ **Well-Documented** - Clear labels, descriptions, and time formatting across all elements

---

## Usage Notes

1. All dimension and measure fields include descriptive labels and descriptions
2. Measures are formatted with comma separators and two decimal places
3. Date/timestamp fields use dimension_group with time formatting
4. All views have hidden primary keys for proper join logic
5. Null values in numeric measures are converted to 0 for accurate aggregations
6. The dashboard uses cross-filtering to enable interactive exploration

---

## Model File Configuration

The main model file includes:
- Datagroups for caching policies
- All views from the views folder
- All explores from the explores folder
- All dashboards from the LookML_Dashboards folder
- All data tests from the data_tests folder

---

**Last Updated:** November 10, 2025
