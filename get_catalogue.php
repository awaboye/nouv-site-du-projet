<?php
header("Content-Type: application/json");
$host = "localhost";
$user = "root";
$password = "";
$dbname = "lama_location";

$conn = new mysqli($host, $user, $password, $dbname);

if ($conn->connect_error) {
    die("Erreur de connexion : " . $conn->connect_error);
}

$sql = "SELECT * FROM vehicules";
$result = $conn->query($sql);

$vehicules = [];
while ($row = $result->fetch_assoc()) {
    $vehicules[] = $row;
}

echo json_encode($vehicules);
$conn->close();
?>
