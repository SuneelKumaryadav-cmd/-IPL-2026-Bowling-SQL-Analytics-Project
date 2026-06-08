# -IPL-2026-Bowling-SQL-Analytics-Project

> A beginner-to-intermediate SQL project analyzing IPL 2026 bowling statistics — covering wicket-takers, economy rates, team bowling strength, and Purple Cap leaderboard queries.

---

## 📌 Project Overview

This project explores bowling data from the **IPL 2026 season** using SQL.  
The dataset contains stats for **100 bowlers** across all **10 franchises**, sourced directly from ESPN Cricinfo.

The queries are organized into 4 categories:

| Category | Queries | Focus |
|---|---|---|
| 🏅 Bowler Performance | Q1 – Q5 | Top wicket-takers, economy, hauls |
| 🏟️ Team Insights | Q6 – Q10 | Team totals, best economy, top per team |
| 📊 Match & Consistency | Q11 – Q15 | Overs bowled, wickets per match, BBI |
| 🧠 Advanced / Business | Q16 – Q20 | Impact score, death bowling, Purple Cap view |

---

## 📂 Files in This Repo

```
IPL2026_SQL_Project/
│
├── iplwickets26.csv          # Raw dataset (100 bowlers, 16 columns)
├── IPL26_WKTS_QUERY.sql      # All 20 SQL queries
├── IPLRUNS.csv               # Batting dataset (151 players)
├── IPL_RUNS_QUERY.sql        # Batting queries
└── README.md                 # You're here
```

---

## 🗄️ Dataset

