<?php

$start = microtime(true);

$host = getenv('MYSQL_HOST');
$dbname = getenv('MYSQL_DATABASE');
$user = getenv('MYSQL_USER');
$password = getenv('MYSQL_PASSWORD');
$dsn = sprintf('mysql:host=%s;dbname=%s', $host, $dbname);

$db = new \PDO($dsn, $user, $password);

$end = microtime(true);

echo 'Took: ' . ($end - $start);
