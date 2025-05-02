<?php
session_start();
$host = "localhost"; 
$user = "root"; 
$password = ""; 
$dbname = "lama_location"; 

$conn = new mysqli($host, $user, $password, $dbname);

// Vérifier la connexion
if ($conn->connect_error) {
    die("Échec de la connexion : " . $conn->connect_error);
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $email = $_POST['email'];
    $password = $_POST['password'];

    // Requête préparée pour éviter les injections SQL
    $stmt = $conn->prepare("SELECT id, email, password FROM users WHERE email = ?");
    $stmt->bind_param("s", $email);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        $user = $result->fetch_assoc();
        
        // Vérifier le mot de passe hashé
        if (password_verify($password, $user['password'])) {
            $_SESSION['user'] = $user['id'];
            header("Location: index.html");
            exit();
        } else {
            echo "<script>alert('Mot de passe incorrect. Veuillez réessayer.');</script>";
        }
    } else {
        echo "<script>alert('Aucun compte trouvé avec cet email. Veuillez réessayer.');</script>";
    }

    $stmt->close();
}
$conn->close();
?>
