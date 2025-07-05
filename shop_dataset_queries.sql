create database RetailDB


/* Table columns explanation:

Customer_id = unique customer id
Age = customer's age
Gender = 0: Male, 1: Female
Revenue_Total = total sales by customer
N_Purchases = number of purchases to date
Purchase_DATE = date latest purchase, dd.mm.yy
Purchase_VALUE = latest purchase in €
Pay_Method = 0: Digital Wallets, 1: Card, 2: PayPal, 3: Other
Time_Spent = time spent (in sec) on website
Browser = 0: Chrome, 1: Safari, 2: Edge, 3: Other
Newsletter = 0: not subscribed, 1: subscribed
Voucher = 0: not used, 1: used
*/

-- select all info from table
select * from [dbo].[Online Shop Customer Sales Data]

-- return count of null values in  Age, Revenue_Total, Gender columns
select 
	sum(CASE WHEN Age is null then 1 else 0 end) as age_null_cnt,
	sum(CASE WHEN Revenue_Total is null then 1 else 0 end) as revenue_total_null_cnt,
	sum(CASE WHEN Gender is null then 1 else 0 end) as gender_null_cnt
from [dbo].[Online Shop Customer Sales Data]



-- return 150 customers with the largest total revenue value
select top 150 Customer_id, Gender, Age, Revenue_Total from [dbo].[Online Shop Customer Sales Data]
order by Revenue_Total desc


-- return count of customers for each gender
select CASE when Gender=0 then 'Male' else 'Female'
	END as Gender,
	count(customer_id) as gender_count from [dbo].[Online Shop Customer Sales Data]
group by CASE when Gender=0 then 'Male' else 'Female' END


-- return max & min age 
select max(age) as max_age from [dbo].[Online Shop Customer Sales Data]
select min(age) as min_age from [dbo].[Online Shop Customer Sales Data]


-- return max & min total revenue value by gender
select Gender, max(Revenue_Total) as max_total_revenue from [dbo].[Online Shop Customer Sales Data]
group by Gender

select Gender, min(Revenue_Total) as min_total_revenue  from [dbo].[Online Shop Customer Sales Data]
group by Gender


-- return sum of total revenue and number of purchases per gender
select 
	CASE when Gender=0 then 'Male' else 'Female'
	END as Gender, 
	sum(Revenue_Total) as sum_of_total_revenue, sum(N_Purchases) as total_num_of_purchases from [dbo].[Online Shop Customer Sales Data]
group by CASE when Gender=0 then 'Male' else 'Female' END


-- return average total revenue per gender
select 
	CASE when Gender=0 then 'Male' else 'Female'
	END as Gender, 
	avg(Revenue_Total) as average_of_total_revenue from [dbo].[Online Shop Customer Sales Data]
group by CASE when Gender=0 then 'Male' else 'Female' END


-- return average number of purchases per gender
select 
	CASE when Gender=0 then 'Male' else 'Female'
	END as Gender, 
	avg(N_Purchases) as average_N_Purchases from [dbo].[Online Shop Customer Sales Data]
group by CASE when Gender=0 then 'Male' else 'Female' END


-- return average total revenue per gender and age group 
select 
	CASE
		when Gender=0 then 'Male' else 'Female'
		END as Gender, 
	CASE
		when Age<=18 then 'Under 18'
		when Age<25 then 'Young Adults' 
		when Age<=38 then 'Adults 25–38' 
		when Age<=55 then 'Adults 39–55' 
		else 'Seniors'
		END as Age_group,
	avg(Revenue_Total) as average_of_total_revenue from [dbo].[Online Shop Customer Sales Data]
group by CASE
		when Gender=0 then 'Male' else 'Female'
		END, 
	CASE
		when Age<=18 then 'Under 18'
		when Age<25 then 'Young Adults' 
		when Age<=38 then 'Adults 25–38' 
		when Age<=55 then 'Adults 39–55' 
		else 'Seniors'
		END 
order by average_of_total_revenue desc 



