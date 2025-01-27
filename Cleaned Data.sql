

--- populate property address date

select a.parcelid ,a.propertyaddress ,b.parcelid,b.propertyaddress,ISNULL(a.propertyaddress,b.propertyaddress )
from nashvillehousing as a
join nashvillehousing as b
on a.parcelid = b.parcelid
and a.uniqueid <> b.uniqueid
where a.propertyaddress is null

update a
set propertyaddress =   ISNULL(a.propertyaddress,b.propertyaddress )
from nashvillehousing as a
join nashvillehousing as b
on a.parcelid = b.parcelid
and a.uniqueid <> b.uniqueid
where a.propertyaddress is null


---- Breaking out address into individual columns(Address,City,State)

alter table NashvilleHousing
add propertyspilitcity nvarchar(255)

update NashvilleHousing
set propertyspilitcity = RIGHT(propertyaddress,len(propertyaddress)-CHARINDEX(',',propertyaddress) )


alter table NashvilleHousing
add propertyspilitaddress nvarchar(255)

update NashvilleHousing
set propertyspilitaddress = replace(SUBSTRING(propertyaddress,1,CHARINDEX(',',propertyaddress)),',','')


alter table NashvilleHousing
add ownerspilitcity nvarchar(255)

update NashvilleHousing
set ownerspilitcity = PARSENAME(replace(owneraddress,',','.'),2)


alter table NashvilleHousing
add ownerspilitstate nvarchar(255)

update NashvilleHousing
set ownerspilitstate = PARSENAME(replace(owneraddress,',','.'),1)

alter table NashvilleHousing
add ownerspilitaddress nvarchar(255)

update NashvilleHousing
set ownerspilitaddress = PARSENAME(replace(owneraddress,',','.'),3)

---Change 0 and 1to Yes and No in soldasvacant

alter table NashvilleHousing
add soldasvacant_Yes_No varchar(3)

update NashvilleHousing 
set soldasvacant_Yes_No = case when soldasvacant = 1 then 'Yes'
	                           when soldasvacant = 0 then 'No'
		                       end

alter table NashvilleHousing
drop column soldasvacant


--- Remove Duplicates

with row_num as (select *,
         row_number() over( partition by  parcelid,propertyaddress,saleprice,saledate,legalreference
		                    order by uniqueid) row_nm
from NashvilleHousing 
--order by uniqueid
 )
 delete 
 from row_num 
 where row_nm > 1

 --- Delete Unused Columns 

 Alter table NashvilleHousing
 drop column PropertyAddress,owneraddress,taxdistrict






