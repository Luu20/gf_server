<?php

$db_gs = pg_connect("host=localhost dbname=gf_gs user=postgres password=db_pwd");
$db_ls = pg_connect("host=localhost dbname=gf_ls user=postgres password=db_pwd");

$config['host'] = "host_ip";
$config['loginPort'] = 6543;
$config['gatewayPort'] = 5560;
$config['ticketPort'] = 7777;

$loginSocket = @fsockopen($config['host'], $config['loginPort'], $err, $err, 1);
$gatewaySocket = @fsockopen($config['host'], $config['gatewayPort'], $err, $err, 1);
$ticketsocket = @fsockopen($config['host'], $config['ticketPort'], $err, $err, 1);

$characters_result = pg_query($db_gs, "SELECT COUNT(*) FROM player_characters");
$num_characters = pg_fetch_result($characters_result, 0, 0);

$accounts_result = pg_query($db_ls, "SELECT COUNT(*) FROM accounts");
$num_accounts = pg_fetch_result($accounts_result, 0, 0);

?>

<!DOCTYPE html>
<html lang="en">

<head>
  <title> Grand Fantasia | Status </title>
  <meta http-equiv="content-type" content="text/html" ; charset="UTF-8" />
</head>

<body>
  <center>
    <br>
    <h3> Grand Fantasia Status </h3>
    <br>
    <?php
    if (!$loginSocket) {
        echo "LoginServer: <font color='red'>Offline</font><br>";
    } else {
        echo "LoginServer: <font color='green'>Online</font><br>";
        fclose($loginSocket);
    }
    
    if (!$gatewaySocket) {
        echo "GatewayServer: <font color='red'>Offline</font><br>";
    } else {
        echo "GatewayServer: <font color='green'>Online</font><br>";
        fclose($gatewaySocket);
    }
    
    if (!$ticketsocket) {
        echo "TicketServer: <font color='red'>Offline</font><br>";
    } else {
        echo "TicketServer: <font color='green'>Online</font><br>";
        fclose($ticketsocket);
    }
    echo "<br>Registered Accounts: $num_accounts";
    echo "<br>Characters Created: $num_characters";
    
    ?>
  </center>
</body>

</html>