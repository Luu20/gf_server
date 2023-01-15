<?php

$config['host'] = "host_ip";
$config['loginPort'] = 6543;
$config['gatewayPort'] = 5560;
$config['ticketPort'] = 7777;

$loginSocket = @fsockopen($config['host'], $config['loginPort'], $err, $err, 1);
$gatewaySocket = @fsockopen($config['host'], $config['gatewayPort'], $err, $err, 1);
$ticketsocket = @fsockopen($config['host'], $config['ticketPort'], $err, $err, 1);

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
        ?>
    </center>
</body>

</html>