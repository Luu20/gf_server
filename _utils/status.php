<?php

$config['host'] = "host_ip";
$config['loginPort'] = 6543;
$config['gatewayPort'] = 5560;
$config['ticketPort'] = 7777;

$loginSocket = @fsockopen($config['host'], $config['loginPort'], $err, $err, 1);
$gatewaySocket = @fsockopen($config['host'], $config['gatewayPort'], $err, $err, 1);
$ticketsocket = @fsockopen($config['host'], $config['ticketPort'], $err, $err, 1);

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