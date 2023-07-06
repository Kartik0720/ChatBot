from flask import Flask, render_template, request,redirect,flash
import json
import random
import re
import mysql.connector
import json

def mysqlconnect():
    connect = mysql.connector.connect(
        host="localhost",
        user="root",
        password="",
        database="chatbot"
    )
    return connect

# Connect to the database
db = mysqlconnect()

# Create a cursor object to execute SQL queries
cursor = db.cursor()

#Execute a SELECT query to retrieve all rows from the "intents" table
cursor.execute("SELECT * FROM intents")

# Fetch all rows as a list of tuples
rows = cursor.fetchall()

# Create an empty list to store the JSON objects for each row
intents = []

# Loop through the rows and create a JSON object for each one
for row in rows:
  intent = {
    "tag": row[0],
    "patterns": row[1].split(","),
    "responses": row[2].replace('\u2022','').replace('\r','').replace('\n',''),
  }
  intents.append(intent)

# Convert the list of JSON objects to a JSON string
json_string = json.dumps(intents, indent=2)

# Write the JSON string to a file
with open("intents.json", "w") as f:
  f.write(json_string)

app = Flask(__name__)

with open('intents.json', 'r') as f:
    intents = json.load(f)

def find(URL):
  url = re.findall('http[s]?://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\(\), ]|(?:%[0-9a-fA-F][0-9a-fA-F]))+',URL) 
  return url 

def urlsep(response):
    print(response)
    print(find(response))
    if(len(find(response))==0):
        return response
    else:
        url=find(response)[0]
        suburl="drive.google.com"
        print(url)
        if suburl in url:
            url = url[32:65]
            finalurl="https://drive.google.com/uc?export=download&id="+ url
            finalurl =  '<a href="'+finalurl+'">Click here</a>'
        else:
            finalurl =  '<a href="'+url+'">Click Here to Open Website</a>'
        remainString = response.removesuffix(find(response)[0])
        remainString = remainString + "\n" + finalurl
        print(remainString)
        return  remainString

def get_response(tag):
    for intent in intents:
        if intent['tag'] == tag:
            res = intent['responses']
            res = urlsep(res)
            # result = res.split("|")
            result = res.replace("|","<br>")
            print(result)
            # print(intent['responses'][0])
            return result
    return 'Sorry,get response I do not understand your message '


@app.route('/', methods=['POST'])
def botResponse(msgText):
    
    message = msgText
    print(msgText)
    for intent in intents:
        for pattern in intent['patterns']:
            if pattern.lower() in message.lower():
                response = get_response(intent['tag'])
                return response
    return 'Sorry, For more Information Contact +91(079) 26447636 '


@app.route("/")
def home():
    return render_template("index.html")


@app.route('/adminlog',methods=['GET', 'POST'])
def adminlog():
        if request.method == 'POST':
            admin_name = request.form['admin_name']
            admin_password = request.form['admin_password']
        
            db = mysqlconnect()
            cur = db.cursor()
            
            cur.execute('select * from admin_db WHERE admin_name = %s',[admin_name])
            admin = cur.fetchone()
            print(admin)
            if admin is not None and admin_name in admin:
                if admin_password in admin:
                    if admin[5]== 1:
                    # Valid login, redirect to dashboard
                        print(admin[5])
                        cur.close()
                        return redirect('/dashboard')
                    else:
                        print("Your Acount is deactivate")
                else:
                    # Incorrect password
                    cur.close()
                    return render_template('adminLog.html', error='Invalid password')
                    #return "invalid password"
            else:
                # User not found
                cur.close()
                return render_template('adminLog.html', error='Invalid username')
                #return "invalid user"
        
        return render_template('adminLog.html')


@app.route('/register',methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        admin_name = request.form['admin_name']
        admin_password = request.form['admin_password']
        admin_mail = request.form['admin_mail']
        confirm_password = request.form['confirm_password']
        is_active = 1
        #sha256_crypt.encrypt(request.form['admin_password'])
        # Check if the passwords match
        if admin_password != confirm_password:
            return "Passwords do not match. Please try again."
        if admin_password == confirm_password:    
            db = mysqlconnect()
            cur = db.cursor()
            cur.execute('INSERT INTO admin_db (admin_name,admin_password,confirm_password,admin_mail,is_active) VALUES (%s,%s,%s,%s,%s)', (admin_name,admin_password,confirm_password,admin_mail,is_active))
            db.commit()
            cur.close()
            
            return redirect('/adminlog')
    else:
        return render_template('adminReg.html')

@app.route("/get")
def get_bot_response():

    userText = request.args.get('msg')
    
    if not userText:
        return "No message provided"
    
    response = botResponse(userText)
    return response
    

@app.route('/addresponse',methods=['GET', 'POST'])
def addResponse():
    return render_template('addResponse.html')


@app.route('/dashboard', methods=['GET', 'POST'])
def query():
    if request.method == 'POST':
         if request.form['submit_button'] == 'INSERT':
            return insert()
         elif request.form['submit_button'] == 'UPDATE':
            return update()
         elif request.form['submit_button'] == 'DELETE':
            return delete()
         else:
            return 'Invalid Request'
    else:
        db = mysqlconnect()
        cur = db.cursor()
        cur.execute('SELECT * FROM intents')
        intents = cur.fetchall()
        cur.close()
        return render_template('adminDashboard.html',intents=intents)


@app.route('/insert', methods=['GET','POST'])
def insert():
    db = mysqlconnect()
    cur = db.cursor()
    itag = request.form['tag']
    ipatterns= request.form['patterns']
    iresponses=request.form['responses']
    cur.execute("INSERT INTO intents (tags, patterns, responses) VALUES (%s, %s, %s)", (itag, ipatterns, iresponses))
    db.commit()
    cur.close()
     # Redirect the user to the dashboard page
    return '<h1>Record inserted successfully!<a href="/addResponse">insert more records</a></h1>'
       

@app.route('/update/<string:id>', methods=['GET','POST'])
def update(id):
    db = mysqlconnect()
    cur = db.cursor()
    cur.execute("SELECT * FROM intents where tags=%s",[id])
    intents = cur.fetchall()
    cur.close()
    if request.method == 'POST':
    # Handle the update function
        cur = db.cursor()
        itag = request.form['tag']
        ipatterns= request.form['patterns']
        iresponses=request.form['responses']
        cur.execute("UPDATE intents SET  tags=%s,patterns=%s, responses=%s WHERE tags=%s", (itag,ipatterns, iresponses,id))
        db.commit()
        cur.close()
        # return render_template("adminadd.html",intents=intents)
        # Redirect the user to the dashboard page
        return '<h1>Record updated successfully!<a href="/dashboard">back to Dashboard</a></h1>'
        # return redirect('/dashboard')
    return render_template("updateResponse.html",intents=intents)

@app.route('/delete/<string:id>', methods=['GET', 'POST'])
def delete(id):
    
    # Handle the delete function
        db = mysqlconnect()
        cur = db.cursor()
        # itag = request.form['tag']
        cur.execute("DELETE FROM intents WHERE tags=%s", [id])
            
        db.commit()
        cur.close()
        return redirect('/dashboard')

        
if __name__ == "__main__":
    app.run()

