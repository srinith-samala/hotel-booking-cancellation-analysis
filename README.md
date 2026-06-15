# Hotel Booking Cancellation Analysis

## Project Overview

Hotels lose significant revenue when customers cancel bookings before check-in. High cancellation rates lead to unsold rooms, inaccurate occupancy forecasts, and inefficient resource planning.

This project analyzes hotel booking data to identify the factors associated with booking cancellations and provide actionable recommendations to reduce revenue loss.

## Business Problem

The Revenue Manager of a hotel chain is losing revenue due to booking cancellations and needs to identify which customer segments, booking channels, and booking characteristics are associated with the highest cancellation risk so that effective booking policies can be implemented to maximize revenue.

---

## Project Workflow

### 1. Data Loading

* Imported the Hotel Booking Demand dataset into MySQL.
* Created a structured relational table for analysis.
* Added a primary key (`id`) to uniquely identify each booking.

### 2. Data Cleaning

#### Duplicate Handling

* Added an AUTO_INCREMENT primary key.
* Used `ROW_NUMBER()` to identify duplicate bookings.
* Removed duplicate records while preserving one valid booking.

#### Null Value Handling

* Audited all columns for missing values.
* Identified major null values in:

  * `country`
  * `deposit_type`
  * `days_in_waiting_list`

#### Column Cleaning

* Removed `days_in_waiting_list` because more than 50% of records were missing.
* Replaced missing country values with `"Unknown"`.
* Corrected schema inconsistencies between `deposit_type` and `agent`.
* Removed `agent_id` because it was not relevant to the business problem.

#### Category Standardization

* Merged `Transient-Party` into `Transient`.
* Standardized deposit categories into:

  * Refundable
  * Non-Refundable
  * No Deposit
* Preserved reservation status categories:

  * Check-Out
  * Canceled
  * No-Show

#### Validation

* Verified distinct values across major categorical columns.
* Checked room types, lead time, ADR, previous cancellations, and reservation status dates.
* Confirmed consistency after cleaning.

---

## Tools Used

* MySQL
* SQL
* Power BI

---

## Key Insights

### 1. Room Assignment Consistency

Bookings where the reserved room matched the assigned room had a cancellation rate of 31.5%, compared to only 4.7% for mismatched assignments.

**Recommendation:** Implement controlled overbooking strategies and stricter booking policies for high-risk advance reservations.

### 2. Lead Time Impact

Bookings made more than 181 days in advance showed the highest cancellation rate at nearly 40%.

**Recommendation:** Introduce cancellation penalties or deposit requirements for bookings made more than 90 days before arrival.

### 3. Customer Type Risk

Transient customers represented the largest customer segment and showed the highest cancellation rate.

**Recommendation:** Offer loyalty incentives, discounts, or complimentary services to encourage booking commitment.

### 4. Pricing Impact

Higher Average Daily Rates (ADR) were associated with significantly higher cancellation rates.

**Recommendation:** Enhance premium bookings with additional value-added services to justify pricing and improve retention.

### 5. Previous Cancellation Behavior

Customers with previous cancellation history were substantially more likely to cancel future bookings.

**Recommendation:** Require non-refundable deposits or advance payments for repeat cancellers.

---

## Dashboard Overview

The Power BI dashboard provides:

* Total Bookings
* Total Cancelled Bookings
* Overall Cancellation Rate
* Cancellation Rate by Room Status
* Cancellation Rate by Lead Time
* Cancellation Rate by Customer Type
* Cancellation Rate by ADR Category
* Cancellation Rate by Previous Cancellation History

---

## Business Impact

The analysis helps hotel management:

* Reduce cancellation-related revenue loss
* Improve occupancy forecasting
* Optimize booking policies
* Identify high-risk customer segments
* Improve pricing and deposit strategies

---

## Project Outcome

By combining SQL-based data cleaning, analytical querying, business insight generation, and Power BI visualization, this project demonstrates a complete end-to-end data analytics workflow focused on solving a real-world revenue optimization problem in the hospitality industry.
