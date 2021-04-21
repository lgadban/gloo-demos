package test

default allow = false
allow {
    input.http_request.path == "/api/pets/2"
    input.http_request.method == "GET"
}

