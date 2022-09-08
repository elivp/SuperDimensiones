create or replace TABLE RRHH.DM_MAESTROS_COMUNES.DIM_FECHA (
	id_fecha NUMBER(38,0),
	fecha DATE,	
    fecha_fiscal DATE,	
	ano_mes_dia VARCHAR(10),
	ano NUMBER(38,0),	
    ano_fiscal NUMBER(38,0),	
	id_trimestre NUMBER(38,0),
    id_trimestre_fiscal NUMBER(38,0),
	trimestre VARCHAR(3),
    trimestre_fiscal VARCHAR(3),
	trimestre_ano NUMBER(38,0),
    trimestre_fiscal_ano NUMBER(38,0),
	id_temporada NUMBER(38,0),
	temporada VARCHAR(20),
    season VARCHAR(20),
    id_mes NUMBER(38,0),    
	id_mes_fiscal NUMBER(38,0),    
    ano_mes NUMBER(38,0), 
    ano_mes_fiscal NUMBER(38,0),     
	mes VARCHAR(12),
    month VARCHAR(12),
    mes_corto VARCHAR(3),
    month_short VARCHAR(3),
	mes_ano VARCHAR(7),
    month_year VARCHAR(7),		
	semana NUMBER(38,0),
	semana_ano NUMBER(38,0),
	semana_iso NUMBER(38,0),
	semana_ano_iso NUMBER(38,0),
    dia_mes NUMBER(38,0),
	dias_mes NUMBER(38,0),
	dia_ano NUMBER(38,0),
	id_dia_semana NUMBER(38,0),
	dia_semana VARCHAR(12),
    week_day VARCHAR(12),
    dia_semana_corto VARCHAR(3),  
    week_day_short VARCHAR(3),  
    dia_semana_mini VARCHAR(1),
    week_day_mini VARCHAR(1),
    dia_semana_agrupacion VARCHAR(3),
    week_day_group VARCHAR(3),
	id_es_fin_semana NUMBER(38,0),
	es_fin_semana VARCHAR(20),
    week_day_type VARCHAR(20),
    es_ano_actual NUMBER(38,0),
    es_mes_actual NUMBER(38,0),
    es_dia_actual NUMBER(38,0),
    es_final_mes NUMBER(38,0),
    periodo_covid VARCHAR(20),
    edad NUMBER(38,2),
    id_edad_tramo NUMBER(38,0),
    edad_tramo VARCHAR(20),
    edad_corto VARCHAR(5),
    id_edad_10 NUMBER(38,0),
    edad_10  VARCHAR(5),
    id_generacion NUMBER(38,0),
    generacion VARCHAR(20),
    generation VARCHAR(20),
    generacion_anos VARCHAR(20),
    generacion_edades VARCHAR(20),
    id_signo_zodiaco NUMBER(38,0),
    signo_zodiaco VARCHAR(20),
    signo_zodiaco_fechas VARCHAR(20),
    signo_zodiaco_URL VARCHAR(100),
    ID_PERIODO_FACTURACION NUMBER(38,0),
    ES_PERIODO_FACTURACION_ACTUAL NUMBER(38,0),
    ES_JORNADA_VERANO NUMBER(38,0)
);

