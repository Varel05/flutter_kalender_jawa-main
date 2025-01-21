<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST');

// Koneksi ke database
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "kalender_jawa";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Koneksi gagal: " . $conn->connect_error);
}

// Ambil data berdasarkan tanggal
if (isset($_GET['tanggal'])) {
    $tanggal = $_GET['tanggal'];
    $sql = "SELECT * FROM kalender WHERE tanggal = '$tanggal'";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        $data = $result->fetch_assoc();
        echo json_encode($data);
    } else {
        echo json_encode(['message' => 'Data tidak ditemukan']);
    }
}

$conn->close();
?>
