<?php
/* -------------------------------------------------------------
 * Simple counter page – increments a number stored in MySQL
 * -------------------------------------------------------------
 * Configuration is read from environment variables that are
 * supplied by docker‑compose.
 * ------------------------------------------------------------- */

// ----- 1⃣  Read env vars -------------------------------------------------
$host = getenv('MYSQL_HOST') ?: 'db';
$port = getenv('MYSQL_PORT') ?: 3306;
$db   = getenv('MYSQL_DATABASE') ?: 'counter_db';
$user = getenv('MYSQL_USER') ?: 'counter_user';
$pass = getenv('MYSQL_PASSWORD') ?: 'counter_pass';

// ----- 2⃣  Connect -------------------------------------------------------
$mysqli = new mysqli($host, $user, $pass, $db, $port);
if ($mysqli->connect_error) {
    die("<h1>❌ DB connection failed:</h1><p>{$mysqli->connect_error}</p>");
}

// ----- 3⃣  Increment the counter -----------------------------------------
$mysqli->query("UPDATE counter SET cnt = cnt + 1 WHERE id = 1");

// ----- 4⃣  Fetch the new value -------------------------------------------
$res = $mysqli->query("SELECT cnt FROM counter WHERE id = 1");
$row = $res->fetch_assoc();
$count = $row['cnt'];

// ----- 5⃣  Render HTML ----------------------------------------------------
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>🧮 Simple Counter</title>
    <style>
        body {font-family:Arial,Helvetica,sans-serif; text-align:center; margin-top:5rem}
        .counter {font-size:4rem; margin:2rem}
        a {color:#0066cc}
    </style>
</head>
<body>
    <h1>🧮 Simple Counter Demo</h1>
    <div class="counter"><?php echo $count; ?></div>
    <p>Refresh the page to increase the counter.</p>
    <p>Database host: <code><?php echo $host; ?></code></p>
</body>
</html>
<?php
$mysqli->close();
?>
