#!/bin/sh

set -x

curl $(glooctl proxy url)/api/pets \
      -H "Authorization: Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzb2xvLmlvIiwic3ViIjoidXNlciIsIm9yZyI6InNvbG8uaW8iLCJhdWQiOiJnbG9vIiwic2NvcGUiOiJhcGkiLCJleHAiOjE1MjQzOTAwMDl9.r_v-GzWBhgTsVumY7Z-VmXQT-5JNzPMZWJbGImBroKPOR9TUz0B2JyDUF8EZmFscuiuP4O5BIXXNSoRSyOkexQeMMwEAcE4ACmjb47Yfwgdm2XMzelHgqUpczWJ-CKKkfawX4edtc_uRTTwQbWrBy2fGR86suCrGWEgMak6clAfkl91uB7oOrHC4L_pOYICIw60JKva6W1HiMs97XLhJ655_kZ9KKMhREne7e-oJl45Po92PrC1ZD88E3pxGkkaNHDjn7roCgNRKqRblYVqUATizI5KWEXuv-KF1RD-qxhi0gR6FbGN4EJ5bYKVlfqc2sInukyQV73COU7XDa9Q6FQ" 
