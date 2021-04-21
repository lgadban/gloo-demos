working:
curl "$(glooctl proxy url)/contact?arg1=foo" -d '{}' -H 'content-type: application/json'

not working:
curl "$(glooctl proxy url)/contact?arg1=foo"