INSERT INTO RRHH.DM_MAESTROS_COMUNES.DIM_FECHA
           ( id_fecha           
            ,fecha            			
            ,fecha_fiscal            			
			,ano_mes_dia
            ,ano		
            ,ano_fiscal
			,id_trimestre
            ,id_trimestre_fiscal
			,trimestre
            ,trimestre_fiscal
			,trimestre_ano
            ,trimestre_fiscal_ano
            ,id_temporada
            ,temporada
            ,season
			,id_mes
            ,id_mes_fiscal
			,ano_mes
			,ano_mes_fiscal
            ,mes
            ,month
            ,mes_corto
            ,month_short
			,mes_ano
            ,month_year			
			,semana
			,semana_ano
			,semana_iso
			,semana_ano_iso
            ,dia_mes
			,dias_mes
			,dia_ano			
			,id_dia_semana
			,dia_semana
            ,week_day
            ,dia_semana_corto
            ,week_day_short
            ,dia_semana_mini
            ,week_day_mini
            ,dia_semana_agrupacion
            ,week_day_group
			,id_es_fin_semana
			,es_fin_semana
            ,week_day_type
            ,es_ano_actual
            ,es_mes_actual
            ,es_dia_actual
            ,es_final_mes
            ,periodo_covid
            ,edad
            ,id_edad_tramo
            ,edad_tramo
            ,edad_corto
            ,id_edad_10
            ,edad_10
            ,id_generacion
            ,generacion
            ,generation
            ,generacion_anos
            ,generacion_edades
            ,id_signo_zodiaco
            ,signo_zodiaco
            ,signo_zodiaco_fechas
            ,signo_zodiaco_URL
            ,ID_PERIODO_FACTURACION 
            ,ES_PERIODO_FACTURACION_ACTUAL
            ,ES_JORNADA_VERANO 
           )
