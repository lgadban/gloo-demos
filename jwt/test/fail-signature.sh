#!/bin/sh

set -x

curl $(glooctl proxy url)/api/pets \
      -H "Authorization: Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzb2xvLmlvIiwic3ViIjoidXNlciIsIm9yZyI6InNvbG8uaW8iLCJhdWQiOiJnbG9vIiwic2NvcGUiOiJhcGkifQ.pNM1bZP2dgIvyHhv9GNE8RAXPu_TSkhvd6wEaL5NwyllcY7Jjvv4SGFfj-QFoKNhqpxYG2NQL6cXN1ndGHf553dV0TIG6ZdUQHmfXHlTXUrqUSScYdzZpZSXyNL9JWrleor70sYfTzCkHiwZVgTBWJpUoxz22zPIZ1VL3DPgcZi7VwWb_1zYbU2bcsasL7zuOXXWiaMmw21qvrmnPdHNx4C51j14Y5j0vGbChtPgx0RipD1LawC-fLBN-xbFdc2ugGYtWynL3T5pw3frOFeItGej0OOfS6GDrTbRYHDTkEzAuOXNMxLNtFOSuv6Le_qsiWIJoSufiWEoD2p6iR4RZA" 
