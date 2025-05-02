<?php
session_start();
$host = "localhost";
$user = "root";
$password = "";
$dbname = "lama_location";

$conn = new mysqli($host, $user, $password, $dbname);

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $fullname = trim($_POST['fullname']);
    $email = trim($_POST['email']);
    $password = $_POST['password'];
    $confirm_password = $_POST['confirm_password'];

    if ($password !== $confirm_password) {
        echo "<script>alert('Les mots de passe ne correspondent pas.'); window.location.href='register.html';</script>";
        exit();
    }

    $password_hash = password_hash($password, PASSWORD_DEFAULT);

    $stmt = $conn->prepare("SELECT id FROM users WHERE email = ?");
    $stmt->bind_param("s", $email);
    $stmt->execute();
    $stmt->store_result();

    if ($stmt->num_rows > 0) {
        echo "<script>alert('Cet email est déjà utilisé.'); window.location.href='register.html';</script>";
        exit();
    }
    $stmt->close();

    // Insérer l'utilisateur en base
    $stmt = $conn->prepare("INSERT INTO users (nom, email, password) VALUES (?, ?, ?)");
    $stmt->bind_param("sss", $fullname, $email, $password_hash);

    if ($stmt->execute()) {
        echo "<script>alert('Inscription réussie ! Connectez-vous pour accéder à la plateforme.'); window.location.href='login.html';</script>";
    } else {
        echo "<script>alert('Erreur lors de l'inscription.'); window.location.href='register.html';</script>";
    }

    $stmt->close();
}
$conn->close();
?>
