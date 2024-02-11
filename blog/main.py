from datetime import datetime
from click import DateTime
from flask import Flask, render_template, request,session,redirect
from flask_sqlalchemy import SQLAlchemy
import json
from werkzeug.utils import secure_filename
import math
import os
from flask_mail import Mail
from sqlalchemy import func


script_dir = os.path.dirname(os.path.abspath(__file__))
config_path = os.path.join(script_dir, "templates", "config.json")

with open(config_path, 'r') as c:
    params = json.load(c)['params']

local_server = True
app = Flask(__name__)

app.config['UPLOAD_FOLDER'] = params['upload_location']
app.secret_key = 'super-secret-key'
app.config.update(
    MAIL_SERVER='smtp.gmail.com',
    MAIL_PORT='465',
    MAIL_USE_SSL=True,
    MAIL_USERNAME=params['gmail-user'],
    MAIL_PASSWORD=params['gmail-password']
)

mail = Mail(app)

if local_server:
    app.config['SQLALCHEMY_DATABASE_URI'] = params['local_uri']
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = params['prod_uri']

db = SQLAlchemy(app)

from sqlalchemy import DateTime, func

class Contact(db.Model):
    sno = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name = db.Column(db.String(80), nullable=False)
    phone_num = db.Column(db.String(12), nullable=False)
    msg = db.Column(db.String(12000), nullable=False)
    date = db.Column(DateTime, default=func.current_timestamp(), nullable=True)
    email = db.Column(db.String(20), nullable=False)


class Posts(db.Model):
    srno = db.Column(db.Integer, primary_key=True, autoincrement=True)
    title = db.Column(db.String(80), nullable=False)
    
    sub_title = db.Column(db.String(800), nullable=False)
    
    slug = db.Column(db.String(80), nullable=False)
    
    content = db.Column(db.String(80000), nullable=False)
    
    date = db.Column(DateTime, default=func.current_timestamp(), nullable=True)
    
    img_file = db.Column(db.String(12), nullable=True)
    


@app.route("/dashboard", methods=["GET", "POST"])
def dashboard():
    posts = []

    if "user" in session and session["user"] == params["admin_user"]:
        # User is already in session, query posts
        posts = Posts.query.all()
        return render_template("dashboard.html", params=params, posts=posts)

    if request.method == "POST":
        username = request.form.get("uname")
        password = request.form.get("pass")

        if username == params["admin_user"] and password == params["admin_password"]:
            # Set the user in the session and then query posts
            session["user"] = username
            posts = Posts.query.all()
            return render_template("dashboard.html", params=params, posts=posts)

    return render_template("login.html", params=params, posts=posts)




@app.route("/layout")
def layout():
    return render_template("layout.html", params=params)

@app.route("/login")
def login():
    return render_template("login.html", params=params)




@app.route("/")
def home():
    posts = Posts.query.filter_by().all()#[0:params["num_of_post"]]
    last = math.ceil(len(posts)/int(params['num_of_post']))
    #[0: params['no_of_posts']]
    #posts = posts[]
    page = request.args.get('page')
    if(not str(page).isnumeric()):
        page = 1
    page= int(page)
    posts = posts[(page-1)*int(params['num_of_post']): (page-1)*int(params['num_of_post'])+ int(params['num_of_post'])]
    #Pagination Logic
    #First
    if (page==1):
        prev = "#"
        next = "/?page="+ str(page+1)
    elif(page==last):
        prev = "/?page=" + str(page - 1)
        next = "#"
    else:
        prev = "/?page=" + str(page - 1)
        next = "/?page=" + str(page + 1)
    
    return render_template("index.html", params=params, posts=posts,prev=prev, next=next)


@app.route("/about")
def about():
    return render_template("about.html", params=params)


@app.route("/edit", methods=["GET", "POST"])
@app.route("/edit/<int:srno>", methods=["GET", "POST"])
def edit(srno=None):
    if 'user' in session and session['user'] == params['admin_user']:
        if request.method == 'POST':
            box_title = request.form.get('title')
            sub_title = request.form.get('sub_title')
            slug = request.form.get('slug')
            content = request.form.get('content')
            img_file = request.form.get('img_file')
            date = datetime.now()

            if srno is None:
                # Creating a new post
                post = Posts(title=box_title, slug=slug, content=content, sub_title=sub_title, img_file=img_file, date=date)
                db.session.add(post)
            else:
                # Updating an existing post
                post = Posts.query.get(srno)
                if post:
                    post.title = box_title
                    post.sub_title = sub_title
                    post.slug = slug
                    post.content = content
                    post.img_file = img_file
                    post.date = date

            db.session.commit()

            # Redirect to the edited post
            return redirect("/edit/" + str(post.srno) if post else "/dashboard")

        # Fetch post data for editing
        post = Posts.query.get(srno) if srno else None
        return render_template('edit.html', params=params, post=post, srno=srno)

    return render_template('login.html', params=params)



@app.route("/uploader", methods = ['GET', 'POST'])
def uploader():
    if ('user' in session and session['user'] == params['admin_user']):
        if (request.method == 'POST'):
            f= request.files['file1']
            f.save(os.path.join(app.config['UPLOAD_FOLDER'], secure_filename(f.filename) ))
            return "Uploaded successfully"


@app.route("/delete/<int:srno>")
def delete_post(srno):
    if 'user' in session and session['user'] == params['admin_user']:
        post = Posts.query.filter_by(srno=srno).first()

        if post:
            db.session.delete(post)
            db.session.commit()
            return redirect("/dashboard")

    # If user is not logged in or not authorized, redirect to login page or homepage
    return redirect("/login")  # Adjust this to your login route


@app.route("/logout")
def logout():
    # Clear the session
    session.pop('user', None)
    
    # Redirect to the login page (adjust the route accordingly)
    return redirect("/login")

        
@app.route("/contact", methods=["GET", "POST"])
def contact():
    if request.method == 'POST':
        name = request.form.get('name')
        email = request.form.get('email')
        phone_num = request.form.get('phone_num')
        msg = request.form.get('msg')
        entry = Contact(name=name, phone_num=phone_num, msg=msg, date=datetime.now(), email=email)
        db.session.add(entry)
        db.session.commit()
        
        mail.send_message('New message from ' + name,
                          sender=email,
                          recipients = [params['gmail-user']],
                          body = msg + "\n" + phone_num
                          )

        
    return render_template("contact.html", params=params)

@app.route("/post/<string:post_slug>")
def post_route(post_slug):
    post = Posts.query.filter_by(slug=post_slug).first()
    if post:
        paragraphs = post.content.split('\n\n') if '\n\n' in post.content else post.content.split('\n')
        return render_template('post.html', params=params, post=post, paragraphs=paragraphs)
    else:
        return render_template('post.html', params=params, post=None, paragraphs=None)




app.run(debug=True, use_reloader=False)

