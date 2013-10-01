<?php
  header('Content-type: text/javascript');
  $services = getenv("VCAP_SERVICES");
  print $services ;
?>

