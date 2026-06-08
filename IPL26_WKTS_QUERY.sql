-- Business-Oriented SQL Practice Questions (Bowling Dataset)

-- 1.Find the top 10 wicket-takers overall.
select player , team , wkts
from iplwickets26
order by wkts desc
limit 10;

-- 2.Show bowlers with an average below 25
SELECT 
PLAYER , TEAM ,AVE
FROM iplwickets26
WHERE AVE<=25;

-- 3.List bowlers who bowled more than 300 balls and took at least 20 wickets
SELECT 
PLAYER , TEAM , BALLS
FROM IPLWICKETS26
WHERE BALLS >300;

-- 4.Find the best economy rate bowler (minimum Econ)
SELECT PLAYER , TEAM , ECON
FROM IPLWICKETS26
ORDER BY ECON 
LIMIT 1;

-- 5.Show bowlers who took a 4-wicket haul or 5-wicket haul
SELECT PLAYER , TEAM ,WKTS, `4` ,`5` 
FROM IPLWICKETS26
WHERE `4` >0 OR `5` >0;
SELECT * FROM IPLWICKETS26;

-- 6.Calculate total wickets taken by each team.
SELECT 
TEAM , SUM(WKTS) AS TOTAL_WKTS
FROM IPLWICKETS26
GROUP BY TEAM;

-- 7.Find the team with lowest average bowling economy
SELECT 
TEAM , MIN(AVE) AS LOW_BOWL_AVG
FROM IPLWICKETS26
GROUP BY TEAM ;

-- 8.Show the top wicket-taker for each team
SELECT 
TEAM , MAX(WKTS) AS HIGH_WKTS_TAKER
FROM IPLWICKETS26
GROUP BY 1  ;
SELECT Team, Player, Wkts
FROM IPLWICKETS26  C
WHERE Wkts = (
    SELECT MAX(Wkts)
    FROM IPLWICKETS26
    WHERE TEAM = C.TEAM 
    
);
 -- 9.Find the team with most bowlers having 15+ wickets.
SELECT TEAM,COUNT(*) AS TOP_15WKTS
FROM IPLWICKETS26
WHERE WKTS >=15
GROUP BY 1
LIMIT 1 ;

-- 10.Compare average wickets per bowler between teams
SELECT TEAM , AVG(WKTS) AS AVG_WKTS
FROM IPLWICKETS26
GROUP BY 1;

-- 11.List bowlers who played more than 15 matches and took at least 25 wickets
SELECT 
PLAYER , TEAM , MAT , WKTS 
FROM IPLWICKETS26
WHERE MAT>=15 AND WKTS >=25;

-- 12.Find bowlers with highest wickets per match ratio
SELECT 
PLAYER , TEAM , WKTS/MAT AS AVG_WKTS_PER_MAT
FROM IPLWICKETS26
order by 3 DESC 
LIMIT 1 ;

-- 13.Show bowlers who bowled more than 50 overs and maintained Econ < 9.
SELECT 
PLAYER , TEAM , ECON , OVERS 
FROM IPLWICKETS26 
WHERE OVERS>50 AND ECON <9;

-- 14.Identify bowlers who took more wickets than matches played.
SELECT PLAYER,TEAM , WKTS , MAT
FROM IPLWICKETS26
WHERE WKTS >MAT;

-- 15.Find bowlers who achieved best bowling figures (BBI) with 4+ wickets
SELECT PLAYER , TEAM , WKTS , BBI , `4` , `5`
FROM IPLWICKETS26
WHERE `4`>0 OR `5`>0;

-- 16.Rank bowlers by impact score = Wickets × (Overs ÷ Econ)
SELECT PLAYER  ,WKTS*(OVERS/ECON) AS IMPACT 
, RANK() OVER(
order by WKTS*(OVERS/ECON) DESC ) AS RANKING 
FROM IPLWICKETS26;

-- 17.Find the most efficient death bowler (lowest Econ among bowlers with ≥ 200 balls)
SELECT 
PLAYER ,TEAM, WKTS , AVE , BALLS ,ECON
FROM IPLWICKETS26 AS C
WHERE ECON IN ( SELECT MIN(ECON)
FROM IPLWICKETS26 
WHERE BALLS >=200); 
 -- OR 
 SELECT 
 PLAYER , TEAM ,WKTS , AVE , BALLS , ECON
 FROM IPLWICKETS26
 WHERE BALLS >=200
 ORDER BY ECON ASC
 LIMIT 1 ;
 
  -- 18.Show the top 5 teams by total wickets
  SELECT TEAM , SUM(WKTS) AS TOTAL_WKTS
  FROM IPLWICKETS26
  GROUP BY TEAM 
  ORDER BY SUM(WKTS) DESC 
  LIMIT 5;
  
  -- 19.Find the bowler with best strike rate (SR)
SELECT PLAYER , TEAM ,WKTS , SR 
FROM IPLWICKETS26 AS W
WHERE SR IN ( SELECT MIN(SR) FROM IPLWICKETS26 
WHERE WKTS>0 AND BALLS>300
ORDER BY SR 
) LIMIT 1
;

-- 20.Create a view for Purple Cap leaderboard (Player, Team, Wickets, Ave, Econ, SR, 4s, 5s)
CREATE VIEW  PURPLECAP_TABLE
 AS(  SELECT PLAYER , TEAM , WKTS , AVE , ECON, SR ,`4`,`5`
FROM IPLWICKETS26
LIMIT 15);



