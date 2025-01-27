---Sales by year

select sum(saleprice) as total_sales ,year(saledate) as sales_year
from NashvilleHousing

group by year(saledate)
having year(saledate) is not null
order by sales_year

--- sales by city

select propertyspilitcity ,count(propertyspilitcity) as most_demand_city
from NashvilleHousing
group by propertyspilitcity
order by most_demand_city desc

--- sales by landuse

select landuse ,count(landuse) as most_demand_landuse
from NashvilleHousing
group by landuse
order by 2 desc

