module OxygenExample

using Oxygen, SwaggerMarkdown, HTTP

const NAME = Ref{String}("")

@post "/my_name_is/{name}" f(::HTTP.Request, name::String) = NAME[] = name
@get "/name" () -> begin NAME[] end

@swagger """
/my_name_is/{name}:
    post:
        description: Set name.
        parameters:
            -   name: name
                in: path
                required: true
                description: Your name
                schema:
                    type: string
                    example: Name
        responses:
            "200":
                description: OK
"""
@swagger """
/name:
    get:
        description: Get name.
        responses:
            "200":
                description: OK
                content:
                    "*/*":
                        schema:
                            type: string
                            example: Name
"""

openApi_version = "3.0"

info = Dict{String, Any}(
    "title" => "Example API",
    "version" => openApi_version
)

OpenAPI(openApi_version, info) |> build |> mergeschema

start_server(;port::Int=8080, async::Bool = true) = serve(; port, async)

end
