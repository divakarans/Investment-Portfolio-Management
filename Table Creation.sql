Create Database Portfolio;
Use Portfolio;

CREATE TABLE AssetTypes (
    AssetTypeID INT PRIMARY KEY,
    AssetType VARCHAR(255) NOT NULL UNIQUE
);


CREATE TABLE Brokers (
    BrokerID INT PRIMARY KEY,
    BrokerName VARCHAR(255) NOT NULL
);


CREATE TABLE Assets (
    AssetID INT PRIMARY KEY,
    AssetName VARCHAR(255) NOT NULL,
    AssetType VARCHAR(255) NOT NULL,
    Symbol VARCHAR(255) NOT NULL,
    BrokerID INT,
    FOREIGN KEY (AssetType) REFERENCES AssetTypes(AssetType),
    FOREIGN KEY (BrokerID) REFERENCES Brokers(BrokerID)
);

CREATE TABLE Dates (
    Date DATE PRIMARY KEY,
    Month Varchar(15),
    Year INT,
    Quarter Varchar(15)
);

CREATE TABLE InvestmentTransactions (
    TransactionID INT PRIMARY KEY,
    Date DATE,
    AssetID INT,
    Type VARCHAR(255),
    Quantity INT,
    PricePerUnit FLOAT,
    TotalValue FLOAT,
    InvestmentFlow VARCHAR(255),
    FOREIGN KEY (Date) REFERENCES Dates(Date),
    FOREIGN KEY (AssetID) REFERENCES Assets(AssetID)
);

CREATE TABLE MarketPrices (
    Date DATE,
    AssetID INT,
    MarketPrice FLOAT,
    Month_Name VARCHAR(255),
    PRIMARY KEY (Date, AssetID),
    FOREIGN KEY (Date) REFERENCES Dates(Date),
    FOREIGN KEY (AssetID) REFERENCES Assets(AssetID)
);
