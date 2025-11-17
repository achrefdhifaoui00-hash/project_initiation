# simple security headers middleware
class SecurityHeadersMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        response = self.get_response(request)

        # Add basic security headers (tune values as needed)
        # Content-Security-Policy: a baseline; you must adapt to your app's external resources
        response.setdefault(
            "Content-Security-Policy",
            "default-src 'self'; script-src 'self' 'unsafe-inline'; style-src 'self' 'unsafe-inline'; img-src 'self' data:;"
        )

        # Permissions-Policy (formerly Feature-Policy) - example: deny geolocation/microphone
        response.setdefault("Permissions-Policy", "geolocation=(), microphone=()")

        # Ensure the browser doesn't sniff the MIME type
        response.setdefault("X-Content-Type-Options", "nosniff")

        # Add a Referrer-Policy (already set in settings but set again just in case)
        response.setdefault("Referrer-Policy", "no-referrer-when-downgrade")

        return response
