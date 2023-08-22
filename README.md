# Group-Project-Insy-661-Airbnb

In this project, we are hosting a live website on which we are hosting our database live, providing the users an option to interact with the database using the pre-defined queries 
or by writing their own queries for which we even have a relational schema in place for reference.

We have built a dummy database for Airbnb and utilized the Streamlit library to design and host the website.

You can interact with our website here; https://group-project-insy-661-airbnb.streamlit.app/

Process:

## Prerequisites

- GitHub account
- Aiven account with a MySQL database instance
- Python and Streamlit installed
- Knowledge of SQL

## Setup

1. **Create a GitHub Repository:**

   Create a new repository on GitHub to host your project.

2. **Database Setup:**

   - Set up a MySQL database instance on Aiven and obtain the connection details (hostname, port, username, password, database name).
   - Create a `.env` file in your project directory to store your database connection details.

     ```
     DB_HOST=<your_database_host>
     DB_PORT=<your_database_port>
     DB_USER=<your_database_username>
     DB_PASSWORD=<your_database_password>
     DB_NAME=<your_database_name>
     ```

3. **Install Dependencies:**

   Install the required dependencies using pip:

   ```bash
   pip install -r requirements.txt

   File Structure:


4. **Create & Organize your project files:**


Create a Streamlit web application (app.py) with the provided code.

### Database Schema:

Add an image (schema.jpeg) representing your database schema.

### Query Files:

Create a query.sql file containing your SQL queries for the "Queries" tab.

### Helper Functions:

Create a helper.py file to define helper functions.

### Usage
Run the Streamlit App:

Run the Streamlit app using the following command:

bash
Copy code
streamlit run app.py
Interact with the Web App:

Open your web browser and navigate to the provided URL to access the Streamlit web application. Use the tabs to interact with the database, run queries, and view results.

### Hosting on Streamlit
Create a Streamlit Account:

If you haven't already, sign up for a Streamlit account.

### Deploy the App:

Log in to your Streamlit account.
Create a new Streamlit app and connect it to your GitHub repository.
Configure the deployment settings.
Streamlit will automatically deploy your app and provide you with a URL.
