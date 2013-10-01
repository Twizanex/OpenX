<h1> VCAP_SERVICES </h1>
<hr />
<?php
  $services = getenv("VCAP_SERVICES");
  print_r( json_decode($services,true); );
  // config for wp https://docs.appfog.com/languages/php/wordpress
?>