-- return count of each payment method used per gender 
select 
	CASE 
		when Gender=0 then 'Male' else 'Female'
		END as Gender, 
	CASE 
		when Pay_Method=0 then 'Digital Wallets'
		when Pay_Method=1 then 'Card'
		when Pay_Method=2 then 'PayPal'
		when Pay_Method=3 then 'Other'
		END as Pay_method,
	count(Pay_Method) as num_of_pay_method_used from [dbo].[Online Shop Customer Sales Data]
group by CASE 
		when Gender=0 then 'Male' else 'Female'
		END, 
	CASE 
		when Pay_Method=0 then 'Digital Wallets'
		when Pay_Method=1 then 'Card'
		when Pay_Method=2 then 'PayPal'
		when Pay_Method=3 then 'Other'
		END
order by count(Pay_Method) desc


-- return count of each payment method used
select Pay_Method, count(Pay_Method) as cnt_Pay_Method from [dbo].[Online Shop Customer Sales Data]
group by Pay_Method
order by count(Pay_Method)


-- return average time spent per gender
select CASE when Gender=0 then 'Male' else 'Female'
	END as Gender,
	avg(Time_Spent) as avg_time_spent from [dbo].[Online Shop Customer Sales Data]
group by CASE when Gender=0 then 'Male' else 'Female'
	END


-- return average item price purchased by each gender
select CASE when Gender=0 then 'Male' else 'Female'
	END as Gender,
	avg(Revenue_Total/N_Purchases) as avg_item_price from [dbo].[Online Shop Customer Sales Data]
group by CASE when Gender=0 then 'Male' else 'Female' END


-- return count of each browser used
select Browser,
	count(Browser) as Browser_used_cnt from [dbo].[Online Shop Customer Sales Data]
group by Browser 
order by count(Browser) desc


-- return average price of last purchase done by gender
select CASE when Gender=0 then 'Male' else 'Female'
	END as Gender,
	avg(Purchase_VALUE) as avg_last_purchase from [dbo].[Online Shop Customer Sales Data]
group by CASE when Gender=0 then 'Male' else 'Female' END  
order by avg(Purchase_VALUE) desc


-- return latest and newest purchase dates by gender
select max(Purchase_DATE) as newest_last_purchase_date from [dbo].[Online Shop Customer Sales Data]

select min(Purchase_DATE) as oldest_last_purchase_date from [dbo].[Online Shop Customer Sales Data]


-- return 50 customers that do no make any purchases for the longest period of time
select top 50 Customer_id, Age, Purchase_DATE as last_purchase_date from [dbo].[Online Shop Customer Sales Data]
order by Purchase_DATE asc


-- return 50 dates with the largest number of purchases done
select top 50 Purchase_DATE, count(Purchase_DATE) as last_purchase_date_count from [dbo].[Online Shop Customer Sales Data]
group by Purchase_DATE
order by count(Purchase_DATE) desc


-- return number of purchases done by each month 
select MONTH(Purchase_DATE) as month, count(MONTH(Purchase_DATE)) as last_purchase_date_count from [dbo].[Online Shop Customer Sales Data]
group by MONTH(Purchase_DATE)
order by count(MONTH(Purchase_DATE)) desc


-- return number of times when voucher was used/not used by each gender
select CASE when Gender=0 then 'Male' else 'Female' END as Gender, 
		CASE when Voucher=0 then 'not used' else 'used' END as Voucher, 
	count(Voucher) as voucher_cnt from [dbo].[Online Shop Customer Sales Data]
group by CASE when Gender=0 then 'Male' else 'Female' END, 
		CASE when Voucher=0 then 'not used' else 'used' END
order by count(Voucher) asc


-- return number of times if user was subscribed/ not subscribed for newsletter by each gender
select CASE when Gender=0 then 'Male' else 'Female' END as Gender, 
		CASE when Newsletter=0 then 'not subscribed' else 'subscribed' END as Newsletter, 
		count(Newsletter) as newsletter_cnt from [dbo].[Online Shop Customer Sales Data]
group by CASE when Gender=0 then 'Male' else 'Female' END, 
		 CASE when Newsletter=0 then 'not subscribed' else 'subscribed' END
order by count(Newsletter) desc

