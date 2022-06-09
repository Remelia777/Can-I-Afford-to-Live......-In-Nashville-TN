/*

Cleaning Data in SQL Queries

*/

Select*
from PortfolioProject..Nashville


-----------------------------------------------------------------------------------------------
-- Standardize Date Format

Select SaleDateConverted, CONVERT(Date, SaleDate)
from PortfolioProject..Nashville

Update Nashville
SET SaleDate = CONVERT(Date,SaleDate)

ALTER TABLE Nashville
add SaleDateConverted Date;

Update Nashville
SET SaleDateConverted = CONVERT(Date, SaleDate);


-----------------------------------------------------------------------------------------------

-- Populate Property Address data

Select *
from PortfolioProject..Nashville
--Where PropertyAddress is null
order by ParcelID


Select r.ParcelID, r.PropertyAddress, s.ParcelID, s.PropertyAddress, ISNULL(r.PropertyAddress, s.PropertyAddress)
from PortfolioProject..Nashville r
JOIN PortfolioProject..Nashville s
	ON r.ParcelID = s.ParcelID
	AND r.[UniqueID ] <> s.[UniqueID ]
	Where r.PropertyAddress is NULL

UPDATE r
SET PropertyAddress =  ISNULL(r.PropertyAddress, s.PropertyAddress)
from PortfolioProject..Nashville r
JOIN PortfolioProject..Nashville s
	ON r.ParcelID = s.ParcelID
	AND r.[UniqueID ] <> s.[UniqueID ]
Where r.PropertyAddress is NULL




-----------------------------------------------------------------------------------------------

-- Breaking out Address into Individual Columns (Address, City, State)

Select PropertyAddress
from PortfolioProject..Nashville
--Where PropertyAddress is null
--order by ParcelID


SELECT
SUBSTRING( propertyaddress, 1, CHARINDEX(',', PropertyAddress) -1) as Address
, SUBSTRING( propertyaddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress)) as Address
from PortfolioProject..Nashville


ALTER TABLE Nashville
add PropertSplitAddress NVARCHAR(255);

Update Nashville
SET PropertSplitAddress = SUBSTRING( propertyaddress, 1, CHARINDEX(',', PropertyAddress) -1);

ALTER TABLE Nashville
add PropertySplitCity NVARCHAR(255);


Update Nashville
SET PropertySplitCity = SUBSTRING( propertyaddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress))

SELECT *
from PortfolioProject..Nashville





SELECT OwnerAddress
from PortfolioProject..Nashville

Select
PARSENAME(REPLACE(OwnerAddress,',', '.'), 3)
,PARSENAME(REPLACE(OwnerAddress,',', '.'), 2)
,PARSENAME(REPLACE(OwnerAddress,',', '.'), 1)
from PortfolioProject..Nashville


ALTER TABLE Nashville
add OwnerSplitAddress NVARCHAR(255);

Update Nashville
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress,',', '.'), 3);

ALTER TABLE Nashville
add OwnerSplitCity NVARCHAR(255);

Update Nashville
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress,',', '.'), 2);

ALTER TABLE Nashville
add OwnerSplitState  NVARCHAR(255);

Update Nashville
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress,',', '.'), 1);

SELECT *
from PortfolioProject..Nashville



-----------------------------------------------------------------------------------------------

-- Delete Unused Columns

SELECT *
from PortfolioProject..Nashville

ALTER TABLE PortfolioProject..Nashville
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress

ALTER TABLE PortfolioProject..Nashville
DROP COLUMN SaleDate