package test

default allow = false

allow {
    output := split(input.http_request.headers.authorization, " ")
    [header, payload, signature] = io.jwt.decode(output[1])
    payload["sub"] = "user"
    contains(payload["scope"], "api")
}
