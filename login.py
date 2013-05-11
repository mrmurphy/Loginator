import web
import random

urls = ('/login', 'Login')


class Login:

    def GET(self):
        web.header('Access-Control-Allow-Origin', '*')
        params = web.input()
        if 'user' not in params or 'pass' not in params:
            return web.badrequest()
        if random.choice([True, False]):
            return web.ok()
        else:
            return web.unauthorized()


if __name__ == '__main__':
    app = web.application(urls, globals())
    app.run()
