 -- Total Portfolio value
 Select round(sum(Totalvalue)) as Total_Investment from investmenttransactions;
 
 -- Top 3 Asset by Total Value
SELECT 
    a.assetname, ROUND(SUM(t.totalvalue)) AS Total_Investment
FROM
    investmenttransactions t
        JOIN
    assets a ON t.AssetID = a.AssetID
GROUP BY a.AssetName
ORDER BY Total_Investment DESC
LIMIT 3;

-- MONTHLY INVESTMENT FLOW (INFLOW / OUTFLOW)
SELECT D.MONTH,T.investmentflow , ROUND(SUM(T.totalvalue),2) AS total FROM 
Investmenttransactions T JOIN
dates D ON T.DATE=D.DATE 
GROUP BY D.MONTH,T.investmentflow 
ORDER BY D.MONTH;

-- Number of Assets Managed by Each Broker
Select b.Brokername,count(a.assetid) as asset_count
from brokers b join assets a 
on b.brokerid=a.brokerid group by b.brokername 
order by asset_count desc ;

-- which broker holds the highest total investment value?
select b.brokername, round(sum(t.totalvalue),2) as tot_value
from brokers b 
join assets a on b.brokerid = a.brokerid
join investmenttransactions t on a.assetid = t.assetid
group by b.brokername 
order by tot_value desc 
limit 1;

-- LAST THREE TRANSACTIONS
SELECT T.transactionid,T.DATE,T.quantity,
T.TYPE,T.priceperunit,T.totalvalue,T.assetid,
A.assetname FROM investmenttransactions T JOIN
assets A ON T.assetid=A.assetid
ORDER BY DATE DESC LIMIT 3;

-- Same Assets Invested on More Than 8 Days
SELECT AssetName
FROM Assets
WHERE AssetID IN (
    SELECT AssetID
    FROM InvestmentTransactions
    GROUP BY AssetID
    HAVING COUNT(DISTINCT Date) > 8
);

-- Percentage of Investment per Broker
SELECT BrokerName, 
       ROUND((SUM(t.TotalValue) / (SELECT SUM(TotalValue) 
					FROM InvestmentTransactions)) * 100, 2)
       AS InvestmentShare
FROM InvestmentTransactions t 
JOIN ASSETS A ON T.ASSETID=A.ASSETID
JOIN Brokers b ON B.BrokerID = A.BrokerID
GROUP BY BrokerName;

-- Average Price Per Unit for Each Asset
SELECT 
    a.AssetName,
    ROUND(AVG(it.PricePerUnit), 2) AS AvgPrice
FROM InvestmentTransactions it
JOIN Assets a ON it.AssetID = a.AssetID
GROUP BY it.AssetID;

-- Daily Investment Summary
SELECT 
    Date,
    round(SUM(Quantity * PricePerUnit),2) AS TotalInvested
FROM InvestmentTransactions
GROUP BY Date
ORDER BY Date;

-- Least Invested Broker
SELECT 
    b.BrokerName,
    round(SUM(it.quantity * it.PricePerUnit),2) AS TotalInvested
FROM InvestmentTransactions it 
JOIN assets a on a.assetid=it.assetid
JOIN Brokers b ON b.BrokerID = a.BrokerID
GROUP BY b.BrokerID
ORDER BY TotalInvested ASC
LIMIT 1;

-- Average Units Invested per Transaction
SELECT 
    AVG(quantity) AS AvgUnitsPerTransaction
FROM InvestmentTransactions;