**Source:** [ESPN Cricinfo — IPL 2026 Bowling Records](https://www.espncricinfo.com/records/tournament/bowling-most-wickets-career/indian-premier-league-2026-17740)

**Table name used:** `IPLWICKETS26`

### Column Reference

| Column | Description |
|---|---|
| `Player` | Player name |
| `Team` | Franchise (GT, RCB, RR, CSK, SRH, KKR, LSG, MI, PBKS, DC) |
| `Span` | Season (2026-2026) |
| `Mat` | Matches played |
| `Inns` | Innings bowled |
| `Balls` | Total balls bowled |
| `Overs` | Total overs bowled |
| `Mdns` | Maiden overs |
| `Runs` | Runs conceded |
| `Wkts` | Wickets taken |
| `BBI` | Best bowling figures in an innings |
| `Ave` | Bowling average (Runs ÷ Wickets) |
| `Econ` | Economy rate (Runs per over) |
| `SR` | Bowling strike rate (Balls per wicket) |
| `4` | Four-wicket hauls |
| `5` | Five-wicket hauls |

---

## 🔍 Queries at a Glance

### 🏅 Bowler Performance

```sql
-- Q1: Top 10 wicket-takers overall
SELECT player, team, wkts FROM iplwickets26
ORDER BY wkts DESC LIMIT 10;

-- Q2: Bowlers with average below 25
SELECT player, team, ave FROM iplwickets26 WHERE ave <= 25;

-- Q3: Bowlers with 300+ balls and 20+ wickets
SELECT player, team, balls FROM iplwickets26 WHERE balls > 300;

-- Q4: Best economy rate bowler
SELECT player, team, econ FROM iplwickets26 ORDER BY econ LIMIT 1;

-- Q5: Bowlers with a 4-wicket or 5-wicket haul
SELECT player, team, wkts, `4`, `5` FROM iplwickets26 WHERE `4` > 0 OR `5` > 0;
```

### 🏟️ Team Insights

```sql
-- Q6: Total wickets taken by each team
SELECT team, SUM(wkts) AS total_wkts FROM iplwickets26 GROUP BY team;

-- Q7: Team with lowest average bowling economy
SELECT team, MIN(ave) AS low_bowl_avg FROM iplwickets26 GROUP BY team;

-- Q8: Top wicket-taker per team (with player name using correlated subquery)
SELECT team, player, wkts FROM iplwickets26 c
WHERE wkts = (SELECT MAX(wkts) FROM iplwickets26 WHERE team = c.team);

-- Q9: Team with most bowlers having 15+ wickets
SELECT team, COUNT(*) AS top_15wkts FROM iplwickets26
WHERE wkts >= 15 GROUP BY team LIMIT 1;

-- Q10: Average wickets per bowler by team
SELECT team, AVG(wkts) AS avg_wkts FROM iplwickets26 GROUP BY team;
```

### 📊 Match & Consistency Analysis

```sql
-- Q11: Bowlers with 15+ matches and 25+ wickets
SELECT player, team, mat, wkts FROM iplwickets26 WHERE mat >= 15 AND wkts >= 25;

-- Q12: Highest wickets-per-match ratio
SELECT player, team, wkts/mat AS avg_wkts_per_mat FROM iplwickets26 ORDER BY 3 DESC LIMIT 1;

-- Q13: Bowlers with 50+ overs and Econ < 9
SELECT player, team, econ, overs FROM iplwickets26 WHERE overs > 50 AND econ < 9;

-- Q14: Bowlers who took more wickets than matches played
SELECT player, team, wkts, mat FROM iplwickets26 WHERE wkts > mat;

-- Q15: Best bowling figures (BBI) with 4+ wickets
SELECT player, team, wkts, bbi, `4`, `5` FROM iplwickets26 WHERE `4` > 0 OR `5` > 0;
```

### 🧠 Advanced / Business Queries

```sql
-- Q16: Impact Score = Wickets × (Overs ÷ Econ)  with RANK window function
SELECT player, wkts * (overs / econ) AS impact,
       RANK() OVER(ORDER BY wkts * (overs / econ) DESC) AS ranking
FROM iplwickets26;

-- Q17: Most efficient death bowler (lowest Econ, min 200 balls)
SELECT player, team, wkts, ave, balls, econ FROM iplwickets26
WHERE balls >= 200 ORDER BY econ ASC LIMIT 1;

-- Q18: Top 5 teams by total wickets
SELECT team, SUM(wkts) AS total_wkts FROM iplwickets26
GROUP BY team ORDER BY SUM(wkts) DESC LIMIT 5;

-- Q19: Bowler with best strike rate (min 300 balls, wickets > 0)
SELECT player, team, wkts, sr FROM iplwickets26 w
WHERE sr IN (SELECT MIN(sr) FROM iplwickets26 WHERE wkts > 0 AND balls > 300) LIMIT 1;

-- Q20: Purple Cap leaderboard view
CREATE VIEW purplecap_table AS (
  SELECT player, team, wkts, ave, econ, sr, `4`, `5`
  FROM iplwickets26 LIMIT 15
);
```

---

## 📈 Key Findings

| Insight | Detail |
|---|---|
| 🥇 Most Wickets | K Rabada (GT) — 29 wickets |
| 💰 Best Economy | B Kumar (RCB) — 7.95 runs/over |
| 🎯 Best Average | B Kumar (RCB) — 17.89 |
| 🏟️ Teams Covered | GT, RCB, RR, CSK, SRH, KKR, LSG, MI, PBKS, DC |
| 📋 Total Bowlers | 100 |

---

## 🛠️ How to Run

1. Import the dataset into your MySQL database:
```sql
CREATE TABLE IPLWICKETS26 (
  Player  VARCHAR(100),
  Team    VARCHAR(10),
  Span    VARCHAR(20),
  Mat     INT,
  Inns    INT,
  Balls   INT,
  Overs   FLOAT,
  Mdns    INT,
  Runs    INT,
  Wkts    INT,
  BBI     VARCHAR(20),
  Ave     FLOAT,
  Econ    FLOAT,
  SR      FLOAT,
  `4`     INT,
  `5`     INT
);

LOAD DATA INFILE 'iplwickets26.csv'
INTO TABLE IPLWICKETS26
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;
```

2. Run any query from `IPL26_WKTS_QUERY.sql`

> ⚠️ **Note:** Columns `4` and `5` are reserved-ish names in MySQL — always wrap them in backticks: `` `4` `` and `` `5` ``

---

## 🧰 Tools Used

- **MySQL** — query execution
- **ESPN Cricinfo** — data source
- **GitHub** — version control

---

## 🔗 Related
This is **Part 2** of the IPL 2026 SQL Analytics project.  
👉 Check out **[Part 1 — Batting Stats](https://github.com/SuneelKumaryadav-cmd/IPL2026_SQL_Project)
**
---

## 👤 Author

**SKY** — CS & IT Student | Aspiring Data Analyst  
📊 Learning SQL • Python • Power BI • Excel

---

## ⭐ If you found this useful, drop a star!
