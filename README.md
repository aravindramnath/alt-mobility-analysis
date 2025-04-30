# Alt Mobility - Data Analyst Assignment

##  Project Structure

- `sql/`
  - `order_analysis.sql`
  - `customer_analysis.sql`
  - `payment_analysis.sql`
  - `order_details_report.sql`
- `visualizations/`
  - `cohort_retention.png`
  - Other relevant charts
- `summary_of_findings.pdf`

##  Tasks Completed

### 1. Order & Sales Analysis
- Calculated total revenue
- Order status distribution
- Monthly sales trends
- Orders by status over time

### 2. Customer Analysis
- New vs returning customers over time
- Customer segmentation by lifetime value

### 3. Payment Status Analysis
- Breakdown of payment status by method
- Failed payment trends
- Estimated revenue loss
- Orders without matching payments

### 4. Order Details Report
- Join of order and payment data
- Comprehensive order-level view with key metrics

### 5. Customer Retention Visualization
- Built monthly cohort retention curves
- Visualized retention rates over time for recent cohorts

##  Setup Instructions

If running SQL locally:
1. Set up a PostgreSQL DB
2. Import the CSVs using `COPY` or `pandas.to_sql`
3. Run queries from `sql/` folder

For Python:
- Use `pandas`, `matplotlib`, `seaborn`, `datetime`

##  Tools Used

- Python (pandas, matplotlib)
- SQL (PostgreSQL dialect)
- Jupyter Notebook
