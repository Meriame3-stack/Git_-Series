



-- Cleaning Data in SQL Queries

SELECT *
FROM [Portfolio Project 3].[dbo].[Nashville Housing Data for Data Cleaning]

-- Standardize Date Format


SELECT SaleDateConverted, CONVERT(Date, SaleDate)
FROM [Portfolio Project 3].[dbo].[Nashville Housing Data for Data Cleaning]


Update [Portfolio Project 3].[dbo].[Nashville Housing Data for Data Cleaning]
SET SaleDate = CONVERT(Date, SaleDate)


ALTER TABLE [Portfolio Project 3].[dbo].[Nashville Housing Data for Data Cleaning]
ADD SaleDateConveted Date;


   

update  [Portfolio Project 3].[dbo].[Nashville Housing Data for Data Cleaning]
SET SaleDateConverted = CONVERT(DATE, SaleDate);



SELECT SaleDateConverted, CONVERT(Date, SaleDate)
FROM [Portfolio Project 3].[dbo].[Nashville Housing Data for Data Cleaning]

--Populate Property Address Date


SELECT *
FROM [Portfolio Project 3].[dbo].[Nashville Housing Data for Data Cleaning]
-- WHERE PropertyAddress is null
ORDER BY ParcelID


SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM [Portfolio Project 3].[dbo].[Nashville Housing Data for Data Cleaning] a
JOIN [Portfolio Project 3].[dbo].[Nashville Housing Data for Data Cleaning] b
    on a.ParcelID = b.ParcelID
    AND a.[UniqueID] <> b.[UniqueID]
    WHERE a.PropertyAddress is null


    update a
    SET PropertyAddress = ISNULL (a.PropertyAddress,b.PropertyAddress)
    FROM [Portfolio Project 3].[dbo].[Nashville Housing Data for Data Cleaning] a
JOIN [Portfolio Project 3].[dbo].[Nashville Housing Data for Data Cleaning] b
    on a.ParcelID = b.ParcelID
    AND a.[UniqueID] <> b.[UniqueID]
    WHERE a.PropertyAddress is null


    -- Breaking out Address into Individual Columns (Address, City, State)


 SELECT PropertyAddress
FROM [Portfolio Project 3].[dbo].[Nashville Housing Data for Data Cleaning]
-- WHERE PropertyAddress is null
-- ORDER BY ParcelID

SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) AS Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1 , LEN(PropertyAddress)) AS Address


FROM [Portfolio Project 3].[dbo].[Nashville Housing Data for Data Cleaning]




ALTER TABLE [Portfolio Project 3].[dbo].[Nashville Housing Data for Data Cleaning]
ADD PropertySplitAddress Nvarchar(255);

update  [Portfolio Project 3].[dbo].[Nashville Housing Data for Data Cleaning]
SET  PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1)




ALTER TABLE [Portfolio Project 3].[dbo].[Nashville Housing Data for Data Cleaning]
ADD PropertySplitCity  NVarchar(255);

update  [Portfolio Project 3].[dbo].[Nashville Housing Data for Data Cleaning]
SET  PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) 


SELECT *
FROM [Portfolio Project 3].[dbo].[Nashville Housing Data for Data Cleaning]



SELECT OwnerAddress
FROM  [Portfolio Project 3].[dbo].[Nashville Housing Data for Data Cleaning]


SELECT 
    PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3) AS OwnerSplitAddress
    ,PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2) AS OwnerSplitCity
    ,PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1) AS OwnerSplitState
FROM [Portfolio Project 3].[dbo].[Nashville Housing Data for Data Cleaning]


ALTER TABLE [Portfolio Project 3].[dbo].[Nashville Housing Data for Data Cleaning]
ADD OwnerSplitAddress NVarchar(255),
    OwnerSplitCity NVarchar(255),
    OwnerSplitState NVarchar(255);


    UPDATE [Portfolio Project 3].[dbo].[Nashville Housing Data for Data Cleaning]
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3),
    OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2),
    OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1);



    
SELECT *
FROM [Portfolio Project 3].[dbo].[Nashville Housing Data for Data Cleaning]



-- Change Y and N to Yes and No in "Sold as Vacant" Field

SELECT Distinct (SoldAsVacant), Count(SoldASVacant)
FROM [Portfolio Project 3].[dbo].[Nashville Housing Data for Data Cleaning]
GROUP BY SoldAsVacant
ORDER BY SoldAsVacant


SELECT SoldAsVacant
, CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
       WHEN SoldAsVacant = 'N' THEN 'No'
       ELSE SoldAsVacant
       END
FROM [Portfolio Project 3].[dbo].[Nashville Housing Data for Data Cleaning]



UPDATE [Portfolio Project 3].[dbo].[Nashville Housing Data for Data Cleaning]
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
       WHEN SoldAsVacant = 'N' THEN 'No'
       ELSE SoldAsVacant
       END



-- Remove Duplicates

WITH RowNumCTE AS(
SELECT *,
    ROW_NUMBER() OVER (
        PARTITION BY ParcelID,
                     PropertyAddress,
                     SalePrice,
                     SaleDate,
                     LegalReference
        ORDER BY
            UniqueID
    ) row_num
FROM [Portfolio Project 3].[dbo].[Nashville Housing Data for Data Cleaning]
-- ORDER BY ParcelID
)
SELECT *
FROM RowNumCTE
WHERE row_num > 1
ORDER BY PropertyAddress


-- Delete unused Column

SELECT *
FROM [Portfolio Project 3].[dbo].[Nashville Housing Data for Data Cleaning]



ALTER TABLE [Portfolio Project 3].[dbo].[Nashville Housing Data for Data Cleaning]
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress


ALTER TABLE [Portfolio Project 3].[dbo].[Nashville Housing Data for Data Cleaning]
DROP COLUMN SaleDate

















