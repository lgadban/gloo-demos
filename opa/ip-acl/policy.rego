package test

default allow = false
allow {
    startswith(input.http_request.path, "/api/pets")
    input.http_request.method == "GET"
    input.check_request.attributes.source.address.Address.SocketAddress.address == "173.175.123.25"
}
