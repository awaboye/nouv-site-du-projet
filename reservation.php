<?php
session_start();
$host = "localhost";
$user = "root";
$password = "";
$dbname = "lama_location";

$conn = new mysqli($host, $user, $password, $dbname);

if ($conn->connect_error) {
    die("Échec de connexion : " . $conn->connect_error);
}

// Vérification si l'utilisateur est connecté
if (!isset($_SESSION['user'])) {
    echo "<script>alert('Vous devez être connecté pour effectuer une réservation.'); window.location.href='login.html';</script>";
    exit();
}

// Traitement du formulaire
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $user_id = $_SESSION['user'];
    $vehicule = $_POST['vehicule'];
    $quantite = $_POST['quantite'];
    $date_debut = $_POST['date-debut'];
    $date_fin = $_POST['date-fin'];
    $chauffeur = $_POST['chauffeur'];
    
    // Calcul du nombre de jours
    $days = (strtotime($date_fin) - strtotime($date_debut)) / (60 * 60 * 24);
    if ($days <= 0) {
        echo "<script>alert('La date de fin doit être après la date de début.'); window.location.href='reservation.html';</script>";
        exit();
    }

    // Récupérer le prix du véhicule depuis la base
    $stmt = $conn->prepare("SELECT prix_jour FROM vehicules WHERE marque = ?");
    $stmt->bind_param("s", $vehicule);
    $stmt->execute();
    $result = $stmt->get_result();
    if ($result->num_rows === 0) {
        echo "<script>alert('Véhicule non trouvé.'); window.location.href='reservation.html';</script>";
        exit();
    }
    
    $vehicule_data = $result->fetch_assoc();
    $prix_jour = $vehicule_data["prix_jour"];
    $stmt->close();

    // Calcul du montant total
    $chauffeur_prix = ($chauffeur === "avec") ? 15000 * $days : 0;
    $montant_total = ($prix_jour * $quantite * $days) + $chauffeur_prix;

    // Insérer la réservation en base
    $stmt = $conn->prepare("INSERT INTO reservations (user_id, vehicule, quantite, date_debut, date_fin, chauffeur, montant_total) VALUES (?, ?, ?, ?, ?, ?, ?)");
    $stmt->bind_param("isssssi", $user_id, $vehicule, $quantite, $date_debut, $date_fin, $chauffeur, $montant_total);

    if ($stmt->execute()) {
        echo "<script>alert('Réservation confirmée !'); window.location.href='index.html';</script>";
    } else {
        echo "<script>alert('Erreur lors de la réservation.'); window.location.href='reservation.html';</script>";
    }

    $stmt->close();
}
$conn->close();
?>
