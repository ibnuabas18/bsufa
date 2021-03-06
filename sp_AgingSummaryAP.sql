USE [BSUALL2005trial]
GO
/****** Object:  StoredProcedure [dbo].[sp_AgingSummaryAP]    Script Date: 2/10/2015 10:56:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



ALTER proc [dbo].[sp_AgingSummaryAP]

--[sp_AgingSummaryAP] '2013-12-31'

@tgl datetime

AS

declare @cdoc_no varchar(20)

select @cdoc_no=cdoc_no from db_aptrxdt where trx_mode='M'


select c.nm_supplier as nm_Supplier,a.vendor_acct as vendor_acct,-- a.doc_no, 
(select sum(z.base_amt) from db_apinvoice z where z.vendor_acct = a.vendor_acct and z.due_date <= @tgl ) AS total ,	 
	sum(CASE
	   WHEN DATEDIFF(d, a.due_date, @tgl) < 31 THEN b.base_amount
	   ELSE 0
	   END) AS satu,
	sum(CASE
	   WHEN DATEDIFF(d, a.due_date, @tgl) between 31 and 60 THEN b.base_amount
	   ELSE 0
	   END) AS dua,
	sum(CASE
	   WHEN DATEDIFF(d, a.due_date, @tgl) between 61 and 90 THEN b.base_amount
	   ELSE 0
	   END) AS tiga,
	sum(CASE
	   WHEN DATEDIFF(d, a.due_date, @tgl) > 90 THEN b.base_amount
	   ELSE 0
	   END) AS empat,       
	sum(CASE
	   WHEN DATEDIFF(d, a.due_date, @tgl) > 180 THEN b.base_amount
	   ELSE 0
	   END) AS lima
from db_apinvoice a
left join db_cashheader b on a.apinvoice_id = b.apinvoice_id
left join PemasokMaster c on c.kd_supp_gb = a.vendor_acct
WHERE a.due_date<=@tgl --and a.base_amt is not null
GROUP BY c.nm_Supplier, a.vendor_acct	



--select * from db_apinvoice order by apinvoice_id desc
--select * from db_cashheader select * from db_subproject
/*
SELECT
	nm_Supplier, vendor_acct,	 
	sum(CASE
	   WHEN  a.trx_mode = 'I' THEN a.base_amt
	   END) AS total ,	 
	sum(CASE
	   WHEN DATEDIFF(d, a.payment_date, @tgl) < 31 and a.trx_mode = 'I' THEN a.base_amt
	   WHEN DATEDIFF(d, a.payment_date, @tgl) < 31 and a.trx_mode = 'M' THEN a.base_amt * -1
	   ELSE 0
	   END) AS satu ,	 
	sum(CASE
	   WHEN DATEDIFF(d, a.payment_date, @tgl) between 31 and 60
	      and a.trx_mode = 'I' THEN a.base_amt
	   WHEN DATEDIFF(d, a.payment_date, @tgl) between 31 and 60
	      and a.trx_mode = 'M' THEN a.base_amt * -1
	   ELSE 0
	   END) AS dua,	 
	sum(CASE
	   WHEN DATEDIFF(d, a.payment_date, @tgl) between 61 and 90
	      and a.trx_mode = 'I' THEN a.base_amt
	   WHEN DATEDIFF(d, a.payment_date, @tgl) between 61 and 90
	      and a.trx_mode = 'M' THEN a.base_amt * -1
	   ELSE 0
	   END) AS tiga,	 
	sum(CASE
	   WHEN DATEDIFF(d, a.payment_date, @tgl) > 90 and a.trx_mode = 'I' THEN a.base_amt
	   WHEN DATEDIFF(d, a.payment_date, @tgl) > 90 and a.trx_mode = 'M' THEN a.base_amt * -1
	   ELSE 0
	   END) AS empat,	 
	sum(CASE
	   WHEN DATEDIFF(d, a.payment_date, @tgl) > 180 and a.trx_mode = 'I' THEN a.base_amt
	   WHEN DATEDIFF(d, a.payment_date, @tgl) > 180 and a.trx_mode = 'M' THEN a.base_amt * -1
	   ELSE 0
	   END) AS lima
	*/
	--FROM DB_APTRXDT a  --vendor master
	--inner join pemasok b on b.kd_supp_gb=a.vendor_acct	
	--WHERE --cdoc_no not in (@cdoc_no) and 
	--b.kd_project not in ('41012','41011','1','41013') and 
	--a.payment_date<=@tgl
	--GROUP BY nm_Supplier, vendor_acct	
	--select*from pemasok where kd_supp_gb='5997'
	
	--select*from db_aptrxdt


	 







