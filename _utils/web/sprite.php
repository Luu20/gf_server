<?php
include('config.php');

$message = '';

$list = array('fuck');

if (isset($_POST['submit'])) {
    $playername = $_POST['playername'];
    $spritename = $_POST['spritename'];
    if (preg_match('/\s/', $newname)) {
        $message = "Invalid SpriteName: SHULD NOT CONTAIN SPACES";
    } else {

        $query = "SELECT id FROM player_characters WHERE given_name='$playername'";
        $result = pg_query($db_gs, $query);
        $row = pg_fetch_assoc($result);
        if (!$row) {
            $message = "<font color='red'>PLAYER '$playername' NOT FOUND</font>";
        } else {
            $player_id = pg_fetch_result($result, 0, 0);

            $block_special_characteres = false;
            if ($block_special_characteres && preg_match('/[^a-zA-Z0-9 ]/', $spritename)) {
                $message = "CAN'T USE NAME WITH SPECIAL CHARACTER";
            } else {
                $name_lower = strtolower($spritename);

                $word_found = '';
                foreach ($list as $word) {
                    if (preg_match("/$word/", $name_lower)) {
                        $word_found = $word;
                        break;
                    }
                }

                if (!empty($word_found)) {
                    $message = "INVALID SPRITE NAME '$spritename' MUST NOT CONTAINS '$word_found'";
                } else {

                    $query = "UPDATE elf1 SET name = '$spritename' WHERE player_id = $player_id";
                    $result = pg_query($db_gs, $query);

                    if ($result) {
                        $message = "<font color='green'>SUCCESS CHANGING SPRITE NAME TO '$spritename'</font>";
                    } else {
                        $message = "<font color='red'>ERROR CHANGING SPRITE NAME</font>";
                    }
                }
            }
        }
    }
}
?>

<!DOCTYPE html>
<html lang='en'>

<head>
    <title> Grand Fantasia | Change Sprite Name </title>
    <meta http-equiv='content-type' content='text/html' ; charset='UTF-8' />
</head>

<body>
    <center>
        <br>
        <input type='button' value='Back' onclick="window.location.href='index.php'" />
        <br>
        <h3> Grand Fantasia Change Sprite Name </h3>
        <br>
        <form action="<?= $_SERVER['PHP_SELF']; ?>" method='post'>
            <label for='playername'>Player Name:</label>
            <input type='text' id='playername' name='playername'>
            <br>
            <label for='playername'>New Sprite Name:</label>
            <input type='text' id='spritename' name='spritename'>
            <br>
            <input type='submit' name='submit' value='Change Sprite Name'>
        </form>
        <p><?php echo $message;
            ?></p>
    </center>
</body>

</html>