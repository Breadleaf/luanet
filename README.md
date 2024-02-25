# Lua Net

## Packet Structure

### Requests

| LUANET [VERSION] | [REQUEST TYPE] | [URL] |
| :-: | :-: | :-: |
| DATA (OPTIONAL) | | |

### Responses

| LUANET [VERSION] | [STATUS CODE] | [STATUS MESSAGE] |
| :-: | :-: | :-: |
| CONTENT | [CONTENT LENGTH] | [CONTENT TYPE ( PLAINTEXT, LON )] |
| DATA | | |
