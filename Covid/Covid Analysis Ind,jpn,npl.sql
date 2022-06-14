CREATE DATABASE covidanalysis;
use covidanalysis;
-- Create table
create TABLE covidanalysis.for (
				iso_code CHAR(10) DEFAULT NULL,
                continent char(30) DEFAULT NULL ,
                location char(30) DEFAULT NULL,
                dated   date ,
                total_cases DEC(20,3) DEFAULT NULL ,
                new_cases DEC(20,3) DEFAULT NULL ,
                new_cases_smoothed DEC(20,3) DEFAULT NULL ,
                total_deaths DEC(20,3) DEFAULT NULL ,
                new_deaths DEC(20,3) DEFAULT NULL ,
                new_deaths_smoothed DEC(20,3) DEFAULT NULL ,
                total_cases_per_million DEC(20,3) DEFAULT NULL ,
                new_cases_per_million DEC(20,3) DEFAULT NULL ,
                new_cases_smoothed_per_milllion DEC(20,3) DEFAULT NULL ,
                total_deaths_per_million DEC(20,3) DEFAULT NULL,
                new_deaths_per_million DEC(20,3) DEFAULT NULL ,
                new_deaths_smoothed_per_million DEC(20,3) DEFAULT NULL ,
                reproduction_rate DEC(20,3) DEFAULT NULL ,
                icu_patients DEC(20,3) DEFAULT NULL ,
                icu_patients_per_million DEC(20,3) DEFAULT NULL ,
                hosp_patients DEC(20,3) DEFAULT NULL ,
                hosp_patients_per_million DEC(20,3) DEFAULT NULL ,
                weekly_icu_admission DEC(20,3) DEFAULT NULL ,
                weekly_icu_admisssion_per_million DEC(20,3) DEFAULT NULL,
                weekly_hosp_admission DEC(20,3) DEFAULT NULL ,
                weekly_hosp_admission_per_million DEC(20,3) DEFAULT NULL ,
                total_tests DEC(20,3) DEFAULT NULL ,
                new_tests DEC(20,3) DEFAULT NULL ,
                total_tests_per_thousand DEC(20,3) DEFAULT NULL ,
                new_tests_per_thousand DEC(20,3) DEFAULT NULL ,
                new_tests_smoothed DEC(20,3) DEFAULT NULL ,
                new_tests_smoothed_per_thousand DEC(20,3) DEFAULT NULL ,
                positive_rate DEC(20,3) DEFAULT NULL ,
                tests_per_case DEC(20,3) DEFAULT NULL ,
                tests_units DEC(20,3) DEFAULT NULL,
                total_vaccination DEC(20,3) DEFAULT NULL,
                people_vaccinated DEC(20,3) DEFAULT NULL ,
                people_fully_vaccinated DEC(20,3) DEFAULT NULL,
                total_boosters DEC(20,3) DEFAULT NULL ,
                new_vaccination DEC(20,3) DEFAULT NULL ,
                new_vaccination_smoothed DEC(20,3) DEFAULT NULL ,
                total_vaccination_per_hundred DEC(20,3) DEFAULT NULL ,
                people_vaccinated_per_hundred DEC(20,3) DEFAULT NULL ,
                people_fully_vaccinated_per_hundred DEC(20,3) DEFAULT NULL ,
                total_boosters_per_hundred DEC(20,3) DEFAULT NULL ,
                new_vaccinations_smoothed_per_million DEC(20,3) DEFAULT NULL ,
                new_people_vaccinated_smoothed DEC(20,3) DEFAULT NULL ,
                new_people_vaccinated_smoothed_per_hundred DEC(20,3) DEFAULT NULL ,
                stringency_index DEC(20,3) DEFAULT NULL ,
                population int(30) DEFAULT NULL ,
                population_density DEC(20,3) DEFAULT NULL ,
                median_age DEC(20,3) DEFAULT NULL ,
                aged_65_older DEC(20,3) DEFAULT NULL ,
                aged_70_older DEC(20,3) DEFAULT NULL , 
                gdp_per_capita DEC(20,3) DEFAULT NULL ,
                extreme_poverty DEC(20,3) DEFAULT NULL ,
                cardiovasc_death_rate DEC(20,3) DEFAULT NULL ,
                diabetes_prevalence DEC(20,3) DEFAULT NULL,
                female_smokers DEC(20,3) DEFAULT NULL ,
                male_smokers DEC(20,3) DEFAULT NULL ,
                handwashing_facilities DEC(20,3) DEFAULT NULL ,
                hospital_beds_per_thousand DEC(20,3) DEFAULT NULL ,
                life_expectancy DEC(20,3) DEFAULT NULL ,
                human_development_index DEC(20,3) DEFAULT NULL ,
                excess_mortality_cumulative_absolute DEC(20,3) DEFAULT NULL ,
                excess_mortality_cumulative DEC(20,3) DEFAULT NULL ,
                excess_mortality DEC(20,3) DEFAULT NULL ,
                excess_mortality_cumulative_per_million DEC(20,3) DEFAULT NULL
                );
    
    -- Alter table 
    
  alter table covidanalysis.for
  modify new_cases_smoothed DEC(20,4) DEFAULT NULL ;
  
  -- Imported all data 
  
load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/owid-covid-data (1).csv"
into table   covidanalysis.for
FIELDS TERMINATED BY ','
ignore 1 rows;              

ALTER TABLE covidanalysis.for  
RENAME TO four;                  

use covidanalysis;
           
    -- selection of data       

SELECT * FROM xfour; 

CREATE TABLE xfour AS 
SELECT date as dated,positive_rate,new_cases,location,icu_patients,hosp_patients,new_tests,stringency_index,population_density,gdp_per_capita,hospital_beds_per_thousand,handwashing_facilities,life_expectancy,human_development_index 
FROM four;

-- currecting data format

select positive_rate from xfour  order by positive_rate desc ;

update xfour
set positive_rate = 0 
where positive_rate = '' ;

alter table xfour
modify positive_rate dec(10,5) DEFAULT null;


-- modified new_cases
select new_cases from xfour  where new_cases = '' order by new_cases desc ;

update xfour
set new_cases = 0 
where new_cases = '' ;
          
alter table xfour
modify new_cases int(20) DEFAULT null;    
          
  
-- modified location 
  
alter table xfour
modify location char(50) DEFAULT null;   
                
                
       
 -- modify icu_patients and hosp_patients, new_tests,stringency index,population_density,gdp_per_capita,hospital_beds_per_thousand,handwashing_facilities
 --  life_expectancy, human_development_index
 
select icu_patients,hosp_patients from xfour  where hosp_patients = '' or icu_patients = ''
order by new_cases desc ;

update xfour
set human_development_index = 0 

where human_development_index = '' ;
          
alter table xfour
modify human_development_index dec(20,5) DEFAULT null   ; 
          
 --  Ectract useful data        
          
select * from xfour where location = 'japan' order by new_cases desc;
    
TABLE xfour
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/cleandataovid.csv'
FIELDS TERMINATED BY ','
optionally enclosed by '"'
escaped by ''
LINES TERMINATED BY '\n';

-- Nepal data
    
select * from four where location = 'nepal' and date between '2022-03-01' and '2022-06-12';

-- Combined data
         
CREATE TABLE join03_06 AS 
SELECT * 
FROM four
where location in  ('nepal','japan','india') and date between '2022-03-01' and '2022-06-12';
    
 -- Export data   
  
TABLE Nepal3_06
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/I03_06.csv'
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'

                
                
                
                
                
                
                
                
                
                
                
                