WITH DATERANGE AS (  
select DATEADD(DAY,(row_number() over (order by seq4()) -1),'1930-01-01') AS STARTDATE
    from table(generator(rowcount => (110 * 365.25)))
)
SELECT
   TO_CHAR(STARTDATE,'YYYYMMDD')                                   AS id_fecha    
  ,CAST(STARTDATE as date)                                         AS fecha
  ,CAST(DATEADD(MONTH, -1, STARTDATE) as date)                     AS fecha_fiscal 
  ,TO_CHAR(STARTDATE,'YYYY-MM-DD')                                 AS ano_mes_dia    
  ,YEAR(STARTDATE)                                                 AS ano
  ,YEAR(DATEADD(MONTH, -1,STARTDATE))                              AS ano_fiscal
  ,QUARTER(STARTDATE)                                              AS id_trimestre
  ,QUARTER(DATEADD(MONTH, -1,STARTDATE))                           AS id_trimestre_fiscal
  ,'T '||QUARTER(STARTDATE)                                        AS trimestre
  ,'T '||QUARTER(DATEADD(MONTH, -1,STARTDATE))                     AS trimestre_fiscal
  ,YEAR(STARTDATE)||QUARTER(STARTDATE)                             AS trimestre_ano
  ,YEAR(DATEADD(MONTH, -1,STARTDATE))||
   QUARTER(DATEADD(MONTH, -1,STARTDATE))                           AS trimestre_fiscal_ano
  ,DECODE(MONTH(STARTDATE),     
      '01','1'
     ,'02','1'
     ,'03','2'
     ,'04','2'
     ,'05','2'
     ,'06','3'
     ,'07','3'
     ,'08','3'
     ,'09','4'
     ,'10','4'
     ,'11','4'
     ,'12','1')                                                    AS id_temporada
     --REVISAR ESTA TABLA DONDE TENEMOS LAS TEMPORADAS COMERCIALES en función de la fecha --> OPCORPORATIVO.Maestros.temporada_comercial
  ,DECODE(MONTH(STARTDATE),     
      '01','Invierno'
     ,'02','Invierno'
     ,'03','Primavera'
     ,'04','Primavera'
     ,'05','Primavera'
     ,'06','Verano'
     ,'07','Verano'
     ,'08','Verano'
     ,'09','Otoño'
     ,'10','Otoño'
     ,'11','Otoño'
     ,'12','Invierno')                                             AS temporada
  ,DECODE(MONTH(STARTDATE),     
      '01','Winter'
     ,'02','Winter'
     ,'03','Spring'
     ,'04','Spring'
     ,'05','Spring'
     ,'06','Summer'
     ,'07','Summer'
     ,'08','Summer'
     ,'09','Autumn'
     ,'10','Autumn'
     ,'11','Autumn'
     ,'12','Winter')                                              AS season   
  ,MONTH(STARTDATE)                                               AS id_mes
  ,CASE MONTH(STARTDATE)   
			WHEN 1 THEN 12
			ELSE  MONTH(STARTDATE)-1
   END                                                            AS id_mes_fiscal
  ,YEAR(STARTDATE)||LPAD(MONTH(STARTDATE),2,'0')                  AS ano_mes
  ,YEAR(DATEADD(MONTH, -1,STARTDATE))
  ||LPAD(CASE MONTH(STARTDATE)   
            WHEN 1 THEN 12
            ELSE  MONTH(STARTDATE)-1
         END ,2,'0')                                              AS ano_mes_fiscal
  ,DECODE(MONTH(STARTDATE),     
      '01','Enero'
     ,'02','Febrero'
     ,'03','Marzo'
     ,'04','Abril'
     ,'05','Mayo'
     ,'06','Junio'
     ,'07','Julio'
     ,'08','Agosto'
     ,'09','Septiembre'
     ,'10','Octubre'
     ,'11','Noviembre'
     ,'12','Diciembre')                                            AS mes
   ,DECODE(MONTH(STARTDATE),     
      '01','January'
     ,'02','February'
     ,'03','March'
     ,'04','April'
     ,'05','May'
     ,'06','June'
     ,'07','July'
     ,'08','August'
     ,'09','September'
     ,'10','October'
     ,'11','November'
     ,'12','December')                                            AS month
   ,DECODE(MONTH(STARTDATE),     
      '01','Ene'
     ,'02','Feb'
     ,'03','Mar'
     ,'04','Abr'
     ,'05','May'
     ,'06','Jun'
     ,'07','Jul'
     ,'08','Ago'
     ,'09','Sep'
     ,'10','Oct'
     ,'11','Nov'
     ,'12','Dic')                                                  AS mes_corto
  ,DECODE(MONTH(STARTDATE),     
      '01','Jan'
     ,'02','Feb'
     ,'03','Mar'
     ,'04','Apr'
     ,'05','May'
     ,'06','Jun'
     ,'07','Jul'
     ,'08','Aug'
     ,'09','Sep'
     ,'10','Oct'
     ,'11','Nov'
     ,'12','Dec')                                                  AS month_short        
  ,CONCAT(DECODE(MONTH(STARTDATE),     
      '01','Ene'' '
     ,'02','Feb'' '
     ,'03','Mar'' '
     ,'04','Abr'' '
     ,'05','May'' '
     ,'06','Jun'' '
     ,'07','Jul'' '
     ,'08','Ago'' '
     ,'09','Sep'' '
     ,'10','Oct'' '
     ,'11','Nov'' ' 
     ,'12','Dic'' '), TO_CHAR(STARTDATE,'YY'))                     AS mes_ano
    ,CONCAT(DECODE(MONTH(STARTDATE),     
      '01','Jan'' '
     ,'02','Feb'' '
     ,'03','Mar'' '
     ,'04','Apr'' '
     ,'05','May'' '
     ,'06','Jun'' '
     ,'07','Jul'' '
     ,'08','Aug'' '
     ,'09','Sep'' '
     ,'10','Oct'' '
     ,'11','Nov'' ' 
     ,'12','Dec'' '), TO_CHAR(STARTDATE,'YY'))                     AS month_year 
  ,WEEKOFYEAR(STARTDATE)                                           AS semana
  ,YEAR(STARTDATE)||LPAD(WEEKOFYEAR(STARTDATE),2,'0')              AS semana_ano
  ,WEEKISO(STARTDATE)                                              AS semana_iso
  ,YEAR(STARTDATE)||LPAD(WEEKISO(STARTDATE),2,'0')                 AS semana_ano_iso  
  ,DAYOFMONTH(STARTDATE)                                           AS dia_mes
  ,DAYOFMONTH(LAST_DAY(STARTDATE,'month'))                         AS dias_mes
  ,DAYOFYEAR(STARTDATE)                                            AS dia_ano
  ,CASE WHEN DAYOFWEEK(STARTDATE) = 0 THEN 7
        ELSE DAYOFWEEK(STARTDATE) 
   END                                                             AS id_dia_semana
  ,DECODE(DAYNAME(STARTDATE),     
      'Mon','Lunes'
     ,'Tue','Martes'
     ,'Wed','Miércoles'
     ,'Thu','Jueves'
     ,'Fri','Viernes'
     ,'Sat','Sábado'
     ,'Sun','Domingo')                                             AS dia_semana
  ,DECODE(DAYNAME(STARTDATE),           
      'Mon','Monday'
     ,'Tue','Tuesday'
     ,'Wed','Wednesday'
     ,'Thu','Thursday'
     ,'Fri','Friday'
     ,'Sat','Saturday'
     ,'Sun','Sunday')                                             AS week_day   
  ,DECODE(DAYNAME(STARTDATE),     
      'Mon','Lun'
     ,'Tue','Mar'
     ,'Wed','Mie'
     ,'Thu','Jue'
     ,'Fri','Vie'
     ,'Sat','Sab'
     ,'Sun','Dom')                                                  AS dia_semana_corto  
   ,DAYNAME(STARTDATE)                                              AS week_day_short  
   ,DECODE(DAYNAME(STARTDATE),     
      'Mon','L'
     ,'Tue','M'
     ,'Wed','X'
     ,'Thu','J'
     ,'Fri','V'
     ,'Sat','S'
     ,'Sun','D')                                                   AS dia_semana_mini 
   ,DECODE(DAYNAME(STARTDATE),     
      'Mon','M'
     ,'Tue','T'
     ,'Wed','W'
     ,'Thu','R'
     ,'Fri','F'
     ,'Sat','S'
     ,'Sun','U')                                                   AS week_day_mini    
   ,DECODE(DAYNAME(STARTDATE),     
      'Mon','L-V'
     ,'Tue','L-V'
     ,'Wed','L-V'
     ,'Thu','L-V'
     ,'Fri','L-V'
     ,'Sat','S-D'
     ,'Sun','S-D')                                                   AS dia_semana_agrupacion  
    ,DECODE(DAYNAME(STARTDATE),     
      'Mon','M-F'
     ,'Tue','M-F'
     ,'Wed','M-F'
     ,'Thu','M-F'
     ,'Fri','M-F'
     ,'Sat','S-U'
     ,'Sun','S-U')                                                   AS week_day_group           
  ,IFF(DAYOFWEEK(STARTDATE) between 1 and 5,1,0)                   AS id_es_fin_semana
  ,IFF(DAYOFWEEK(STARTDATE) between 1 and 5,'Entre Semana','Fin Semana')   AS es_fin_semana
  ,IFF(DAYOFWEEK(STARTDATE) between 1 and 5,'Weekday','Weekend')   AS week_day_type
  ,IFF(YEAR(GETDATE()) = YEAR(STARTDATE), 1, 0)                     AS es_ano_actual
  ,IFF((YEAR(GETDATE()) *100 + MONTH(GETDATE())) = (YEAR(STARTDATE) *100 + MONTH(STARTDATE)), 1, 0)                     AS es_mes_actual
  ,IFF(CAST(GETDATE() as date) = CAST(STARTDATE as date), 1, 0)                    AS es_dia_actual  
  ,IFF(CAST(STARTDATE as date) = CAST(last_day(STARTDATE) as date), 1, 0)          AS es_final_mes
  ,CASE WHEN STARTDATE<'2020-01-01' then 'No' 
        ELSE CASE WHEN STARTDATE>='2020-01-01' AND STARTDATE<='2020-03-15' THEN 'PreCovid' 
                    ELSE CASE WHEN STARTDATE > CAST(GETDATE() as date) THEN '?'  
                            ELSE 'Covid'
                         END	
             END 
    END as periodo_covid
    ,CAST(CASE 
          WHEN COALESCE(DATEDIFF(MONTH, STARTDATE, GETDATE())/12,-1)>0 AND COALESCE(DATEDIFF(MONTH, STARTDATE, GETDATE())/12,-1)<100 THEN COALESCE(DATEDIFF(MONTH, STARTDATE, GETDATE())/12,-1)
          ELSE                -1
      END AS DECIMAL(38,2))                                                       AS edad
    ,CASE 
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<5   THEN 1
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<10  THEN 2
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<15  THEN 3
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<20  THEN 4
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<25  THEN 5
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<30  THEN 6
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<35  THEN 7
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<40  THEN 8
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<45  THEN 9
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<50  THEN 10
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<55  THEN 11
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<60  THEN 12
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<65  THEN 13
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<70  THEN 14
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<75  THEN 15
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<80  THEN 16
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<85  THEN 17
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<90  THEN 18
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<95  THEN 19
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<100  THEN 20
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12>=100 THEN 21
          ELSE                -1
      END                                                                       as id_edad_tramo
    ,CASE 
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<5    THEN 'Menor de 5 Años'
		  WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<10   THEN 'De 05 a 09 Años'
		  WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<15   THEN 'De 10 a 14 Años'
		  WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<20   THEN 'De 15 a 19 Años'
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<25   THEN 'De 20 a 24 Años'
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<30   THEN 'De 25 a 29 Años'
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<35   THEN 'De 30 a 34 Años'
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<40   THEN 'De 35 a 39 Años'
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<45   THEN 'De 40 a 44 Años'
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<50   THEN 'De 45 a 49 Años'
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<55   THEN 'De 50 a 54 Años'
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<60   THEN 'De 55 a 59 Años'
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<65   THEN 'De 60 a 64 Años'
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<70   THEN 'De 65 a 70 Años'
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<75   THEN 'De 70 a 74 Años'
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<80   THEN 'De 75 a 79 Años'
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<85   THEN 'De 80 a 84 Años'
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<90   THEN 'De 85 a 89 Años'
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<95   THEN 'De 90 a 94 Años'
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<100  THEN 'De 95 a 99 Años'
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12>=100 THEN 'Mayor de 100 Años'
          ELSE                'No Informado'
       END                                                 AS edad_tramo
    ,CASE 
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<5 THEN '<5'
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<10 THEN '05-09'
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<15 THEN '10-14'
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<20 THEN '15-19'
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<25 THEN '20-24'
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<30 THEN '25-29'
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<35 THEN '30-34'
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<40 THEN '35-39'
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<45 THEN '40-44'
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<50 THEN '45-49'
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<55 THEN '50-54'
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<60 THEN '55-59'
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<65 THEN '60-64'
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<70 THEN '65-69'
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<75 THEN '70-74'
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<80 THEN '75-79'
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<85 THEN '80-84'
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<90 THEN '85-89'
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<95 THEN '90-94'
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<100 THEN '95-99'
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12>=100 THEN '> 100'
          ELSE                'No Informado'
      END 												   AS edad_corto
    ,CASE 
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<10 THEN 0
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<20 THEN 10
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<30 THEN 20
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<40 THEN 30
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<50 THEN 40
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<60 THEN 50
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<70 THEN 60
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<80 THEN 70
		  WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12>=80 THEN 80
          ELSE                99
      END 												   AS id_edad_10
    ,CASE 
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<10 THEN '00-09'
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<20 THEN '10-19'
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<30 THEN '20-29'
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<40 THEN '30-39'
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<50 THEN '40-49'
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<60 THEN '50-59'
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<70 THEN '60-69'
          WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12<80 THEN '70-79'
		  WHEN DATEDIFF(MONTH, STARTDATE, GETDATE())/12>=80 THEN '80+'
          ELSE                'No Informado'
      END 												   AS edad_10
    ,CASE 
          WHEN YEAR(STARTDATE) < 1949 THEN 1
          WHEN YEAR(STARTDATE) < 1969 THEN 2
          WHEN YEAR(STARTDATE) < 1981 THEN 3
          WHEN YEAR(STARTDATE) < 1994 THEN 4
          WHEN YEAR(STARTDATE) < 2011 THEN 5
          WHEN YEAR(STARTDATE) >= 2011 THEN 6
          ELSE                -1
      END AS id_generacion
    ,CASE 
          WHEN YEAR(STARTDATE) < 1949 THEN 'Silent Generation'
          WHEN YEAR(STARTDATE) < 1969 THEN 'Baby Boom'
          WHEN YEAR(STARTDATE) < 1981 THEN 'Generación X'
          WHEN YEAR(STARTDATE) < 1994 THEN 'Millennials'
          WHEN YEAR(STARTDATE) < 2011 THEN 'Generación Z'
          WHEN YEAR(STARTDATE) >= 2011 THEN 'Generación T'
          ELSE                'No Informado'
       END AS generacion
    ,CASE 
          WHEN YEAR(STARTDATE) < 1949 THEN 'Silent Generation'
          WHEN YEAR(STARTDATE) < 1969 THEN 'Baby Boom'
          WHEN YEAR(STARTDATE) < 1981 THEN 'Generación X'
          WHEN YEAR(STARTDATE) < 1994 THEN 'Millennials'
          WHEN YEAR(STARTDATE) < 2011 THEN 'Generación Z'
          WHEN YEAR(STARTDATE) >= 2011 THEN 'Generación T'
          ELSE                'Unknown'
       END AS generation   
    ,CASE 
          WHEN YEAR(STARTDATE) < 1949 THEN '1930-1948'
          WHEN YEAR(STARTDATE) < 1969 THEN '1949-1968'
          WHEN YEAR(STARTDATE) < 1981 THEN '1969-1980'
          WHEN YEAR(STARTDATE) < 1994 THEN '1981-1993'
          WHEN YEAR(STARTDATE) < 2011 THEN '1994-2010'
          WHEN YEAR(STARTDATE) >= 2011 THEN '2011-202*'
          ELSE                'No Informado'
       END AS generacion_anos
    ,CASE 
          WHEN YEAR(STARTDATE) < 1949 THEN cast(YEAR(getdate()) - 1948 as varchar) || '-' || cast(YEAR(getdate()) - 1930 as varchar)
          WHEN YEAR(STARTDATE) < 1969 THEN cast(YEAR(getdate()) - 1968 as varchar) || '-' || cast(YEAR(getdate()) - 1949 as varchar)
          WHEN YEAR(STARTDATE) < 1981 THEN cast(YEAR(getdate()) - 1980 as varchar) || '-' || cast(YEAR(getdate()) - 1969 as varchar)
          WHEN YEAR(STARTDATE) < 1994 THEN cast(YEAR(getdate()) - 1993 as varchar) || '-' || cast(YEAR(getdate()) - 1981 as varchar)
		  WHEN YEAR(STARTDATE) < 2011 THEN cast(YEAR(getdate()) - 2010 as varchar) || '-' || cast(YEAR(getdate()) - 1994 as varchar)
          WHEN YEAR(STARTDATE) >= 2011 THEN '00-' || cast(YEAR(getdate()) - 2010 as varchar)
          ELSE                'No Informado'
       END AS generacion_edades
    ,CASE   WHEN MONTH(STARTDATE)*100 + DAYOFMONTH(STARTDATE) <= 120  then 10 --Capricornio
            WHEN MONTH(STARTDATE)*100 + DAYOFMONTH(STARTDATE) <= 219  then 11 --Acuario    
            WHEN MONTH(STARTDATE)*100 + DAYOFMONTH(STARTDATE) <= 320  then 12 --Piscis     
            WHEN MONTH(STARTDATE)*100 + DAYOFMONTH(STARTDATE) <= 420  then 1  --Aries      
            WHEN MONTH(STARTDATE)*100 + DAYOFMONTH(STARTDATE) <= 520  then 2  --Tauro      
            WHEN MONTH(STARTDATE)*100 + DAYOFMONTH(STARTDATE) <= 621  then 3  --Géminis    
            WHEN MONTH(STARTDATE)*100 + DAYOFMONTH(STARTDATE) <= 721  then 4  --Cáncer     
            WHEN MONTH(STARTDATE)*100 + DAYOFMONTH(STARTDATE) <= 823  then 5  --Leo        
            WHEN MONTH(STARTDATE)*100 + DAYOFMONTH(STARTDATE) <= 923  then 6  --Virgo      
            WHEN MONTH(STARTDATE)*100 + DAYOFMONTH(STARTDATE) <= 1022 then 7  --Libra      
            WHEN MONTH(STARTDATE)*100 + DAYOFMONTH(STARTDATE) <= 1122 then 8  --Escorpio   
            WHEN MONTH(STARTDATE)*100 + DAYOFMONTH(STARTDATE) <= 1221 then 9  --Sagitario  
            WHEN MONTH(STARTDATE)*100 + DAYOFMONTH(STARTDATE) > 1221  then 10 --Capricornio
            ELSE -1        
    END as id_signo_zodiaco
    ,CASE   WHEN MONTH(STARTDATE)*100 + DAYOFMONTH(STARTDATE) <= 120  then 'Capricornio' 
            WHEN MONTH(STARTDATE)*100 + DAYOFMONTH(STARTDATE) <= 219  then 'Acuario'     
            WHEN MONTH(STARTDATE)*100 + DAYOFMONTH(STARTDATE) <= 320  then 'Piscis'      
            WHEN MONTH(STARTDATE)*100 + DAYOFMONTH(STARTDATE) <= 420  then 'Aries'       
            WHEN MONTH(STARTDATE)*100 + DAYOFMONTH(STARTDATE) <= 520  then 'Tauro'       
            WHEN MONTH(STARTDATE)*100 + DAYOFMONTH(STARTDATE) <= 621  then 'Géminis'     
            WHEN MONTH(STARTDATE)*100 + DAYOFMONTH(STARTDATE) <= 721  then 'Cáncer'      
            WHEN MONTH(STARTDATE)*100 + DAYOFMONTH(STARTDATE) <= 823  then 'Leo'         
            WHEN MONTH(STARTDATE)*100 + DAYOFMONTH(STARTDATE) <= 923  then 'Virgo'       
            WHEN MONTH(STARTDATE)*100 + DAYOFMONTH(STARTDATE) <= 1022 then 'Libra'       
            WHEN MONTH(STARTDATE)*100 + DAYOFMONTH(STARTDATE) <= 1122 then 'Escorpio'    
            WHEN MONTH(STARTDATE)*100 + DAYOFMONTH(STARTDATE) <= 1221 then 'Sagitario'   
            WHEN MONTH(STARTDATE)*100 + DAYOFMONTH(STARTDATE) > 1221  then 'Capricornio' 
            ELSE 'No Informado'        
    END as signo_zodiaco 
    ,CASE   WHEN MONTH(STARTDATE)*100 + DAYOFMONTH(STARTDATE) <= 120  then '22 Dic - 20 Ene'
            WHEN MONTH(STARTDATE)*100 + DAYOFMONTH(STARTDATE) <= 219  then '21 Ene - 19 Feb'
            WHEN MONTH(STARTDATE)*100 + DAYOFMONTH(STARTDATE) <= 320  then '20 Feb - 20 Mar'
            WHEN MONTH(STARTDATE)*100 + DAYOFMONTH(STARTDATE) <= 420  then '21 Mar - 20 Abr'
            WHEN MONTH(STARTDATE)*100 + DAYOFMONTH(STARTDATE) <= 520  then '21 Abr - 20 May'
            WHEN MONTH(STARTDATE)*100 + DAYOFMONTH(STARTDATE) <= 621  then '21 May - 21 Jun'
            WHEN MONTH(STARTDATE)*100 + DAYOFMONTH(STARTDATE) <= 721  then '22 Jun - 21 Jul'
            WHEN MONTH(STARTDATE)*100 + DAYOFMONTH(STARTDATE) <= 823  then '22 Jul - 23 Ago'
            WHEN MONTH(STARTDATE)*100 + DAYOFMONTH(STARTDATE) <= 923  then '24 Ago - 23 Sep'
            WHEN MONTH(STARTDATE)*100 + DAYOFMONTH(STARTDATE) <= 1022 then '24 Sep - 22 Oct'
            WHEN MONTH(STARTDATE)*100 + DAYOFMONTH(STARTDATE) <= 1122 then '23 Oct - 22 Nov'
            WHEN MONTH(STARTDATE)*100 + DAYOFMONTH(STARTDATE) <= 1221 then '23 Nov - 21 Dic'
            WHEN MONTH(STARTDATE)*100 + DAYOFMONTH(STARTDATE) > 1221  then '22 Dic - 20 Ene'
            ELSE '-1'        
    END as signo_zodiaco_fechas
   ,CASE    WHEN MONTH(STARTDATE)*100 + DAYOFMONTH(STARTDATE) <= 120  then 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/76/Capricorn.svg/40px-Capricorn.svg.png'
            WHEN MONTH(STARTDATE)*100 + DAYOFMONTH(STARTDATE) <= 219  then 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/24/Aquarius.svg/40px-Aquarius.svg.png'
            WHEN MONTH(STARTDATE)*100 + DAYOFMONTH(STARTDATE) <= 320  then 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/95/Pisces.svg/40px-Pisces.svg.png'
            WHEN MONTH(STARTDATE)*100 + DAYOFMONTH(STARTDATE) <= 420  then 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/Aries.svg/40px-Aries.svg.png'
            WHEN MONTH(STARTDATE)*100 + DAYOFMONTH(STARTDATE) <= 520  then 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Taurus.svg/40px-Taurus.svg.png'
            WHEN MONTH(STARTDATE)*100 + DAYOFMONTH(STARTDATE) <= 621  then 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/15/Gemini.svg/40px-Gemini.svg.png'
            WHEN MONTH(STARTDATE)*100 + DAYOFMONTH(STARTDATE) <= 721  then 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/29/Cancer.svg/40px-Cancer.svg.png'
            WHEN MONTH(STARTDATE)*100 + DAYOFMONTH(STARTDATE) <= 823  then 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/99/Leo.svg/40px-Leo.svg.png'
            WHEN MONTH(STARTDATE)*100 + DAYOFMONTH(STARTDATE) <= 923  then 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0c/Virgo.svg/40px-Virgo.svg.png'
            WHEN MONTH(STARTDATE)*100 + DAYOFMONTH(STARTDATE) <= 1022 then 'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f7/Libra.svg/40px-Libra.svg.png' 
            WHEN MONTH(STARTDATE)*100 + DAYOFMONTH(STARTDATE) <= 1122 then 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ea/Scorpio.svg/40px-Scorpio.svg.png'
            WHEN MONTH(STARTDATE)*100 + DAYOFMONTH(STARTDATE) <= 1221 then 'https://commons.wikimedia.org/wiki/File:Sagittarius.svg'
            WHEN MONTH(STARTDATE)*100 + DAYOFMONTH(STARTDATE) > 1221  then 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/76/Capricorn.svg/40px-Capricorn.svg.png'
            ELSE 'No Informado'        
    END as signo_zodiaco_URL
   ,CASE WHEN DAY(STARTDATE) <= 25 THEN YEAR(STARTDATE)||LPAD(MONTH(STARTDATE),2,'0')
         ELSE YEAR(DATEADD(MONTH, 1,STARTDATE))||LPAD(MONTH(DATEADD(MONTH, 1,STARTDATE)),2,'0')
    END AS ID_PERIODO_FACTURACION
   ,CASE WHEN YEAR(getdate())||LPAD(MONTH(getdate()), 2, 0) = ID_PERIODO_FACTURACION THEN 1 
         ELSE 0 
    END AS ES_PERIODO_FACTURACION_ACTUAL
    ,CASE WHEN MONTH(STARTDATE) IN (7,8) THEN 1 
         ELSE 0 
    END AS ES_JORNADA_VERANO   
    FROM DATERANGE DG; 
