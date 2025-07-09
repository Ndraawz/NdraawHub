<?php
$ua = $_SERVER['HTTP_USER_AGENT'];
$path = $_SERVER['REQUEST_URI'];
$filename = ltrim($path, "/");

if (strpos($ua, "Roblox") !== false || strpos($ua, "curl") !== false) {
    if (file_exists($filename)) {
        header("Content-Type: text/plain");
        readfile($filename);
    } else {
        echo "-- Script not found!";
    }
} else {
    echo "-- Access Denied";
}
?>
