<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Hey, je suis un container Docker!</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.9.3/css/bulma.min.css">
  </head>
  <body>
  <section class="section">
    <div class="container">
      <h1 class="title">Bonjour Bruxelles !, je suis un script s'exécutant depuis Docker</h1>

      <p class="subtitle">
        <?php
          // Affiche la date et l'heure en français, heure de Bruxelles bien sûr!
          date_default_timezone_set('Europe/Brussels');
          $date = date('d-m-y H:i:s');
          echo "Bonjour, nous sommes le $date";
        ?>
      </p>
    </div>
  </section>
  </body>
</html>


