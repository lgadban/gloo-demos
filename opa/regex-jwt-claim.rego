package test

default allow = false

allow {
    trace(sprintf("payload: %v", [input.http_request.headers.authorization]))
    output := split(input.http_request.headers.authorization, " ")
    [header, payload, signature] = io.jwt.decode(output[1])
    re_match("admin.*", payload["x-role"])
}
