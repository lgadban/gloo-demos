#!/bin/sh

set -x

curl http://localhost:8080/api/pets \
      -H "Authorization: Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzb2xvLmlvIiwic3ViIjoidXNlciIsIm9yZyI6InNvbG8uaW8iLCJhdWQiOiJnbG9vIiwic2NvcGUiOiJhcGkifQ.rZy4DGf3NRJGISOu140sRu8Ml5Ze9IVuhLYhWO9Y3NMiwVD044Nm_COZn76MUJsYnu2kjSqfILileQv_lENX_S9QW2e5j_KN0gocLFovAkMQwbr9mF4hOwAFiNE-qYob0mQzt4JkPMEy7LB-Nv2ZXh8lPJ2NumHSl3h9hqeFl35oLYaMC0cBmmvIaZWuyO-gtvy5EJvH76Of2HpNfhM5bZme-QREWfwvQtltnH8VcZL5ujZyD8kdeqGYj1o691oqIwsNG3LXIs8g3UDlI31hH0d7vpHLtfi97QglaPHiKuTl4YGTNST6L1au-c7HH2iNhchGnFY7XuKg3p-GWgFJ3Q" 
