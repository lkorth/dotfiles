from http.server import SimpleHTTPRequestHandler
from socketserver import TCPServer
import logging
import sys

class GetHandler(SimpleHTTPRequestHandler):

    def do_GET(self):
        logging.error(self.headers)
        self.send_head()
        for h in self.headers:
            self.send_header(h, self.headers[h])
        self.end_headers()
        self.send_response(200, "")

    def do_POST(self):
        logging.error(self.headers)
        logging.error(self.body)
        SimpleHTTPRequestHandler.do_POST(self)

Handler = GetHandler
httpd = TCPServer(("", int(sys.argv[1])), Handler)

httpd.serve_forever()
