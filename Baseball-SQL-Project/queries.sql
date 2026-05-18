-- VIEW ALL PLAYERS
SELECT *
FROM Players;

-- VIEW ALL GAMES
SELECT *
FROM Games;

-- VIEW ALL PLAYER STATS
SELECT *
FROM Player_Stats;

-- PLAYERS BATTING OVER .300
SELECT first_name, last_name, batting_average
FROM Players
WHERE batting_average > .300;

-- SORT PLAYERS BY BATTING AVERAGE
SELECT first_name, last_name, batting_average
FROM Players
ORDER BY batting_average DESC;

-- SHOW ALL WINS
SELECT opponent, game_date, runs_scored, result
FROM Games
WHERE result = 'Win';

-- SHOW ALL LOSSES
SELECT opponent, game_date, runs_scored, result
FROM Games
WHERE result = 'Loss';

-- HIGHEST SCORING GAMES
SELECT opponent, runs_scored
FROM Games
ORDER BY runs_scored DESC;

-- GAMES WITH 10+ RUNS SCORED
SELECT opponent, game_date, runs_scored
FROM Games
WHERE runs_scored >= 10;

-- COUNT TOTAL WINS
SELECT COUNT(*) AS total_wins
FROM Games
WHERE result = 'Win';

-- COUNT TOTAL LOSSES
SELECT COUNT(*) AS total_losses
FROM Games
WHERE result = 'Loss';

-- AVERAGE RUNS SCORED
SELECT ROUND(AVG(runs_scored), 2) AS average_runs_scored
FROM Games;

-- AVERAGE RUNS ALLOWED
SELECT ROUND(AVG(runs_allowed), 2) AS average_runs_allowed
FROM Games;

-- TOTAL RUNS SCORED
SELECT SUM(runs_scored) AS total_runs_scored
FROM Games;

-- TOTAL RUNS ALLOWED
SELECT SUM(runs_allowed) AS total_runs_allowed
FROM Games;

-- RUN DIFFERENTIAL BY GAME
SELECT 
    opponent,
    runs_scored,
    runs_allowed,
    runs_scored - runs_allowed AS run_differential,
    result
FROM Games
ORDER BY run_differential DESC;

-- BEST OFFENSIVE PERFORMANCES
SELECT 
    opponent,
    runs_scored
FROM Games
ORDER BY runs_scored DESC
LIMIT 5;

-- HOME GAMES ONLY
SELECT 
    opponent,
    game_date,
    runs_scored,
    runs_allowed,
    result
FROM Games
WHERE location = 'Columbus, MS';

-- AWAY GAMES ONLY
SELECT 
    opponent,
    game_date,
    runs_scored,
    runs_allowed,
    result
FROM Games
WHERE location != 'Columbus, MS';

-- CONFERENCE GAMES ONLY
SELECT *
FROM Games
WHERE conference_game = 'Yes';

-- NON-CONFERENCE GAMES ONLY
SELECT *
FROM Games
WHERE conference_game = 'No';

-- CONFERENCE RECORD
SELECT 
    result,
    COUNT(*) AS total_games
FROM Games
WHERE conference_game = 'Yes'
GROUP BY result;

-- NON-CONFERENCE RECORD
SELECT 
    result,
    COUNT(*) AS total_games
FROM Games
WHERE conference_game = 'No'
GROUP BY result;

-- AVERAGE RUNS BY RESULT
SELECT 
    result,
    ROUND(AVG(runs_scored), 2) AS avg_runs_scored
FROM Games
GROUP BY result;

-- BEST OFFENSIVE LOCATIONS
SELECT 
    location,
    ROUND(AVG(runs_scored), 2) AS avg_runs
FROM Games
GROUP BY location
ORDER BY avg_runs DESC;

-- PLAYER PERFORMANCE REPORT
SELECT
    Players.first_name,
    Players.last_name,
    Games.opponent,
    Games.game_date,
    Player_Stats.hits,
    Player_Stats.RBIs
FROM Player_Stats
JOIN Players
ON Player_Stats.player_id = Players.player_id
JOIN Games
ON Player_Stats.game_id = Games.game_id;

-- PLAYER PERFORMANCE SORTED BY HITS
SELECT
    Players.first_name,
    Players.last_name,
    Games.opponent,
    Player_Stats.hits,
    Player_Stats.RBIs
FROM Player_Stats
JOIN Players
ON Player_Stats.player_id = Players.player_id
JOIN Games
ON Player_Stats.game_id = Games.game_id
ORDER BY Player_Stats.hits DESC;

-- TOTAL HITS BY PLAYER
SELECT
    Players.first_name,
    Players.last_name,
    SUM(Player_Stats.hits) AS total_hits
FROM Player_Stats
JOIN Players
ON Player_Stats.player_id = Players.player_id
GROUP BY Players.player_id
ORDER BY total_hits DESC;

-- TOTAL RBIs BY PLAYER
SELECT
    Players.first_name,
    Players.last_name,
    SUM(Player_Stats.RBIs) AS total_RBIs
FROM Player_Stats
JOIN Players
ON Player_Stats.player_id = Players.player_id
GROUP BY Players.player_id
ORDER BY total_RBIs DESC;

-- TOTAL STRIKEOUTS BY PLAYER
SELECT
    Players.first_name,
    Players.last_name,
    SUM(Player_Stats.strikeouts) AS total_strikeouts
FROM Player_Stats
JOIN Players
ON Player_Stats.player_id = Players.player_id
GROUP BY Players.player_id
ORDER BY total_strikeouts DESC;

-- PLAYER STATS FOR A SPECIFIC OPPONENT
SELECT
    Players.first_name,
    Players.last_name,
    Games.opponent,
    Player_Stats.hits,
    Player_Stats.RBIs
FROM Player_Stats
JOIN Players
ON Player_Stats.player_id = Players.player_id
JOIN Games
ON Player_Stats.game_id = Games.game_id
WHERE Games.opponent = 'Blackburn College';

-- GAMES SORTED BY DATE
SELECT *
FROM Games
ORDER BY game_date ASC;

-- CLOSE GAMES (3 RUN DIFFERENCE OR LESS)
SELECT
    opponent,
    runs_scored,
    runs_allowed,
    ABS(runs_scored - runs_allowed) AS run_difference
FROM Games
WHERE ABS(runs_scored - runs_allowed) <= 3;

-- BIGGEST WIN
SELECT
    opponent,
    runs_scored,
    runs_allowed,
    runs_scored - runs_allowed AS run_differential
FROM Games
ORDER BY run_differential DESC
LIMIT 1;

-- BIGGEST LOSS
SELECT
    opponent,
    runs_scored,
    runs_allowed,
    runs_scored - runs_allowed AS run_differential
FROM Games
ORDER BY run_differential ASC
LIMIT 1;
