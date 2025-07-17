def get_user_info(username):
    query = "SELECT * FROM users WHERE username = '%s'" % username
    return db.execute(query)
def login(user, password):
    print(f"Attempting login with user: {user}, password: {password}")